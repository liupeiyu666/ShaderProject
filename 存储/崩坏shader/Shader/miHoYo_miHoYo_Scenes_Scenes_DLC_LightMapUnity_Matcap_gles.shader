//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/LightMapUnity_Matcap" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[MHYHeaderBox(MATCAP)] [Toggle(MATCAP_ON)] _EnableMatcap ("Enable Matcap", Float) = 0
_MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
[Toggle(BUMPMAP_ON)] _EnableBumpMap ("Enable Bump Map", Float) = 0
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(MATCAP SPECULAR)] [Toggle(SPECULAR_ON)] _EnableMatcapSpecular ("Enable Matcap Specular", Float) = 0
_SpecularMap ("Specular MatCap", 2D) = "black" { }
_SpecularIntensity ("Specular Intensity", Range(0, 1)) = 0
_LightmapThreshold ("Lightmap Threshold", Range(0, 1)) = 0.5
_IntensityInLightmap ("Intensity In Lightmap", Range(0, 1)) = 0.1
[MHYHeaderBox(LIGHTMAP)] [Toggle(LIGHTMAPCOLOR_ON)] _EnableLightmapColor ("Enable LightmapColor Change", Float) = 0
_LightmapColorScale ("LightmapColorScale", Range(0, 4)) = 1.85
_LightmapColorIns ("LightmapColorIns", Range(0, 2)) = 0.9
_LightmapColorChange ("LightmapColorChange (RGB)", 2D) = "white" { }
_LightmapColorLerp ("LightmapColorLerp", Range(0, 1)) = 1
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 14106
Program "vp" {
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" "MATCAP_ON" "BUMPMAP_ON" "SPECULAR_ON" "LIGHTMAPCOLOR_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}