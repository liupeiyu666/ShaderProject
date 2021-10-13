using System;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine.Utility;
using UnityEngine.Events;
using System.Collections;

namespace Cinemachine
{
    /// <summary>
    /// CinemachineBrain is the link between the Unity Camera and the Cinemachine Virtual 
    /// Cameras in the scene.  It monitors the priority stack to choose the current 
    /// Virtual Camera, and blend with another if necessary.  Finally and most importantly, 
    /// it applies the Virtual Camera state to the attached Unity Camera.
    /// 
    /// The CinemachineBrain is also the place where rules for blending between virtual cameras 
    /// are defined.  Camera blending is an interpolation over time of one virtual camera 
    /// position and state to another. If you think of virtual cameras as cameramen, then 
    /// blending is a little like one cameraman smoothly passing the camera to another cameraman. 
    /// You can specify the time over which to blend, as well as the blend curve shape. 
    /// Note that a camera cut is just a zero-time blend.
    /// </summary>
    [DocumentationSorting(0, DocumentationSortingAttribute.Level.UserRef)]
//    [RequireComponent(typeof(Camera))] // strange but true: we can live without it
    [ExecuteInEditMode, DisallowMultipleComponent]
    [AddComponentMenu("Cinemachine/CinemachineBrain")]
    [SaveDuringPlay]
    public class CinemachineBrain : MonoBehaviour
    {
        [Tooltip("Game视图右上角显示当前激活的相机")]
        public bool m_ShowDebugText = false;
        [Tooltip("Scene视图显示当前摄像机的视锥框")]
        public bool m_ShowCameraFrustum = true;        
        [Tooltip("是否忽略TimeScale")]
        public bool m_IgnoreTimeScale = false;

        /// <summary>
        /// 这个也没看明白，重定义worldUp，说是如果是俯视游戏，将forward定义为up，感觉没啥必要。
        /// </summary>
        [Tooltip("If set, this object's Y axis will define the worldspace Up vector for all the virtual cameras.  This is useful for instance in top-down game environments.  If not set, Up is worldspace Y.  Setting this appropriately is important, because Virtual Cameras don't like looking straight up or straight down.")]
        public Transform m_WorldUpOverride;

        /// <summary>This enum defines the options available for the update method.</summary>
        [DocumentationSorting(0.1f, DocumentationSortingAttribute.Level.UserRef)]
        public enum UpdateMethod
        {
            /// <summary>Virtual cameras are updated in sync with the Physics module, in FixedUpdate</summary>
            FixedUpdate,
            /// <summary>Virtual cameras are updated in MonoBehaviour LateUpdate.</summary>
            LateUpdate,
            /// <summary>Virtual cameras are updated according to how the target is updated.
            /// 该虚拟相机的target在fixedUpdate移动次数多还是在lateupdate移动的次数多。来判断下一段时间用fixedUpdate还是lateUpdate。
            /// </summary>
            SmartUpdate
        };

        /// <summary>Depending on how the target objects are animated, adjust the update method to
        /// minimize the potential jitter.  Use FixedUpdate if all your targets are animated with for RigidBody animation.
        /// SmartUpdate will choose the best method for each virtual camera, depending
        /// on how the target is animated.</summary>
        [Tooltip("Use FixedUpdate if all your targets are animated during FixedUpdate (e.g. RigidBodies), LateUpdate if all your targets are animated during the normal Update loop, and SmartUpdate if you want Cinemachine to do the appropriate thing on a per-target basis.  SmartUpdate is the recommended setting")]
        public UpdateMethod m_UpdateMethod = UpdateMethod.SmartUpdate;
                
        [CinemachineBlendDefinitionProperty]
        [Tooltip("默认相机切换的设置")]
        public CinemachineBlendDefinition m_DefaultBlend
            = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f);        
        [Tooltip("自定义的相机的混合设置")]
        public CinemachineBlenderSettings m_CustomBlends = null;

        /// <summary>
        ///Unity的相机
        /// </summary>
        public Camera OutputCamera
        {
            get
            {
                if (m_OutputCamera == null)
                    m_OutputCamera = GetComponent<Camera>();
                return m_OutputCamera;
            }
        }
        private Camera m_OutputCamera = null; // never use directly - use accessor

        /// <summary>相机</summary>
        [Serializable] public class BrainEvent : UnityEvent<CinemachineBrain> {}

