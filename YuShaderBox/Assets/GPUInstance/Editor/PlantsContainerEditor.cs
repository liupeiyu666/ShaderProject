using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
using Random = UnityEngine.Random;
using static PlantsContainer;

/// <summary>
/// Author Lpy
/// @date 2020.8.13 植被编辑器界面，用于存储编辑的信息，来绘制植被
/// </summary>
[CustomEditor(typeof(PlantsContainer))]
public class PlantsContainerEditor : Editor
{
    #region 编辑控制

    #endregion
    public GameObject AddObject;

    public Texture[] TexObjects = new Texture[6];//TexObjects

    public int PlantSelect;

    PlantsContainer plantsContainer;

    Dictionary<GameObject, List<PlantInfo>> allPlantsDictionary=new Dictionary<GameObject, List<PlantInfo>>();
    private void OnEnable()
    {
        plantsContainer = target as PlantsContainer;
        InitData();
        if (m_go == null)
        {
            m_go = GameObject.CreatePrimitive(PrimitiveType.Quad);
            //m_go.hideFlags = HideFlags.HideAndDontSave;
            Material burshMat=Resources.Load<Material>("BurshMat");
            m_go.layer = LayerMask.NameToLayer("Ignore Raycast");
            m_go.GetComponent<MeshRenderer>().sharedMaterial = burshMat;
            m_go.transform.forward=Vector3.up;
        }
    }

    private void OnDisable()
    {
        if (m_go!=null)
        {
            DestroyImmediate(m_go);
        }
        SaveData();
    }
    #region 数据的初始化和存储

    void InitData()
    {
        allPlantsDictionary.Clear();
        //---记录数据中存储的所有数据
        for (int i = 0; i < plantsContainer.PlantsList.Count; i++)
        {
            var temp = plantsContainer.PlantsList[i];
            if (temp.MPlant!=null)
            {
                List<PlantInfo> plantList = new List<PlantInfo>();
                plantList.AddRange(temp.PlantInfos);
                allPlantsDictionary.Add(temp.MPlant, plantList);
            }
        }
    }

    void SaveData()
    {
        plantsContainer.PlantsList.Clear();
        foreach (var go in allPlantsDictionary.Keys)
        {
            if (go)
            {
                OnePlants tempOnePlants=new OnePlants();
                tempOnePlants.MPlant = go;
                tempOnePlants.PlantInfos=new PlantInfo[allPlantsDictionary[go].Count];
                for (int i = 0; i < allPlantsDictionary[go].Count; i++)
                {
                    tempOnePlants.PlantInfos[i] = allPlantsDictionary[go][i];
                }
                plantsContainer.PlantsList.Add(tempOnePlants);
            }
        }
    }

    #endregion


