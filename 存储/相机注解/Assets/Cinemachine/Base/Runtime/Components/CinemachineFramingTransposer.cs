using System;
using Cinemachine.Utility;
using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine
{
    /// <summary>
    /// This is a Cinemachine Component in the Body section of the component pipeline. 
    /// Its job is to position the camera in a fixed screen-space relationship to 
    /// the vcam's Follow target object, with offsets and damping.
    /// Pipeline中的Body组件，通过目标在屏幕中的位置来设置相机的位置。（屏幕位置可以分成三个区域 1.不跟随区域
    ///  2.缓动跟随区域 3.立即跟随区域）。当物体在1区域时，相机不会移动，在2区域时，将damping到1区域内，在3区域
    ///  时，将立即设置到2区域内。
    ///  相机移动时，先移动到和目标制定距离，然后在进行x-y平面的移动，使之适配屏幕区域。
    ///  使用此组件，不应该在使用Aim组件，因为此组件会自动设置相机看向跟随目标
    ///  
    /// 
    /// The camera will be first moved along the camera Z axis until the Follow target
    /// is at the desired distance from the camera's X-Y plane.  The camera will then
    /// be moved in its XY plane until the Follow target is at the desired point on
    /// the camera's screen.
    /// 
    /// The FramingTansposer will only change the camera's position in space.  It will not 
    /// re-orient or otherwise aim the camera.
    /// 
    /// For this component to work properly, the vcam's LookAt target must be null.
    /// The Follow target will define what the camera is looking at.
    /// 
    /// If the Follow target is a CinemachineTargetGroup, then additional controls will 
    /// be available to dynamically adjust the camera抯 view in order to frame the entire group.
    /// 
    /// Although this component was designed for orthographic cameras, it works equally  
    /// well with persective cameras and can be used in 3D environments.
    /// </summary>
    [DocumentationSorting(5.5f, DocumentationSortingAttribute.Level.UserRef)]
    [ExecuteInEditMode] // for OnGUI
    [AddComponentMenu("")] // Don't display in add component menu
    [RequireComponent(typeof(CinemachinePipeline))]
    [SaveDuringPlay]
    public class CinemachineFramingTransposer : CinemachineComponentBase
    {
        /// <summary>Used by the Inspector Editor to display on-screen guides.</summary>
        [NoSaveDuringPlay, HideInInspector]
        public Action OnGUICallback = null;

        /// <summary>This setting will instruct the composer to adjust its target offset based
        /// on the motion of the target.  The composer will look at a point where it estimates
        /// the target will be this many seconds into the future.  Note that this setting is sensitive
        /// to noisy animation, and can amplify the noise, resulting in undesirable camera jitter.
        /// If the camera jitters unacceptably when the target is in motion, turn down this setting, 
        /// or animate the target more smoothly.</summary>
        [Tooltip("This setting will instruct the composer to adjust its target offset based on the motion of the target.  The composer will look at a point where it estimates the target will be this many seconds into the future.  Note that this setting is sensitive to noisy animation, and can amplify the noise, resulting in undesirable camera jitter.  If the camera jitters unacceptably when the target is in motion, turn down this setting, or animate the target more smoothly.")]
        [Range(0f, 1f)]
        public float m_LookaheadTime = 0;

        /// <summary>Controls the smoothness of the lookahead algorithm.  Larger values smooth out 
        /// jittery predictions and also increase prediction lag</summary>
        [Tooltip("Controls the smoothness of the lookahead algorithm.  Larger values smooth out jittery predictions and also increase prediction lag")]
        [Range(3, 30)]
        public float m_LookaheadSmoothing = 10;

        /// <summary>
        /// X方向的Damp
        /// </summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to maintain the offset in the X-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's x-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
        public float m_XDamping = 1f;

        /// <summary>
        /// Y方向的Damp
        /// </summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to maintain the offset in the Y-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's y-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
        public float m_YDamping = 1f;

        /// <summary>
        /// Z方向的Damp
        /// </summary>
        [Range(0f, 20f)]
        [Tooltip("How aggressively the camera tries to maintain the offset in the Z-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's z-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
        public float m_ZDamping = 1f;

        /// <summary>
        /// 区域1的中心点在屏幕x位置
        /// </summary>
        [Space]
        [Range(0f, 1f)]
        [Tooltip("Horizontal screen position for target. The camera will move to position the tracked object here.")]
        public float m_ScreenX = 0.5f;

        /// <summary>
        /// 区域1的中心点在屏幕y位置
        /// </summary>
        [Range(0f, 1f)]
        [Tooltip("Vertical screen position for target, The camera will move to position the tracked object here.")]
        public float m_ScreenY = 0.5f;

        /// <summary>
        /// 相机到目标的距离
        /// </summary>
        [Tooltip("The distance along the camera axis that will be maintained from the Follow target")]
        public float m_CameraDistance = 10f;

        /// <summary>
        /// 区域1的宽度
        /// </summary>
        [Space]
        [Range(0f, 1f)]
        [Tooltip("Camera will not move horizontally if the target is within this range of the position.")]
        public float m_DeadZoneWidth = 0.1f;

        /// <summary>
        /// 区域1的高度
        /// </summary>
        [Range(0f, 1f)]
        [Tooltip("Camera will not move vertically if the target is within this range of the position.")]
        public float m_DeadZoneHeight = 0.1f;

        /// <summary>The camera will not move along its z-axis if the Follow target is within this distance of the specified camera distance
        /// 相机在Z方向上可以活动的范围，Z值的范围[m_CameraDistance-m_DeadZoneDepth,m_CameraDistance+m_DeadZoneDepth]决定，
        /// </summary>
        [Tooltip("The camera will not move along its z-axis if the Follow target is within this distance of the specified camera distance")]
        [FormerlySerializedAs("m_DistanceDeadZoneSize")]
        public float m_DeadZoneDepth = 0;

        [Space]
        /// <summary>
        /// 是否禁用区域2
        /// </summary>
        [Tooltip("If checked, then then soft zone will be unlimited in size.")]
        public bool m_UnlimitedSoftZone = false;

        /// <summary>
        /// 区域2的宽度
        /// </summary>
        [Range(0f, 2f)]
        [Tooltip("When target is within this region, camera will gradually move horizontally to re-align towards the desired position, depending on the damping speed.")]
        public float m_SoftZoneWidth = 0.8f;

        /// <summary>
        /// 区域2的高度
        /// </summary>
        [Range(0f, 2f)]
        [Tooltip("When target is within this region, camera will gradually move vertically to re-align towards the desired position, depending on the damping speed.")]
        public float m_SoftZoneHeight = 0.8f;

        /// <summary>
        /// 区域2相对于区域1的中心点的X偏移
        /// </summary>
        [Range(-0.5f, 0.5f)]
        [Tooltip("A non-zero bias will move the target position horizontally away from the center of the soft zone.")]
        public float m_BiasX = 0f;

        /// <summary>
        /// 区域2相对于区域1的中心点的Y偏移
        /// </summary>
        [Range(-0.5f, 0.5f)]
        [Tooltip("A non-zero bias will move the target position vertically away from the center of the soft zone.")]
        public float m_BiasY = 0f;

        /// <summary>What screen dimensions to consider when framing
        /// 基准参考，当相机看到一个bounds时，相机需要知道自己要看到的高度，换句话说要保证一个方向我们能看全，
        /// 所以我们要指定参考方向，比如指定水平，则计算出来的就会优先保证水平方向这个bounds我们是能看全的，垂直方向
        /// 则垂直方向我们能看全，两者都有则优先都在视野内。不是指
        /// </summary>
        [DocumentationSorting(4.01f, DocumentationSortingAttribute.Level.UserRef)]
        public enum FramingMode
        {
            /// <summary>Consider only the horizontal dimension.  Vertical framing is ignored.</summary>
            Horizontal,
            /// <summary>Consider only the vertical dimension.  Horizontal framing is ignored.</summary>
            Vertical,
            /// <summary>The larger of the horizontal and vertical dimensions will dominate, to get the best fit.</summary>
            HorizontalAndVertical,
            /// <summary>Don't do any framing adjustment</summary>
            None
        };

        /// <summary>What screen dimensions to consider when framing</summary>
        [Space]
        [Tooltip("What screen dimensions to consider when framing.  Can be Horizontal, Vertical, or both")]
        [FormerlySerializedAs("m_FramingMode")]
        public FramingMode m_GroupFramingMode = FramingMode.HorizontalAndVertical;

        /// <summary>How to adjust the camera to get the desired framing
        /// 相机的调节模式。调节FOV和正交相机的size，移动相机，先移动相机，在调节fov
        /// </summary>
        public enum AdjustmentMode
        {
            /// <summary>Do not move the camera, only adjust the FOV.</summary>
            ZoomOnly,
            /// <summary>Just move the camera, don't change the FOV.</summary>
            DollyOnly,
            /// <summary>Move the camera as much as permitted by the ranges, then
            /// adjust the FOV if necessary to make the shot.</summary>
            DollyThenZoom
        };

        /// <summary>How to adjust the camera to get the desired framing</summary>
        [Tooltip("How to adjust the camera to get the desired framing.  You can zoom, dolly in/out, or do both.")]
        public AdjustmentMode m_AdjustmentMode = AdjustmentMode.DollyThenZoom;

        /// <summary>How much of the screen to fill with the bounding box of the targets.</summary>
        [Tooltip("The bounding box of the targets should occupy this amount of the screen space.  1 means fill the whole screen.  0.5 means fill half the screen, etc.")]
        public float m_GroupFramingSize = 0.8f;

        /// <summary>How much closer to the target can the camera go?
        /// 当根据Bounds来求相机的位置和根据中心点求位置出现偏差时，Bounds的下部区域[targetZ-m_MaxDollyIn
        /// </summary>
        [Tooltip("The maximum distance toward the target that this behaviour is allowed to move the camera.")]
        public float m_MaxDollyIn = 5000f;

        /// <summary>How much farther from the target can the camera go?
        /// 当根据Bounds来求相机的位置和根据中心点求位置出现偏差时，Bounds的上部区域targetZ+m_MaxDollyOut]
        /// </summary>
        [Tooltip("The maximum distance away the target that this behaviour is allowed to move the camera.")]
        public float m_MaxDollyOut = 5000f;

        /// <summary>Set this to limit how close to the target the camera can get
        /// 依据Bounds计算的出的相机位置的区间范围[m_MinimumDistance, m_MaximumDistance]
        /// </summary>
        [Tooltip("Set this to limit how close to the target the camera can get.")]
        public float m_MinimumDistance = 1;

        /// <summary>Set this to limit how far from the taregt the camera can get
        /// 依据Bounds计算的出的相机位置的区间范围[m_MinimumDistance, m_MaximumDistance]
        /// </summary>
        [Tooltip("Set this to limit how far from the target the camera can get.")]
        public float m_MaximumDistance = 5000f;

        /// <summary>If adjusting FOV, will not set the FOV lower than this</summary>
        [Range(1, 179)]
        [Tooltip("If adjusting FOV, will not set the FOV lower than this.")]
        public float m_MinimumFOV = 3;

        /// <summary>If adjusting FOV, will not set the FOV higher than this</summary>
        [Range(1, 179)]
        [Tooltip("If adjusting FOV, will not set the FOV higher than this.")]
        public float m_MaximumFOV = 60;

        /// <summary>If adjusting Orthographic Size, will not set it lower than this</summary>
        [Tooltip("If adjusting Orthographic Size, will not set it lower than this.")]
        public float m_MinimumOrthoSize = 1;

        /// <summary>If adjusting Orthographic Size, will not set it higher than this</summary>
        [Tooltip("If adjusting Orthographic Size, will not set it higher than this.")]
        public float m_MaximumOrthoSize = 100;

        /// <summary>Internal API for the inspector editor
        /// 区域1的Rect范围（屏幕空间）
        /// </summary>
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

        /// <summary>Internal API for the inspector editor
        /// 区域2的Rect范围（屏幕空间）
        /// </summary>
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

        private void OnValidate()
        {
            m_CameraDistance = Mathf.Max(m_CameraDistance, kMinimumCameraDistance);
            m_DeadZoneDepth = Mathf.Max(m_DeadZoneDepth, 0);

            m_GroupFramingSize = Mathf.Max(Epsilon, m_GroupFramingSize);
            m_MaxDollyIn = Mathf.Max(0, m_MaxDollyIn);
            m_MaxDollyOut = Mathf.Max(0, m_MaxDollyOut);
            m_MinimumDistance = Mathf.Max(0, m_MinimumDistance);
            m_MaximumDistance = Mathf.Max(m_MinimumDistance, m_MaximumDistance);
            m_MinimumFOV = Mathf.Max(1, m_MinimumFOV);
            m_MaximumFOV = Mathf.Clamp(m_MaximumFOV, m_MinimumFOV, 179);
            m_MinimumOrthoSize = Mathf.Max(0.01f, m_MinimumOrthoSize);
            m_MaximumOrthoSize = Mathf.Max(m_MinimumOrthoSize, m_MaximumOrthoSize);
        }

#if UNITY_EDITOR
        private void OnGUI() { if (OnGUICallback != null) OnGUICallback(); }
#endif

        /// <summary>
        /// 可用条件，有Follow目标没有Aim目标
        /// </summary>
        public override bool IsValid { get { return enabled && FollowTarget != null && LookAtTarget == null; } }

        /// <summary>Get the Cinemachine Pipeline stage that this component implements.
        /// Always returns the Body stage</summary>
        public override CinemachineCore.Stage Stage { get { return CinemachineCore.Stage.Body; } }

        const float kMinimumCameraDistance = 0.01f;

        /// <summary>
        /// Damp使用
        /// </summary>
        Vector3 m_PreviousCameraPosition = Vector3.zero;
        /// <summary>
        /// 预测器
        /// </summary>
        PositionPredictor m_Predictor = new PositionPredictor();

        /// <summary>Internal API for inspector
        /// 轨迹位置（包括预测位置）
        /// </summary>
        public Vector3 TrackedPoint { get; private set; }

        /// <summary>
        /// 进行位置设置
        /// </summary>
        /// <param name="curState">The current camera state</param>
        /// <param name="deltaTime">Used for damping.  If less than 0, no damping is done.</param>
        public override void MutateCameraState(ref CameraState curState, float deltaTime)
        {
            if (deltaTime < 0)
            {
                //--设置位置为当前位置
                m_Predictor.Reset();
                m_PreviousCameraPosition = curState.RawPosition 
                    + (curState.RawOrientation * Vector3.back) * m_CameraDistance;
            }
            if (!IsValid)
                return;

            //UnityEngine.Profiling.Profiler.BeginSample("CinemachineFramingTransposer.MutateCameraState");
            Vector3 camPosWorld = m_PreviousCameraPosition;
            curState.ReferenceLookAt = FollowTarget.position;
            //--正太分布预测下一个点的位置，如果预测时间小于0则认为不预测，直接使用目标的位置
            m_Predictor.Smoothing = m_LookaheadSmoothing;
            m_Predictor.AddPosition(curState.ReferenceLookAt);
            //--TrackedPoint目标的本次位置
            TrackedPoint = (m_LookaheadTime > 0) 
                ? m_Predictor.PredictPosition(m_LookaheadTime) : curState.ReferenceLookAt;

            // Work in camera-local space
            //--相当于Matrix4x4.TRS（Vecter3(0,0,0),curState.RawOrientation,Vecter3(1,1,1)）,构建的矩阵
            //--只是将世界坐标系的坐标轴和相机的轴保持了一致而已，因为我们只关心相机空间的Z值，所以这里可以简单使用
            Quaternion localToWorld = curState.RawOrientation;
            Quaternion worldToLocal = Quaternion.Inverse(localToWorld);
            //--上一帧相机的位置，转化到上述空间的位置
            Vector3 cameraPos = worldToLocal * camPosWorld;
            //--本次目标位置在相机空间和相机位置做差，得到的z就是距离目标距离相机的位置
            Vector3 targetPos = (worldToLocal * TrackedPoint) - cameraPos;

            // Move along camera z
            Vector3 cameraOffset = Vector3.zero;
            //计算相机Z值的范围
            float cameraMin = Mathf.Max(kMinimumCameraDistance, m_CameraDistance - m_DeadZoneDepth/2);
            float cameraMax = Mathf.Max(cameraMin, m_CameraDistance + m_DeadZoneDepth/2);
            //计算偏移值-如果计算的偏移值小于最小幅度，或者大于最大幅度则记录其偏移信息
            //如果在区间内，则保持不变
            if (targetPos.z < cameraMin)
                cameraOffset.z = targetPos.z - cameraMin;
            if (targetPos.z > cameraMax)
                cameraOffset.z = targetPos.z - cameraMax;

            // Adjust for group framing
            CinemachineTargetGroup group = TargetGroup;
            //--如果是targetgroup则计算group的偏移，因为group可能会需要看到全部的bounds
            //--注意下面targetPos.z - cameraOffset.z的结果就是使数据在[cameraMin,cameraMax]区间
            if (group != null && m_GroupFramingMode != FramingMode.None)
                cameraOffset.z += AdjustCameraDepthAndLensForGroupFraming(
                    group, targetPos.z - cameraOffset.z, ref curState, deltaTime);

            // Move along the XY plane
            //--计算物体相对于相机的偏移，这个计算有点绕。
            //targetPos.z 在[m_CameraDistance-m_DeadZoneDepth,m_CameraDistance+m_DeadZoneDepth]区间
            targetPos.z -= cameraOffset.z;
            //获取屏幕高度（一半），如果像是正交直接获取size，如果是透视，获取targetPos.z位置处相机视框的高度
            float screenSize = curState.Lens.Orthographic 
                ? curState.Lens.OrthographicSize 
                : Mathf.Tan(0.5f * curState.Lens.FieldOfView * Mathf.Deg2Rad) * targetPos.z;
            //-计算区域1在屏幕中的位置
            Rect softGuideOrtho = ScreenToOrtho(SoftGuideRect, screenSize, curState.Lens.Aspect);
            if (deltaTime < 0)
            {
                // No damping or hard bounds, just snap to central bounds, skipping the soft zone
                //--强制中心点对齐
                Rect rect = new Rect(softGuideOrtho.center, Vector2.zero); // Force to center
                cameraOffset += OrthoOffsetToScreenBounds(targetPos, rect);
            }
            else
            {
                // Move it through the soft zone
                //--目标点相对于区域1的偏移，只有xy平面的偏移
                cameraOffset += OrthoOffsetToScreenBounds(targetPos, softGuideOrtho);

                // Find where it intersects the hard zone
                Vector3 hard = Vector3.zero;
                //-如果不禁用区域2，则会有缓动效果
                if (!m_UnlimitedSoftZone)
                {
                    //计算区域2在屏幕中的位置
                    Rect hardGuideOrtho = ScreenToOrtho(HardGuideRect, screenSize, curState.Lens.Aspect);
                    //当前位置相对区域2的偏移
                    hard = OrthoOffsetToScreenBounds(targetPos, hardGuideOrtho);
                    float t = Mathf.Max(hard.x / (cameraOffset.x + Epsilon), hard.y / (cameraOffset.y + Epsilon));
                    //--超出部分偏移
                    hard = cameraOffset * t;
                }
                // Apply damping, but only to the portion of the move that's inside the hard zone
                //--hard是超出区域2的部分，超出部分会立刻被执行偏移，缓动部分会差值执行
                cameraOffset = hard + Damper.Damp(
                    cameraOffset - hard, new Vector3(m_XDamping, m_YDamping, m_ZDamping), deltaTime);
            }
            //--设置相机的位置
            curState.RawPosition = m_PreviousCameraPosition = localToWorld * (cameraPos + cameraOffset);
            //UnityEngine.Profiling.Profiler.EndSample();
        }

        // Convert from screen coords to normalized orthographic distance coords
        /// <summary>
        /// 由于设置的Rect在屏幕显示时的坐标系是左上角为(0,0)点，右下角为（1,1）点，我们需要将这个坐标系
        /// 转换为屏幕左下角为（-0.5，-0.5），屏幕中心为（0,0），右上角为（0.5,0.5）。
        /// 转换过程如下：
        ///  1.将左上角的（0,0），右下角为（1,1）的转换为左下角为（0,0），右上角为（1,1），即
        ///  r.yMax =1f-rScreen.yMin;r.yMin =1f-rScreen.yMax; 
        ///  2.将坐标系转换到屏幕中心为（0,0），分别减0.5即可。
        ///  3.将屏幕的y:[0,1]转换到[0,2 * orthoSize]   x:[0,1]转换到[0,2 * orthoSize * aspect]
        /// </summary>
        /// <param name="rScreen"></param>
        /// <param name="orthoSize"></param>
        /// <param name="aspect"></param>
        /// <returns></returns>
        private Rect ScreenToOrtho(Rect rScreen, float orthoSize, float aspect)
        {
            Rect r = new Rect();          

            r.yMax = 2 * orthoSize * ((1f-rScreen.yMin) - 0.5f);
            r.yMin = 2 * orthoSize * ((1f-rScreen.yMax) - 0.5f);
            r.xMin = 2 * orthoSize * aspect * (rScreen.xMin - 0.5f);
            r.xMax = 2 * orthoSize * aspect * (rScreen.xMax - 0.5f);
            return r;
        }
        /// <summary>
        /// 指定点相对于屏幕指定区域内的偏移量，如果在区域内在为0
        /// </summary>
        /// <param name="targetPos2D"></param>
        /// <param name="screenRect"></param>
        /// <returns></returns>
        private Vector3 OrthoOffsetToScreenBounds(Vector3 targetPos2D, Rect screenRect)
        {
            // Bring it to the edge of screenRect, if outside.  Leave it alone if inside.
            Vector3 delta = Vector3.zero;
            if (targetPos2D.x < screenRect.xMin)
                delta.x += targetPos2D.x - screenRect.xMin;
            if (targetPos2D.x > screenRect.xMax)
                delta.x += targetPos2D.x - screenRect.xMax;
            if (targetPos2D.y < screenRect.yMin)
                delta.y += targetPos2D.y - screenRect.yMin;
            if (targetPos2D.y > screenRect.yMax)
                delta.y += targetPos2D.y - screenRect.yMax;
            return delta;
        }

        float m_prevTargetHeight; // State for frame damping

        /// <summary>For editor visulaization of the calculated bounding box of the group</summary>
        public Bounds m_LastBounds { get; private set; }

        /// <summary>For editor visualization of the calculated bounding box of the group</summary>
        public Matrix4x4 m_lastBoundsMatrix { get; private set; }

        /// <summary>Get Follow target as CinemachineTargetGroup, or null if target is not a group
        /// 目标是否是TargetGroup
        /// </summary>
        public CinemachineTargetGroup TargetGroup 
        { 
            get
            {
                Transform follow = FollowTarget;
                if (follow != null)
                    return follow.GetComponent<CinemachineTargetGroup>();
                return null;
            }
        }
        /// <summary>
        /// 根据TargetGroup来重新设定相机的位置和FOV，因为TargetGroup的需求会有需要看到全貌
        /// </summary>
        /// <param name="group"></param>
        /// <param name="targetZ">目标中心在伪相机空间的Z深度</param>
        /// <param name="curState"></param>
        /// <param name="deltaTime"></param>
        /// <returns></returns>
        float AdjustCameraDepthAndLensForGroupFraming(
            CinemachineTargetGroup group, float targetZ, 
            ref CameraState curState, float deltaTime)
        {
            float cameraOffset = 0;

            // Get the bounding box from that POV in view space, and find its height
            //--获取bounds
            Bounds bounds = group.BoundingBox;
            //--获取forward
            Vector3 fwd = curState.RawOrientation * Vector3.forward;
            //--构建以摄像机方向，bounds在相机forward方向在extents.magnitude位置的矩阵。
            //--为什么要bounds.center - (fwd * bounds.extents.magnitude)，因为要保证，新的坐标系，bounds要在
            //--新坐标系z的相同侧，因为我们要保证相机可以看到全部的bounds
            m_lastBoundsMatrix = Matrix4x4.TRS(
                    bounds.center - (fwd * bounds.extents.magnitude),
                    curState.RawOrientation, Vector3.one);
            //--获取新空间bounds==》将世界空间的bounds转化到新空间
            m_LastBounds = group.GetViewSpaceBoundingBox(m_lastBoundsMatrix);
            //--获取高度
            float targetHeight = GetTargetHeight(m_LastBounds);

            // Apply damping
            //进行Damp的应用，叠加高度
            if (deltaTime >= 0)
            {
                float delta = targetHeight - m_prevTargetHeight;
                delta = Damper.Damp(delta, m_ZDamping, deltaTime);
                targetHeight = m_prevTargetHeight + delta;
            }
            m_prevTargetHeight = targetHeight;

            // Move the camera
            if (!curState.Lens.Orthographic && m_AdjustmentMode != AdjustmentMode.ZoomOnly)
            {
                // What distance would be needed to get the target height, at the current FOV
                //按照当前FOV计算，如果需要看到Bounds的高度，需要设置相机的距离。
                float desiredDistance 
                    = targetHeight / (2f * Mathf.Tan(curState.Lens.FieldOfView * Mathf.Deg2Rad / 2f));

                // target the near surface of the bounding box
                //-由于上面看到的是bounds的中心位置，再次基础上进行z偏移，因为Bounds是有厚度的，上面的计算只是计算到Bounds中心高度
                desiredDistance += m_LastBounds.extents.z;

                // Clamp to respect min/max distance settings
                //当根据Bounds来求相机的位置和根据中心点求位置出现偏差时，两者之间的偏差范围
                //--即，依据Bounds求的位置数值区间[targetZ - m_MaxDollyIn, targetZ + m_MaxDollyOut]
                desiredDistance = Mathf.Clamp(
                        desiredDistance, targetZ - m_MaxDollyIn, targetZ + m_MaxDollyOut);
                //--依据Bounds计算的出的相机位置的区间范围[m_MinimumDistance, m_MaximumDistance]
                desiredDistance = Mathf.Clamp(desiredDistance, m_MinimumDistance, m_MaximumDistance);

                //应用相机偏移。（Bounds和中心点的偏移差--》这句话的意思就是按照计算出来的Bounds来做）
                cameraOffset += desiredDistance - targetZ;
            }

            // Apply zoom
            //--正交相机需要设置OrthographicSize，或者调解模式需要设置fov
            if (curState.Lens.Orthographic || m_AdjustmentMode != AdjustmentMode.DollyOnly)
            {
                float nearBoundsDistance = (targetZ + cameraOffset) - m_LastBounds.extents.z;
                float currentFOV = 179;
                if (nearBoundsDistance > Epsilon)
                    currentFOV = 2f * Mathf.Atan(targetHeight / (2 * nearBoundsDistance)) * Mathf.Rad2Deg;

                LensSettings lens = curState.Lens;
                //--透视相机时，设置fov确保bounds被完全看到
                lens.FieldOfView = Mathf.Clamp(currentFOV, m_MinimumFOV, m_MaximumFOV);
                //--只有正交相机才会设置，设置正交相机的size，如果在[m_MinimumOrthoSize,m_MaximumOrthoSize]则会正好看到
                lens.OrthographicSize = Mathf.Clamp(targetHeight / 2, m_MinimumOrthoSize, m_MaximumOrthoSize);
                curState.Lens = lens;
            }
            return -cameraOffset;
        }

        float GetTargetHeight(Bounds b)
        {
            float framingSize = Mathf.Max(Epsilon, m_GroupFramingSize);
            switch (m_GroupFramingMode)
            {
                case FramingMode.Horizontal:
                    return b.size.x / (framingSize * VcamState.Lens.Aspect);
                case FramingMode.Vertical:
                    return b.size.y / framingSize;
                default:
                case FramingMode.HorizontalAndVertical:
                    return Mathf.Max(
                        b.size.x / (framingSize * VcamState.Lens.Aspect), 
                        b.size.y / framingSize);
            }
        }
    }
}
