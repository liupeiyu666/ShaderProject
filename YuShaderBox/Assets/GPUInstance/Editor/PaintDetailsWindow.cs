using UnityEditor;
using UnityEngine;
public class PaintDetailsWindow : EditorWindow
{
    public static PaintDetailsWindow MPaintDetailsWindow;
    public int brushSize;
    public float scaleRandom;
    public int density;
    public GameObject AddObject;

    public GameObject[] Plants = new GameObject[6];//TexObjects
    public Texture[] TexObjects = new Texture[6];//TexObjects

    public int PlantSelect;
    //打开窗口
    [MenuItem("Window/Paint Details %g")]
    static void Open()
    {
        var window = (PaintDetailsWindow)EditorWindow.GetWindow(typeof(PaintDetailsWindow),  false, "Paint Detail");
        window.Show();
        MPaintDetailsWindow = window;
    }

    private void OnDisable()
    {
        MPaintDetailsWindow = null;
    }
    void OnInspectorUpdate()
    {
        Repaint();
    }

    void OnGUI()
    {
       // CurrentSelect = Selection.activeTransform;

        GUILayout.Space(20);

        GUILayout.BeginHorizontal();
       // GUILayout.FlexibleSpace();
       // GUILayout.BeginVertical("box", GUILayout.Width(347));
        GUILayout.BeginVertical("box", GUILayout.Width(Screen.width));
        GUILayout.BeginHorizontal();
       // GUILayout.Label("Add Assets", GUILayout.Width(125));
        GUILayout.Label("Add Assets", GUILayout.Width(125));
        AddObject = (GameObject)EditorGUILayout.ObjectField("", AddObject, typeof(GameObject), true, GUILayout.Width(160));
        if (GUILayout.Button("+", GUILayout.Width(40)))
        {
            for (int i = 0; i < 6; i++)
            {
                if (Plants[i] == null)
                {
                    Plants[i] = AddObject;
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
            if (Plants[i] != null)
                TexObjects[i] = AssetPreview.GetAssetPreview(Plants[i]) as Texture;
            else TexObjects[i] = null;
        }

        GUILayout.BeginHorizontal();
       // GUILayout.FlexibleSpace();
        GUILayout.BeginVertical("box", GUILayout.Width(Screen.width));
        PlantSelect = GUILayout.SelectionGrid(PlantSelect, TexObjects, 6, "gridlist", GUILayout.Width(400), GUILayout.Height(70));

        GUILayout.BeginHorizontal();

        for (int i = 0; i < 6; i++)
        {
            if (GUILayout.Button("—", GUILayout.Width(63)))
            {
                Plants[i] = null;
            }
        }

        GUILayout.EndHorizontal();

        GUILayout.EndVertical();
      //  GUILayout.FlexibleSpace();
        GUILayout.EndHorizontal();

        GUILayout.BeginHorizontal();
     //   GUILayout.FlexibleSpace();
        GUILayout.BeginVertical("box", GUILayout.Width(347));
        GUILayout.BeginHorizontal();
        GUILayout.Label("Setting", GUILayout.Width(145));
        GUILayout.EndHorizontal();
        brushSize = (int)EditorGUILayout.Slider("Brush Size", brushSize, 1, 36);
        scaleRandom = EditorGUILayout.Slider("Scale Random(+/-)", scaleRandom, 0.05f, 1f);
        density = (int)EditorGUILayout.Slider("Density", density, 1, 10);
        GUILayout.EndVertical();
      //  GUILayout.FlexibleSpace();
        GUILayout.EndHorizontal();

        GUILayout.BeginHorizontal();
      //  GUILayout.FlexibleSpace();
        GUILayout.BeginVertical(GUILayout.Width(347));

        //string btnText = IsHome ? "二级地图" : "领地地图";
        //if (GUILayout.Button(btnText))
        //{
        //    IsHome = btnText.Equals("领地地图");
        //    Editor = !IsHome;
        //}
    }
}
