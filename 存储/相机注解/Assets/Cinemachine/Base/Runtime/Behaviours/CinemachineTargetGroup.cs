using UnityEngine;
using System;
using Cinemachine.Utility;

namespace Cinemachine
{
    /// <summary>Defines a group of target objects, each with a radius and a weight.
    /// The weight is used when calculating the average position of the target group.
    /// Higher-weighted members of the group will count more.
    /// The bounding box is calculated by taking the member positions, weight, 
    /// and radii into account.
    /// 位置计算：位置叠加，然后除以weight之和。
    /// weight：相加然后相除个数，计算平均权重，所以weight并不是0-1
    /// </summary>
    [DocumentationSorting(19, DocumentationSortingAttribute.Level.UserRef)]
    [AddComponentMenu("Cinemachine/CinemachineTargetGroup")]
    [SaveDuringPlay]
    [ExecuteInEditMode]
    public class CinemachineTargetGroup : MonoBehaviour
    {
        /// <summary>Holds the information that represents a member of the group</summary>
        [DocumentationSorting(19.1f, DocumentationSortingAttribute.Level.UserRef)]
        [Serializable] public struct Target
        {
            /// <summary>
            /// 目标的Transform
            /// </summary>
            [Tooltip("The target objects.  This object's position and orientation will contribute to the group's average position and orientation, in accordance with its weight")]
            public Transform target;
            /// <summary>
            /// 目标权重
            /// </summary>
            [Tooltip("How much weight to give the target when averaging.  Cannot be negative")]
            public float weight;
            /// <summary>
            /// 目标半径
            /// </summary>
            [Tooltip("The radius of the target, used for calculating the bounding box.  Cannot be negative")]
            public float radius;
        }

        /// <summary>How the group's position is calculated</summary>
        [DocumentationSorting(19.2f, DocumentationSortingAttribute.Level.UserRef)]
        public enum PositionMode
        {
            ///<summary>Group position will be the center of the group's axis-aligned bounding box</summary>
            GroupCenter,
            /// <summary>Group position will be the weighted average of the positions of the members</summary>
            GroupAverage
        }

        /// <summary>How the group's position is calculated</summary>
        [Tooltip("How the group's position is calculated.  Select GroupCenter for the center of the bounding box, and GroupAverage for a weighted average of the positions of the members.")]
        public PositionMode m_PositionMode = PositionMode.GroupCenter;

        /// <summary>How the group's orientation is calculated</summary>
        [DocumentationSorting(19.3f, DocumentationSortingAttribute.Level.UserRef)]
        public enum RotationMode
        {
            /// <summary>Manually set in the group's transform</summary>
            Manual,
            /// <summary>Weighted average of the orientation of its members.</summary>
            GroupAverage
        }

        /// <summary>How the group's orientation is calculated</summary>
        [Tooltip("How the group's rotation is calculated.  Select Manual to use the value in the group's transform, and GroupAverage for a weighted average of the orientations of the members.")]
        public RotationMode m_RotationMode = RotationMode.Manual;

        /// <summary>更新模式</summary>
        public enum UpdateMethod
        {
            /// <summary>Updated in normal MonoBehaviour Update.</summary>
            Update,
            /// <summary>Updated in sync with the Physics module, in FixedUpdate</summary>
            FixedUpdate,
            /// <summary>Updated in MonoBehaviour LateUpdate.</summary>
            LateUpdate
        };

        /// <summary>When to update the group's transform based on the position of the group members</summary>
        [Tooltip("When to update the group's transform based on the position of the group members")]
        public UpdateMethod m_UpdateMethod = UpdateMethod.LateUpdate;

        /// <summary>
        /// 目标列表
        /// </summary>
        [NoSaveDuringPlay]
        [Tooltip("The target objects, together with their weights and radii, that will contribute to the group's average position, orientation, and size.")]
        public Target[] m_Targets = new Target[0];

        /// Cache of the last valid radius
        private float m_lastRadius = 0;

        /// <summary>
        /// 根据目标和权重计算Bounds
        /// </summary>
        public Bounds BoundingBox
        {
            get
            {
                float averageWeight;
                //-计算中心位置和平均权重
                Vector3 center = CalculateAveragePosition(out averageWeight);
                bool gotOne = false;
                //-
                Bounds b = new Bounds(center, new Vector3(m_lastRadius*2, m_lastRadius*2, m_lastRadius*2));
                //--当有平均权重时，使用权重计算bounds（下面会重新对b进行赋值），没有则使用上边的默认值
                if (averageWeight > UnityVectorExtensions.Epsilon)
                {
                    for (int i = 0; i < m_Targets.Length; ++i)
                    {
                        if (m_Targets[i].target != null)
                        {
                            float w = m_Targets[i].weight;
                            //--小于平均权重，则对半径进行等比例缩放
                            if (w < averageWeight - UnityVectorExtensions.Epsilon)
                                w = w / averageWeight;
                            else
                                //--大于标准值，则半径使用正常的半径
                                w = 1;
                            float d = m_Targets[i].radius * 2 * w;
                            //--根据权重计算目标的bounds中心点
                            Vector3 p = Vector3.Lerp(center, m_Targets[i].target.position, w);
                            Bounds b2 = new Bounds(p, new Vector3(d, d, d));
                            //--如果没有计算过bounds则将第一个记录为bonds，如果有了则不断重新扩大这个bounds
                            if (!gotOne)
                                b = b2;
                            else
                                b.Encapsulate(b2);
                            gotOne = true;
                        }
                    }
                }
                Vector3 r = b.extents;
                //--bounds半径的最大值
                m_lastRadius = Mathf.Max(r.x, Mathf.Max(r.y, r.z));
                return b;
            }
        }

