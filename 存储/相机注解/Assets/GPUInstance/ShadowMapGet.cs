using UnityEngine;
using UnityEngine.Rendering;
[ExecuteInEditMode]
public class ShadowMapGet : MonoBehaviour
{
    public Light m_Light;
    public RenderTexture m_ShadowmapCopy;
    void Start()
    {
        Debug.LogError(Vector3.Cross(Vector3.up,Vector3.right));
        if (m_Light == null)
        {
            m_Light = GetComponent<Light>();
        }
        if (m_Light == null)
        {
            return;
        }
        RenderTargetIdentifier shadowmap = BuiltinRenderTextureType.CurrentActive;
        m_ShadowmapCopy = new RenderTexture(1024, 1024, 0);
        CommandBuffer cb = new CommandBuffer();
        cb.SetShadowSamplingMode(shadowmap, ShadowSamplingMode.RawDepth);
        cb.Blit(shadowmap, new RenderTargetIdentifier(m_ShadowmapCopy));
        Shader.SetGlobalTexture("_CustomShadowMap", m_ShadowmapCopy);
        m_Light.AddCommandBuffer(LightEvent.AfterShadowMap, cb);
    }
}