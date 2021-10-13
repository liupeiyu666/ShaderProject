//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Misc/Misc_AnisSpecular" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_MainRadian ("Main Specular Radian", Range(-2, 2)) = 0
_SecRadian ("Secondary Specular Radian", Range(-2, 2)) = 0
_XMMove ("X Move Scale of Main", Range(0, 10)) = 1
_XSMove ("X Move Scale of Second", Range(0, 10)) = 1
_YMMove ("Y Move Scale of Main", Range(0, 10)) = 1
_YSMove ("Y Move Scale of Second", Range(0, 10)) = 1
_MIntense ("Intensity of Main", Range(0, 1)) = 1
_SIntense ("Intensity of Second", Range(0, 1)) = 0.3
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 22186
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
}