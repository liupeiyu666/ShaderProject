using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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

    Matrix4x4[] grassMaterix4X4;
    Vector4[] positions;

    Vector3 selfPosition;
    private float maxHeight = 0f;

    //private int curGrassCount=0, curFlowerCount=0;

    void Start()
    {
        Draw();
    }
    public void Draw()
    {

        if (grassGO == null)
        {
            int childCount = grassContainer.childCount;
            int randomIndex = Random.Range(0, childCount);
            grassGO = grassContainer.GetChild(randomIndex).gameObject;
        }
        grassMesh = grassGO.GetComponent<MeshFilter>().mesh;
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
        grassBounds = new Bounds(new Vector3(selfPosition.x, maxHeight / 2, selfPosition.z), new Vector3(xRange * 2, maxHeight / 2, zRange * 2));
    }
    void Update()
    {
        Graphics.DrawMeshInstanced(grassMesh, 0, grassMaterial, grassMaterix4X4, grassMaterix4X4.Length);
    }
    // void OnDrawGizmos(){
    //     Gizmos.DrawCube(grassBounds.center,grassBounds.size);
    // }

    void SetupGrassBuffers()
    {
        if (grassCount < 1) grassCount = 1;
        List<Matrix4x4> matrixList = new List<Matrix4x4>();

        for (int i = 0; i < grassCount; i++)
        {

            float x = Random.Range(-xRange, xRange) + selfPosition.x;
            float z = Random.Range(-zRange, zRange) + selfPosition.z;
            float y = drawGrassHeight;//selfPosition.y;

            Vector3 randomPos = new Vector4(x, 0, z, 1f);
            if (GetGround(ref randomPos)||true)
            {
                matrixList.Add(Matrix4x4.TRS(randomPos, Quaternion.Euler(0F, 0, 0F), new Vector3(1, 1, 1)));
            }
        }
        grassMaterix4X4 = matrixList.ToArray();
    }


    RaycastHit[] hitArr = new RaycastHit[3];
    bool GetGround(ref Vector3 p)
    {
        Ray ray = new Ray(p, Vector3.down);
        int hitCount = Physics.RaycastNonAlloc(ray, hitArr, drawGrassHeight);
        if (hitCount > 0)
        {
            hitCount = Mathf.Min(hitCount, hitArr.Length);
            float maxHight = float.MinValue;
            int index = -1;
            for (int i = 0; i < hitCount; ++i)
            {
                RaycastHit hit = hitArr[i];

                if (hit.point.y > maxHight)
                {
                    maxHight = hit.point.y;
                    index = i;
                }
            }
            if (index >= 0)
            {
                RaycastHit closeHit = hitArr[index];

                if (closeHit.collider.CompareTag("Terrain") || closeHit.collider.CompareTag("SkyGround"))
                {
                    //如果命中地面,则使用命中后的位置.
                    p = closeHit.point;
                    if (p.y >= limitHeight)
                    {
                        return false;
                    }
                    return true;
                }
            }

        }
        return false;
    }
}
