using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[Serializable]
public class PlantsSetting : ScriptableObject
{
    public PlantsSetting()
    {
        PlantingSettings = new OnePlantSetting[6];
        Plants = new GameObject[6];
        for (int i = 0; i < PlantingSettings.Length; i++)
        {
            PlantingSettings[i]=new OnePlantSetting();
        }
    }

    /// <summary>
    /// 存储每一个植被的设置信息
    /// </summary>
    [SerializeField]
    public OnePlantSetting[] PlantingSettings = new OnePlantSetting[6];

    /// <summary>
    /// 存储当前保存的植被信息
    /// </summary>
    public GameObject[] Plants = new GameObject[6];

    public float BrushSize;

    public float Density;

    public bool canEdit = false;
    /// <summary>
    /// 是否为添加
    /// </summary>
    public bool useEraser = false;
    /// <summary>
    /// 是否单个植被进行擦除
    /// </summary>
    public bool isSingleEraser = true;
}
[Serializable]
public class OnePlantSetting
{
    // 植被
    public GameObject Plant;
    // 同类植被的半径
    public float SameRadius;
    //异类植被的半径
    public float DiffRadius;

    public Vector3 ScaleRandom;

    public Vector3 Scale;

    public Vector3 Offset;
}