using System;
using UnityEngine;

namespace Cinemachine
{
    /// <summary>
    /// Base class for a Monobehaviour that represents a Virtual Camera within the Unity scene.
    ///
    /// This is intended to be attached to an empty Transform GameObject.
    /// Inherited classes can be either standalone virtual cameras such
    /// as CinemachineVirtualCamera, or meta-cameras such as
    /// CinemachineClearShot or CinemachineFreeLook.
    ///
    /// A CinemachineVirtualCameraBase exposes a Priority property.  When the behaviour is
    /// enabled in the game, the Virtual Camera is automatically placed in a queue
    /// maintained by the static CinemachineCore singleton.
    /// The queue is sorted by priority.  When a Unity camera is equipped with a
    /// CinemachineBrain behaviour, the brain will choose the camera
    /// at the head of the queue.  If you have multiple Unity cameras with CinemachineBrain
    /// behaviours (say in a split-screen context), then you can filter the queue by
    /// setting the culling flags on the virtual cameras.  The culling mask of the
    /// Unity Camera will then act as a filter for the brain.  Apart from this,
    /// there is nothing that prevents a virtual camera from controlling multiple
    /// Unity cameras simultaneously.
    /// </summary>
    [SaveDuringPlay]
    public abstract class CinemachineVirtualCameraBase : MonoBehaviour, ICinemachineCamera
    {
        /// <summary>This is deprecated.  It is here to support the soon-to-be-removed
        /// Cinemachine Debugger in the Editor.</summary>
        [HideInInspector, NoSaveDuringPlay]
        public Action CinemachineGUIDebuggerCallback = null;

        /// <summary>Inspector control - Use for hiding sections of the Inspector UI.</summary>
        [HideInInspector, SerializeField, NoSaveDuringPlay]
        public string[] m_ExcludedPropertiesInInspector = new string[] { "m_Script" };

        /// <summary>Inspector control - Use for enabling sections of the Inspector UI.</summary>
        [HideInInspector, SerializeField, NoSaveDuringPlay]
        public CinemachineCore.Stage[] m_LockStageInInspector;

        /// <summary>Version that was last streamed, for upgrading legacy</summary>
        public int ValidatingStreamVersion 
        { 
            get { return m_OnValidateCalled ? m_ValidatingStreamVersion : CinemachineCore.kStreamingVersion; }
            private set { m_ValidatingStreamVersion = value; } 
        }
        private int m_ValidatingStreamVersion = 0;
        private bool m_OnValidateCalled = false;

        [HideInInspector, SerializeField, NoSaveDuringPlay]
        private int m_StreamingVersion;

        /// <summary>The priority will determine which camera becomes active based on the
        /// state of other cameras and this camera.  Higher numbers have greater priority.
        /// </summary>
        [NoSaveDuringPlay]
        [Tooltip("The priority will determine which camera becomes active based on the state of other cameras and this camera.  Higher numbers have greater priority.")]
        public int m_Priority = 10;

        /// <summary>
        /// A delegate to hook into the state calculation pipeline.
        /// This will be called after each pipeline stage, to allow others to hook into the pipeline.
        /// See CinemachineCore.Stage.
        /// </summary>
        /// <param name="d">The delegate to call.</param>
        public virtual void AddPostPipelineStageHook(OnPostPipelineStageDelegate d)
        {
            OnPostPipelineStage -= d;
            OnPostPipelineStage += d;
        }

        /// <summary>Remove a Pipeline stage hook callback.
        /// 清除postPipeline的回调
        /// </summary>
        /// <param name="d">The delegate to remove.</param>
        public virtual void RemovePostPipelineStageHook(OnPostPipelineStageDelegate d)
        {
            OnPostPipelineStage -= d;
        }

        /// <summary>
        /// A delegate to hook into the state calculation pipeline.
        /// This will be called after each pipeline stage, to allow other
        /// services to hook into the pipeline.
        /// See CinemachineCore.Stage.
        /// 
        /// Parameters:
        /// 
        /// * CinemachineVirtualCameraBase vcam: the virtual camera being updated
        /// * CinemachineCore.Stage stage: what stage in the pipeline has just been updated
        /// * ref CameraState newState: the current state of the vcam
        /// * float deltaTime: the frame timestep.  Less than 0 means "don't consider the previous frame"
        /// </summary>
        public delegate void OnPostPipelineStageDelegate(
            CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage,
            ref CameraState newState, float deltaTime);

        /// <summary>
        /// 这里看不明白的是，代码里会在真正修改相机调用这个回调啊。。跟这里的翻译不太匹配啊
        /// A delegate to hook into the state calculation pipeline.
        /// Implementaion must be sure to call this after each pipeline stage, to allow
        /// other services to hook into the pipeline.
        /// See CinemachineCore.Stage.
        /// </summary>
        protected OnPostPipelineStageDelegate OnPostPipelineStage;

