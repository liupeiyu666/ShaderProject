using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshCombine : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }
    Material _material;
    void Combine()
    {
        List<CombineInstance> combineInstances = new List<CombineInstance>();
        List<Material> materials = new List<Material>();
        List<Transform> bones = new List<Transform>();
        Transform[] transforms = GetComponentsInChildren<Transform>();
        List<Texture2D> textures = new List<Texture2D>();
        int width = 0;
        int height = 0;

        int uvCount = 0;

        List<Vector2[]> uvList = new List<Vector2[]>();

        //蒙皮模型
        foreach (SkinnedMeshRenderer smr in GetComponentsInChildren<SkinnedMeshRenderer>())
        {
            if (_material == null)
                _material = Instantiate(smr.sharedMaterial) as Material;

            for (int sub = 0; sub < smr.sharedMesh.subMeshCount; sub++)
            {
                CombineInstance ci = new CombineInstance();
                ci.mesh = smr.sharedMesh;
                ci.subMeshIndex = sub;
                ci.transform = smr.transform.localToWorldMatrix;
                combineInstances.Add(ci);
            }

            uvList.Add(smr.sharedMesh.uv);
            uvCount += smr.sharedMesh.uv.Length;

            if (smr.material.mainTexture != null)
            {
                //保存材质
                materials.AddRange(smr.GetComponent<Renderer>().materials);

                //保存贴图
                foreach (var mat in materials)
                {
                    textures.Add(mat.mainTexture as Texture2D);
                }
            }

            //保存骨骼信息
            foreach (Transform bone in smr.bones)
            {
                bones.Add(bone);
            }

            Destroy(smr.gameObject);
        }

        SkinnedMeshRenderer r = GetComponent<SkinnedMeshRenderer>();
        if (!r)
            r = gameObject.AddComponent<SkinnedMeshRenderer>();

        r.sharedMesh = new Mesh();

        //合并子网格
        r.sharedMesh.CombineMeshes(combineInstances.ToArray(), true, false);
        r.bones = bones.ToArray();
        r.material = _material;

        Texture2D skinnedMeshAtlas = new Texture2D(width, height);
        Rect[] packingResult = skinnedMeshAtlas.PackTextures(textures.ToArray(), 0);
        Vector2[] atlasUVs = new Vector2[uvCount];


        //合并材质，处理uv
        int j = 0;
        for (int i = 0; i < uvList.Count; i++)
        {
            foreach (Vector2 uv in uvList[i])
            {
                atlasUVs[j].x = Mathf.Lerp(packingResult[i].xMin, packingResult[i].xMax, uv.x);
                atlasUVs[j].y = Mathf.Lerp(packingResult[i].yMin, packingResult[i].yMax, uv.y);
                j++;
            }
        }

        r.material.mainTexture = skinnedMeshAtlas;
        r.sharedMesh.uv = atlasUVs;
    }
}
