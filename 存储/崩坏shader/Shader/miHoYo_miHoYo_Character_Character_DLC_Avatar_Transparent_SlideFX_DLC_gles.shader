//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_DLC/Avatar_Transparent_SlideFX_DLC" {
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
[KeywordEnum(Normal, Tangent, UV2)] _OutlineNormalFrom ("Outline Normal From", Float) = 0
[MHYHeaderBox(SPECIAL_STATE)] [Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
[MHYHeaderBox(SlideFx)] _SlideFxSlide ("SlideFxSlide", Range(-0.5, 1)) = 0
_SlideFxEdge ("SlideFxEdge", Range(0, 0.2)) = 0.22
_SlideFxSmoothStep ("SlideFxSmoothStep", Range(0, 0.2)) = 0.12
_SlideFxEdgeColor ("SlideFxEdgeColor", Color) = (0.9448276,1,0,0)
_SlideFxEdgeIntensity ("SlideFxEdgeIntensity", Float) = 1
_SlideFxNoiseTex ("SlideFxNoiseTex", 2D) = "white" { }
[MHYHeaderBox(UvMove)] _UvMoveTex ("UvMoveTex", 2D) = "white" { }
_UvMoveSpeed ("UvMoveSpeed", Vector) = (0,0,0,0)
_UvMoveScaler ("UvMoveScaler", Range(0, 10)) = 0
_UvMoveColor ("UvMoveColor", Color) = (1,1,1,1)
[Toggle(_UVMOVECOLOURFUL_ON)] _UvMoveColorful ("UvMoveColorful", Float) = 0
_UvMoveNoiseTex ("UvMoveNoiseTex", 2D) = "white" { }
_UvMoveNoiseSpeed ("UvMoveNoiseSpeed", Vector) = (0,0,0,0)
_UvMoveNoiseIntensity ("UvMoveNoiseIntensity", Range(0, 3)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
[MHYHeaderBox(DITHER)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 600
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARDONLY"
  LOD 600
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 53117
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
Keywords { "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
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
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Character/Shared/TRANSPARENTALPHA"
 UsePass "Hidden/miHoYo/DLC/Character/Shared/TRANSPARENTSLIDEFXOUTLINE"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARDONLY"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 99684
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
Keywords { "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" }
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
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_UVMOVECOLOURFUL_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}