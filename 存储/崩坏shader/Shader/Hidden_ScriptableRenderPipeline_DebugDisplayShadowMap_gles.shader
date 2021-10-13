//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/ScriptableRenderPipeline/DebugDisplayShadowMap" {
Properties {
}
SubShader {
 Pass {
  Name "REGULARSHADOW"
  ZTest Off
  Cull Off
  GpuProgramID 48976
}
 Pass {
  Name "VARIANCESHADOW"
  ZTest Off
  Cull Off
  GpuProgramID 68690
}
}
}