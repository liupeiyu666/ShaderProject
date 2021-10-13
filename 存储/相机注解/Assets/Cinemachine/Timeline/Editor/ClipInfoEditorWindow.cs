using System.Collections.Generic;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;
public class ClipInfoEditorWindow : EditorWindow
{
    [MenuItem("Window/显示Clip信息")]
    static void Init()
    {
        //--打开窗口
        ClipInfoEditorWindow window = (ClipInfoEditorWindow)EditorWindow.GetWindow(typeof(ClipInfoEditorWindow));
        window.Show();
    }
    private AnimationClip clip;
    ReorderableList reorderableList;//列表显示
    Vector2 scrollPos;//滚动窗口需要
    private void OnGUI()
    {
        var originClip = clip;
        clip =(AnimationClip)EditorGUILayout.ObjectField("动画片段:", clip,typeof(AnimationClip));
        if (clip != null)
        {
            GUILayout.Label("RootCurves:"+clip.hasRootCurves + "   MotionCurves:" + clip.hasMotionCurves + "    GenericRootTransform:" + clip.hasGenericRootTransform+ "     isHumanMotion:" + clip.isHumanMotion+ "    humanMotion:" + clip.humanMotion);
        }
        if (clip!=null&&originClip!=clip)
        {
           
            //--获取animationclip的binding信息
            EditorCurveBinding[] curveBindings = AnimationUtility.GetCurveBindings(clip);
            List<AnimationClipCurveData> listData = new List<AnimationClipCurveData>();
            for (int i = 0; i < curveBindings.Length; i++)
            {
                //AnimationCurve curve = AnimationUtility.GetEditorCurve(clip, curveBindings[i]);
                listData.Add(new AnimationClipCurveData(curveBindings[i]));
            }
            
            reorderableList = new ReorderableList(listData,typeof(AnimationClipCurveData),true,true,false,false);
            reorderableList.elementHeight = 20;
            reorderableList.drawElementCallback =
                (rect, index, isActive, isFocused) =>
                {
                    var element = listData[index];
                    //rect.height -= 4;
                    //rect.y += 2;
                    if (index == reorderableList.index)
                    {
                        GUI.backgroundColor = Color.red;
                    }
                    else
                    {
                        GUI.backgroundColor = Color.yellow;
                    }                   
                    EditorGUI.HelpBox(rect,"",MessageType.None);
                    EditorGUI.LabelField(rect,"路径信息:"+element.path + "  属性名称:" + element.propertyName + "  属性类型:" + element.type);
                    GUI.backgroundColor = Color.white;

                };

            var defaultColor = GUI.backgroundColor;
            reorderableList.drawElementBackgroundCallback = (rect, index, isActive, isFocused) =>
            {
                GUI.backgroundColor = Color.red;
            };
            reorderableList.drawHeaderCallback = (rect) =>
                EditorGUI.LabelField(rect, "片段信息");
        }
        if (reorderableList!=null)
        {
            scrollPos =
           EditorGUILayout.BeginScrollView(scrollPos,GUILayout.Width(position.width-10), GUILayout.Height(position.height - 50));
            reorderableList.DoLayoutList();
            EditorGUILayout.EndScrollView();
        }
    }
}
