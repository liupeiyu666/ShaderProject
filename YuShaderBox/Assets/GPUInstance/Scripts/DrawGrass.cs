using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
public class DrawGrass : MonoBehaviour
{

    public int grassCount = 100;

    private Mesh grassMesh;
    private Material grassMaterial;

    public Transform grassContainer;

    private GameObject grassGO = null;
    private GameObject flowerGo = null;

    public float xRange = 100f;
    public float zRange = 100f;

    public float minHightScale = 0.8f;
    public float maxHightScale = 1.5f;

    public float drawGrassHeight = 20f;

    public float limitHeight = 29f;

    public Bounds grassBounds;

    List<Matrix4x4[]> grassMaterix4X4s=new List<Matrix4x4[]>();
    Vector4[] positions;

    Vector3 selfPosition;
    private float maxHeight = 0f;

    //private int curGrassCount=0, curFlowerCount=0;

    void Start()
    {
        Draw();
    }

    void OnEnable()
    {
        Draw();
    }

    void OnDisable()
    {
        grassGO = null;
        grassMaterix4X4s.Clear();
    }

    public void Draw()
    {

        if (grassGO == null)
        {
            int childCount = grassContainer.childCount;
            int randomIndex = Random.Range(0, childCount);
            grassGO = grassContainer.GetChild(randomIndex).gameObject;
        }
        grassMesh = grassGO.GetComponent<MeshFilter>().sharedMesh;
        grassMaterial = grassGO.GetComponent<MeshRenderer>().sharedMaterial;
        if (grassMesh == null || grassMaterial == null)
        {
            Debug.LogError("mesh or material is null");
            return;
        }

        selfPosition = transform.position;
        maxHeight = 0;
        SetupGrassBuffers();
        maxHeight += 1.5f;
      //  grassBounds = new Bounds(new Vector3(selfPosition.x, maxHeight / 2, selfPosition.z), new Vector3(xRange * 2, maxHeight / 2, zRange * 2));
    }
    void Update()
    {
      //  Debug.LogError(grassMaterix4X4.Length);
        for (int i = 0; i < grassMaterix4X4s.Count; i++)
        {
            Graphics.DrawMeshInstanced(grassMesh, 0, grassMaterial, grassMaterix4X4s[i], grassMaterix4X4s[i].Length);
        }
       
    }
    void SetupGrassBuffers()
    {
        if (grassCount < 1) grassCount = 1;
        List<Matrix4x4> matrixList = new List<Matrix4x4>();

        int counts = grassCount / 1020;
        int left= grassCount % 1020;
        counts = left == 0 ? counts : counts + 1;
        for (int i = 0; i < counts; i++)
        {
            matrixList.Clear();
            //--有余数的时候，需要在最后一次添加的数量为余数的数量
            if (left!=0&& i== counts-1)
            {
                for (int j = 0; j < left; j++)
                {
                    float x = Random.Range(-xRange, xRange);
                    float z = Random.Range(-zRange, zRange);
                    float y = drawGrassHeight;//selfPosition.y;
                    Vector3 randomPos = new Vector4(x, 0, z);
                    matrixList.Add(Matrix4x4.TRS(randomPos, grassGO.transform.rotation, grassGO.transform.lossyScale));
                }
            }
            else
            {
                for (int j = 0; j < 1020; j++)
                {
                    float x = Random.Range(-xRange, xRange);
                    float z = Random.Range(-zRange, zRange);
                    float y = drawGrassHeight;//selfPosition.y;
                    Vector3 randomPos = new Vector4(x, 0, z);
                    matrixList.Add(Matrix4x4.TRS(randomPos, grassGO.transform.rotation, grassGO.transform.lossyScale));
                }
            }
            var grassMaterix4X4 = matrixList.ToArray();
            grassMaterix4X4s.Add(grassMaterix4X4);
            // matrixList.Add(Matrix4x4.TRS(randomPos, Quaternion.Euler(0F, 0, 0F), new Vector3(1, 1, 1)));
        }
       
    }

}
