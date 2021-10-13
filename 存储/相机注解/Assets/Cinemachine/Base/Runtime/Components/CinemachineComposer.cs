using UnityEngine;
using System;
using Cinemachine.Utility;

namespace Cinemachine
{
    /// <summary>
    /// This is a CinemachineComponent in the Aim section of the component pipeline.
    /// Its job is to aim the camera at the vcam's LookAt target object, with 
    /// configurable offsets, damping, and composition rules.
    /// Aim类型的组件，他的任务就是让摄像机看向目标，然后应用偏移，阻尼，合成规则
    /// 
    /// 
    /// The composer does not change the camera's position.  It will only pan and tilt the 
    /// camera where it is, in order to get the desired framing.  To move the camera, you have
    /// to use the virtual camera's Body section.
    /// 该组件不会改变相机的位置，他只会平移和倾斜相机，如果想要移动相机，需要使用Body组件
    /// </summary>
    [DocumentationSorting(3, DocumentationSortingAttribute.Level.UserRef)]
    [ExecuteInEditMode] // for OnGUI
    [AddComponentMenu("")] // Don't display in add component menu
    [RequireComponent(typeof(CinemachinePipeline))]
    [SaveDuringPlay]
    public class CinemachineComposer : CinemachineComponentBase
    {
        /// <summary>Used by the Inspector Editor to display on-screen guides.</summary>
        [NoSaveDuringPlay, HideInInspector]
        public Action OnGUICallback = null;

        /// <summary>Target offset from the object's center in LOCAL space which
        /// the Composer tracks. Use this to fine-tune the tracking target position
        /// when the desired area is not in the tracked object's center
        /// 相对于目标自身空间的偏移值，叠加到看向的目标上
        /// </summary>
        [Tooltip("Target offset from the target object's center in target-local space. Use this to fine-tune the tracking target position when the desired area is not the tracked object's center.")]
        public Vector3 m_TrackedObjectOffset = Vector3.zero;

        /// <summary>This setting will instruct the composer to adjust its target offset based
        /// on the motion of the target.  The composer will look at a point where it estimates
        /// the target will be this many seconds into the future.  Note that this setting is sensitive
        /// to noisy animation, and can amplify the noise, resulting in undesirable camera jitter.
        /// If the camera jitters unacceptably when the target is in motion, turn down this setting, 
        /// or animate the target more smoothly.
        /// 预测时间，正态分布，Predictor注释
        /// </summary>
        [Tooltip("This setting will instruct the composer to adjust its target offset based on the motion of the target.  The composer will look at a point where it estimates the target will be this many seconds into the future.  Note that this setting is sensitive to noisy animation, and can amplify the noise, resulting in undesirable camera jitter.  If the camera jitters unacceptably when the target is in motion, turn down this setting, or animate the target more smoothly.")]
        [Range(0f, 1f)]
        public float m_LookaheadTime = 0;

        /// <summary>Controls the smoothness of the lookahead algorithm.  Larger values smooth out 
        /// jittery predictions and also increase prediction lag
        /// 正态分布曲线分布控制，Predictor注释
        /// </summary>
        [Tooltip("Controls the smoothness of the lookahead algorithm.  Larger values smooth out jittery predictions and also increase prediction lag")]
        [Range(3, 30)]
        public float m_LookaheadSmoothing = 10;

        /// <summary>How aggressively the camera tries to follow the target in the screen-horizontal direction.
        /// Small numbers are more responsive, rapidly orienting the camera to keep the target in
        /// the dead zone. Larger numbers give a more heavy slowly responding camera.
        /// Using different vertical and horizontal settings can yield a wide range of camera behaviors.
        /// 水平方向的阻尼
        /// </summary>
        [Space]
        [Range(0f, 20)]
        [Tooltip("How aggressively the camera tries to follow the target in the screen-horizontal direction. Small numbers are more responsive, rapidly orienting the camera to keep the target in the dead zone. Larger numbers give a more heavy slowly responding camera. Using different vertical and horizontal settings can yield a wide range of camera behaviors.")]
        public float m_HorizontalDamping = 0.5f;

        /// <summary>How aggressively the camera tries to follow the target in the screen-vertical direction. 
        /// Small numbers are more responsive, rapidly orienting the camera to keep the target in 
        /// the dead zone. Larger numbers give a more heavy slowly responding camera. Using different vertical 
        /// and horizontal settings can yield a wide range of camera behaviors.
        /// 垂直方向的阻尼
        /// </summary>
        [Range(0f, 20)]
        [Tooltip("How aggressively the camera tries to follow the target in the screen-vertical direction. Small numbers are more responsive, rapidly orienting the camera to keep the target in the dead zone. Larger numbers give a more heavy slowly responding camera. Using different vertical and horizontal settings can yield a wide range of camera behaviors.")]
        public float m_VerticalDamping = 0.5f;

