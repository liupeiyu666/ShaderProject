using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine
{
    /// <summary>
    /// This is a CinemachineComponent in the Body section of the component pipeline. 
    /// Its job is to position the camera in a fixed relationship to the vcam's Follow 
    /// target object, with offsets and damping.
    /// 缓动跟随，（这里我们有两个缓动地方），1.有一个跟随坐标系的确定，即我们设置的跟随偏移的坐标系是什么样的，这个由BindingMode确定，当我们的跟随坐标系确定后，由于跟随物体的移动，跟随坐标系会发生变化，那么两次的坐标系的变化就要执行Damp，由此来达到偏移的缓动跟随。  2.当我们跟随的物体发生移动时，我们还需要有位置缓动，而位置的Damp的方式，是由位置偏移的Damp之后的坐标系和期望偏移计算的forward和相机中指定的Up构成的新的空间，再这个空间下我们执行位置的Damp缓动跟随。
    /// The Tansposer will only change the camera's position in space.  It will not 
    /// re-orient or otherwise aim the camera.  To to that, you need to instruct 
    /// the vcam in the Aim section of its pipeline.
    /// </summary>
    [DocumentationSorting(5, DocumentationSortingAttribute.Level.UserRef)]
    [AddComponentMenu("")] // Don't display in add component menu
    [RequireComponent(typeof(CinemachinePipeline))]
    [SaveDuringPlay]
    public class CinemachineTransposer : CinemachineComponentBase
    {
        /// <summary>
        /// The coordinate space to use when interpreting the offset from the target
        /// </summary>
        [DocumentationSorting(5.01f, DocumentationSortingAttribute.Level.UserRef)]
        ///相机如何跟随物体
        public enum BindingMode
        {
            /// <summary>
            /// Camera will be bound to the Follow target using a frame of reference consisting
            /// of the target's local frame at the moment when the virtual camera was enabled,
            /// or when the target was assigned.
            /// </summary>
            LockToTargetOnAssign = 0,
            /// <summary>
            /// Camera will be bound to the Follow target using a frame of reference consisting
            /// of the target's local frame, with the tilt and roll zeroed out.
            /// </summary>
            LockToTargetWithWorldUp = 1,
            /// <summary>
            /// Camera will be bound to the Follow target using a frame of reference consisting
            /// of the target's local frame, with the roll zeroed out.
            /// </summary>
            LockToTargetNoRoll = 2,
            /// <summary>
            /// Camera will be bound to the Follow target using the target's local frame.
            /// 相机被设置到Target的局部坐标系中，游戏物体在旋转的时候，相机也跟着旋转，也会跟随Target移动
            /// </summary>
            LockToTarget = 3,
            /// <summary>Camera will be bound to the Follow target using a world space offset.</summary>
            WorldSpace = 4,
            /// <summary>Offsets will be calculated relative to the target, using Camera-local axes</summary>
            SimpleFollowWithWorldUp = 5
        }
        /// <summary>The coordinate space to use when interpreting the offset from the target</summary>
        [Tooltip("The coordinate space to use when interpreting the offset from the target.  This is also used to set the camera's Up vector, which will be maintained when aiming the camera.")]
        public BindingMode m_BindingMode = BindingMode.LockToTargetWithWorldUp;

        /// <summary>The distance which the transposer will attempt to maintain from the transposer subject</summary>
        [Tooltip("The distance vector that the transposer will attempt to maintain from the Follow target")]
        public Vector3 m_FollowOffset = Vector3.back * 10f;

        /// <summary>How aggressively the camera tries to maintain the offset in the X-axis.
        /// Small numbers are more responsive, rapidly translating the camera to keep the target's
        /// x-axis offset.  Larger numbers give a more heavy slowly responding camera.
        /// Using different settings per axis can yield a wide range of camera behaviors</summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to maintain the offset in the X-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's x-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
        public float m_XDamping = 1f;

        /// <summary>How aggressively the camera tries to maintain the offset in the Y-axis.
        /// Small numbers are more responsive, rapidly translating the camera to keep the target's
        /// y-axis offset.  Larger numbers give a more heavy slowly responding camera.
        /// Using different settings per axis can yield a wide range of camera behaviors</summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to maintain the offset in the Y-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's y-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
        public float m_YDamping = 1f;

        /// <summary>How aggressively the camera tries to maintain the offset in the Z-axis.
        /// Small numbers are more responsive, rapidly translating the camera to keep the
        /// target's z-axis offset.  Larger numbers give a more heavy slowly responding camera.
        /// Using different settings per axis can yield a wide range of camera behaviors</summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to maintain the offset in the Z-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's z-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
        public float m_ZDamping = 1f;

        /// <summary>How aggressively the camera tries to track the target rotation's X angle.  
        /// Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.</summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to track the target rotation's X angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
        public float m_PitchDamping = 0;

        /// <summary>How aggressively the camera tries to track the target rotation's Y angle.  
        /// Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.</summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to track the target rotation's Y angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
        public float m_YawDamping = 0;

        /// <summary>How aggressively the camera tries to track the target rotation's Z angle.  
        /// Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.</summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to track the target rotation's Z angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
        public float m_RollDamping = 0f;

        protected virtual void OnValidate()
        {
            m_FollowOffset = EffectiveOffset;
        }
        
        /// <summary>Get the target offset, with sanitization</summary>
        protected Vector3 EffectiveOffset 
        { 
            get 
            { 
                Vector3 offset = m_FollowOffset; 
                if (m_BindingMode == BindingMode.SimpleFollowWithWorldUp)
                {
                    offset.x = 0;
                    offset.z = -Mathf.Abs(offset.z);
                }
                return offset;
            } 
        }
        
        /// <summary>True if component is enabled and has a valid Follow target</summary>
        public override bool IsValid { get { return enabled && FollowTarget != null; } }

        /// <summary>Get the Cinemachine Pipeline stage that this component implements.
        /// Always returns the Body stage</summary>
        public override CinemachineCore.Stage Stage { get { return CinemachineCore.Stage.Body; } }

        /// <summary>Positions the virtual camera according to the transposer rules.</summary>
        /// <param name="curState">The current camera state</param>
        /// <param name="deltaTime">Used for damping.  If less than 0, no damping is done.</param>
        public override void MutateCameraState(ref CameraState curState, float deltaTime)
        {
            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineTransposer.MutateCameraState");
            //-初始化上一帧的信息
            InitPrevFrameStateInfo(ref curState, deltaTime);
            if (IsValid)
            {
                Vector3 pos;
                Quaternion orient;
                Vector3 offset = EffectiveOffset;
                TrackTarget(deltaTime, curState.ReferenceUp, offset, out pos, out orient);
                curState.RawPosition = pos + orient * offset;
                curState.ReferenceUp = orient * Vector3.up;
            }
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        /// <summary>API for the editor, to process a position drag from the user.
        /// This implementation adds the delta to the follow offset.
        /// 位置发生拖拽时，用于Editor编辑
        /// </summary>
        /// <param name="delta">The amount dragged this frame</param>
        public override void OnPositionDragged(Vector3 delta)
        {
            Quaternion targetOrientation = GetReferenceOrientation(VcamState.ReferenceUp);
            Vector3 localOffset = Quaternion.Inverse(targetOrientation) * delta;
            m_FollowOffset += localOffset;
            m_FollowOffset = EffectiveOffset;
        }

        /// <summary>Initializes the state for previous frame if appropriate.
        /// 初始化前一帧的状态(如果合适的话)，初始化目标和m_targetOrientationOnAssign
        /// </summary>
        protected void InitPrevFrameStateInfo(
            ref CameraState curState, float deltaTime)
        {
            if (m_previousTarget != FollowTarget || deltaTime < 0)
            {
                m_previousTarget = FollowTarget;
                m_targetOrientationOnAssign 
                    = (m_previousTarget == null) ? Quaternion.identity : FollowTarget.rotation;
            }
            //-如果deltaTime < 0，初始化上一帧目标位置为当前相机的目标位置，朝向初始化
            if (deltaTime < 0)
            {
                m_PreviousTargetPosition = curState.RawPosition;
                m_PreviousReferenceOrientation = GetReferenceOrientation(curState.ReferenceUp);
            }
        }

        /// <summary>Positions the virtual camera according to the transposer rules.</summary>
        /// <param name="deltaTime">Used for damping.  If less than 0, no damping is done.</param>
        /// <param name="up">Current camera up</param>
        /// <param name="desiredCameraOffset">Where we want to put the camera relative to the follow target</param>
        /// <param name="outTargetPosition">Resulting camera position</param>
        /// <param name="outTargetOrient">Damped target orientation</param>
        protected void TrackTarget(
            float deltaTime, Vector3 up, Vector3 desiredCameraOffset,
            out Vector3 outTargetPosition, out Quaternion outTargetOrient)
        {
            //获取偏移的参考坐标系（通过旋转获取）
            Quaternion targetOrientation = GetReferenceOrientation(up);
            Quaternion dampedOrientation = targetOrientation;
            if (deltaTime >= 0)
            {
                //由当前旋转角度和上一帧的旋转角度的相差的旋转角的欧拉值
                Vector3 relative = (Quaternion.Inverse(m_PreviousReferenceOrientation) 
                    * targetOrientation).eulerAngles;
                //角度限定在[-180,180]
                for (int i = 0; i < 3; ++i)
                    if (relative[i] > 180)
                        relative[i] -= 360;
                //相差值阻尼，上一帧的旋转角和当前帧的旋转角阻尼计算
                relative = Damper.Damp(relative, AngularDamping, deltaTime);
                //当前阻尼过后的旋转角度
                dampedOrientation = m_PreviousReferenceOrientation * Quaternion.Euler(relative);
            }
            //记录当前的旋转角度（进过阻尼后的旋转角度）
            m_PreviousReferenceOrientation = dampedOrientation;
            //跟随目标的位置（原始位置，不包括偏移）
            Vector3 targetPosition = FollowTarget.position;
            //--上一次相机的位置，添加了偏移的位置
            Vector3 currentPosition = m_PreviousTargetPosition;
            //目标的移动位置，上一次的偏移量（因为偏移可以Damp执行），这个是实际的偏移
            Vector3 worldOffset = targetPosition - currentPosition;

            // Adjust for damping, which is done in camera-offset-local coords
            //进行位置偏移的计算
            if (deltaTime >= 0)
            {
                Quaternion dampingSpace;
                //desiredCameraOffset我们配置的偏移数据。
                //如果偏移为0，就是用相机的角度作为偏移空间
                if (desiredCameraOffset.AlmostZero())
                    dampingSpace = VcamState.RawOrientation;
                else
                    //--dampedOrientation是前后两次相对偏移的空间差值的结果，也就是当前应该
                    //执行的偏移的空间。确定空间后，通过偏移设置可以计算到偏移空间下的forward，
                    //由于相机我们设定了Up，所以使用forward和指定的相机的up计算出新的偏移空间
                    dampingSpace = Quaternion.LookRotation(dampedOrientation * desiredCameraOffset.normalized, up);
                //--世界空间中的偏移到新偏移空间
                Vector3 localOffset = Quaternion.Inverse(dampingSpace) * worldOffset;
                //--在局部空间做位移Damp
                localOffset = Damper.Damp(localOffset, Damping, deltaTime);
                //--再讲局部Damp之后的偏移转换到世界空间
                worldOffset = dampingSpace * localOffset;
            }
            //我们跟随目标发生的跟随偏移通过这个来实现，而我们Damp的方式即上述方式
            outTargetPosition = m_PreviousTargetPosition = currentPosition + worldOffset;
            //给出新的偏移方向，也就是我们damp的旋转方向，之后会用他乘以期望偏移计算
            //相对目标的偏移位置
            outTargetOrient = dampedOrientation;
        }

        /// <summary>
        /// Damping speeds for each of the 3 axes of the offset from target
        /// </summary>
        protected Vector3 Damping
        {
            get 
            { 
                switch (m_BindingMode)
                {
                    case BindingMode.SimpleFollowWithWorldUp:
                        return new Vector3(0, m_YDamping, m_ZDamping); 
                    default:
                        return new Vector3(m_XDamping, m_YDamping, m_ZDamping); 
                }
            } 
        }

        /// <summary>
        /// Damping speeds for each of the 3 axes of the target's rotation
        /// </summary>
        protected Vector3 AngularDamping
        {
            get 
            { 
                switch (m_BindingMode)
                {
                    case BindingMode.LockToTargetNoRoll:
                        return new Vector3(m_PitchDamping, m_YawDamping, 0); 
                    case BindingMode.LockToTargetWithWorldUp:
                        return new Vector3(0, m_YawDamping, 0); 
                    case BindingMode.LockToTargetOnAssign:
                    case BindingMode.WorldSpace:
                    case BindingMode.SimpleFollowWithWorldUp:
                        return Vector3.zero;
                    default:
                        return new Vector3(m_PitchDamping, m_YawDamping, m_RollDamping); 
                }
            } 
        }

        /// <summary>Internal API for the Inspector Editor, so it can draw a marker at the target</summary>
        public Vector3 GeTargetCameraPosition(Vector3 worldUp)
        {
            if (!IsValid)
                return Vector3.zero;
            return FollowTarget.position + GetReferenceOrientation(worldUp) * EffectiveOffset;
        }

        /// <summary>State information for damping</summary>
        Vector3 m_PreviousTargetPosition = Vector3.zero;
        Quaternion m_PreviousReferenceOrientation = Quaternion.identity;
        //目标发生变更，或者初始化时赋值=当前目标的角度
        Quaternion m_targetOrientationOnAssign = Quaternion.identity;
        Transform m_previousTarget = null;

        /// <summary>Internal API for the Inspector Editor, so it can draw a marker at the target</summary>
        public Quaternion GetReferenceOrientation(Vector3 worldUp)
        {
            if (FollowTarget != null)
            {
                Quaternion targetOrientation = FollowTarget.rotation;
                switch (m_BindingMode)
                {
                    //使用目标变更和相机激活时目标的角度
                    case BindingMode.LockToTargetOnAssign:
                        return m_targetOrientationOnAssign;
                    //将当前目标的角度旋转的y轴旋转到worldUp
                    case BindingMode.LockToTargetWithWorldUp:
                        return Uppify(targetOrientation, worldUp);
                    //使用目标的角度，且是去除目标的roll旋转也就是z轴的旋转
                    case BindingMode.LockToTargetNoRoll:
                        return Quaternion.LookRotation(targetOrientation * Vector3.forward, worldUp);
                    //使用目标的旋转
                    case BindingMode.LockToTarget:
                        return targetOrientation;
                    //于目标和相机的位置为forward创建旋转，然后将生成的旋转的y轴旋转到worldUp（这一步和LockToTargetWithWorldUp一样）
                    case BindingMode.SimpleFollowWithWorldUp:
                    {
                        Vector3 dir = FollowTarget.position - VcamState.RawPosition;
                        if (dir.AlmostZero())
                            break;
                        return Uppify(Quaternion.LookRotation(dir, worldUp), worldUp);
                    }
                    default:
                        break;
                }
            }
            return Quaternion.identity; 
        }
        /// <summary>
        /// 将q的y轴，旋转到up方向
        /// </summary>
        /// <param name="q"></param>
        /// <param name="up"></param>
        /// <returns></returns>
        static Quaternion Uppify(Quaternion q, Vector3 up)
        {
            Quaternion r = Quaternion.FromToRotation(q * Vector3.up, up);
            return r * q;
        }
    }
}