    public override void OnInspectorGUI()
    {
        base.DrawDefaultInspector();

        GUILayout.Space(20);
        GUILayout.BeginVertical("box", GUILayout.Width(Screen.width));
        GUILayout.BeginHorizontal();
        GUILayout.Label("开启编辑", GUILayout.Width(80));
        plantsContainer.mSetting.canEdit = GUILayout.Toggle(plantsContainer.mSetting.canEdit,"", GUILayout.Width(40));

        GUILayout.Label("显示植被", GUILayout.Width(80));
        plantsContainer.ShowMap = GUILayout.Toggle(plantsContainer.ShowMap, "", GUILayout.Width(40));
        
        GUILayout.EndHorizontal();
        GUILayout.BeginHorizontal();
        GUILayout.Label(new GUIContent("橡皮擦", "开启为添加，关闭为删除"), GUILayout.Width(80));
        plantsContainer.mSetting.useEraser = GUILayout.Toggle(plantsContainer.mSetting.useEraser, "", GUILayout.Width(40));
        if (plantsContainer.mSetting.useEraser)
        {
            GUILayout.Label(new GUIContent("单一种类删除", "选中为删除选中植被，非选中为删除所有植被"), GUILayout.Width(80));
            plantsContainer.mSetting.isSingleEraser = GUILayout.Toggle(plantsContainer.mSetting.isSingleEraser, "", GUILayout.Width(40));
        }
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();
        if (!plantsContainer.mSetting.canEdit)
        {
            return;
        }


        GUILayout.Space(20);
        GUILayout.BeginVertical("box", GUILayout.Width(Screen.width));
        GUILayout.BeginHorizontal();
        plantsContainer.mSetting = (PlantsSetting)EditorGUILayout.ObjectField("选择植被设置", plantsContainer.mSetting, typeof(PlantsSetting), true);
        if (GUILayout.Button(new GUIContent("创建","创建一个新的植被设置,路径为对应的场景路径Asset/PlantSettings.asset")))
        {
            plantsContainer.mSetting=new PlantsSetting();
            string path = string.Format("Assets/{0}.asset", (typeof(PlantsSetting).ToString()));
            AssetDatabase.CreateAsset(plantsContainer.mSetting, path);
        }
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();
        if (plantsContainer.mSetting==null)
        {
           
           
           
        }
        else
        {
            GUILayout.BeginHorizontal();

            GUILayout.BeginVertical("box", GUILayout.Width(Screen.width));
            GUILayout.BeginHorizontal();
            // GUILayout.Label("Add Assets", GUILayout.Width(125));
            GUILayout.Label("Add Assets", GUILayout.Width(125));
            AddObject = (GameObject)EditorGUILayout.ObjectField("", AddObject, typeof(GameObject), true, GUILayout.Width(160));
            if (GUILayout.Button("添加", GUILayout.Width(40)))
            {
                for (int i = 0; i < 6; i++)
                {
                    if (plantsContainer.mSetting.Plants[i] == null)
                    {
                        plantsContainer.mSetting.Plants[i] = AddObject;
                        plantsContainer.mSetting.PlantingSettings[i].Plant= AddObject;
                        break;
                    }
                }
            }

            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
            // GUILayout.FlexibleSpace();
            GUILayout.EndHorizontal();

            for (int i = 0; i < 6; i++)
            {
                if (plantsContainer.mSetting.Plants[i] != null)
                    TexObjects[i] = AssetPreview.GetAssetPreview(plantsContainer.mSetting.Plants[i]) as Texture;
                else TexObjects[i] = null;
            }

            GUILayout.BeginHorizontal();
            // GUILayout.FlexibleSpace();
            GUILayout.BeginVertical("box", GUILayout.Width(Screen.width));
            PlantSelect = GUILayout.SelectionGrid(PlantSelect, TexObjects, 6, "gridlist", GUILayout.Width(400), GUILayout.Height(70));

            GUILayout.BeginHorizontal();

            for (int i = 0; i < 6; i++)
            {
                if (GUILayout.Button("删除", GUILayout.Width(63)))
                {
                    plantsContainer.mSetting.Plants[i] = null;
                    plantsContainer.mSetting.PlantingSettings[i].Plant = null;
                }
            }

            GUILayout.EndHorizontal();

            GUILayout.EndVertical();
            //  GUILayout.FlexibleSpace();
            GUILayout.EndHorizontal();

            GUILayout.BeginHorizontal();
            //   GUILayout.FlexibleSpace();
            GUILayout.BeginVertical("box", GUILayout.Width(Screen.width-50));
            GUILayout.BeginHorizontal();
            GUILayout.Label("Setting", GUILayout.Width(145));
            GUILayout.EndHorizontal();
            plantsContainer.mSetting.BrushSize = (int)EditorGUILayout.Slider("笔刷大小", plantsContainer.mSetting.BrushSize, 1, 36);
            plantsContainer.mSetting.Density = (float)EditorGUILayout.Slider(new GUIContent("密度","一平米有几个"), plantsContainer.mSetting.Density, 0.01f, 10);
            var onePlants = plantsContainer.mSetting.PlantingSettings[PlantSelect];
            //---显示选中的数据
            GUILayout.BeginHorizontal();
            GUILayout.Label("Scale.x:", GUILayout.Width(50));
            onePlants.Scale.x = EditorGUILayout.FloatField(new GUIContent("", ""), onePlants.Scale.x, GUILayout.Width(100));

            GUILayout.Label(new GUIContent("随机大小范围+-", "以1为基本比例，比如0.2，则缩放大小为0.8-1.2"), GUILayout.Width(90));
            onePlants.ScaleRandom.x = EditorGUILayout.Slider(new GUIContent("", ""), onePlants.ScaleRandom.x, 0f, 1f);
            GUILayout.EndHorizontal();

            GUILayout.BeginHorizontal();
            GUILayout.Label("Scale.y:", GUILayout.Width(50));
            onePlants.Scale.y = EditorGUILayout.FloatField(new GUIContent("", ""), onePlants.Scale.y, GUILayout.Width(100));

            GUILayout.Label(new GUIContent("随机大小范围+-", "以1为基本比例，比如0.2，则缩放大小为0.8-1.2"), GUILayout.Width(90));
            onePlants.ScaleRandom.y = EditorGUILayout.Slider(new GUIContent("", ""), onePlants.ScaleRandom.y, 0f, 1f);
            GUILayout.EndHorizontal();

            GUILayout.BeginHorizontal();
            GUILayout.Label("Scale.z:", GUILayout.Width(50));
            onePlants.Scale.z = EditorGUILayout.FloatField(new GUIContent("", ""), onePlants.Scale.z, GUILayout.Width(100));

            GUILayout.Label(new GUIContent("随机大小范围+-", "以1为基本比例，比如0.2，则缩放大小为0.8-1.2"), GUILayout.Width(90));
            onePlants.ScaleRandom.z = EditorGUILayout.Slider(new GUIContent("", ""), onePlants.ScaleRandom.z, 0f, 1f);
           
            GUILayout.EndHorizontal();
            onePlants.Offset= EditorGUILayout.Vector3Field("位置偏移",onePlants.Offset);

            onePlants.SameRadius = EditorGUILayout.Slider(new GUIContent("同类半径", "植被半径---半径内不会有同类植被出现"), onePlants.SameRadius, 0, 2);
            onePlants.DiffRadius = EditorGUILayout.Slider(new GUIContent("异类半径", "植被半径---半径内不会异类植被出现"), onePlants.DiffRadius, 0,2);
            GUILayout.EndVertical();
            //  GUILayout.FlexibleSpace();
            GUILayout.EndHorizontal();

            GUILayout.BeginHorizontal();
            //  GUILayout.FlexibleSpace();
            GUILayout.BeginVertical(GUILayout.Width(347));


            GUILayout.BeginVertical("box", GUILayout.Width(Screen.width - 50));
            GUILayout.BeginHorizontal();
            if (GUILayout.Button("删除所有植被"))
            {
                allPlantsDictionary.Clear();
                SaveData();
            }
            if (GUILayout.Button("保存配置"))
            {
                plantsContainer.mSetting.SetDirty();
            }
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
        }

    }
    //Scene面板回调函数
    public  void OnSceneGUI()
    {
        if (!plantsContainer.mSetting.canEdit)
        {
            return;
        }
        DrawBrush();
        Event e = Event.current;
        var et = e.type;
        int id = GUIUtility.GetControlID(FocusType.Passive);
        et = e.GetTypeForControl(id);

        if ((et == EventType.MouseDown || et == EventType.MouseDrag || et == EventType.MouseUp) && e.button == 0)
        {
            HandleMouseEvent(e, et, id);
        }
    }