        /// <summary>
        /// Invokes the PostPipelineStageDelegate for this camera, and up the hierarchy for all
        /// parent cameras (if any).
        /// </summary>
        protected void InvokePostPipelineStageCallback(
            CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage,
            ref CameraState newState, float deltaTime)
        {
            if (OnPostPipelineStage != null)
                OnPostPipelineStage(vcam, stage, ref newState, deltaTime);
            //--更新父节点的stage
            CinemachineVirtualCameraBase parent = ParentCamera as CinemachineVirtualCameraBase;
            if (parent != null)
                parent.InvokePostPipelineStageCallback(vcam, stage, ref newState, deltaTime);
        }

        /// <summary>
        /// 相机的名称，返回绑定物体的名称
        /// </summary>
        public string Name { get { return name; } }

        /// <summary>Gets a brief debug description of this virtual camera, for use when displayiong debug info</summary>
        public virtual string Description { get { return ""; }}

        /// <summary>
        /// 当前相机的优先级
        /// </summary>
        public int Priority { get { return m_Priority; } set { m_Priority = value; } }

        /// <summary>
        /// 绑定的GameObject
        /// </summary>
        public GameObject VirtualCameraGameObject
        {
            get
            {
                if (this == null)
                    return null; // object deleted
                return gameObject;
            }
        }

        /// <summary>
        /// 当前相机的state
        /// </summary>
        public abstract CameraState State { get; }

        /// <summary>
        /// 激活的相机
        /// Just returns self.</summary>
        public virtual ICinemachineCamera LiveChildOrSelf { get { return this; } }

        /// <summary>Support for meta-virtual-cameras.  This is the situation where a
        /// virtual camera is in fact the public face of a private army of virtual cameras, which
        /// it manages on its own.  This method gets the VirtualCamera owner, if any.
        /// Private armies are implemented as Transform children of the parent vcam.</summary>
        public ICinemachineCamera ParentCamera
        {
            get
            {
                if (!mSlaveStatusUpdated || !Application.isPlaying)
                    UpdateSlaveStatus();
                return m_parentVcam;
            }
        }

        /// <summary>Check whether the vcam a live child of this camera.  
        /// This base class implementation always returns false.</summary>
        /// <param name="vcam">The Virtual Camera to check</param>
        /// <returns>True if the vcam is currently actively influencing the state of this vcam</returns>
        public virtual bool IsLiveChild(ICinemachineCamera vcam) { return false; }

        /// <summary>Get the LookAt target for the Aim component in the CinemachinePipeline.
        /// 看向的目标
        /// </summary>
        public abstract Transform LookAt { get; set; }

        /// <summary>Get the Follow target for the Body component in the CinemachinePipeline.
        /// 跟随的目标
        /// </summary>
        public abstract Transform Follow { get; set; }

        /// <summary>Set this to force the next update to ignore deltaTime and reset itself
        /// 检测跟随和看向的目标是否发生变更。
        /// 之前的状态是否可用，看向和跟随发生变更则返回false，不发生变更返回true
        /// </summary>
        public bool PreviousStateIsValid 
        { 
            get
            {
                if (LookAt != m_previousLookAtTarget)
                {
                    m_previousLookAtTarget = LookAt;
                    m_previousStateIsValid = false;
                }
                if (Follow != m_previousFollowTarget)
                {
                    m_previousFollowTarget = Follow;
                    m_previousStateIsValid = false;
                }
                return m_previousStateIsValid;
            }
            set
            {
                m_previousStateIsValid = value;
            }
        }
        private bool m_previousStateIsValid;
        private Transform m_previousLookAtTarget;
        private Transform m_previousFollowTarget;


        /// <summary>
        /// 相机更新，从CinemachineCore中进行调用
        /// Called by CinemachineCore at designated update time
        /// so the vcam can position itself and track its targets.  
        /// Do not call this method.  Let the framework do it at the appropriate time</summary>
        /// <param name="worldUp">Default world Up, set by the CinemachineBrain</param>
        /// <param name="deltaTime">Delta time for time-based effects (ignore if less than 0)</param>
        public abstract void UpdateCameraState(Vector3 worldUp, float deltaTime);

        /// <summary>
        /// 当前相机被激活，以及从哪个相机激活，混合结束则不再调用
        /// Notification that this virtual camera is going live.
        /// Base class implementationmust be called by any overridden method.</summary>
        /// <param name="fromCam">The camera being deactivated.  May be null.</param>
        /// <param name="worldUp">Default world Up, set by the CinemachineBrain</param>
        /// <param name="deltaTime">Delta time for time-based effects (ignore if less than or equal to 0)</param>
        public virtual void OnTransitionFromCamera(
            ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime) 
        {
            if (!gameObject.activeInHierarchy)
                PreviousStateIsValid = false;
        }

        /// <summary>Base class implementation does nothing.</summary>
        protected virtual void Start()
        {
        }

        /// <summary>Base class implementation removes the virtual camera from the priority queue.</summary>
        protected virtual void OnDestroy()
        {
            CinemachineCore.Instance.RemoveActiveCamera(this);
        }

