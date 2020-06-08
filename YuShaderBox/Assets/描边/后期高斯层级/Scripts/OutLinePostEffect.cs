/// <summary>
/// 后期描边--需要描边的物体添加OutLineBind脚本
/// </summary>
using UnityEngine;
using System.Collections.Generic;
namespace Effect.YuPost
{
    public class OutLinePostEffect : PostEffectsBase
    {
        public RenderTexture TestRender;

        public static OutLinePostEffect instance;
        public Shader drawOccupied;
        private Material occupiedMaterial = null;
        public Material OccupiedMaterial { get { return CheckShaderAndCreateMaterial(drawOccupied, ref occupiedMaterial); } }

        public Color outlineColor = Color.green;
        [Range(0, 10)]
        public int outlineWidth = 4;
        [Range(0, 9)]
        public int iterations = 1;
        [Range(0, 1)]
        public float gradient = 1;

        // public Dictionary<GameObject, Dictionary<Transform, List<Mesh>>> targetsDic = new Dictionary<GameObject, Dictionary<Transform, List<Mesh>>>();

        public Dictionary<GameObject, Dictionary<Transform,int>> targetsDic = new Dictionary<GameObject, Dictionary<Transform, int>>();

        private MeshFilter[] meshFilters;
        private RenderTexture tempRT;
        private Camera additionalCamera;

        private void Awake()
        {
            instance = this;
            SetupAddtionalCamera();
        }
        public LayerMask layerMask;

        private void SetupAddtionalCamera()
        {
            if (additionalCamera == null)
            {
                GameObject go = new GameObject("Camera");
                go.transform.SetParent(transform, false);
                additionalCamera = go.AddComponent<Camera>();               
            }
            additionalCamera.CopyFrom(MainCamera);
            additionalCamera.clearFlags = CameraClearFlags.Color;
            additionalCamera.backgroundColor = Color.black;
            additionalCamera.cullingMask = layerMask;   //    // 标记渲染"PostEffect"层的物体
            additionalCamera.enabled = false;
        }
        void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            if (TargetMaterial != null && drawOccupied != null && additionalCamera != null && targetsDic.Count != 0)
            {
                SetupAddtionalCamera();
                tempRT = RenderTexture.GetTemporary(source.width , source.height , 0);
                additionalCamera.targetTexture = tempRT;
                //---这种方法对于蒙皮动画无效，但是效率较高
                //foreach (var item in targetsDic.Values)
                //{
                //    foreach (var meshInfo in item)
                //    {
                //        for (int i = 0; i < meshInfo.Value.Count; i++)
                //        {
                //            for (int k = 0; k < meshInfo.Value[i].subMeshCount; k++)
                //            {
                //                Graphics.DrawMesh(meshInfo.Value[i], meshInfo.Key.localToWorldMatrix,
                //           OccupiedMaterial, GetLayer(layerMask), additionalCamera, k); // 描绘选中物体的所占面积
                //            }
                           
                //        }
                //    }                 
                //}

                //设置层级
                foreach (var item in targetsDic.Values)
                {
                    foreach (var transInfo in item)
                    {
                        transInfo.Key.gameObject.layer = GetLayer(layerMask);
                        
                    }
                }
                additionalCamera.SetReplacementShader(drawOccupied, "");
                additionalCamera.Render();  // 需要调用渲染函数，才能及时把描绘物体渲染到纹理中
                foreach (var item in targetsDic.Values)
                {
                    foreach (var transInfo in item)
                    {
                        transInfo.Key.gameObject.layer = transInfo.Value ;
                    }
                }


                TargetMaterial.SetTexture("_SceneTex", source);
                TargetMaterial.SetColor("_Color", outlineColor);
                TargetMaterial.SetInt("_Width", outlineWidth);
                TargetMaterial.SetInt("_Iterations", iterations);
                TargetMaterial.SetFloat("_Gradient", gradient);
                Graphics.Blit(tempRT, TestRender);
                // 使用描边混合材质实现描边效果 
                Graphics.Blit(tempRT, destination, TargetMaterial);
                additionalCamera.targetTexture = null;
                RenderTexture.ReleaseTemporary(tempRT);
                

            }
            else
                Graphics.Blit(source, destination);
        }
        int GetLayer(LayerMask mask)
        {
            for (int i = 0; i < 32; i++)
            {
                if ((1 << i & mask.value) != 0)
                {
                    return i;
                }
            }
            return 0;
        }
        #region 层级设置
        public void AddGameObject(GameObject go)
        {
            if (!targetsDic.ContainsKey(go))
            {
                Dictionary<Transform,int> tempDic = new Dictionary<Transform, int>();
                targetsDic.Add(go, tempDic);
                MeshFilter[] meshFilters = go.GetComponentsInChildren<MeshFilter>();
                SkinnedMeshRenderer[] skinnedMeshRenderers = go.GetComponentsInChildren<SkinnedMeshRenderer>();
                for (int i = 0; i < meshFilters.Length; i++)
                {
                    if (!tempDic.ContainsKey(meshFilters[i].transform))
                    {
                        tempDic.Add(meshFilters[i].transform, meshFilters[i].gameObject.layer);
                    }
                }
                for (int i = 0; i < skinnedMeshRenderers.Length; i++)
                {
                    if (!tempDic.ContainsKey(skinnedMeshRenderers[i].transform))
                    {
                        tempDic.Add(skinnedMeshRenderers[i].transform, skinnedMeshRenderers[i].gameObject.layer);
                    }
                }
            }
        }
        public void RemoveGameObject(GameObject go)
        {
            if (targetsDic.ContainsKey(go))
            {
                targetsDic.Remove(go);
            }
            Debug.LogError("=========:"+ targetsDic.Count);
        }
        #endregion
        //#region 对外方法--初版--Mesh记录，高效
        //public void AddGameObject(GameObject go)
        //{
        //    if (!targetsDic.ContainsKey(go))
        //    {
        //        Dictionary<Transform, List<Mesh>> tempDic = new Dictionary<Transform, List<Mesh>>();
        //        targetsDic.Add(go, tempDic);
        //        List<Mesh> meshes = new List<Mesh>();
                
        //        MeshFilter[] meshFilters = go.GetComponentsInChildren<MeshFilter>();
        //        SkinnedMeshRenderer[] skinnedMeshRenderers = go.GetComponentsInChildren<SkinnedMeshRenderer>();
        //        for (int i = 0; i < meshFilters.Length; i++)
        //        {
        //            meshes.Add(meshFilters[i].sharedMesh);
        //            if (!tempDic.ContainsKey(meshFilters[i].transform))
        //            {
        //                tempDic.Add(meshFilters[i].transform,meshes);
        //            }
        //        }
        //        for (int i = 0; i < skinnedMeshRenderers.Length; i++)
        //        {
        //            meshes.Add(skinnedMeshRenderers[i].sharedMesh);
        //            if (!tempDic.ContainsKey(skinnedMeshRenderers[i].transform))
        //            {
        //                tempDic.Add(skinnedMeshRenderers[i].transform, meshes);
        //            }
        //        }
        //    }
        //}
        //public void RemoveGameObject(GameObject go)
        //{
        //    if (targetsDic.ContainsKey(go))
        //    {
        //        targetsDic.Remove(go);
        //    }
        //}
        //#endregion
    }
}