    #region Draw绘制

    private float mRecordTime;
    void HandleMouseEvent(Event e, EventType et, int id)
    {
        if (et == EventType.MouseDown)
        {
            mRecordTime = Time.realtimeSinceStartup;
            //开始画草
            var onePlants = plantsContainer.mSetting.PlantingSettings[PlantSelect];
            if (onePlants.Plant != null)
            {
                if (plantsContainer.mSetting.useEraser)
                {
                    UseEraser(onePlants, m_go.transform.position, plantsContainer.mSetting.Density, plantsContainer.mSetting.BrushSize);
                }
                else
                {
                    Planting(onePlants, m_go.transform.position, plantsContainer.mSetting.Density, plantsContainer.mSetting.BrushSize);
                }
                
            }
        }
        if (et == EventType.MouseDrag)
        {
            //--开始画草-间隔0.5秒一次
            var onePlants = plantsContainer.mSetting.PlantingSettings[PlantSelect];
            if (onePlants.Plant != null)
            {
                if (plantsContainer.mSetting.useEraser)
                {
                    UseEraser(onePlants, m_go.transform.position, plantsContainer.mSetting.Density, plantsContainer.mSetting.BrushSize);
                }
                else
                {
                    if (Time.realtimeSinceStartup - mRecordTime >= 0.2f)
                    {
                        mRecordTime = Time.realtimeSinceStartup;
                        Planting(onePlants, m_go.transform.position, plantsContainer.mSetting.Density, plantsContainer.mSetting.BrushSize);
                    }
                }
                
            }
        }

        if (et == EventType.MouseDown)
        {
            GUIUtility.hotControl = id;
        }
        else if (et == EventType.MouseUp)
        {
            if (GUIUtility.hotControl == id && e.button == 0)
                GUIUtility.hotControl = 0;
        }
        e.Use();
    }

