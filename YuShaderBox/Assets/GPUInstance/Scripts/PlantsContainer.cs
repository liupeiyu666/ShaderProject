using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// Author Lpy
/// @date 2020.8.10
/// 批量植被，使用GPUInstance
/// TODO Me:1.修改序列化的方式
/// 2.添加BoundsCulling-----实现剔除，实现LOD
/// 3.优化数据算法
/// 4.使用脚本池，避免重复申请
/// </summary>
[ExecuteInEditMode]
public class PlantsContainer : MonoBehaviour
{
#if UNITY_EDITOR
    [SerializeField]
    [HideInInspector]
    public PlantsSetting mSetting;
    [HideInInspector]
    public bool ShowMap;
#endif
    #region 扩展数据
    public struct DrawPlants
    {
        //需要的矩阵
        public List<Matrix4x4[]>  MMaterix4X4s;
        public Mesh MMesh;
        public Material MMaterial;
    }

    [System.Serializable]
    public struct OnePlants
    {
        //植被预制
        public GameObject MPlant;
        //此类植被的信息
        public PlantInfo[] PlantInfos;
    }
    [System.Serializable]
    public struct PlantInfo
    {
        public Vector3 Pos;
        public Quaternion Rot;
        public Vector3 Scal;
    }
    #endregion

    [SerializeField]
    //[HideInInspector]
    public List<OnePlants> PlantsList;
    /// <summary>
    /// 与之发生碰撞的地表，运行时，特殊时候时候
    /// </summary>
    public LayerMask Mask;
    //需要绘制的数据信息
    private List<DrawPlants> drawPlantsList = new List<DrawPlants>();

    void Awake()
    {
#if UNITY_EDITOR
        if (!Application.isPlaying )
        {
            //默认不显示
            ShowMap = false;
        }
#endif
        SetDrawBuffer();
    }

    void Update()
    {

#if UNITY_EDITOR
        if (!Application.isPlaying)
        {
            if (ShowMap)
            {
                SetDrawBuffer();
            }
            else
            {
                return;
            }
        }
#endif
        for (int i = 0; i < drawPlantsList.Count; i++)
        {
            for (int j = 0; j < drawPlantsList[i].MMaterix4X4s.Count; j++)
            {
                Graphics.DrawMeshInstanced(drawPlantsList[i].MMesh, 0, drawPlantsList[i].MMaterial, drawPlantsList[i].MMaterix4X4s[j], drawPlantsList[i].MMaterix4X4s[j].Length);
            }
          
        }
    }
    /// <summary>
    /// 设置需要绘制的数据信息
    /// </summary>
    void SetDrawBuffer()
    {
        drawPlantsList.Clear();
        for (int i = 0; i < PlantsList.Count; i++)
        {
            int oneTimes = 1020;
            //----计算一共多少数量，每1020为一个批次
            int counts = PlantsList[i].PlantInfos.Length / oneTimes;
            int left = PlantsList[i].PlantInfos.Length % oneTimes;
            counts = left == 0 ? counts : counts + 1;
            //----
            DrawPlants drawPlants = new DrawPlants();
            drawPlants.MMesh = PlantsList[i].MPlant.GetComponent<MeshFilter>().sharedMesh;
            drawPlants.MMaterial = PlantsList[i].MPlant.GetComponent<MeshRenderer>().sharedMaterial;
            drawPlants.MMaterix4X4s = new List<Matrix4x4[]>();

            for (int j = 0; j < counts; j++)
            {
                if (left != 0 && j == counts - 1)
                {
                    Matrix4x4[] oneX4s = new Matrix4x4[left];
                    for (int k = 0; k < left; k++)
                    {
                        var tempInfo = PlantsList[i].PlantInfos[j * oneTimes + k];
                        oneX4s[k] = Matrix4x4.TRS(tempInfo.Pos, tempInfo.Rot, tempInfo.Scal);
                    }
                    drawPlants.MMaterix4X4s.Add(oneX4s);
                }
                else
                {
                    Matrix4x4[] oneX4s=new Matrix4x4[oneTimes];
                    for (int k = 0; k < oneTimes; k++)
                    {
                        var tempInfo = PlantsList[i].PlantInfos[j * oneTimes + k];
                        oneX4s[k] = Matrix4x4.TRS(tempInfo.Pos, tempInfo.Rot, tempInfo.Scal);
                    }
                    drawPlants.MMaterix4X4s.Add(oneX4s);
                }
                
            }
            drawPlantsList.Add(drawPlants);
        }
    }

}