        /// <summary>Event with a ICinemachineCamera parameter</summary>
        [Serializable] public class VcamEvent : UnityEvent<ICinemachineCamera> {}

        /// <summary>This event will fire whenever a virtual camera goes live and there is no blend</summary>
        [Tooltip("没有混合时，相机激活时触发的事件")]
        public BrainEvent m_CameraCutEvent = new BrainEvent();

        /// <summary>This event will fire whenever a virtual camera goes live.  If a blend is involved, 
        /// then the event will fire on the first frame of the blend</summary>
        [Tooltip("有混合时，相机激活时（开始混合的第一帧）触发的事件")]
        public VcamEvent m_CameraActivatedEvent = new VcamEvent();

        /// <summary>Support for opaque post-processing module</summary>
        internal Component PostProcessingComponent { get; set; }

        /// <summary>
        /// 用于处理后效的委托
        /// </summary>
        internal static BrainEvent sPostProcessingHandler = new BrainEvent();

        /// <summary>
        /// unityEditor使用的API，当前正在调试的摄像机。
        /// </summary>
        public static ICinemachineCamera SoloCamera { get; set; }

        /// <summary>API for the Unity Editor.</summary>
        /// <returns>Color used to indicate that a camera is in Solo mode.</returns>
        public static Color GetSoloGUIColor() { return Color.Lerp(Color.red, Color.yellow, 0.8f); }

        /// <summary>世界坐标的Up的方向</summary>
        public Vector3 DefaultWorldUp
            { get { return (m_WorldUpOverride != null) ? m_WorldUpOverride.transform.up : Vector3.up; } }

        //-上一帧激活的相机
        private ICinemachineCamera mActiveCameraPreviousFrame;
        //--上一帧淡出的相机
        private ICinemachineCamera mOutgoingCameraPreviousFrame;
        //--当前的Blend
        private CinemachineBlend mActiveBlend = null;
        //--上一帧是否结束
        private bool mPreviousFrameWasOverride = false;

        private class OverrideStackFrame
        {
            public int id;
            public ICinemachineCamera camera;
            public CinemachineBlend blend;
            public float deltaTime;
            public float timeOfOverride;
            public bool Active { get { return camera != null; } }
            /// <summary>
            /// 是否过期，运行时永远是false
            /// </summary>
            public bool Expired 
            { 
                get 
                { 
                    return !Application.isPlaying 
                        && Time.realtimeSinceStartup - timeOfOverride > Time.maximumDeltaTime; 
                }
            }
        }
        private List<OverrideStackFrame> mOverrideStack = new List<OverrideStackFrame>();
        private int mNextOverrideId = 1;

        /// Get the override if it's present, else insert it
        private OverrideStackFrame GetOverrideFrame(int id)
        {
            int count = mOverrideStack.Count;
            for (int i = 0; i < count; ++i)
                if (mOverrideStack[i].id == id)
                    return mOverrideStack[i];
            OverrideStackFrame ovr = new OverrideStackFrame();
            ovr.id = id;
            mOverrideStack.Insert(0, ovr);
            return ovr;
        }

        /// Get the next active blend on the stack.  Used when an override blends in from nothing.
        private OverrideStackFrame mOverrideBlendFromNothing = new OverrideStackFrame();
        private OverrideStackFrame GetNextActiveFrame(int overrideId)
        {
            bool pastMine = false;
            int count = mOverrideStack.Count;
            for (int i = 0; i < count; ++i)
            {
                //--获取这个overrideId之前激活的frame。
                if (mOverrideStack[i].id == overrideId)
                    pastMine = true;
                else if (mOverrideStack[i].Active && pastMine)
                    return mOverrideStack[i];
            }
            // Create a frame representing the non-override state (gameplay)
            mOverrideBlendFromNothing.camera = TopCameraFromPriorityQueue();
            mOverrideBlendFromNothing.blend = mActiveBlend;
            return mOverrideBlendFromNothing;
        }

        /// Get the first override that has a camera
        private OverrideStackFrame GetActiveOverride()
        {
            int count = mOverrideStack.Count;
            for (int i = 0; i < count; ++i)
                if (mOverrideStack[i].Active)
                    return mOverrideStack[i];
            return null;
        }