        /// <summary>Horizontal screen position for target. The camera will rotate to the position the tracked object here</summary>
        [Space]
        [Range(0f, 1f)]
        [Tooltip("Horizontal screen position for target. The camera will rotate to position the tracked object here.")]
        public float m_ScreenX = 0.5f;

        /// <summary>Vertical screen position for target, The camera will rotate to to position the tracked object here</summary>
        [Range(0f, 1f)]
        [Tooltip("Vertical screen position for target, The camera will rotate to position the tracked object here.")]
        public float m_ScreenY = 0.5f;

        /// <summary>Camera will not rotate horizontally if the target is within this range of the position</summary>
        [Range(0f, 1f)]
        [Tooltip("Camera will not rotate horizontally if the target is within this range of the position.")]
        public float m_DeadZoneWidth = 0.1f;

        /// <summary>Camera will not rotate vertically if the target is within this range of the position</summary>
        [Range(0f, 1f)]
        [Tooltip("Camera will not rotate vertically if the target is within this range of the position.")]
        public float m_DeadZoneHeight = 0.1f;

        /// <summary>When target is within this region, camera will gradually move to re-align
        /// towards the desired position, depending onm the damping speed</summary>
        [Range(0f, 2f)]
        [Tooltip("When target is within this region, camera will gradually rotate horizontally to re-align towards the desired position, depending on the damping speed.")]
        public float m_SoftZoneWidth = 0.8f;

        /// <summary>When target is within this region, camera will gradually move to re-align
        /// towards the desired position, depending onm the damping speed</summary>
        [Range(0f, 2f)]
        [Tooltip("When target is within this region, camera will gradually rotate vertically to re-align towards the desired position, depending on the damping speed.")]
        public float m_SoftZoneHeight = 0.8f;

        /// <summary>A non-zero bias will move the targt position away from the center of the soft zone</summary>
        [Range(-0.5f, 0.5f)]
        [Tooltip("A non-zero bias will move the target position horizontally away from the center of the soft zone.")]
        public float m_BiasX = 0f;

        /// <summary>A non-zero bias will move the targt position away from the center of the soft zone</summary>
        [Range(-0.5f, 0.5f)]
        [Tooltip("A non-zero bias will move the target position vertically away from the center of the soft zone.")]
        public float m_BiasY = 0f;

        /// <summary>True if component is enabled and has a LookAt defined</summary>
        public override bool IsValid { get { return enabled && LookAtTarget != null; } }

        /// <summary>Get the Cinemachine Pipeline stage that this component implements.
        /// Always returns the Aim stage</summary>
        public override CinemachineCore.Stage Stage { get { return CinemachineCore.Stage.Aim; } }

        /// <summary>Internal API for inspector
        /// 预测点位
        /// </summary>
        public Vector3 TrackedPoint { get; private set; }

        /// <summary>Apply the target offsets to the target location.
        /// Also set the TrackedPoint property, taking lookahead into account.
        /// 获取看向的目标点（偏移），设置预测点
        /// </summary>
        /// <param name="lookAt">The unoffset LookAt point</param>
        /// <returns>The LookAt point with the offset applied</returns>
        protected virtual Vector3 GetLookAtPointAndSetTrackedPoint(Vector3 lookAt)
        {
            Vector3 pos = lookAt;
            if (LookAtTarget != null)
                pos += LookAtTarget.transform.rotation * m_TrackedObjectOffset;

            m_Predictor.Smoothing = m_LookaheadSmoothing;
            m_Predictor.AddPosition(pos);
            TrackedPoint = (m_LookaheadTime > 0)
                ? m_Predictor.PredictPosition(m_LookaheadTime) : pos;

            return pos;
        }
        
#if UNITY_EDITOR
        private void OnGUI() { if (OnGUICallback != null) OnGUICallback(); }
#endif

        /// <summary>State information for damping</summary>
        Vector3 m_CameraPosPrevFrame = Vector3.zero;
        Vector3 m_LookAtPrevFrame = Vector3.zero;
        Vector2 m_ScreenOffsetPrevFrame = Vector2.zero;
        Quaternion m_CameraOrientationPrevFrame = Quaternion.identity;
        PositionPredictor m_Predictor = new PositionPredictor();

        public override void PrePipelineMutateCameraState(ref CameraState curState) 
        {
            if (IsValid && curState.HasLookAt)
                curState.ReferenceLookAt = GetLookAtPointAndSetTrackedPoint(curState.ReferenceLookAt);
        }