        /// <summary>
        /// 编辑器模式下，当inspector面板数值发生变更时调用。
        /// </summary>
        protected virtual void OnValidate()
        {
            m_OnValidateCalled = true;
            ValidatingStreamVersion = m_StreamingVersion;
            m_StreamingVersion = CinemachineCore.kStreamingVersion;
        }

        /// <summary>Base class implementation adds the virtual camera from the priority queue.</summary>
        protected virtual void OnEnable()
        {
            // Sanity check - if another vcam component is enabled, shut down
            //如果一个物体上挂在了多个此脚本，只保留一个启用
            var vcamComponents = GetComponents<CinemachineVirtualCameraBase>();
            for (int i = 0; i < vcamComponents.Length; ++i)
            {
                if (vcamComponents[i].enabled && vcamComponents[i] != this)
                {
                    Debug.LogError(Name
                        + " has multiple CinemachineVirtualCameraBase-derived components.  Disabling "
                        + GetType().Name + ".");
                    enabled = false;
                }
            }
            UpdateSlaveStatus();
            UpdateVcamPoolStatus();    // Add to queue
            PreviousStateIsValid = false;
        }

        /// <summary>Base class implementation makes sure the priority queue remains up-to-date.</summary>
        protected virtual void OnDisable()
        {
            UpdateVcamPoolStatus();    // Remove from queue
        }

        /// <summary>Base class implementation makes sure the priority queue remains up-to-date.
        /// 优先级是否发生变更
        /// </summary>
        protected virtual void Update()
        {
            if (m_Priority != m_QueuePriority)
                UpdateVcamPoolStatus();
        }

        /// <summary>
        /// 当父子节点发生变化
        /// </summary>
        protected virtual void OnTransformParentChanged()
        {
            UpdateSlaveStatus();
            UpdateVcamPoolStatus();
        }

#if UNITY_EDITOR
        /// <summary>Support for the deprecated CinemachineDebugger.</summary>
        protected virtual void OnGUI()
        {
            if (CinemachineGUIDebuggerCallback != null)
                CinemachineGUIDebuggerCallback();
        }
#endif
        private bool mSlaveStatusUpdated = false;
        private CinemachineVirtualCameraBase m_parentVcam = null;
        /// <summary>
        /// 查看自己是否有父控制，也就是自己是child的控制器
        /// </summary>
        private void UpdateSlaveStatus()
        {
            mSlaveStatusUpdated = true;
            m_parentVcam = null;
            Transform p = transform.parent;
            if (p != null)
                m_parentVcam = p.GetComponent<CinemachineVirtualCameraBase>();
        }

        /// <summary>
        /// 如果localLookAt为空，如果有父级相机则返回父级相机的lookAt
        /// </summary>
        /// <param name="localLookAt">This vcam's LookAt value.</param>
        /// <returns>The same value, or the parent's if null and a parent exists.</returns>
        protected Transform ResolveLookAt(Transform localLookAt)
        {
            Transform lookAt = localLookAt;
            if (lookAt == null && ParentCamera != null)
                lookAt = ParentCamera.LookAt; // Parent provides default
            return lookAt;
        }

        /// <summary>
        /// 如果localfollow为空，如果有父级相机则返回父级相机的Follow
        /// </summary>
        /// <param name="localFollow">This vcam's Follow value.</param>
        /// <returns>The same value, or the parent's if null and a parent exists.</returns>
        protected Transform ResolveFollow(Transform localFollow)
        {
            Transform follow = localFollow;
            if (follow == null && ParentCamera != null)
                follow = ParentCamera.Follow; // Parent provides default
            return follow;
        }

        private int m_QueuePriority = int.MaxValue;
        /// <summary>
        /// 如果这个相机是根节点相机则加入到cinemachiencore的相机管理器中，
        /// 如果是个子相机则加入到child的相机管理中
        /// </summary>
        private void UpdateVcamPoolStatus()
        {
            m_QueuePriority = int.MaxValue;
            CinemachineCore.Instance.RemoveActiveCamera(this);
            CinemachineCore.Instance.RemoveChildCamera(this);
            if (m_parentVcam == null)
            {
                if (isActiveAndEnabled)
                {
                    CinemachineCore.Instance.AddActiveCamera(this);
                    m_QueuePriority = m_Priority;
                }
            }
            else
            {
                if (isActiveAndEnabled)
                    CinemachineCore.Instance.AddChildCamera(this);
            }
        }

        /// <summary>
        /// 将当前相机推到同级别优先级的最前端，如果优先级不同则无法超越。
        /// 比如相机A,B,C的优先级为1，D的优先级为2.则优先显示相机D，当D不显示的时候，如果想显示B则B调用此方法即可。
        /// </summary>
        public void MoveToTopOfPrioritySubqueue()
        {
            UpdateVcamPoolStatus();
        }
    }
}
