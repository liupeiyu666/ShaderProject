//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/BlendFrames" {
Properties {
_MainTex ("Before Texture", 2D) = "white" { }
_AfterTex ("After Texture", 2D) = "white" { }
_t ("t", Float) = 0.5
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 48292
Program "vp" {
}
Program "fp" {
}
}
}
}