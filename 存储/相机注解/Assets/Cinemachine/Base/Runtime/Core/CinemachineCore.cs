using UnityEngine;
using System.Collections.Generic;

namespace Cinemachine
{
    /// <summary>A singleton that manages complete lists of CinemachineBrain and,
    /// Cinemachine Virtual Cameras, and the priority queue.  Provides
    /// services to keeping track of whether Cinemachine Virtual Cameras have
    /// been updated each frame.</summary>
    public sealed class CinemachineCore
    {
        /// <summary>Data version string.  Used to upgrade from legacy projects</summary>
        public static readonly int kStreamingVersion = 20170927;

        /// <summary>Human-readable Cinemachine Version</summary>
        public static readonly string kVersionString = "2.1";

        /// <summary>
        /// Stages in the Cinemachine Component pipeline, used for
        /// UI organization>.  This enum defines the pipeline order.
        /// </summary>
        public enum Stage
        {
            /// <summary>Second stage: position the camera in space</summary>
            Body,

            /// <summary>Third stage: orient the camera to point at the target</summary>
            Aim,

            /// <summary>Final stage: apply noise (this is done separately, in the
            /// Correction channel of the CameraState)</summary>
            Noise
        };

        private static CinemachineCore sInstance = null;

        /// <summary>Get the singleton instance</summary>
        public static CinemachineCore Instance
        {
            get
            {
                if (sInstance == null)
                    sInstance = new CinemachineCore();
                return sInstance;
            }
        }

        /// <summary>
        /// If true, show hidden Cinemachine objects, to make manual script mapping possible.
        /// </summary>
        public static bool sShowHiddenObjects = false;

        /// <summary>Delegate for overriding Unity's default input system.  Returns the value
        /// of the named axis.</summary>
        public delegate float AxisInputDelegate(string axisName);

        /// <summary>
        /// 数据轴控制 ，用于滑屏操作
        /// </summary>
        public static AxisInputDelegate GetInputAxis = UnityEngine.Input.GetAxis;

        /// <summary>
        /// 当前激活的Brains
        /// </summary>
        private List<CinemachineBrain> mActiveBrains = new List<CinemachineBrain>();

        /// <summary>Access the array of active CinemachineBrains in the scene</summary>
        public int BrainCount { get { return mActiveBrains.Count; } }

        /// <summary>
        /// 根据下标获取当前激活的Brain
        /// </summary>
        /// <param name="index">Index of the brain to access, range 0-BrainCount</param>
        /// <returns>The brain at the specified index</returns>
        public CinemachineBrain GetActiveBrain(int index)
        {
            return mActiveBrains[index];
        }

        /// <summary>Called when a CinemachineBrain is enabled.</summary>
        internal void AddActiveBrain(CinemachineBrain brain)
        {
            // First remove it, just in case it's being added twice
            RemoveActiveBrain(brain);
            mActiveBrains.Insert(0, brain);
        }

        /// <summary>Called when a CinemachineBrain is disabled.</summary>
        internal void RemoveActiveBrain(CinemachineBrain brain)
        {
            mActiveBrains.Remove(brain);
        }
        /// <summary>
        /// 这里CinemachineBrain和Cameras是相互独立的，并不是一个Brain里管理自己的Cameras。
        /// 这里的问题就是为什么Brain不是单独存在的呢？我们看到Brain只是处理Blend的，可以处理相同相机
        /// 切换时，不一样的混合？这个需求还是不常见。 另外就是Brain可以layer去屏蔽某个相机。可视Brain
        /// 没有优先级的概念啊，同时激活的Brain如果有多个的会导致相机显示不对啊~~或许是为了什么扩展吧
        /// </summary>
        private List<ICinemachineCamera> mActiveCameras = new List<ICinemachineCamera>();

        /// <summary>
        /// List of all active Cinemachine Virtual Cameras for all brains.
        /// This list is kept sorted by priority.
        /// </summary>
        public int VirtualCameraCount { get { return mActiveCameras.Count; } }

        /// <summary>Access the array of active ICinemachineCamera in the scene 
        /// without gebnerating garbage</summary>
        /// <param name="index">Index of the camera to access, range 0-VirtualCameraCount</param>
        /// <returns>The virtual camera at the specified index</returns>
        public ICinemachineCamera GetVirtualCamera(int index)
        {
            return mActiveCameras[index];
        }

        /// <summary>Called when a Cinemachine Virtual Camera is enabled.</summary>
        internal void AddActiveCamera(ICinemachineCamera vcam)
        {
            // Bring it to the top of the list
            RemoveActiveCamera(vcam);

            // Keep list sorted by priority
            int insertIndex;
            for (insertIndex = 0; insertIndex < mActiveCameras.Count; ++insertIndex)
                if (vcam.Priority >= mActiveCameras[insertIndex].Priority)
                    break;

            mActiveCameras.Insert(insertIndex, vcam);
        }