        /// <summary>Return true if there are no members with weight > 0</summary>
        public bool IsEmpty 
        {
            get 
            {
                for (int i = 0; i < m_Targets.Length; ++i)
                    if (m_Targets[i].target != null && m_Targets[i].weight > UnityVectorExtensions.Epsilon)
                        return false;
                return true;
            }
        }

        /// <summary>The axis-aligned bounding box of the group, in a specific reference frame
        /// 获取bounds在视空间的表示
        /// </summary>
        /// <param name="mView">The frame of reference in which to compute the bounding box</param>
        /// <returns>The axis-aligned bounding box of the group, in the desired frame of reference</returns>
        public Bounds GetViewSpaceBoundingBox(Matrix4x4 mView)
        {
            //inverseView为世界空间到本地空间的矩阵
            Matrix4x4 inverseView = mView.inverse;
            float averageWeight;
            //视空间的中心点
            Vector3 center = inverseView.MultiplyPoint3x4(CalculateAveragePosition(out averageWeight));
            bool gotOne = false;
            Bounds b = new Bounds(center, new Vector3(m_lastRadius*2, m_lastRadius*2, m_lastRadius*2));
            if (averageWeight > UnityVectorExtensions.Epsilon)
            {
                //重新将targetgroup中节点在视空间再次构建bounds
                for (int i = 0; i < m_Targets.Length; ++i)
                {
                    if (m_Targets[i].target != null)
                    {
                        float w = m_Targets[i].weight;
                        //--小于平均权重，则对半径进行等比例缩放
                        if (w < averageWeight - UnityVectorExtensions.Epsilon)
                            w = w / averageWeight;
                        else
                            //--大于标准值，则半径使用正常的半径
                            w = 1;
                        float d = m_Targets[i].radius * 2;
                        Vector4 p = inverseView.MultiplyPoint3x4(m_Targets[i].target.position);
                        p = Vector3.Lerp(center, p, w);
                        Bounds b2 = new Bounds(p, new Vector3(d, d, d));
                        if (!gotOne)
                            b = b2;
                        else
                            b.Encapsulate(b2);
                        gotOne = true;
                    }
                }
            }
            Vector3 r = b.extents;
            m_lastRadius = Mathf.Max(r.x, Mathf.Max(r.y, r.z));
            return b;
        }

        Vector3 CalculateAveragePosition(out float averageWeight)
        {
            Vector3 pos = Vector3.zero;
            float weight = 0;
            int numTargets = 0;
            //--位置叠加，然后除以weight之后，求出平均位置。
            //注意向量的算法应用求取平均值
            for (int i = 0; i < m_Targets.Length; ++i)
            {
                if (m_Targets[i].target != null && m_Targets[i].weight > UnityVectorExtensions.Epsilon)
                {
                    ++numTargets;
                    weight += m_Targets[i].weight;
                    pos += m_Targets[i].target.position * m_Targets[i].weight;
                }
            }
            
            if (weight > UnityVectorExtensions.Epsilon)
                pos /= weight;
            if (numTargets == 0)
            {
                averageWeight = 0;
                return transform.position;
            }
            //--计算平均权重，weight是没有数据限定的，并不是限定在[0,1]之间，所以获取平均权重
            averageWeight = weight / numTargets;
            return pos;
        }

        Quaternion CalculateAverageOrientation()
        {
            Quaternion r = Quaternion.identity;
            for (int i = 0; i < m_Targets.Length; ++i)
            {
                if (m_Targets[i].target != null)
                {
                    float w = m_Targets[i].weight;
                    Quaternion q = m_Targets[i].target.rotation;
                    // This is probably bogus
                    r = new Quaternion(r.x + q.x * w, r.y + q.y * w, r.z + q.z * w, r.w + q.w * w);
                }
            }
            return r.Normalized();
        }

        private void OnValidate()
        {
            for (int i = 0; i < m_Targets.Length; ++i)
            {
                if (m_Targets[i].weight < 0)
                    m_Targets[i].weight = 0;
                if (m_Targets[i].radius < 0)
                    m_Targets[i].radius = 0;
            }
        }

        void FixedUpdate()
        {
            if (m_UpdateMethod == UpdateMethod.FixedUpdate)
                UpdateTransform();
        }

        void Update()
        {
            if (!Application.isPlaying || m_UpdateMethod == UpdateMethod.Update)
                UpdateTransform();
        }

        void LateUpdate()
        {
            if (m_UpdateMethod == UpdateMethod.LateUpdate)
                UpdateTransform();
        }

        void UpdateTransform()
        {
            if (IsEmpty)
                return;
            switch (m_PositionMode)
            {
                case PositionMode.GroupCenter:
                    transform.position = BoundingBox.center;
                    break;
                case PositionMode.GroupAverage:
                    float averageWeight;
                    transform.position = CalculateAveragePosition(out averageWeight);
                    break;
            }
            switch (m_RotationMode)
            {
                case RotationMode.Manual:
                    break;
                case RotationMode.GroupAverage:
                    transform.rotation = CalculateAverageOrientation();
                    break;
            }
        }
    }
}