        /// <summary>Applies the composer rules and orients the camera accordingly</summary>
        /// <param name="curState">The current camera state</param>
        /// <param name="deltaTime">Used for calculating damping.  If less than
        /// zero, then target will snap to the center of the dead zone.</param>
        public override void MutateCameraState(ref CameraState curState, float deltaTime)
        {
            // Initialize the state for previous frame if appropriate
            if (deltaTime < 0)
                m_Predictor.Reset();
                
            if (!IsValid || !curState.HasLookAt)
                return;
            //预测的位置和当前相机之间的距离
            float targetDistance = (TrackedPoint - curState.CorrectedPosition).magnitude;
            if (targetDistance < Epsilon)
            {
                //--如果距离小于0，说明重合了，保持角度不变即可
                if (deltaTime >= 0)
                    curState.RawOrientation = m_CameraOrientationPrevFrame;
                return;  // navel-gazing, get outa here
            }

            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineComposer.MutateCameraState");
            //-fov：filed of view视角。fovH水平的角度
            //-因为fov是垂直方向的视角，需要根据宽高比计算出水平方向的角度
            float fov, fovH;
            if (curState.Lens.Orthographic)
            {
                // Calculate effective fov - fake it for ortho based on target distance
                fov = Mathf.Rad2Deg * 2 * Mathf.Atan(curState.Lens.OrthographicSize / targetDistance);
                fovH = Mathf.Rad2Deg * 2 * Mathf.Atan(
                    curState.Lens.Aspect * curState.Lens.OrthographicSize / targetDistance);
            }
            else 
            {
                fov = curState.Lens.FieldOfView;
                double radHFOV = 2 * Math.Atan(Math.Tan(fov * Mathf.Deg2Rad / 2) * curState.Lens.Aspect);
                fovH = (float)(Mathf.Rad2Deg * radHFOV);
            }

            Quaternion rigOrientation = curState.RawOrientation;
            //--根据当前相机垂直角度，水平角度，转换屏幕空间的Rect到FOV相机空间，并使用角度表示rect
            Rect softGuideFOV = ScreenToFOV(SoftGuideRect, fov, fovH, curState.Lens.Aspect);
            if (deltaTime < 0)
            {
                //时间小于0，直接看向，合法预期就是soft的中心点
                // No damping, just snap to central bounds, skipping the soft zone
                Rect rect = new Rect(softGuideFOV.center, Vector2.zero); // Force to center
                RotateToScreenBounds(ref curState, rect, ref rigOrientation, fov, fovH, -1);
            }
            else
            {
                // Start with previous frame's orientation (but with current up)
                //--上一帧看向的位置
                Vector3 dir = m_LookAtPrevFrame - (m_CameraPosPrevFrame + curState.PositionDampingBypass);
                //-如果看向的位置和上一帧相机的位置重合，使用相机的forwar和curState.ReferenceUp作为相机的旋转，
                //-否则
                if (dir.AlmostZero())  
                    rigOrientation = Quaternion.LookRotation(
                        m_CameraOrientationPrevFrame * Vector3.forward, curState.ReferenceUp);
                else 
                {
                    //上一帧相机需要看向的角度
                    rigOrientation = Quaternion.LookRotation(dir, curState.ReferenceUp);
                    //去除偏移影响
                    rigOrientation = rigOrientation.ApplyCameraRotation(
                        -m_ScreenOffsetPrevFrame, curState.ReferenceUp);
                }
                
                // First force the previous rotation into the hard bounds, no damping, 
                // then Now move it through the soft zone, with damping
                //首先将看向的目标点移动到hardbounds内部，然后使用damp移动到softbound区域内
                Rect hardGuideFOV = ScreenToFOV(HardGuideRect, fov, fovH, curState.Lens.Aspect);
                if (!RotateToScreenBounds(ref curState, hardGuideFOV, ref rigOrientation, fov, fovH, -1))
                    RotateToScreenBounds(ref curState, softGuideFOV, ref rigOrientation, fov, fovH, deltaTime);
            }
            m_CameraPosPrevFrame = curState.CorrectedPosition;
            m_LookAtPrevFrame = TrackedPoint;
            m_CameraOrientationPrevFrame = UnityQuaternionExtensions.Normalized(rigOrientation);
            //-记录本次相机的转动偏移
            m_ScreenOffsetPrevFrame = m_CameraOrientationPrevFrame.GetCameraRotationToTarget(
                m_LookAtPrevFrame - curState.CorrectedPosition, curState.ReferenceUp);

            curState.RawOrientation = m_CameraOrientationPrevFrame;
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        /// <summary>Internal API for the inspector editor</summary>
        public Rect SoftGuideRect
        {
            get
            {
                return new Rect(
                    m_ScreenX - m_DeadZoneWidth / 2, m_ScreenY - m_DeadZoneHeight / 2,
                    m_DeadZoneWidth, m_DeadZoneHeight);
            }
            set
            {
                m_DeadZoneWidth = Mathf.Clamp01(value.width);
                m_DeadZoneHeight = Mathf.Clamp01(value.height);
                m_ScreenX = Mathf.Clamp01(value.x + m_DeadZoneWidth / 2);
                m_ScreenY = Mathf.Clamp01(value.y + m_DeadZoneHeight / 2);
                m_SoftZoneWidth = Mathf.Max(m_SoftZoneWidth, m_DeadZoneWidth);
                m_SoftZoneHeight = Mathf.Max(m_SoftZoneHeight, m_DeadZoneHeight);
            }
        }

        /// <summary>Internal API for the inspector editor</summary>
        public Rect HardGuideRect
        {
            get
            {
                Rect r = new Rect(
                        m_ScreenX - m_SoftZoneWidth / 2, m_ScreenY - m_SoftZoneHeight / 2,
                        m_SoftZoneWidth, m_SoftZoneHeight);
                r.position += new Vector2(
                        m_BiasX * (m_SoftZoneWidth - m_DeadZoneWidth),
                        m_BiasY * (m_SoftZoneHeight - m_DeadZoneHeight));
                return r;
            }
            set
            {
                m_SoftZoneWidth = Mathf.Clamp(value.width, 0, 2f);
                m_SoftZoneHeight = Mathf.Clamp(value.height, 0, 2f);
                m_DeadZoneWidth = Mathf.Min(m_DeadZoneWidth, m_SoftZoneWidth);
                m_DeadZoneHeight = Mathf.Min(m_DeadZoneHeight, m_SoftZoneHeight);

                Vector2 center = value.center;
                Vector2 bias = center - new Vector2(m_ScreenX, m_ScreenY);
                float biasWidth = Mathf.Max(0, m_SoftZoneWidth - m_DeadZoneWidth);
                float biasHeight = Mathf.Max(0, m_SoftZoneHeight - m_DeadZoneHeight);
                m_BiasX = biasWidth < Epsilon ? 0 : Mathf.Clamp(bias.x / biasWidth, -0.5f, 0.5f);
                m_BiasY = biasHeight < Epsilon ? 0 : Mathf.Clamp(bias.y / biasHeight, -0.5f, 0.5f);
            }
        }
        
        // Convert from screen coords to normalized FOV angular coords
        /// <summary>
        /// 将屏幕空间Rect转换到FOV空间中，
        /// </summary>
        /// <param name="rScreen"></param>
        /// <param name="fov"></param>
        /// <param name="fovH"></param>
        /// <param name="aspect"></param>
        /// <returns></returns>
        private Rect ScreenToFOV(Rect rScreen, float fov, float fovH, float aspect)
        {
            Rect r = new Rect(rScreen);
            //构建一个相机的矩阵
            Matrix4x4 persp = Matrix4x4.Perspective(fov, aspect, 0.01f, 10000f).inverse;
            //将屏幕空间的点转换到相机空间
            Vector3 p = persp.MultiplyPoint(new Vector3(0, (r.yMin * 2f) - 1f, 0.1f));
            p.z = -p.z;
            //-计算到空间后与相机的水平方向的角度
            float angle = UnityVectorExtensions.SignedAngle(Vector3.forward, p, Vector3.left);
            r.yMin = ((fov / 2) + angle) / fov;

            p = persp.MultiplyPoint(new Vector3(0, (r.yMax * 2f) - 1f, 0.1f));
            p.z = -p.z;
            angle = UnityVectorExtensions.SignedAngle(Vector3.forward, p, Vector3.left);
            r.yMax = ((fov / 2) + angle) / fov;

            p = persp.MultiplyPoint(new Vector3((r.xMin * 2f) - 1f, 0, 0.1f));
            p.z = -p.z;
            angle = UnityVectorExtensions.SignedAngle(Vector3.forward, p, Vector3.up);
            r.xMin = ((fovH / 2) + angle) / fovH;

            p = persp.MultiplyPoint(new Vector3((r.xMax * 2f) - 1f, 0, 0.1f));
            p.z = -p.z;
            angle = UnityVectorExtensions.SignedAngle(Vector3.forward, p, Vector3.up);
            r.xMax = ((fovH / 2) + angle) / fovH;
            return r;
        }

        /// <summary>
        /// Adjust the rigOrientation to put the camera within the screen bounds.
        /// If deltaTime >= 0 then damping will be applied.
        /// Assumes that currentOrientation fwd is such that input rigOrientation's
        /// local up is NEVER NEVER NEVER pointing downwards, relative to
        /// state.ReferenceUp.  If this condition is violated
        /// then you will see crazy spinning.  That's the symptom.
        /// screenRect
        /// </summary>
        /// <param name="screenRect">相机空间的Rect</param>
        private bool RotateToScreenBounds(
            ref CameraState state, Rect screenRect,
            ref Quaternion rigOrientation, float fov, float fovH, float deltaTime)
        {
            //当前看向的位置和相机的差值
            Vector3 targetDir = TrackedPoint - state.CorrectedPosition;
            //获取本次移动，相机需要旋转的角度，参考坐标系的上方向为state.ReferenceUp。Vector2.y
            //是围绕up转的角度，Vector2.x是围绕right的角度
            Vector2 rotToRect = rigOrientation.GetCameraRotationToTarget(targetDir, state.ReferenceUp);

            // Bring it to the edge of screenRect, if outside.  Leave it alone if inside.
            //旋转俯仰角，使目标在上下的rect中，注意这里只负责俯仰角，不处理左右的移动，同时确保screenRect的内都不会出现相机翻车的情况
            ClampVerticalBounds(ref screenRect, targetDir, state.ReferenceUp, fov);
            //将合法的screenRect转换成相机的角度
            float min = (screenRect.yMin - 0.5f) * fov;
            float max = (screenRect.yMax - 0.5f) * fov;
            //如果需要旋转的角度小于我们的最小角度，说明已经超出了合法的边界，所以需要旋转的角度=rotToRect.x - min，保证相机旋转在合法的边缘
            if (rotToRect.x < min)
            {
                rotToRect.x -= min;
            }
            else if (rotToRect.x > max)
            {
                rotToRect.x -= max;
            }               
            else
                rotToRect.x = 0;

            min = (screenRect.xMin - 0.5f) * fovH;
            max = (screenRect.xMax - 0.5f) * fovH;
            if (rotToRect.y < min)
                rotToRect.y -= min;
            else if (rotToRect.y > max)
                rotToRect.y -= max;
            else
                rotToRect.y = 0;

            // Apply damping
            //应用Damp
            if (deltaTime >= 0)
            {
                rotToRect.x = Damper.Damp(rotToRect.x, m_VerticalDamping, deltaTime);
                rotToRect.y = Damper.Damp(rotToRect.y, m_HorizontalDamping, deltaTime);
            }

            // 旋转相机
            rigOrientation = rigOrientation.ApplyCameraRotation(rotToRect, state.ReferenceUp);
#if false
            // GML this gives false positives when the camera is moving.
            // The way to address this would be to grow the hard rect by the amount 
            // that it would be damped
            return Mathf.Abs(rotToRect.x) > Epsilon || Mathf.Abs(rotToRect.y) > Epsilon;
#else
            return false; 
#endif
        }

        /// <summary>
        /// Prevent upside-down camera situation.  This can happen if we have a high
        /// camera pitch combined with composer settings that cause the camera to tilt
        /// beyond the vertical in order to produce the desired framing.  We prevent this by
        /// clamping the composer's vertical settings so that this situation can't happen.
        /// 避免相机倒挂，就是避免相机y轴和参考的Up值夹角大于90度，一旦大于90度，则进行Z轴180度旋转
        /// </summary>
        private bool ClampVerticalBounds(ref Rect r, Vector3 dir, Vector3 up, float fov)
        {           
            float angle = Vector3.Angle(dir, up);
            float halfFov = (fov / 2f) + 1; // give it a little extra to accommodate precision errors
            //-即将正向翻车--绕x轴正向旋转
            //-
            if (angle < halfFov)
            {
                // looking up
                //-
                float maxY = 1f - (halfFov - angle) / fov;
                //将r的区域限定在合法的范围，不可以翻车
                if (r.yMax > maxY)
                {
                    r.yMin = Mathf.Min(r.yMin, maxY);
                    r.yMax = Mathf.Min(r.yMax, maxY);                  
                    return true;
                }
            }
            //计量反向翻车--绕x轴反向旋转
            if (angle > (180 - halfFov))
            {
                // looking down
                float minY = (angle - (180 - halfFov)) / fov;
                if (minY > r.yMin)
                {
                    r.yMin = Mathf.Max(r.yMin, minY);
                    r.yMax = Mathf.Max(r.yMax, minY);
                    return true;
                }
            }
            return false;
        }
    }
}