        /// <summary>Called when a Cinemachine Virtual Camera is disabled.</summary>
        internal void RemoveActiveCamera(ICinemachineCamera vcam)
        {
            mActiveCameras.Remove(vcam);
        }

        // Registry of all vcams that are parented (i.e. slaves of) to other vcams
        /// <summary>
        /// 有父子节点的相机，所有相同等级的相机存储在一起。
        /// 比A.B.C其中的层级关系，并且ABC均有摄像机，D.E，则mchildCameras的有两个其中BE为一组，C为一组
        /// </summary>
        private List<List<ICinemachineCamera>> mChildCameras = new List<List<ICinemachineCamera>>();

        /// <summary>Called when a child vcam is enabled.</summary>
        internal void AddChildCamera(ICinemachineCamera vcam)
        {
            RemoveChildCamera(vcam);

            int parentLevel = 0;
            //--找到自己的父的根节点，parentLevel自己与父节点相差多少层
            for (ICinemachineCamera p = vcam; p != null; p = p.ParentCamera)
                ++parentLevel;
            //--
            while (mChildCameras.Count < parentLevel)
                mChildCameras.Add(new List<ICinemachineCamera>());

            mChildCameras[parentLevel-1].Add(vcam);
        }

        /// <summary>Called when a child vcam is disabled.</summary>
        internal void RemoveChildCamera(ICinemachineCamera vcam)
        {
            for (int i = 0; i < mChildCameras.Count; ++i)
                mChildCameras[i].Remove(vcam);
        }

        /// <summary>
        /// 更新所有的虚拟相机
        /// </summary>
        internal void UpdateAllActiveVirtualCameras(Vector3 worldUp, float deltaTime)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineCore.UpdateAllActiveVirtualCameras");
            int numCameras;

            // Update the leaf-most cameras first
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineCore.UpdateAllActiveVirtualCameras.leaf-most");
            //--更新子相机，优先末端的
            for (int i = mChildCameras.Count-1; i >= 0; --i)
            {
                numCameras = mChildCameras[i].Count;
                for (int j = 0; j < numCameras; ++j)
                    UpdateVirtualCamera(mChildCameras[i][j], worldUp, deltaTime);
            }
            //UnityEngine.Profiling.Profiler.EndSample();

            // Then all the top-level cameras
            //--更新所有最高层的相机，包括所有激活和未激活的相机
            numCameras = VirtualCameraCount;
            for (int i = 0; i < numCameras; ++i)
                UpdateVirtualCamera(GetVirtualCamera(i), worldUp, deltaTime);
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        /// <summary>
        /// Update a single Cinemachine Virtual Camera if and only if it
        /// hasn't already been updated this frame.  Always update vcams via this method.
        /// Calling this more than once per frame for the same camera will have no effect.
        /// </summary>
        internal bool UpdateVirtualCamera(ICinemachineCamera vcam, Vector3 worldUp, float deltaTime)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineCore.UpdateVirtualCamera");
            //---记录当前帧，用于避免同帧多次执行
            int now = Time.frameCount;
            //--当前的更细模式，在CinemachineBrain中会进行设置
            UpdateFilter filter = CurrentUpdateFilter;
            //--UpdateMethod为SmartUpdate
            bool isSmartUpdate = filter != UpdateFilter.ForcedFixed 
                && filter != UpdateFilter.ForcedLate;
            //--是否是在LateUpdate中调用的~filter
            bool isSmartLateUpdate = filter == UpdateFilter.Late;
            //--将filter全部设置为fixed和late模式
            if (!isSmartUpdate)
            {
                if (filter == UpdateFilter.ForcedFixed)
                    filter = UpdateFilter.Fixed;
                if (filter == UpdateFilter.ForcedLate)
                    filter = UpdateFilter.Late;
            }

            if (mUpdateStatus == null)
                mUpdateStatus = new Dictionary<ICinemachineCamera, UpdateStatus>();
            //--相机不存在，移除
            if (vcam.VirtualCameraGameObject == null)
            {
                if (mUpdateStatus.ContainsKey(vcam))
                    mUpdateStatus.Remove(vcam);
                //UnityEngine.Profiling.Profiler.EndSample();
                return false; // camera was deleted
            }
            UpdateStatus status;
            //--创建更新申请
            if (!mUpdateStatus.TryGetValue(vcam, out status))
            {
                status = new UpdateStatus(now);
                mUpdateStatus.Add(vcam, status);
            }
            //--如果是fixedupate和Smartupdate会在记录物理帧调用次数
            int subframes = isSmartLateUpdate ? 1 : CinemachineBrain.GetSubframeCount();
            //--如果不是同一帧的请求，清空本帧的请求次数
            if (status.lastUpdateFrame != now)
                status.lastUpdateSubframe = 0;

