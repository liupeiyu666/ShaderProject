//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_DLC/Avatar Transparent Back Then Front" {
Properties {
[MHYHelpBox(Info, Vertex Color B (outline width))] [MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnits ("Polygon Offset Units", Float) = 0
_OutlinePolygonOffsetFactor ("Outline Polygon Offset Factor", Float) = 0
_OutlinePolygonOffsetUnits ("Outline Polygon Offset Units", Float) = 0
[MHYHeaderBox(MAPS)] [MHYHeader(Main Maps)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
[MHYSingleLineTextureNoScaleOffset] _LightMap ("Light Map |R (sepcular intensity) G (diffuse threshold) B (specular threshold) A (material id)", 2D) = "grey" { }
[MHYSingleLineTextureNoScaleOffset] _MaskMap ("Mask Map |R (curvature) G (metal mask)", 2D) = "grey" { }
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYHeaderBox(LIGHTING)] [Toggle(_MULTI_BLOOM_ON)] _EnableMultipleBloom ("Enable Multiple Bloom", Float) = 0
[MHYKeywordFilter(_MULTI_BLOOM_ON Off)] _BloomIntensity ("Bloom Intensity", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity0 ("Bloom Intensity 0 (ID = 0)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity1 ("Bloom Intensity 1 (ID = 31)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity2 ("Bloom Intensity 2 (ID = 63)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity3 ("Bloom Intensity 3 (ID = 95)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity4 ("Bloom Intensity 4 (ID = 127)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity5 ("Bloom Intensity 5 (ID = 159)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity6 ("Bloom Intensity 6 (ID = 192)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity7 ("Bloom Intensity 7 (ID = 223)", Float) = 1
[MHYHeaderBox(DIFFUSE)] [Toggle(_MULTI_DIFFUSE_ON)] _EnableMultipleDiffuse ("Enable Multiple Diffuse", Float) = 0
[MHYColorGradient(_MULTI_DIFFUSE_ON On)] _DiffuseRampMuitiTex ("Diffuse Multiple Ramp", 2D) = "white" { }
[MHYColorGradient(_MULTI_DIFFUSE_ON Off)] _DiffuseRampTex ("Diffuse Ramp", 2D) = "white" { }
_DiffuseRanges ("Diffuse Ranges", Vector) = (0.4,0.6,0,0)
_ShadowThreshold ("Shadow Threshold", Range(0, 1)) = 0.5
[MHYHeaderBox(SPECULAR)] [Toggle(_MULTI_SPECULAR_ON)] _EnableMultipleSpecular ("Enable Multiple Specular", Float) = 0
[MHYKeywordFilter(_MULTI_SPECULAR_ON Off)] _SpecularColor ("Specular Color", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor0 ("Specular Color (ID = 0)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor1 ("Specular Color (ID = 31)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor2 ("Specular Color (ID = 63)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor3 ("Specular Color (ID = 95)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor4 ("Specular Color (ID = 127)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor5 ("Specular Color (ID = 159)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor6 ("Specular Color (ID = 192)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor7 ("Specular Color (ID = 223)", Color) = (1,1,1,1)
_SpecularShininess ("Specular Shininess", Range(0.1, 500)) = 10
_SpecularIntensity ("Specular Intensity", Range(0, 50)) = 1
[MHYHeaderBox(OUTLINE)] [Toggle(_MULTI_OUTLINE_ON)] _EnableMultipleOutline ("Enable Multiple Outline", Float) = 0
[MHYKeywordFilter(_MULTI_OUTLINE_ON Off)] _OutlineColor ("Outline Color", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor0 ("Outline Color 0 (ID = 0)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor1 ("Outline Color 1 (ID = 31)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor2 ("Outline Color 2 (ID = 63)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor3 ("Outline Color 3 (ID = 95)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor4 ("Outline Color 4 (ID = 127)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor5 ("Outline Color 5 (ID = 159)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor6 ("Outline Color 6 (ID = 192)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor7 ("Outline Color 7 (ID = 223)", Color) = (0,0,0,1)
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.1
_Scale ("Scale Compared to Maya", Float) = 0.01
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 0.2
[KeywordEnum(Normal, Tangent, UV2)] _OutlineNormalFrom ("Outline Normal From", Float) = 0
[MHYHeaderBox(RIMLIGHT)] [Toggle(_MULTI_RIMLIGHT_ON)] _EnableMultipleRim ("Enable Multiple Rim", Float) = 0
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON Off)] _RimColor ("RimColor(alpha for range)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor0 ("RimColor 0 (ID = 0)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor1 ("RimColor 1 (ID = 31)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor2 ("RimColor 2 (ID = 63)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor3 ("RimColor 3 (ID = 95)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor4 ("RimColor 4 (ID = 127)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor5 ("RimColor 5 (ID = 159)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor6 ("RimColor 6 (ID = 192)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_RIMLIGHT_ON On)] _RimColor7 ("RimColor 7 (ID = 223)", Color) = (1,1,1,1)
_RimPower ("RimPower", Range(0, 3)) = 0
_RimEdge ("RimEdge", Range(-1, 1)) = 0
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
[MHYKeywordFilter(RIM_GLOW On)] _RGColor ("Rim Glow Color", Color) = (1,1,1,1)
[MHYKeywordFilter(RIM_GLOW On)] _RGShininess ("Rim Glow Shininess", Float) = 1
[MHYKeywordFilter(RIM_GLOW On)] _RGScale ("Rim Glow Scale", Float) = 1
[MHYKeywordFilter(RIM_GLOW On)] _RGBias ("Rim Glow Bias", Float) = 0
[MHYKeywordFilter(RIM_GLOW On)] _RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
[MHYKeywordFilter(RIM_GLOW On)] _RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[MHYHeaderBox(SPECIAL STATE)] [Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
[MHYKeywordFilter(SPECIAL_STATE On)] _SPTex ("SP Tex", 2D) = "white" { }
[MHYKeywordFilter(SPECIAL_STATE On)] _SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
[MHYKeywordFilter(SPECIAL_STATE On)] _SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
[MHYKeywordFilter(SPECIAL_STATE On)] _SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
[MHYKeywordFilter(SPECIAL_STATE On)] _SPTransition ("SP Transition", Range(0, 1)) = 0
[MHYKeywordFilter(SPECIAL_STATE On)] _SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
[MHYKeywordFilter(SPECIAL_STATE On)] _SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
[MHYKeywordFilter(SPECIAL_STATE On)] _SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
[MHYKeywordFilter(SPECIAL_STATE On)] _SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
[MHYKeywordFilter(SPECIAL_STATE On)] _SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
[MHYKeywordFilter(SPECIAL_STATE On)] _SPCubeMap ("SP CubeMap", Cube) = "white" { }
[MHYKeywordFilter(SPECIAL_STATE On)] _SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
[MHYKeywordFilter(SPECIAL_STATE On)] _SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
[MHYKeywordFilter(SPECIAL_STATE On)] _SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
[MHYKeywordFilter(SPECIAL_STATE On)] _SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
[MHYKeywordFilter(SPECIAL_STATE On)] _SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
[MHYKeywordFilter(SPECIAL_STATE On)] _SPOldColor ("SP Old Color", Color) = (1,1,1,0)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
[MHYHeaderBox(DITHER)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 600
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "TRANSPARENTBACKFACE"
  LOD 600
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 47867
Program "vp" {
}
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
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
}
}
 Pass {
  Name "FORWARDONLY"
  LOD 600
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 121854
Program "vp" {
}
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
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Character/Shared/TRANSPARENTALPHA"
 UsePass "Hidden/miHoYo/DLC/Character/Shared/TRANSPARENTBACKTHENFRONTOUTLINE"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "TRANSPARENTBACKFACE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 149502
Program "vp" {
}
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
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
}
}
 Pass {
  Name "FORWARDONLY"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 240329
Program "vp" {
}
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
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" "_MULTI_RIMLIGHT_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}