        /// <summary>
        /// This API is specifically for Timeline.  Do not use it.
        /// Override the current camera and current blend.  This setting will trump
        /// any in-game logic that sets virtual camera priorities and Enabled states.
        /// This is the main API for the timeline.
        /// </summary>
        /// <param name="overrideId">Id to represent a specific client.  An internal
        /// stack is maintained, with the most recent non-empty override taking precenence.
        /// This id must be > 0.  If you pass -1, a new id will be created, and returned.
        /// Use that id for subsequent calls.  Don't forget to
        /// call ReleaseCameraOverride after all overriding is finished, to
        /// free the OverideStack resources.</param>
        /// <param name="camA"> The camera to set, corresponding to weight=0</param>
        /// <param name="camB"> The camera to set, corresponding to weight=1</param>
        /// <param name="weightB">The blend weight.  0=camA, 1=camB</param>
        /// <param name="deltaTime">override for deltaTime.  Should be Time.FixedDelta for
        /// time-based calculations to be included, -1 otherwise</param>
        /// <returns>The oiverride ID.  Don't forget to call ReleaseCameraOverride
        /// after all overriding is finished, to free the OverideStack resources.</returns>
        internal int SetCameraOverride(
            int overrideId,
            ICinemachineCamera camA, ICinemachineCamera camB,
            float weightB, float deltaTime)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineBrain.SetCameraOverride");
            if (overrideId < 0)
                overrideId = mNextOverrideId++;

            OverrideStackFrame ovr = GetOverrideFrame(overrideId);
            ovr.camera = null;
            ovr.deltaTime = deltaTime;
            ovr.timeOfOverride = Time.realtimeSinceStartup;
            if (camA != null || camB != null)
            {
                if (weightB <= Utility.UnityVectorExtensions.Epsilon)
                {
                    ovr.blend = null;
                    if (camA != null)
                        ovr.camera = camA; // no blend
                }
                else if (weightB >= (1f - Utility.UnityVectorExtensions.Epsilon))
                {
                    ovr.blend = null;
                    if (camB != null)
                        ovr.camera = camB; // no blend
                }
                else
                {
                    // We have a blend.  If one of the supplied cameras is null,
                    // we use the current active virtual camera (blending in/out of game logic),
                    // If we do have a null camera, make sure it's the 'from' camera.
                    // Timeline does not distinguish between from and to cams, but we do.
                    if (camB == null)
                    {
                        // Swap them
                        ICinemachineCamera c = camB;
                        camB = camA;
                        camA = c;
                        weightB = 1f - weightB;
                    }

                    // Are we blending with something in progress?
                    if (camA == null)
                    {
                        OverrideStackFrame frame = GetNextActiveFrame(overrideId);
                        if (frame.blend != null)
                            camA = new BlendSourceVirtualCamera(frame.blend, deltaTime);
                        else
                            camA = frame.camera != null ? frame.camera : camB;
                    }

                    // Create the override blend
                    if (ovr.blend == null)
                        ovr.blend = new CinemachineBlend(
                            camA, camB, AnimationCurve.Linear(0, 0, 1, 1), 1, weightB);
                    ovr.blend.CamA = camA;
                    ovr.blend.CamB = camB;
                    ovr.blend.TimeInBlend = weightB;
                    ovr.camera = camB;
                }
            }
            //UnityEngine.Profiling.Profiler.EndSample();
            return overrideId;
        }

        /// <summary>
        /// This API is specifically for Timeline.  Do not use it.
        /// Release the resources used for a camera override client.
        /// See SetCameraOverride.
        /// </summary>
        /// <param name="overrideId">The ID to released.  This is the value that
        /// was returned by SetCameraOverride</param>
        internal void ReleaseCameraOverride(int overrideId)
        {
            int count = mOverrideStack.Count;
            for (int i = 0; i < count; ++i)
            {
                if (mOverrideStack[i].id == overrideId)
                {
                    mOverrideStack.RemoveAt(i);
                    return;
                }
            }
        }

        private void OnEnable()
        {
            mActiveBlend = null;
            mActiveCameraPreviousFrame = null;
            mOutgoingCameraPreviousFrame = null;
            mPreviousFrameWasOverride = false;
            CinemachineCore.Instance.AddActiveBrain(this);
        }

        private void OnDisable()
        {
            CinemachineCore.Instance.RemoveActiveBrain(this);
            mActiveBlend = null;
            mActiveCameraPreviousFrame = null;
            mOutgoingCameraPreviousFrame = null;
            mPreviousFrameWasOverride = false;
            mOverrideStack.Clear();
        }

        private void Start()
        {
            UpdateVirtualCameras(CinemachineCore.UpdateFilter.Late, -1f);

            // We check in after the physics system has had a chance to move things
            StartCoroutine(AfterPhysics());
        }