    void Planting(OnePlantSetting plant, Vector3 pos, float density, float brushSize)
    {
        //--数据填充--圆形区域内随机分布
        float area = Mathf.PI * brushSize * brushSize;
        //---向上取整
        int count = Mathf.CeilToInt(area*density);
        count = count == 0 ? 1 : count;
        for (int i = 0; i < count; i++)
        {
            //float x= pos.x+ Random.Range(-brushSize, brushSize);
            //float z = pos.z+ Random.Range(-brushSize, brushSize);
            Vector2 randomPoint = Random.insideUnitCircle;
            float x = pos.x + randomPoint.x* brushSize;
            float z = pos.z + randomPoint.y * brushSize;
            //---//---检测是否可以种植，有没有接种的地方
            Vector3 tempPos = SetHeight(new Vector3(x, 0, z));
            
            if (tempPos.y>=1999.9)
            {
                continue;
            }
            //--
            if (CheckCanPlant(plant.Plant,new Vector3(x,0,z),plant.SameRadius))
            {
                //--可以种植了
                var tempPlant = new PlantsContainer.PlantInfo();
                tempPlant.Pos = tempPos+ plant.Offset;
                tempPlant.Rot = Quaternion.Euler(0, 0, 0);
                tempPlant.Scal.x = plant.Scale.x * (1 + Random.Range(-plant.ScaleRandom.x, plant.ScaleRandom.x));
                tempPlant.Scal.y = plant.Scale.y * (1 + Random.Range(-plant.ScaleRandom.y, plant.ScaleRandom.y));
                tempPlant.Scal.z = plant.Scale.z * (1 + Random.Range(-plant.ScaleRandom.z, plant.ScaleRandom.z));
                allPlantsDictionary[plant.Plant].Add(tempPlant);
            }
        }

        SaveData();
    }

    void UseEraser(OnePlantSetting plant, Vector3 pos, float density, float brushSize)
    {
        pos.y = 0;
        //---范围内的都消除
        if (plantsContainer.mSetting.isSingleEraser)
        {
            for (int i = allPlantsDictionary[plant.Plant].Count-1; i >=0 ; i--)
            {
                Vector3 savePos = allPlantsDictionary[plant.Plant][i].Pos;
                savePos.y = 0;
                if (Vector3.Distance(savePos, pos)< brushSize)
                {
                    allPlantsDictionary[plant.Plant].RemoveAt(i);
                }
            }
            
        }
        else
        {
            //记录需要删除的key
            List<GameObject> toBeRemoveGos=new List<GameObject>();
            //--删除所有植被
            foreach (var plantKey in allPlantsDictionary.Keys) 
            {
                for (int i = allPlantsDictionary[plantKey].Count - 1; i >= 0; i--)
                {
                    Vector3 savePos = allPlantsDictionary[plantKey][i].Pos;
                    savePos.y = 0;
                    if (Vector3.Distance(savePos, pos) < brushSize)
                    {
                        allPlantsDictionary[plantKey].RemoveAt(i);
                    }
                }

                if (allPlantsDictionary[plantKey].Count==0)
                {
                    toBeRemoveGos.Add(plantKey);
                }
            }

            for (int i = 0; i < toBeRemoveGos.Count; i++)
            {
                allPlantsDictionary.Remove(toBeRemoveGos[i]);
            }
        }
        SaveData();
    }

    /// <summary>
    /// 用于检测是否可以种植
    /// </summary>
    bool CheckCanPlant(GameObject go,Vector3 pos,float dis)
    {
        //--如果之前没有，直接种植即可
        if (!allPlantsDictionary.ContainsKey(go))
        {
            allPlantsDictionary.Add(go,new List<PlantInfo>());
            return true;
        }
        var plants = plantsContainer.PlantsList;
        //--一旦发现范围内有则返回不可以
        for (int j = 0; j < allPlantsDictionary[go].Count; j++)
        {
            Vector3 tempPos = allPlantsDictionary[go][j].Pos;
            tempPos.y = 0;
            //--距离检测
            if (Vector3.Distance(tempPos, pos) < dis)
            {
                return false;
            }
        }
        //---遍历所有
        return true;
    }

    void GetLocatPlantByGo(GameObject go)
    {
        var plants = plantsContainer.PlantsList;
        for (int i = 0; i < plants.Count; i++)
        {
            //--Ver.1制作同种判断，异类暂时不做
            if (plants[i].MPlant == go)
            {
               
            }
        }
    }

    private GameObject m_go;
    private CommandBuffer m_cmdDraw;
    void DrawBrush()
    {
        //使用射线取地面交点
        Event e = Event.current;
        RaycastHit raycastHit = new RaycastHit();
        Ray terrain = HandleUtility.GUIPointToWorldRay(e.mousePosition);
        if (Physics.Raycast(terrain, out raycastHit, 1000, plantsContainer.Mask))
        {
            if (m_go == null)
            {
                m_go = GameObject.CreatePrimitive(PrimitiveType.Cube);
                m_go.layer = LayerMask.NameToLayer("UI");
            }

            m_go.transform.localScale = Vector3.one*plantsContainer.mSetting.BrushSize*2;
            m_go.transform.position = raycastHit.point;
        }
    }

    Vector3 SetHeight(Vector3 pos)
    {
        RaycastHit raycastHit = new RaycastHit();
        pos.y = 2000;
        Ray terrain = new Ray(pos,Vector3.down);
        if (Physics.Raycast(terrain, out raycastHit, 2200, plantsContainer.Mask))
        {
             return raycastHit.point;
        }

        return pos;
    }

    #endregion


}