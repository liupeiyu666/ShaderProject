//using UnityEditor;
//using UnityEngine;
//[CustomEditor(typeof(ShadowMapTest))]
//public class ShadowMapTestEditor : Editor
//{
//    ShadowMapTest ShadowMapTest;
//    // Start is called before the first frame update
//    public override void OnInspectorGUI()
//    {
//        ShadowMapTest = target as ShadowMapTest;
//        if (GUILayout.Button("555"))
//        {
//            Undo.RecordObject(ShadowMapTest, "TTT");
//           // ShadowMapTest.AAA = 555;
//           // ShadowMapTest.A.Add(1);
//           // ShadowMapTest.TestData.A.Add(2);
//        }
//       // EditorGUILayout.LabelField("显示数据:" + ShadowMapTest.AAA);
//        serializedObject.ApplyModifiedProperties();
//        base.OnInspectorGUI();
//    }
//}


////SerializedProperty AAA;
////ShadowMapTest ShadowMapTest;
////SerializedProperty TestList;
////// Start is called before the first frame update
////public override void OnInspectorGUI()
////{
////    // AAA = serializedObject.FindProperty("AAA");
////    // TestList = serializedObject.FindProperty("TestData");
////    // TestList = TestList.FindPropertyRelative("A");
////    ShadowMapTest = target as ShadowMapTest;
////    if (GUILayout.Button("555"))
////    {
////        Undo.RecordObject(ShadowMapTest, "TTT");
////        // AAA.intValue = 555;
////        ShadowMapTest.AAA = 555;
////        // ShadowMapTest.TestData.A.Add(1);
////        // ShadowMapTest.TestData.A.Add(2);
////        //EditorUtility.SetDirty(ShadowMapTest);
////        // serializedObject.SetIsDifferentCacheDirty();

////        //serializedObject.UpdateIfRequiredOrScript();
////        //serializedObject.UpdateIfRequiredOrScript();
////        //var erator= TestList.GetEnumerator();
////        //while (erator.MoveNext())
////        //{

////        //}
////        //TestList.InsertArrayElementAtIndex(0);
////    }
////    if (GUILayout.Button("666"))
////    {
////        // AAA.intValue = 666;
////        ShadowMapTest.AAA = 666;
////    }
////    EditorGUILayout.LabelField("显示数据:" + ShadowMapTest.AAA);
////    serializedObject.ApplyModifiedProperties();
////    // base.OnInspectorGUI();
////}