            // If we're in smart update mode and the target moved, then we must examine
            // how the target has been moving recently in order to figure out whether to
            // update now
            //--如果不是smartUpdate则请求更新则立即更新，
            bool updateNow = !isSmartUpdate;
            //如果当前模式为SmartUpdate
            if (isSmartUpdate)
            {
                Matrix4x4 targetPos;
                //--没有目标，如果samrtupdate是在lateupdate中发送的，则依旧更新
                if (!GetTargetPosition(vcam, out targetPos))
                    updateNow = isSmartLateUpdate; // no target
                else
                    //--获取上次记录的模式，如果和本次一直则立即更新，否则不处理
                    updateNow = status.ChoosePreferredUpdate(now, targetPos, filter) 
                        == filter;
            }
            //--需要立刻更新
            if (updateNow)
            {
             //   Debug.Log("*******UpdateNowIsTrue:"+filter+"  " + subframes+"  "+ status.lastUpdateSubframe+"  "+Time.frameCount);
                //--记录更新时的更新模式
                status.preferredUpdate = filter;
                //--对于物理帧的执行，则再次进行操作。
                while (status.lastUpdateSubframe < subframes)
                {
//Debug.Log(vcam.Name + ": frame " + Time.frameCount + "." + status.lastUpdateSubframe + ", " + CurrentUpdateFilter + ", deltaTime = " + deltaTime);
                    vcam.UpdateCameraState(worldUp, deltaTime);
                    ++status.lastUpdateSubframe;
                }
                status.lastUpdateFrame = now;
            }

            mUpdateStatus[vcam] = status;
            //UnityEngine.Profiling.Profiler.EndSample();
            return true;
        }

        struct UpdateStatus
        {
            const int kWindowSize = 30;

            public int lastUpdateFrame;
            public int lastUpdateSubframe;

            public int windowStart;
            public int numWindowLateUpdateMoves;
            public int numWindowFixedUpdateMoves;
            public int numWindows;
            public UpdateFilter preferredUpdate;

            public Matrix4x4 targetPos;

            public UpdateStatus(int currentFrame)
            {
                lastUpdateFrame = -1;
                lastUpdateSubframe = 0;
                windowStart = currentFrame;
                numWindowLateUpdateMoves = 0;
                numWindowFixedUpdateMoves = 0;
                numWindows = 0;
                preferredUpdate = UpdateFilter.Late;
                targetPos = Matrix4x4.zero;
            }

            // Important: updateFilter may ONLY be Late or Fixed
            /// <summary>
            /// 只有SamrtUpdate模式下才会调用
            /// </summary>
            /// <param name="currentFrame"></param>
            /// <param name="pos"></param>
            /// <param name="updateFilter"></param>
            /// <returns></returns>
            public UpdateFilter ChoosePreferredUpdate(
                int currentFrame, Matrix4x4 pos, UpdateFilter updateFilter)
            {
                //--位置不同，记录更新信息。
                if (targetPos != pos)
                {
                    //是在LateUpate的请求记录一次
                    if (updateFilter == UpdateFilter.Late)
                        ++numWindowLateUpdateMoves;
                    //如果在是FixedUpdate中请求的，并且lastUpdateSubframe为0记录一次，LastUpdateSubFrame在下一帧更新
                    //时，会将其设置为0
                    else if (lastUpdateSubframe == 0)
                        ++numWindowFixedUpdateMoves;
                    targetPos = pos;
                }
                //Debug.Log("Fixed=" + numWindowFixedUpdateMoves + ", Late=" + numWindowLateUpdateMoves);
                //--上一次请求的记录
                UpdateFilter choice = preferredUpdate;
                //--如果目标移动在LateUpdate和Update中都发生过请求，
                bool inconsistent = numWindowLateUpdateMoves > 0 && numWindowFixedUpdateMoves > 0;
                //--这句话的意思就是只要LateUpdate请求过就使用LateUpdate的，否则就使用FixedUpdate的
                if (inconsistent || numWindowLateUpdateMoves >= numWindowFixedUpdateMoves)
                    choice = UpdateFilter.Late;
                else
                    choice = UpdateFilter.Fixed;
                //--第一次的话就使用计算的，如果不是第一次则按照下面的方式计算
                if (numWindows == 0)
                    preferredUpdate = choice;
                //--30帧一次循环，30帧算一次
                if (windowStart + kWindowSize <= currentFrame)
                {
                    //--记录请求,当
                    preferredUpdate = choice;
                    //--累加
                    ++numWindows;
                    //--重置请求申请帧数
                    windowStart = currentFrame;
                    //--清空次数
                    numWindowLateUpdateMoves = numWindowFixedUpdateMoves = 0;
                }
              //  Debug.LogError("--检测到位置移动，输出更新模式:"+ preferredUpdate+"  传递进来的更新模式:"+ updateFilter+ "   currentFrame:" + currentFrame+ "   windowStart:" + windowStart+ "  inconsistent:" + inconsistent + "  numWindowLateUpdateMoves:"+ numWindowLateUpdateMoves+ "   numWindowFixedUpdateMoves:" + numWindowFixedUpdateMoves +"   "+ Time.frameCount);
                return preferredUpdate;
            }
        }
        Dictionary<ICinemachineCamera, UpdateStatus> mUpdateStatus;

