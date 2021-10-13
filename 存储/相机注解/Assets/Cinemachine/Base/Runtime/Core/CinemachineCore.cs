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
        /// ��������� �����ڻ�������
        /// </summary>
        public static AxisInputDelegate GetInputAxis = UnityEngine.Input.GetAxis;

        /// <summary>
        /// ��ǰ�����Brains
        /// </summary>
        private List<CinemachineBrain> mActiveBrains = new List<CinemachineBrain>();

        /// <summary>Access the array of active CinemachineBrains in the scene</summary>
        public int BrainCount { get { return mActiveBrains.Count; } }

        /// <summary>
        /// �����±��ȡ��ǰ�����Brain
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
        /// ����CinemachineBrain��Cameras���໥�����ģ�������һ��Brain������Լ���Cameras��
        /// ������������ΪʲôBrain���ǵ������ڵ��أ����ǿ���Brainֻ�Ǵ���Blend�ģ����Դ�����ͬ���
        /// �л�ʱ����һ���Ļ�ϣ���������ǲ������� �������Brain����layerȥ����ĳ�����������Brain
        /// û�����ȼ��ĸ����ͬʱ�����Brain����ж���Ļᵼ�������ʾ���԰�~~������Ϊ��ʲô��չ��
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
        /// �и��ӽڵ�������������ͬ�ȼ�������洢��һ��
        /// ��A.B.C���еĲ㼶��ϵ������ABC�����������D.E����mchildCameras������������BEΪһ�飬CΪһ��
        /// </summary>
        private List<List<ICinemachineCamera>> mChildCameras = new List<List<ICinemachineCamera>>();

        /// <summary>Called when a child vcam is enabled.</summary>
        internal void AddChildCamera(ICinemachineCamera vcam)
        {
            RemoveChildCamera(vcam);

            int parentLevel = 0;
            //--�ҵ��Լ��ĸ��ĸ��ڵ㣬parentLevel�Լ��븸�ڵ������ٲ�
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
        /// �������е��������
        /// </summary>
        internal void UpdateAllActiveVirtualCameras(Vector3 worldUp, float deltaTime)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineCore.UpdateAllActiveVirtualCameras");
            int numCameras;

            // Update the leaf-most cameras first
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineCore.UpdateAllActiveVirtualCameras.leaf-most");
            //--���������������ĩ�˵�
            for (int i = mChildCameras.Count-1; i >= 0; --i)
            {
                numCameras = mChildCameras[i].Count;
                for (int j = 0; j < numCameras; ++j)
                    UpdateVirtualCamera(mChildCameras[i][j], worldUp, deltaTime);
            }
            //UnityEngine.Profiling.Profiler.EndSample();

            // Then all the top-level cameras
            //--����������߲��������������м����δ��������
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
            //---��¼��ǰ֡�����ڱ���ͬ֡���ִ��
            int now = Time.frameCount;
            //--��ǰ�ĸ�ϸģʽ����CinemachineBrain�л��������
            UpdateFilter filter = CurrentUpdateFilter;
            //--UpdateMethodΪSmartUpdate
            bool isSmartUpdate = filter != UpdateFilter.ForcedFixed 
                && filter != UpdateFilter.ForcedLate;
            //--�Ƿ�����LateUpdate�е��õ�~filter
            bool isSmartLateUpdate = filter == UpdateFilter.Late;
            //--��filterȫ������Ϊfixed��lateģʽ
            if (!isSmartUpdate)
            {
                if (filter == UpdateFilter.ForcedFixed)
                    filter = UpdateFilter.Fixed;
                if (filter == UpdateFilter.ForcedLate)
                    filter = UpdateFilter.Late;
            }

            if (mUpdateStatus == null)
                mUpdateStatus = new Dictionary<ICinemachineCamera, UpdateStatus>();
            //--��������ڣ��Ƴ�
            if (vcam.VirtualCameraGameObject == null)
            {
                if (mUpdateStatus.ContainsKey(vcam))
                    mUpdateStatus.Remove(vcam);
                //UnityEngine.Profiling.Profiler.EndSample();
                return false; // camera was deleted
            }
            UpdateStatus status;
            //--������������
            if (!mUpdateStatus.TryGetValue(vcam, out status))
            {
                status = new UpdateStatus(now);
                mUpdateStatus.Add(vcam, status);
            }
            //--�����fixedupate��Smartupdate���ڼ�¼����֡���ô���
            int subframes = isSmartLateUpdate ? 1 : CinemachineBrain.GetSubframeCount();
            //--�������ͬһ֡��������ձ�֡���������
            if (status.lastUpdateFrame != now)
                status.lastUpdateSubframe = 0;

            // If we're in smart update mode and the target moved, then we must examine
            // how the target has been moving recently in order to figure out whether to
            // update now
            //--�������smartUpdate������������������£�
            bool updateNow = !isSmartUpdate;
            //�����ǰģʽΪSmartUpdate
            if (isSmartUpdate)
            {
                Matrix4x4 targetPos;
                //--û��Ŀ�꣬���samrtupdate����lateupdate�з��͵ģ������ɸ���
                if (!GetTargetPosition(vcam, out targetPos))
                    updateNow = isSmartLateUpdate; // no target
                else
                    //--��ȡ�ϴμ�¼��ģʽ������ͱ���һֱ���������£����򲻴���
                    updateNow = status.ChoosePreferredUpdate(now, targetPos, filter) 
                        == filter;
            }
            //--��Ҫ���̸���
            if (updateNow)
            {
             //   Debug.Log("*******UpdateNowIsTrue:"+filter+"  " + subframes+"  "+ status.lastUpdateSubframe+"  "+Time.frameCount);
                //--��¼����ʱ�ĸ���ģʽ
                status.preferredUpdate = filter;
                //--��������֡��ִ�У����ٴν��в�����
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
            /// ֻ��SamrtUpdateģʽ�²Ż����
            /// </summary>
            /// <param name="currentFrame"></param>
            /// <param name="pos"></param>
            /// <param name="updateFilter"></param>
            /// <returns></returns>
            public UpdateFilter ChoosePreferredUpdate(
                int currentFrame, Matrix4x4 pos, UpdateFilter updateFilter)
            {
                //--λ�ò�ͬ����¼������Ϣ��
                if (targetPos != pos)
                {
                    //����LateUpate�������¼һ��
                    if (updateFilter == UpdateFilter.Late)
                        ++numWindowLateUpdateMoves;
                    //�������FixedUpdate������ģ�����lastUpdateSubframeΪ0��¼һ�Σ�LastUpdateSubFrame����һ֡����
                    //ʱ���Ὣ������Ϊ0
                    else if (lastUpdateSubframe == 0)
                        ++numWindowFixedUpdateMoves;
                    targetPos = pos;
                }
                //Debug.Log("Fixed=" + numWindowFixedUpdateMoves + ", Late=" + numWindowLateUpdateMoves);
                //--��һ������ļ�¼
                UpdateFilter choice = preferredUpdate;
                //--���Ŀ���ƶ���LateUpdate��Update�ж�����������
                bool inconsistent = numWindowLateUpdateMoves > 0 && numWindowFixedUpdateMoves > 0;
                //--��仰����˼����ֻҪLateUpdate�������ʹ��LateUpdate�ģ������ʹ��FixedUpdate��
                if (inconsistent || numWindowLateUpdateMoves >= numWindowFixedUpdateMoves)
                    choice = UpdateFilter.Late;
                else
                    choice = UpdateFilter.Fixed;
                //--��һ�εĻ���ʹ�ü���ģ�������ǵ�һ����������ķ�ʽ����
                if (numWindows == 0)
                    preferredUpdate = choice;
                //--30֡һ��ѭ����30֡��һ��
                if (windowStart + kWindowSize <= currentFrame)
                {
                    //--��¼����,��
                    preferredUpdate = choice;
                    //--�ۼ�
                    ++numWindows;
                    //--������������֡��
                    windowStart = currentFrame;
                    //--��մ���
                    numWindowLateUpdateMoves = numWindowFixedUpdateMoves = 0;
                }
              //  Debug.LogError("--��⵽λ���ƶ����������ģʽ:"+ preferredUpdate+"  ���ݽ����ĸ���ģʽ:"+ updateFilter+ "   currentFrame:" + currentFrame+ "   windowStart:" + windowStart+ "  inconsistent:" + inconsistent + "  numWindowLateUpdateMoves:"+ numWindowLateUpdateMoves+ "   numWindowFixedUpdateMoves:" + numWindowFixedUpdateMoves +"   "+ Time.frameCount);
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
        /// ��ȡ������������CinemchineBrain
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