#if UNITY_EDITOR
        private void OnGUI()
        {
            if (!m_ShowDebugText)
                CinemachineGameWindowDebug.ReleaseScreenPos(this);
            else
            {
                // Show the active camera and blend
                Color color = GUI.color;
                ICinemachineCamera vcam = ActiveVirtualCamera;
                string text = "CM " + gameObject.name + ": ";
                if (SoloCamera != null)
                {
                    text += "SOLO ";
                    GUI.color = GetSoloGUIColor();
                }
                if (ActiveBlend == null)
                    text += (vcam != null ? "[" + vcam.Name + "]" : "(none)");
                else
                    text += ActiveBlend.Description;
                Rect r = CinemachineGameWindowDebug.GetScreenPos(this, text, GUI.skin.box);
                GUI.Label(r, text, GUI.skin.box);
                GUI.color = color;
            }
        }
#endif

        WaitForFixedUpdate mWaitForFixedUpdate = new WaitForFixedUpdate();
        private IEnumerator AfterPhysics()
        {
            while (true)
            {
                yield return mWaitForFixedUpdate;
                if (m_UpdateMethod == UpdateMethod.SmartUpdate)
                {
                    AddSubframe(); // FixedUpdate can be called multiple times per frame
                    UpdateVirtualCameras(CinemachineCore.UpdateFilter.Fixed, GetEffectiveDeltaTime(true));
                }
                else
                {
                    if (m_UpdateMethod == UpdateMethod.LateUpdate)
                        msSubframes = 1;
                    else
                    {
                        AddSubframe(); // FixedUpdate can be called multiple times per frame
                        UpdateVirtualCameras(CinemachineCore.UpdateFilter.ForcedFixed, GetEffectiveDeltaTime(true));
                    }
                }
            }
        }

        private void LateUpdate()
        {
            float deltaTime = GetEffectiveDeltaTime(false);
            if (m_UpdateMethod == UpdateMethod.SmartUpdate)
                UpdateVirtualCameras(CinemachineCore.UpdateFilter.Late, deltaTime);
            else if (m_UpdateMethod == UpdateMethod.LateUpdate)
                UpdateVirtualCameras(CinemachineCore.UpdateFilter.ForcedLate, deltaTime);

            // Choose the active vcam and apply it to the Unity camera
            ProcessActiveCamera(GetEffectiveDeltaTime(false));
        }

#if UNITY_EDITOR
        /// This is only needed in editor mode to force timeline to call OnGUI while
        /// timeline is up and the game is not running, in order to allow dragging
        /// the composer guide in the game view.
        private void OnPreCull()
        {
            if (!Application.isPlaying)
            {
                // Note: this call will cause any screen canvas attached to the camera
                // to be painted one frame out of sync.  It will only happen in the editor when not playing.
                float deltaTime = GetEffectiveDeltaTime(false);
                msSubframes = 1;
                UpdateVirtualCameras(CinemachineCore.UpdateFilter.Late, deltaTime);
                ProcessActiveCamera(GetEffectiveDeltaTime(false));
            }
        }

