//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Cloud2D" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_TileSize ("Tile Size", Vector) = (1,1,0,1)
_EmitterWidth ("Emitter Width", Float) = 1
_AspectRatio ("Aspect Ratio", Float) = 1
_BrightColor ("Bright Color", Color) = (1,1,1,1)
_DarkColor ("Dark Color", Color) = (1,1,1,1)
_SecondDarkColor ("Second Dark Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_FlashColor ("Flash Color", Color) = (1,1,1,1)
_FlashAttenFactors ("Flash Attenuation Factors", Vector) = (1,0,0,0)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 32692
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
}
}
}
}