        /// <summary>Internal use only</summary>
        public enum UpdateFilter { Fixed, ForcedFixed, Late, ForcedLate };
        internal UpdateFilter CurrentUpdateFilter { get; set; }
        private static bool GetTargetPosition(ICinemachineCamera vcam, out Matrix4x4 targetPos)
        {
            ICinemachineCamera vcamTarget = vcam.LiveChildOrSelf;
            if (vcamTarget == null || vcamTarget.VirtualCameraGameObject == null)
            {
                targetPos = Matrix4x4.identity;
                return false;
            }
            targetPos = vcamTarget.VirtualCameraGameObject.transform.localToWorldMatrix;
            if (vcamTarget.LookAt != null)
            {
                targetPos = vcamTarget.LookAt.localToWorldMatrix;
                return true;
            }
            if (vcamTarget.Follow != null)
            {
                targetPos = vcamTarget.Follow.localToWorldMatrix;
                return true;
            }
            // If no target, use the vcam itself
            targetPos = vcam.VirtualCameraGameObject.transform.localToWorldMatrix;
            return true;
        }

        /// <summary>Internal use only</summary>
        public UpdateFilter GetVcamUpdateStatus(ICinemachineCamera vcam)
        {
            UpdateStatus status;
            if (mUpdateStatus == null || !mUpdateStatus.TryGetValue(vcam, out status))
                return UpdateFilter.Late;
            return status.preferredUpdate;
        }

        /// <summary>
        /// Is this virtual camera currently actively controlling any Camera?
        /// </summary>
        public bool IsLive(ICinemachineCamera vcam)
        {
            if (vcam != null)
            {
                for (int i = 0; i < BrainCount; ++i)
                {
                    CinemachineBrain b = GetActiveBrain(i);
                    if (b != null && b.IsLive(vcam))
                        return true;
                }
            }
            return false;
        }

        /// <summary>
        /// Signal that the virtual has been activated.
        /// If the camera is live, then all CinemachineBrains that are showing it will
        /// send an activation event.
        /// </summary>
        public void GenerateCameraActivationEvent(ICinemachineCamera vcam)
        {
            if (vcam != null)
            {
                for (int i = 0; i < BrainCount; ++i)
                {
                    CinemachineBrain b = GetActiveBrain(i);
                    if (b != null && b.IsLive(vcam))
                        b.m_CameraActivatedEvent.Invoke(vcam);
                }
            }
        }

        /// <summary>
        /// Signal that the virtual camera's content is discontinuous WRT the previous frame.
        /// If the camera is live, then all CinemachineBrains that are showing it will send a cut event.
        /// </summary>
        public void GenerateCameraCutEvent(ICinemachineCamera vcam)
        {
            if (vcam != null)
            {
                for (int i = 0; i < BrainCount; ++i)
                {
                    CinemachineBrain b = GetActiveBrain(i);
                    if (b != null && b.IsLive(vcam))
                        b.m_CameraCutEvent.Invoke(b);
                }
            }
        }

        /// <summary>
        /// 获取控制这个相机的CinemchineBrain
        /// </summary>
        /// <param name="vcam">Virtual camera whose potential brain we need.</param>
        /// <returns>First CinemachineBrain found that might be
        /// appropriate for this vcam, or null</returns>
        public CinemachineBrain FindPotentialTargetBrain(ICinemachineCamera vcam)
        {
            int numBrains = BrainCount;
            if (vcam != null && numBrains > 1)
            {
                for (int i = 0; i < numBrains; ++i)
                {
                    CinemachineBrain b = GetActiveBrain(i);
                    if (b != null && b.OutputCamera != null && b.IsLive(vcam))
                        return b;
                }
            }
            for (int i = 0; i < numBrains; ++i)
            {
                CinemachineBrain b = GetActiveBrain(i);
                if (b != null && b.OutputCamera != null)
                    return b;
            }
            return null;
        }
    }
}