#endif
        private float GetEffectiveDeltaTime(bool fixedDelta)
        {
            if (SoloCamera != null)
                return Time.unscaledDeltaTime;
            OverrideStackFrame activeOverride = GetActiveOverride();
            if (activeOverride != null)
                return activeOverride.Expired ? -1 : activeOverride.deltaTime;
            if (!Application.isPlaying)
                return -1;
            if (m_IgnoreTimeScale)
                return fixedDelta ? Time.fixedDeltaTime : Time.unscaledDeltaTime;
            return fixedDelta ? Time.fixedDeltaTime * Time.timeScale : Time.deltaTime;
        }

        private void UpdateVirtualCameras(CinemachineCore.UpdateFilter updateFilter, float deltaTime)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineBrain.UpdateVirtualCameras");
            CinemachineCore.Instance.CurrentUpdateFilter = updateFilter;

            // 更新所有的虚拟相机
            CinemachineCore.Instance.UpdateAllActiveVirtualCameras(DefaultWorldUp, deltaTime);

            // Make sure that the current live cameras get updated this frame.
            // Only cameras that are enabled get automatically updated.
            ICinemachineCamera vcam = ActiveVirtualCamera;
            //--更新当前激活的相机，这个不用也可以啊，上面会更新啊
            if (vcam != null)
                CinemachineCore.Instance.UpdateVirtualCamera(vcam, DefaultWorldUp, deltaTime);
            //--更新Blend
            CinemachineBlend activeBlend = ActiveBlend;
            if (activeBlend != null)
                activeBlend.UpdateCameraState(DefaultWorldUp, deltaTime);

            // Restore the filter for general use
            //--恢复过滤器的一般用途
            CinemachineCore.Instance.CurrentUpdateFilter = CinemachineCore.UpdateFilter.Late;
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        private void ProcessActiveCamera(float deltaTime)
        {
            // This condition should never occur, but let's be defensive
            if (!isActiveAndEnabled)
            {
                mActiveCameraPreviousFrame = null;
                mOutgoingCameraPreviousFrame = null;
                mPreviousFrameWasOverride = false;
                return;
            }

            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineBrain.ProcessActiveCamera");
            //--获取当前激活的Stack
            OverrideStackFrame activeOverride = GetActiveOverride();
            //--获取当前激活的相机，这个也是会先看有没有OvrrideStackFrame,有的话就使用Stack中的相机，没有的话就是用
            //--优先级最高的相机
            ICinemachineCamera activeCamera = ActiveVirtualCamera;
            //--当前没有相机？那还扯啥犊子，不用操作了
            if (activeCamera == null)
                mOutgoingCameraPreviousFrame = null;
            else
            {
                // If there is an override, we kill the in-game blend
                //--如果有OverrideStackFrame则把当前的blend清空？大兄弟，如果这个混合是这个OverrideStackFrame的呢？
                if (activeOverride != null)
                    mActiveBlend = null;
                //--这个获取就是获取activeOverride的Blend这么写确实绕
                CinemachineBlend activeBlend = ActiveBlend;

                // Check for unexpected deletion of the cached mActiveCameraPreviousFrame
                //检查缓存的mActiveCameraPreviousFrame的绑定的GameObject是否被删除
                if (mActiveCameraPreviousFrame != null && mActiveCameraPreviousFrame.VirtualCameraGameObject == null)
                    mActiveCameraPreviousFrame = null;

                // 如果先前的相机和当前的不一样我们需要转换相机
                if (mActiveCameraPreviousFrame != activeCamera)
                {
                    // Do we need to create a game-play blend?
                    if (mActiveCameraPreviousFrame != null
                        //--之前的不是OverrideStackFrame
                        && !mPreviousFrameWasOverride
                        //--这里注意没有OverrideStackFrame时，才会创建混合，也就说OverrideStackFrame和普通模式之间没有混合过渡
                        && activeOverride == null
                        //--deltaTime有效需要创建过渡，如果时间小于0说明不需要过渡转换
                        && deltaTime >= 0)
                    {
                        // Create a blend (will be null if a cut)
                        float duration = 0;
                        //--查找混合曲线，有自定的曲线就按照自定义的来，没有则使用默认的混合曲线
                        AnimationCurve curve = LookupBlendCurve(
                            mActiveCameraPreviousFrame, activeCamera, out duration);
                        //--创建一个Blend
                        activeBlend = CreateBlend(
                                mActiveCameraPreviousFrame, activeCamera,
                                curve, duration, mActiveBlend);
                    }
                    // Need this check because Timeline override sometimes inverts outgoing and incoming
                    //--Timeline是可以淡入和淡出是可以翻转的。
                    //--什么意思呢？首先进入到这里的一定是当前相机和上一个相机不一样了，进行了切换
                    //--普通模式下mOutgoingCameraPreviousFrame为null，这里可以进入
                    //--如果是timeLine模式下，mOutgoingCameraPreviousFrame
                    if (activeCamera != mOutgoingCameraPreviousFrame)
                    {
                        // Notify incoming camera of transition
                        //--开始过度
                        activeCamera.OnTransitionFromCamera(mActiveCameraPreviousFrame, DefaultWorldUp, deltaTime);

                        // If the incoming camera is disabled, then we must assume
                        // that it has not been updated properly
                        //--如果当前激活的相机enable为fasle，当前混合为空，或者当前混合和当前相机无关
                        //--我们需要重新更新相机的状态
                        if (!activeCamera.VirtualCameraGameObject.activeInHierarchy
                            && (activeBlend == null || !activeBlend.Uses(activeCamera)))
                        {
                            activeCamera.UpdateCameraState(DefaultWorldUp, -1);
                        }
                        //--通知相机切换了
                        if (m_CameraActivatedEvent != null)
                            m_CameraActivatedEvent.Invoke(activeCamera);
                    }
                    // If we're cutting without a blend, or no active cameras
                    // were active last frame, send an event
                    //--没有触发混合的相机切换
                    if (activeBlend == null
                        || (activeBlend.CamA != mActiveCameraPreviousFrame
                            && activeBlend.CamB != mActiveCameraPreviousFrame
                            && activeBlend.CamA != mOutgoingCameraPreviousFrame
                            && activeBlend.CamB != mOutgoingCameraPreviousFrame))
                    {
                        if (m_CameraCutEvent != null)
                            m_CameraCutEvent.Invoke(this);
                    }
                }

                // Advance the current blend (if any)
                //--执行混合计算
                if (activeBlend != null)
                {
                    //--如果没有activeOverride直接进行activeBlend，如果处理时间为-1，则认为
                   //--混合为总体时长，则认为直接结束
                    if (activeOverride == null)
                        activeBlend.TimeInBlend += (deltaTime >= 0)
                            ? deltaTime : activeBlend.Duration;
                    if (activeBlend.IsComplete)
                        activeBlend = null;
                }
                //--如果没有OverrideStackFrame，则缓存当前的blend，如果有的话使用的是OverrideStackFrame的blend
                if (activeOverride == null)
                    mActiveBlend = activeBlend;

                // Apply the result to the Unity camera
                //--设置相机数据，有blend的使用blend的state，没有则使用当前激活的state
                CameraState state = activeCamera.State;
                if (activeBlend != null)
                    state = activeBlend.State;
                //--将state的属性给unity的摄像机
                PushStateToUnityCamera(state, activeCamera);
                //--记录混合的相机，我们看着这个是只有混合的时候才会被记录
                mOutgoingCameraPreviousFrame = null;
                if (activeBlend != null)
                    mOutgoingCameraPreviousFrame = activeBlend.CamB;
            }

            //--记录先前激活的相机
            mActiveCameraPreviousFrame = activeCamera;
            //--记录先前是否使用了OverrideStackFrame
            mPreviousFrameWasOverride = activeOverride != null;
            //--有OverrideStackFrame的情况下，无法辨别混合起始相机是谁，所以按照权重进行区分~
            //--首先为什么timeline中无法确定呢？因为timeline的mixer混合中只知道当前处于激活状态的两个相机是谁，
            //--无法判断出是哪个相机向哪个相机过渡，而普通模式则不会有这种情况，因为普通模式可以获取到当前激活的
            //--相机，然后和上个相机比较，只要不是同一个则进入混合。
            if (mPreviousFrameWasOverride)
            {
                // Hack: Because we don't know whether blending in or out... grrr...
                if (activeOverride.blend != null)
                {
                    if (activeOverride.blend.BlendWeight < 0.5f)
                    {
                        mActiveCameraPreviousFrame = activeOverride.blend.CamA;
                        mOutgoingCameraPreviousFrame = activeOverride.blend.CamB;
                    }
                    else
                    {
                        mActiveCameraPreviousFrame = activeOverride.blend.CamB;
                        mOutgoingCameraPreviousFrame = activeOverride.blend.CamA;
                    }
                }
            }
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        /// <summary>
        /// Is there a blend in progress?
        /// </summary>
        public bool IsBlending { get { return ActiveBlend != null && ActiveBlend.IsValid; } }

        /// <summary>
        /// Get the current blend in progress.  Returns null if none.
        /// </summary>
        public CinemachineBlend ActiveBlend
        {
            get
            {
                if (SoloCamera != null)
                    return null;
                OverrideStackFrame ovr = GetActiveOverride();
                return (ovr != null && ovr.blend != null) ? ovr.blend : mActiveBlend;
            }
        }

        /// <summary>
        /// True if the ICinemachineCamera the current active camera,
        /// or part of a current blend, either directly or indirectly because its parents are live.
        /// </summary>
        /// <param name="vcam">The camera to test whether it is live</param>
        /// <returns>True if the camera is live (directly or indirectly)
        /// or part of a blend in progress.</returns>
        public bool IsLive(ICinemachineCamera vcam)
        {
            if (IsLiveItself(vcam))
                return true;

            ICinemachineCamera parent = vcam.ParentCamera;
            while (parent != null && parent.IsLiveChild(vcam))
            {
                if (IsLiveItself(parent))
                    return true;
                vcam = parent;
                parent = vcam.ParentCamera;
            }
            return false;
        }

        // True if this vcam (not considering parents) actually live.
        private bool IsLiveItself(ICinemachineCamera vcam)
        {
            if (mActiveCameraPreviousFrame == vcam)
                return true;
            if (ActiveVirtualCamera == vcam)
                return true;
            if (IsBlending && ActiveBlend.Uses(vcam))
                return true;
            return false;
        }

        /// <summary>
        /// Get the current active virtual camera.
        /// </summary>
        public ICinemachineCamera ActiveVirtualCamera
        {
            get
            {
                if (SoloCamera != null)
                    return SoloCamera;
                OverrideStackFrame ovr = GetActiveOverride();
                return (ovr != null && ovr.camera != null) 
                    ? ovr.camera : TopCameraFromPriorityQueue();
            }
        }

        /// <summary>
        /// The current state applied to the unity camera (may be the result of a blend)
        /// </summary>
        public CameraState CurrentCameraState { get; private set; }

        /// <summary>
        /// Get the highest-priority Enabled ICinemachineCamera
        /// that is visible to my camera.  Culling Mask is used to test visibility.
        /// </summary>
        private ICinemachineCamera TopCameraFromPriorityQueue()
        {
            Camera outputCamera = OutputCamera;
            int mask = outputCamera == null ? ~0 : outputCamera.cullingMask;
            int numCameras = CinemachineCore.Instance.VirtualCameraCount;
            for (int i = 0; i < numCameras; ++i)
            {
                ICinemachineCamera cam = CinemachineCore.Instance.GetVirtualCamera(i);
                GameObject go = cam != null ? cam.VirtualCameraGameObject : null;
                if (go != null && (mask & (1 << go.layer)) != 0)
                    return cam;
            }
            return null;
        }

        /// <summary>
        /// 查找混合曲线
        /// </summary>
        private AnimationCurve LookupBlendCurve(
            ICinemachineCamera fromKey, ICinemachineCamera toKey, out float duration)
        {
            // Get the blend curve that's most appropriate for these cameras
            AnimationCurve blendCurve = m_DefaultBlend.BlendCurve;
            if (m_CustomBlends != null)
            {
                string fromCameraName = (fromKey != null) ? fromKey.Name : string.Empty;
                string toCameraName = (toKey != null) ? toKey.Name : string.Empty;
                blendCurve = m_CustomBlends.GetBlendCurveForVirtualCameras(
                        fromCameraName, toCameraName, blendCurve);
            }
            var keys = blendCurve.keys;
            duration = (keys == null || keys.Length == 0) ? 0 : keys[keys.Length-1].time;
            return blendCurve;
        }

        /// <summary>
        /// 创建一个Blend
        /// </summary>
        private CinemachineBlend CreateBlend(
            ICinemachineCamera camA, ICinemachineCamera camB, 
            AnimationCurve blendCurve, float duration,
            CinemachineBlend activeBlend)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineTrackedDolly.MutateCameraState");
            if (blendCurve == null || duration <= 0 || (camA == null && camB == null))
            {
                //UnityEngine.Profiling.Profiler.EndSample();
                return null;
            }
            //--其实这就挺尴尬的，此方法只有一个地方调用，并且调用者做了camA的非空判断
            //--这里的意思就是，如果camA为空，就从当前相机的位置开始混合。
            if (camA == null || activeBlend != null)
            {
                // Blend from the current camera position
                CameraState state = CameraState.Default;
                if (activeBlend != null)
                    state = activeBlend.State;
                else
                {
                    state.RawPosition = transform.position;
                    state.RawOrientation = transform.rotation;
                    state.Lens = LensSettings.FromCamera(OutputCamera);
                }
                camA = new StaticPointVirtualCamera(state, activeBlend == null ? "(none)" : "Mid-blend");
            }
            CinemachineBlend blend = new CinemachineBlend(camA, camB, blendCurve, duration, 0);
            //UnityEngine.Profiling.Profiler.EndSample();
            return blend;
        }

        /// <summary> Apply a cref="CameraState"/> to the game object</summary>
        private void PushStateToUnityCamera(CameraState state, ICinemachineCamera vcam)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineBrain.PushStateToUnityCamera");
            CurrentCameraState = state;
            transform.position = state.FinalPosition;
            transform.rotation = state.FinalOrientation;
            Camera cam = OutputCamera;
            if (cam != null)
            {
                cam.fieldOfView = state.Lens.FieldOfView;
                cam.orthographicSize = state.Lens.OrthographicSize;
                cam.nearClipPlane = state.Lens.NearClipPlane;
                cam.farClipPlane = state.Lens.FarClipPlane;
            }
            if (sPostProcessingHandler != null)
                sPostProcessingHandler.Invoke(this);
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        static int msCurrentFrame;
        static int msFirstBrainObjectId;
        static int msSubframes;
        //--用来统计一帧中被调用了多少次，如果是SamrtUpdate则需要根据调用次数进行计算
        void AddSubframe()
        {
            int now = Time.frameCount;
         //   Debug.Log("AddSubframe：" + msCurrentFrame + "   " + Time.frameCount);
            if (now == msCurrentFrame)
            {
                if (msFirstBrainObjectId == GetInstanceID())
                {
                    ++msSubframes;
         //           Debug.Log("添加msSubframes："+ msSubframes+"   "+Time.frameCount);
                }
                   
            }
            else
            {
                msCurrentFrame = now;
                msFirstBrainObjectId = GetInstanceID();
                msSubframes = 1;
            }
        }

        /// <summary>API for CinemachineCore only: Get the number of subframes to
        /// update the virtual cameras.</summary>
        /// <returns>Number of subframes registered by the first brain's FixedUpdate</returns>
        internal static int GetSubframeCount() { return Math.Max(1, msSubframes); }
    }

    /// <summary>
    /// Point source for blending. It's not really a virtual camera, but takes
    /// a CameraState and exposes it as a virtual camera for the purposes of blending.
    /// </summary>
    internal class StaticPointVirtualCamera : ICinemachineCamera
    {
        public StaticPointVirtualCamera(CameraState state, string name) { State = state; Name = name; }
        public void SetState(CameraState state) { State = state; }

        public string Name { get; private set; }
        public string Description { get { return ""; }}
        public int Priority { get; set; }
        public Transform LookAt { get; set; }
        public Transform Follow { get; set; }
        public CameraState State { get; private set; }
        public GameObject VirtualCameraGameObject { get { return null; } }
        public ICinemachineCamera LiveChildOrSelf { get { return this; } }
        public ICinemachineCamera ParentCamera { get { return null; } }
        public bool IsLiveChild(ICinemachineCamera vcam) { return false; }
        public void UpdateCameraState(Vector3 worldUp, float deltaTime) {}
        public void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime) {}
    }

    /// <summary>
    /// Blend result source for blending.   This exposes a CinemachineBlend object
    /// as an ersatz virtual camera for the purposes of blending.  This achieves the purpose
    /// of blending the result oif a blend.
    /// </summary>
    internal class BlendSourceVirtualCamera : ICinemachineCamera
    {
        public BlendSourceVirtualCamera(CinemachineBlend blend, float deltaTime)
        {
            Blend = blend;
            UpdateCameraState(blend.CamA.State.ReferenceUp, deltaTime);
        }

        public CinemachineBlend Blend { get; private set; }

        public string Name { get { return "Blend"; }}
        public string Description { get { return Blend.Description; }}
        public int Priority { get; set; }
        public Transform LookAt { get; set; }
        public Transform Follow { get; set; }
        public CameraState State { get; private set; }
        public GameObject VirtualCameraGameObject { get { return null; } }
        public ICinemachineCamera LiveChildOrSelf { get { return Blend.CamB; } }
        public ICinemachineCamera ParentCamera { get { return null; } }
        public bool IsLiveChild(ICinemachineCamera vcam) { return vcam == Blend.CamA || vcam == Blend.CamB; }
        public CameraState CalculateNewState(float deltaTime) { return State; }
        public void UpdateCameraState(Vector3 worldUp, float deltaTime)
        {
            Blend.UpdateCameraState(worldUp, deltaTime);
            State = Blend.State;
        }
        public void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime) {}
    }
}
