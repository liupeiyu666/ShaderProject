using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(PlantsSetting))]
public class PlantsSettingEditor:Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        EditorUtility.SetDirty(target);
        serializedObject.ApplyModifiedProperties();
    }
}
