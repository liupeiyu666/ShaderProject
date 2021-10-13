using Cinemachine.Utility;
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine
{
    /// <summary>
    /// This behaviour is intended to be attached to an empty Transform GameObject, 
    /// and it represents a Virtual Camera within the Unity scene.
    /// 
    /// The Virtual Camera will animate its Transform according to the rules contained
    /// in its CinemachineComponent pipeline (Aim, Body, and Noise).  When the virtual
    /// camera is Live, the Unity camera will assume the position and orientation
    /// of the virtual camera.
    /// 
    /// A virtual camera is not a camera. Instead, it can be thought of as a camera controller,
    /// not unlike a cameraman. It can drive the Unity Camera and control its position, 
    /// orientation, lens settings, and PostProcessing effects. Each Virtual Camera owns 
    /// its own Cinemachine Component Pipeline, through which you provide the instructions 
    /// for dynamically tracking specific game objects. 
    /// 
    /// A virtual camera is very lightweight, and does no rendering of its own. It merely 
    /// tracks interesting GameObjects, and positions itself accordingly. A typical game 
    /// can have dozens of virtual cameras, each set up to follow a particular character 
    /// or capture a particular event. 
    /// 
    /// A Virtual Camera can be in any of three states: 
    /// 
    /// * **Live**: The virtual camera is actively controlling the Unity Camera. The 
    /// virtual camera is tracking its targets and being updated every frame. 
    /// * **Standby**: The virtual camera is tracking its targets and being updated 
    /// every frame, but no Unity Camera is actively being controlled by it. This is 
    /// the state of a virtual camera that is enabled in the scene but perhaps at a 
    /// lower priority than the Live virtual camera. 
    /// * **Disabled**: The virtual camera is present but disabled in the scene. It is 
    /// not actively tracking its targets and so consumes no processing power. However, 
    /// the virtual camera can be made live from the Timeline. 
    /// 
    /// The Unity Camera can be driven by any virtual camera in the scene. The game 
    /// logic can choose the virtual camera to make live by manipulating the virtual 
    /// cameras' enabled flags and their priorities, based on game logic. 
    ///
    /// In order to be driven by a virtual camera, the Unity Camera must have a CinemachineBrain 
    /// behaviour, which will select the most eligible virtual camera based on its priority 
    /// or on other criteria, and will manage blending. 
    /// 基础相机
    /// </summary>
    /// <seealso cref="CinemachineVirtualCameraBase"/>
    /// <seealso cref="LensSettings"/>
    /// <seealso cref="CinemachineComposer"/>
    /// <seealso cref="CinemachineTransposer"/>
    /// <seealso cref="CinemachineBasicMultiChannelPerlin"/>
    [DocumentationSorting(1, DocumentationSortingAttribute.Level.UserRef)]
    [ExecuteInEditMode, DisallowMultipleComponent]
    [AddComponentMenu("Cinemachine/CinemachineVirtualCamera")]
    public class CinemachineVirtualCamera : CinemachineVirtualCameraBase
    {
        /// <summary>The object that the camera wants to look at (the Aim target).
        /// The Aim component of the CinemachineComponent pipeline
        /// will refer to this target and orient the vcam in accordance with rules and
        /// settings that are provided to it.
        /// If this is null, then the vcam's Transform orientation will be used.</summary>
        [Tooltip("The object that the camera wants to look at (the Aim target).  If this is null, then the vcam's Transform orientation will define the camera's orientation.")]
        [NoSaveDuringPlay]
        public Transform m_LookAt = null;

        /// <summary>The object that the camera wants to move with (the Body target).
        /// The Body component of the CinemachineComponent pipeline
        /// will refer to this target and position the vcam in accordance with rules and
        /// settings that are provided to it.
        /// If this is null, then the vcam's Transform position will be used.</summary>
        [Tooltip("The object that the camera wants to move with (the Body target).  If this is null, then the vcam's Transform position will define the camera's position.")]
        [NoSaveDuringPlay]
        public Transform m_Follow = null;

        /// <summary>
        /// 相机的参数设置
        /// </summary>
        [FormerlySerializedAs("m_LensAttributes")]
        [LensSettingsProperty]
        public LensSettings m_Lens = LensSettings.Default;

        /// <summary>This is the name of the hidden GameObject that will be created as a child object
        /// of the virtual camera.  This hidden game object acts as a container for the polymorphic
        /// CinemachineComponent pipeline.  The Inspector UI for the Virtual Camera
        /// provides access to this pipleline, as do the CinemachineComponent-family of
        /// public methods in this class.
        /// The lifecycle of the pipeline GameObject is managed automatically.</summary>
        public const string PipelineName = "cm";

        /// <summary>
        /// 当前相机的state
        /// </summary>
        override public CameraState State { get { return m_State; } }
        override public Transform LookAt
        {
            get { return ResolveLookAt(m_LookAt); }
            set { m_LookAt = value; }
        }
        override public Transform Follow
        {
            get { return ResolveFollow(m_Follow); }
            set { m_Follow = value; }
        }
        override public void UpdateCameraState(Vector3 worldUp, float deltaTime)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineVirtualCamera.UpdateCameraState");
            //--当前相机跟随和看向是否发生了变更，变更返回false
            if (!PreviousStateIsValid)
                deltaTime = -1;

            // Reset the base camera state, in case the game object got moved in the editor
            //重置相机状态，下面的CalculateNewState会重置一次
            //状态变更则重置
            if (deltaTime < 0)
                m_State = PullStateFromVirtualCamera(worldUp); // not in gameplay

            // Update the state by invoking the component pipeline
            //计算相机的数据
            m_State = CalculateNewState(worldUp, deltaTime);

            // Push the raw position back to the game object's transform, so it
            // moves along with the camera.
            //编辑器模式下，如果有外部更改生相机位置则使用新的位置
            if (!UserIsDragging)
            {
                if (Follow != null)
                    transform.position = State.RawPosition;
                if (LookAt != null)
                    transform.rotation = State.RawOrientation;
            }
            PreviousStateIsValid = true;
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        /// <summary>Make sure that the pipeline cache is up-to-date.</summary>
        override protected void OnEnable()
        {
            base.OnEnable();
            InvalidateComponentPipeline();

            // Can't add components during OnValidate
            if (ValidatingStreamVersion < 20170927)
            {
                if (Follow != null && GetCinemachineComponent(CinemachineCore.Stage.Body) == null)
                    AddCinemachineComponent<CinemachineHardLockToTarget>();
                if (LookAt != null && GetCinemachineComponent(CinemachineCore.Stage.Aim) == null)
                    AddCinemachineComponent<CinemachineHardLookAt>();
            }
        }

        /// <summary>Calls the DestroyPipelineDelegate for destroying the hidden
        /// child object, to support undo.</summary>
        protected override void OnDestroy()
        {
            // Make the pipeline visible instead of destroying - this is to keep Undo happy
            //foreach (Transform child in transform)
            //    if (child.GetComponent<CinemachinePipeline>() != null)
            //        child.gameObject.hideFlags
            //            &= ~(HideFlags.HideInHierarchy | HideFlags.HideInInspector);

            base.OnDestroy();
        }

        /// <summary>Enforce bounds for fields, when changed in inspector.</summary>
        protected override void OnValidate()
        {
            base.OnValidate();
            m_Lens.Validate();
        }

        void OnTransformChildrenChanged()
        {
            InvalidateComponentPipeline();
        }

        void Reset()
        {
            DestroyPipeline();
        }

        /// <summary>
        /// Override component pipeline creation.
        /// This needs to be done by the editor to support Undo.
        /// The override must do exactly the same thing as the CreatePipeline method in this class.
        /// </summary>
        public static CreatePipelineDelegate CreatePipelineOverride;

        /// <summary>
        ///创建pipeline容器委托
        /// </summary>
        public delegate Transform CreatePipelineDelegate(
            CinemachineVirtualCamera vcam, string name, CinemachineComponentBase[] copyFrom);

        /// <summary>
        /// Override component pipeline destruction.
        /// This needs to be done by the editor to support Undo.
        /// </summary>
        public static DestroyPipelineDelegate DestroyPipelineOverride;

        /// <summary>
        ///销毁pipeline的回调
        /// </summary>
        public delegate void DestroyPipelineDelegate(GameObject pipeline);

        /// <summary>
        /// 销毁pipeline容器
        /// </summary>
        private void DestroyPipeline()
        {
            List<Transform> oldPipeline = new List<Transform>();
            foreach (Transform child in transform)
                if (child.GetComponent<CinemachinePipeline>() != null)
                    oldPipeline.Add(child);
            
            foreach (Transform child in oldPipeline)
            {
                if (DestroyPipelineOverride != null)
                    DestroyPipelineOverride(child.gameObject);
                else
                    Destroy(child.gameObject);
            }
            m_ComponentOwner = null;
            PreviousStateIsValid = false;
        }

        /// <summary>
        /// 创建一个pipline的容器
        /// </summary>
        private Transform CreatePipeline(CinemachineVirtualCamera copyFrom)
        {
            CinemachineComponentBase[] components = null;
            if (copyFrom != null)
            {
                copyFrom.InvalidateComponentPipeline(); // make sure it's up to date
                //--获取
                components = copyFrom.GetComponentPipeline();
                Debug.LogError("-CreatePipeline:" + components.Length);
            }

            Transform newPipeline = null;
            if (CreatePipelineOverride != null)
                newPipeline = CreatePipelineOverride(this, PipelineName, components);
            else
            {
                GameObject go =  new GameObject(PipelineName);
                go.transform.parent = transform;
                go.AddComponent<CinemachinePipeline>();
                newPipeline = go.transform;
                if (components != null)
                    foreach (Component c in components)
                    {
                        ReflectionHelpers.CopyFields(c, go.AddComponent(c.GetType()));
                    }
                        
            }
            PreviousStateIsValid = false;
            return newPipeline;
        }

        /// <summary>
        /// Editor API: Call this when changing the pipeline from the editor.
        /// Will force a rebuild of the pipeline cache.
        /// 重置pipeline容器上组件
        /// </summary>
        public void InvalidateComponentPipeline() { m_ComponentPipeline = null; }

        /// <summary>
        /// 获取pipeline的容器
        /// .</summary>
        public Transform GetComponentOwner() { UpdateComponentPipeline(); return m_ComponentOwner; }

        /// <summary>
        /// 获取pipeline的所有组件
        /// </summary>
        public CinemachineComponentBase[] GetComponentPipeline() { UpdateComponentPipeline(); return m_ComponentPipeline; }

        /// <summary>
        /// 获取指定stage类型的Component
        /// </returns>
        public CinemachineComponentBase GetCinemachineComponent(CinemachineCore.Stage stage)
        {
            CinemachineComponentBase[] components = GetComponentPipeline();
            if (components != null)
                foreach (var c in components)
                    if (c.Stage == stage)
                        return c;
            return null;
        }

        /// <summary>
        /// 获取指定stage类型的Component
        /// </summary>
        public T GetCinemachineComponent<T>() where T : CinemachineComponentBase
        {
            CinemachineComponentBase[] components = GetComponentPipeline();
            if (components != null)
                foreach (var c in components)
                    if (c is T)
                        return c as T;
            return null;
        }

        /// <summary>
        /// 添加组件，将其添加pipeline容器中
        /// </summary>
        public T AddCinemachineComponent<T>() where T : CinemachineComponentBase
        {
            // Get the existing components
            Transform owner = GetComponentOwner();
            CinemachineComponentBase[] components = owner.GetComponents<CinemachineComponentBase>();

            T component = owner.gameObject.AddComponent<T>();
            if (component != null && components != null)
            {
                // Remove the existing components at that stage
                CinemachineCore.Stage stage = component.Stage;
                for (int i = components.Length - 1; i >= 0; --i)
                {
                    if (components[i].Stage == stage)
                    {
                        components[i].enabled = false;
                        DestroyImmediate(components[i]);
                    }
                }
            }
            InvalidateComponentPipeline();
            return component;
        }

        /// <summary>
        /// 从pipeline容器中删除指定组件
        /// </summary>
        public void DestroyCinemachineComponent<T>() where T : CinemachineComponentBase
        {
            CinemachineComponentBase[] components = GetComponentPipeline();
            if (components != null)
            {
                foreach (var c in components)
                {
                    if (c is T)
                    {
                        c.enabled = false;
                        DestroyImmediate(c);
                        InvalidateComponentPipeline();
                    }
                }
            }
        }

        /// <summary>API for the editor, to make the dragging of position handles behave better.</summary>
        public bool UserIsDragging { get; set; }

        /// <summary>API for the editor, to process a position drag from the user.</summary>
        public void OnPositionDragged(Vector3 delta)
        {
            CinemachineComponentBase[] components = GetComponentPipeline();
            if (components != null)
                for (int i = 0; i < components.Length; ++i)
                    components[i].OnPositionDragged(delta);
        }
        //当前的相机状态
        CameraState m_State = CameraState.Default; // Current state this frame
        /// <summary>
        /// 这个相机的Pipline上挂载的组件。其实pipline只是一个gameobjet的容器，
        /// CinemachineComponentBase是挂载这个gameobjet的组件
        /// </summary>
        CinemachineComponentBase[] m_ComponentPipeline = null;
        /// <summary>
        /// pipline只是一个gameobjet的容器，m_ComponentOwner就这个gameobjet
        /// </summary>
        [SerializeField] public Transform m_ComponentOwner = null;   // serialized to handle copy/paste
        void UpdateComponentPipeline()
        {
            //--设置Go的显示属性
            if (m_ComponentOwner!=null)
            {
                m_ComponentOwner.hideFlags = HideFlags.None;
            }
            // 如果已经存在pipeline则直接拷贝之前pipeline绑定的CinemachineVirtualCamera的数据
            if (m_ComponentOwner != null && m_ComponentOwner.parent != transform)
            {
                CinemachineVirtualCamera copyFrom = (m_ComponentOwner.parent != null)
                    ? m_ComponentOwner.parent.gameObject.GetComponent<CinemachineVirtualCamera>() : null;
                DestroyPipeline();
                m_ComponentOwner = CreatePipeline(copyFrom);
            }

            // 更新完成就返回
            if (m_ComponentOwner != null && m_ComponentPipeline != null)
                return;

            m_ComponentOwner = null;
            List<CinemachineComponentBase> list = new List<CinemachineComponentBase>();
            //--pipLine在cinemachine的子节点下面，挂在有CinemachinePipeline脚本
            foreach (Transform child in transform)
            {
                if (child.GetComponent<CinemachinePipeline>() != null)
                {
                    m_ComponentOwner = child;
                    //--或者上面的CinemachineComponentBase的组件
                    CinemachineComponentBase[] components = child.GetComponents<CinemachineComponentBase>();
                    foreach (CinemachineComponentBase c in components)
                        list.Add(c);
                }
            }

            // Make sure we have a pipeline owner
            //--如果经过以上两次还是没有pipeline说过pipeline还没有被创建，我们需要创建一个pipeline
            if (m_ComponentOwner == null)
                m_ComponentOwner = CreatePipeline(null);
            // Make sure the pipeline stays hidden, even through prefab
            //if (CinemachineCore.sShowHiddenObjects)
            //    m_ComponentOwner.gameObject.hideFlags
            //        &= ~(HideFlags.HideInHierarchy | HideFlags.HideInInspector);
            //else
            //    m_ComponentOwner.gameObject.hideFlags
            //        |= (HideFlags.HideInHierarchy | HideFlags.HideInInspector);

            // Sort the pipeline
            //--对pipeline中ComponentBase按照优先级进行排序
            list.Sort((c1, c2) => (int)c1.Stage - (int)c2.Stage);
            m_ComponentPipeline = list.ToArray();
        }
        /// <summary>
        /// 计算相机的state，核心函数
        /// </summary>
        /// <param name="worldUp"></param>
        /// <param name="deltaTime"></param>
        /// <returns></returns>
        private CameraState CalculateNewState(Vector3 worldUp, float deltaTime)
        {
            // Initialize the camera state, in case the game object got moved in the editor
            //初始化这个相机
            CameraState state = PullStateFromVirtualCamera(worldUp);
            //--设置要看向的位置
            if (LookAt != null)
                state.ReferenceLookAt = LookAt.position;

            // Update the state by invoking the component pipeline
            CinemachineCore.Stage curStage = CinemachineCore.Stage.Body;
            //--更新pipeline
            UpdateComponentPipeline(); // avoid GetComponentPipeline() here because of GC
            if (m_ComponentPipeline != null)
            {
                //--改变state前调用，设置偏移RefereceLookAt
                for (int i = 0; i < m_ComponentPipeline.Length; ++i)
                    m_ComponentPipeline[i].PrePipelineMutateCameraState(ref state);

                for (int i = 0; i < m_ComponentPipeline.Length; ++i)
                {
                    //--改变相机前只调用
                    curStage = AdvancePipelineStage(
                        ref state, deltaTime, curStage, (int)m_ComponentPipeline[i].Stage);
                    //--计算CameraState的状态数据
                    m_ComponentPipeline[i].MutateCameraState(ref state, deltaTime);
                }
            }
            int numStages = 3; //Enum.GetValues(typeof(CinemachineCore.Stage)).Length;
            //--需要将这个相机的所有的stage都执行一遍，因为现在只有3个，确保都执行到。  
            //--奇怪的点在于Body Aim Noise,如果组件上只有Body，则Aim和Noise都会执行，如果只有Aim则Body不会执行，Noise依旧会执行,这个设计没搞懂。主要是用于CinemachineExtension使用
            AdvancePipelineStage(ref state, deltaTime, curStage, numStages); 
            return state;
        }
        /// <summary>
        /// 外部通知，stage发生变更，如果是pipeline中的stage，在相机计算前执行，如果是pipeline中没有的stage
        /// 则执行比pipeline中级别靠后的且在相机数据计算之后执行
        /// </summary>
        /// <param name="state"></param>
        /// <param name="deltaTime"></param>
        /// <param name="curStage"></param>
        /// <param name="maxStage"></param>
        /// <returns></returns>
        private CinemachineCore.Stage AdvancePipelineStage(
            ref CameraState state, float deltaTime,
            CinemachineCore.Stage curStage, int maxStage)
        {
            while ((int)curStage < maxStage)
            {
                InvokePostPipelineStageCallback(this, curStage, ref state, deltaTime);
                ++curStage;
            }
            return curStage;
        }
        /// <summary>
        /// 根据当前virtualCamera重新设置CameraState
        /// </summary>
        /// <param name="worldUp"></param>
        /// <returns></returns>
        private CameraState PullStateFromVirtualCamera(Vector3 worldUp)
        {
            CameraState state = CameraState.Default;
            state.RawPosition = transform.position;
            state.RawOrientation = transform.rotation;
            state.ReferenceUp = worldUp;

            CinemachineBrain brain = CinemachineCore.Instance.FindPotentialTargetBrain(this);
            m_Lens.Aspect = brain != null ? brain.OutputCamera.aspect : 1;
            m_Lens.Orthographic = brain != null ? brain.OutputCamera.orthographic : false;
            state.Lens = m_Lens;

            return state;
        }

        // This is a hack for FreeLook rigs - to be removed
        /// <summary>
        /// 设置相机的位置
        /// </summary>
        /// <param name="pos"></param>
        internal void SetStateRawPosition(Vector3 pos) { m_State.RawPosition = pos; }
    }
}
