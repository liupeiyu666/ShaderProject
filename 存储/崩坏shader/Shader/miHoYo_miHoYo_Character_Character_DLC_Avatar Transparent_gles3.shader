//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_DLC/Avatar Transparent" {
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
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 33043
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
mediump vec2 u_xlat16_16;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_7.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_16.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_7.xy = u_xlat16_7.xx * u_xlat16_16.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_25 = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_25 = u_xlat16_33 / u_xlat16_25;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_7.xxyy).xz;
    u_xlat16_8.xy = vec2(u_xlat16_33) + (-u_xlat16_7.xy);
    u_xlat16_33 = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_8.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_7.x = (-u_xlat16_7.y) + 1.0;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.y / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb10.x) ? u_xlat16_25 : u_xlat16_33;
    u_xlat16_7.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_6.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
mediump vec2 u_xlat16_16;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_7.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_16.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_7.xy = u_xlat16_7.xx * u_xlat16_16.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_25 = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_25 = u_xlat16_33 / u_xlat16_25;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_7.xxyy).xz;
    u_xlat16_8.xy = vec2(u_xlat16_33) + (-u_xlat16_7.xy);
    u_xlat16_33 = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_8.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_7.x = (-u_xlat16_7.y) + 1.0;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.y / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb10.x) ? u_xlat16_25 : u_xlat16_33;
    u_xlat16_7.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_6.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
mediump vec2 u_xlat16_16;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_7.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_16.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_7.xy = u_xlat16_7.xx * u_xlat16_16.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_25 = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_25 = u_xlat16_33 / u_xlat16_25;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_7.xxyy).xz;
    u_xlat16_8.xy = vec2(u_xlat16_33) + (-u_xlat16_7.xy);
    u_xlat16_33 = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_8.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_7.x = (-u_xlat16_7.y) + 1.0;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.y / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb10.x) ? u_xlat16_25 : u_xlat16_33;
    u_xlat16_7.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_6.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_34 = (-u_xlat10_2.x) + 1.0;
    u_xlat16_8.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = vec2(u_xlat16_34) * u_xlat16_8.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_33 / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_8.xxyy).xz;
    u_xlat16_26.xy = vec2(u_xlat16_33) + (-u_xlat16_8.xy);
    u_xlat16_33 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_26.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_26.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb10.x) ? u_xlat16_34 : u_xlat16_33;
    u_xlat16_8.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_34 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_8.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_34;
    u_xlat16_34 = float(1.0) / u_xlat16_8.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_34 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat16_34);
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat16_8.xyz);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_34 = (-u_xlat10_2.x) + 1.0;
    u_xlat16_8.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = vec2(u_xlat16_34) * u_xlat16_8.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_33 / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_8.xxyy).xz;
    u_xlat16_26.xy = vec2(u_xlat16_33) + (-u_xlat16_8.xy);
    u_xlat16_33 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_26.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_26.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb10.x) ? u_xlat16_34 : u_xlat16_33;
    u_xlat16_8.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_34 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_8.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_34;
    u_xlat16_34 = float(1.0) / u_xlat16_8.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_34 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat16_34);
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat16_8.xyz);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_34 = (-u_xlat10_2.x) + 1.0;
    u_xlat16_8.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = vec2(u_xlat16_34) * u_xlat16_8.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_33 / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_8.xxyy).xz;
    u_xlat16_26.xy = vec2(u_xlat16_33) + (-u_xlat16_8.xy);
    u_xlat16_33 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_26.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_26.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb10.x) ? u_xlat16_34 : u_xlat16_33;
    u_xlat16_8.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_34 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_8.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_34;
    u_xlat16_34 = float(1.0) / u_xlat16_8.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_34 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat16_34);
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat16_8.xyz);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_18;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat4.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_18;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat4.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_18;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat4.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump vec2 u_xlat16_29;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_38 = (-u_xlat10_3.x) + 1.0;
    u_xlat16_9.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = vec2(u_xlat16_38) * u_xlat16_9.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_37 / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_9.xxyy).xz;
    u_xlat16_29.xy = vec2(u_xlat16_37) + (-u_xlat16_9.xy);
    u_xlat16_37 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_29.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_29.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb12.x) ? u_xlat16_38 : u_xlat16_37;
    u_xlat16_9.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_38 = max(u_xlat16_38, 0.0);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat16_9.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_38;
    u_xlat16_38 = float(1.0) / u_xlat16_9.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_38 = inversesqrt(u_xlat16_38);
    u_xlat16_9.xyz = u_xlat4.xyz * vec3(u_xlat16_38);
    u_xlat16_38 = dot(u_xlat5.xyz, u_xlat16_9.xyz);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump vec2 u_xlat16_29;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_38 = (-u_xlat10_3.x) + 1.0;
    u_xlat16_9.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = vec2(u_xlat16_38) * u_xlat16_9.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_37 / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_9.xxyy).xz;
    u_xlat16_29.xy = vec2(u_xlat16_37) + (-u_xlat16_9.xy);
    u_xlat16_37 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_29.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_29.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb12.x) ? u_xlat16_38 : u_xlat16_37;
    u_xlat16_9.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_38 = max(u_xlat16_38, 0.0);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat16_9.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_38;
    u_xlat16_38 = float(1.0) / u_xlat16_9.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_38 = inversesqrt(u_xlat16_38);
    u_xlat16_9.xyz = u_xlat4.xyz * vec3(u_xlat16_38);
    u_xlat16_38 = dot(u_xlat5.xyz, u_xlat16_9.xyz);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump vec2 u_xlat16_29;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_38 = (-u_xlat10_3.x) + 1.0;
    u_xlat16_9.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = vec2(u_xlat16_38) * u_xlat16_9.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_37 / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_9.xxyy).xz;
    u_xlat16_29.xy = vec2(u_xlat16_37) + (-u_xlat16_9.xy);
    u_xlat16_37 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_29.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_29.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb12.x) ? u_xlat16_38 : u_xlat16_37;
    u_xlat16_9.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_38 = max(u_xlat16_38, 0.0);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat16_9.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_38;
    u_xlat16_38 = float(1.0) / u_xlat16_9.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_38 = inversesqrt(u_xlat16_38);
    u_xlat16_9.xyz = u_xlat4.xyz * vec3(u_xlat16_38);
    u_xlat16_38 = dot(u_xlat5.xyz, u_xlat16_9.xyz);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
mediump vec3 u_xlat16_10;
bvec3 u_xlatb11;
mediump vec2 u_xlat16_16;
lowp float u_xlat10_18;
bvec2 u_xlatb18;
mediump float u_xlat16_19;
mediump vec2 u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18.x){
        u_xlat10_18 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_18;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb18.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb18.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb18.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb18.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb18.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_7.xxx;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_7.xx, u_xlat10_2.yy);
    u_xlat16_16.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_25.x = u_xlat16_1.x + -0.5;
    u_xlat16_25.x = u_xlat16_25.x + u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_25.x * -2.0 + 3.0;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_25.x;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_34;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_25.x * u_xlat16_7.x + u_xlat16_16.x;
    u_xlat16_16.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_25.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_16.xy = u_xlat16_16.xx * u_xlat16_25.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_7.x / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb11.xz = lessThan(u_xlat16_7.xxxx, u_xlat16_16.xxyy).xz;
    u_xlat16_8.xy = (-u_xlat16_16.xy) + u_xlat16_7.xx;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_16.y;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.x / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.25;
    u_xlat16_16.x = (-u_xlat16_16.y) + 1.0;
    u_xlat16_16.x = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_16.x = u_xlat16_8.y / u_xlat16_16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16.x = min(max(u_xlat16_16.x, 0.0), 1.0);
#else
    u_xlat16_16.x = clamp(u_xlat16_16.x, 0.0, 1.0);
#endif
    u_xlat16_16.x = u_xlat16_16.x * 0.25 + 0.75;
    u_xlat16_7.x = (u_xlatb11.z) ? u_xlat16_7.x : u_xlat16_16.x;
    u_xlat16_7.x = (u_xlatb11.x) ? u_xlat16_34 : u_xlat16_7.x;
    u_xlat16_7.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_10.x = dot(u_xlat5.xyz, u_xlat16_10.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.x = log2(u_xlat16_10.x);
    u_xlat16_10.x = u_xlat16_10.x * _SpecularShininess;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat27 = u_xlat16_10.x * u_xlat16_1.x;
    u_xlat16_19 = dFdx(u_xlat27);
    u_xlat16_28 = dFdy(u_xlat27);
    u_xlat16_19 = abs(u_xlat16_28) + abs(u_xlat16_19);
    u_xlat16_28 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_7.x = (-u_xlat16_19) + u_xlat16_28;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_28;
    u_xlat16_19 = (-u_xlat16_7.x) + u_xlat16_19;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x + (-u_xlat16_7.x);
    u_xlat16_10.x = float(1.0) / u_xlat16_19;
    u_xlat16_1.x = u_xlat16_10.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_28 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_28) + 1.0;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat4.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_28 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_28<u_xlat27);
#else
    u_xlatb27 = u_xlat16_28<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
mediump vec3 u_xlat16_10;
bvec3 u_xlatb11;
mediump vec2 u_xlat16_16;
lowp float u_xlat10_18;
bvec2 u_xlatb18;
mediump float u_xlat16_19;
mediump vec2 u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18.x){
        u_xlat10_18 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_18;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb18.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb18.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb18.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb18.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb18.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_7.xxx;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_7.xx, u_xlat10_2.yy);
    u_xlat16_16.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_25.x = u_xlat16_1.x + -0.5;
    u_xlat16_25.x = u_xlat16_25.x + u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_25.x * -2.0 + 3.0;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_25.x;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_34;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_25.x * u_xlat16_7.x + u_xlat16_16.x;
    u_xlat16_16.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_25.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_16.xy = u_xlat16_16.xx * u_xlat16_25.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_7.x / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb11.xz = lessThan(u_xlat16_7.xxxx, u_xlat16_16.xxyy).xz;
    u_xlat16_8.xy = (-u_xlat16_16.xy) + u_xlat16_7.xx;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_16.y;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.x / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.25;
    u_xlat16_16.x = (-u_xlat16_16.y) + 1.0;
    u_xlat16_16.x = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_16.x = u_xlat16_8.y / u_xlat16_16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16.x = min(max(u_xlat16_16.x, 0.0), 1.0);
#else
    u_xlat16_16.x = clamp(u_xlat16_16.x, 0.0, 1.0);
#endif
    u_xlat16_16.x = u_xlat16_16.x * 0.25 + 0.75;
    u_xlat16_7.x = (u_xlatb11.z) ? u_xlat16_7.x : u_xlat16_16.x;
    u_xlat16_7.x = (u_xlatb11.x) ? u_xlat16_34 : u_xlat16_7.x;
    u_xlat16_7.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_10.x = dot(u_xlat5.xyz, u_xlat16_10.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.x = log2(u_xlat16_10.x);
    u_xlat16_10.x = u_xlat16_10.x * _SpecularShininess;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat27 = u_xlat16_10.x * u_xlat16_1.x;
    u_xlat16_19 = dFdx(u_xlat27);
    u_xlat16_28 = dFdy(u_xlat27);
    u_xlat16_19 = abs(u_xlat16_28) + abs(u_xlat16_19);
    u_xlat16_28 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_7.x = (-u_xlat16_19) + u_xlat16_28;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_28;
    u_xlat16_19 = (-u_xlat16_7.x) + u_xlat16_19;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x + (-u_xlat16_7.x);
    u_xlat16_10.x = float(1.0) / u_xlat16_19;
    u_xlat16_1.x = u_xlat16_10.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_28 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_28) + 1.0;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat4.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_28 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_28<u_xlat27);
#else
    u_xlatb27 = u_xlat16_28<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
mediump vec3 u_xlat16_10;
bvec3 u_xlatb11;
mediump vec2 u_xlat16_16;
lowp float u_xlat10_18;
bvec2 u_xlatb18;
mediump float u_xlat16_19;
mediump vec2 u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18.x){
        u_xlat10_18 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_18;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb18.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb18.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb18.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb18.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb18.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_7.xxx;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_7.xx, u_xlat10_2.yy);
    u_xlat16_16.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_25.x = u_xlat16_1.x + -0.5;
    u_xlat16_25.x = u_xlat16_25.x + u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_25.x * -2.0 + 3.0;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_25.x;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_34;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_25.x * u_xlat16_7.x + u_xlat16_16.x;
    u_xlat16_16.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_25.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_16.xy = u_xlat16_16.xx * u_xlat16_25.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_7.x / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb11.xz = lessThan(u_xlat16_7.xxxx, u_xlat16_16.xxyy).xz;
    u_xlat16_8.xy = (-u_xlat16_16.xy) + u_xlat16_7.xx;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_16.y;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.x / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.25;
    u_xlat16_16.x = (-u_xlat16_16.y) + 1.0;
    u_xlat16_16.x = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_16.x = u_xlat16_8.y / u_xlat16_16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16.x = min(max(u_xlat16_16.x, 0.0), 1.0);
#else
    u_xlat16_16.x = clamp(u_xlat16_16.x, 0.0, 1.0);
#endif
    u_xlat16_16.x = u_xlat16_16.x * 0.25 + 0.75;
    u_xlat16_7.x = (u_xlatb11.z) ? u_xlat16_7.x : u_xlat16_16.x;
    u_xlat16_7.x = (u_xlatb11.x) ? u_xlat16_34 : u_xlat16_7.x;
    u_xlat16_7.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_10.x = dot(u_xlat5.xyz, u_xlat16_10.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.x = log2(u_xlat16_10.x);
    u_xlat16_10.x = u_xlat16_10.x * _SpecularShininess;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat27 = u_xlat16_10.x * u_xlat16_1.x;
    u_xlat16_19 = dFdx(u_xlat27);
    u_xlat16_28 = dFdy(u_xlat27);
    u_xlat16_19 = abs(u_xlat16_28) + abs(u_xlat16_19);
    u_xlat16_28 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_7.x = (-u_xlat16_19) + u_xlat16_28;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_28;
    u_xlat16_19 = (-u_xlat16_7.x) + u_xlat16_19;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x + (-u_xlat16_7.x);
    u_xlat16_10.x = float(1.0) / u_xlat16_19;
    u_xlat16_1.x = u_xlat16_10.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_28 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_28) + 1.0;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat4.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_28 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_28<u_xlat27);
#else
    u_xlatb27 = u_xlat16_28<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
bvec3 u_xlatb12;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump float u_xlat16_28;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_18.x = u_xlat16_1.x + -0.5;
    u_xlat16_18.x = u_xlat16_18.x + u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_18.x * -2.0 + 3.0;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_18.x;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_28;
    u_xlat16_37 = u_xlat16_37 + (-u_xlat16_8.x);
    u_xlat16_37 = u_xlat16_18.x * u_xlat16_37 + u_xlat16_8.x;
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat5.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_37) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_37);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_37 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_8.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_37;
    u_xlat16_37 = float(1.0) / u_xlat16_8.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
bvec3 u_xlatb12;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump float u_xlat16_28;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_18.x = u_xlat16_1.x + -0.5;
    u_xlat16_18.x = u_xlat16_18.x + u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_18.x * -2.0 + 3.0;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_18.x;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_28;
    u_xlat16_37 = u_xlat16_37 + (-u_xlat16_8.x);
    u_xlat16_37 = u_xlat16_18.x * u_xlat16_37 + u_xlat16_8.x;
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat5.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_37) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_37);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_37 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_8.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_37;
    u_xlat16_37 = float(1.0) / u_xlat16_8.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
bvec3 u_xlatb12;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump float u_xlat16_28;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_18.x = u_xlat16_1.x + -0.5;
    u_xlat16_18.x = u_xlat16_18.x + u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_18.x * -2.0 + 3.0;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_18.x;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_28;
    u_xlat16_37 = u_xlat16_37 + (-u_xlat16_8.x);
    u_xlat16_37 = u_xlat16_18.x * u_xlat16_37 + u_xlat16_8.x;
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat5.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_37) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_37);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_37 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_8.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_37;
    u_xlat16_37 = float(1.0) / u_xlat16_8.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
bvec3 u_xlatb13;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump vec2 u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
    u_xlat16_11.xyz = u_xlat6.xyz * vec3(u_xlat30) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_8.xxx;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.5;
    u_xlat16_8.x = dot(u_xlat16_8.xx, u_xlat10_3.yy);
    u_xlat16_18.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_28.x = u_xlat16_1.x + -0.5;
    u_xlat16_28.x = u_xlat16_28.x + u_xlat16_28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28.x = min(max(u_xlat16_28.x, 0.0), 1.0);
#else
    u_xlat16_28.x = clamp(u_xlat16_28.x, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_28.x * -2.0 + 3.0;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_28.x;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_38;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_28.x * u_xlat16_8.x + u_xlat16_18.x;
    u_xlat16_18.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_28.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_18.xy = u_xlat16_18.xx * u_xlat16_28.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_8.x / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb13.xz = lessThan(u_xlat16_8.xxxx, u_xlat16_18.xxyy).xz;
    u_xlat16_9.xy = (-u_xlat16_18.xy) + u_xlat16_8.xx;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_18.y;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.25;
    u_xlat16_18.x = (-u_xlat16_18.y) + 1.0;
    u_xlat16_18.x = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_18.x = u_xlat16_9.y / u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_18.x * 0.25 + 0.75;
    u_xlat16_8.x = (u_xlatb13.z) ? u_xlat16_8.x : u_xlat16_18.x;
    u_xlat16_8.x = (u_xlatb13.x) ? u_xlat16_38 : u_xlat16_8.x;
    u_xlat16_8.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat6.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_8.x = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_8.x) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_8.x);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat5.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3.x * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
bvec3 u_xlatb13;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump vec2 u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
    u_xlat16_11.xyz = u_xlat6.xyz * vec3(u_xlat30) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_8.xxx;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.5;
    u_xlat16_8.x = dot(u_xlat16_8.xx, u_xlat10_3.yy);
    u_xlat16_18.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_28.x = u_xlat16_1.x + -0.5;
    u_xlat16_28.x = u_xlat16_28.x + u_xlat16_28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28.x = min(max(u_xlat16_28.x, 0.0), 1.0);
#else
    u_xlat16_28.x = clamp(u_xlat16_28.x, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_28.x * -2.0 + 3.0;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_28.x;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_38;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_28.x * u_xlat16_8.x + u_xlat16_18.x;
    u_xlat16_18.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_28.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_18.xy = u_xlat16_18.xx * u_xlat16_28.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_8.x / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb13.xz = lessThan(u_xlat16_8.xxxx, u_xlat16_18.xxyy).xz;
    u_xlat16_9.xy = (-u_xlat16_18.xy) + u_xlat16_8.xx;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_18.y;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.25;
    u_xlat16_18.x = (-u_xlat16_18.y) + 1.0;
    u_xlat16_18.x = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_18.x = u_xlat16_9.y / u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_18.x * 0.25 + 0.75;
    u_xlat16_8.x = (u_xlatb13.z) ? u_xlat16_8.x : u_xlat16_18.x;
    u_xlat16_8.x = (u_xlatb13.x) ? u_xlat16_38 : u_xlat16_8.x;
    u_xlat16_8.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat6.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_8.x = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_8.x) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_8.x);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat5.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3.x * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
bvec3 u_xlatb13;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump vec2 u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
    u_xlat16_11.xyz = u_xlat6.xyz * vec3(u_xlat30) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_8.xxx;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.5;
    u_xlat16_8.x = dot(u_xlat16_8.xx, u_xlat10_3.yy);
    u_xlat16_18.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_28.x = u_xlat16_1.x + -0.5;
    u_xlat16_28.x = u_xlat16_28.x + u_xlat16_28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28.x = min(max(u_xlat16_28.x, 0.0), 1.0);
#else
    u_xlat16_28.x = clamp(u_xlat16_28.x, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_28.x * -2.0 + 3.0;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_28.x;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_38;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_28.x * u_xlat16_8.x + u_xlat16_18.x;
    u_xlat16_18.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_28.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_18.xy = u_xlat16_18.xx * u_xlat16_28.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_8.x / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb13.xz = lessThan(u_xlat16_8.xxxx, u_xlat16_18.xxyy).xz;
    u_xlat16_9.xy = (-u_xlat16_18.xy) + u_xlat16_8.xx;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_18.y;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.25;
    u_xlat16_18.x = (-u_xlat16_18.y) + 1.0;
    u_xlat16_18.x = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_18.x = u_xlat16_9.y / u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_18.x * 0.25 + 0.75;
    u_xlat16_8.x = (u_xlatb13.z) ? u_xlat16_8.x : u_xlat16_18.x;
    u_xlat16_8.x = (u_xlatb13.x) ? u_xlat16_38 : u_xlat16_8.x;
    u_xlat16_8.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat6.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_8.x = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_8.x) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_8.x);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat5.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3.x * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_10;
mediump vec3 u_xlat16_12;
vec2 u_xlat14;
ivec2 u_xlati14;
bvec3 u_xlatb14;
mediump vec2 u_xlat16_20;
lowp float u_xlat10_22;
bvec2 u_xlatb22;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb22.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb22.x){
        u_xlat10_22 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_22;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb22.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb22.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat7.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_8.xxx;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat6.xyz = vec3(u_xlat33) * vs_TEXCOORD4.xyz;
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.5;
    u_xlat16_41 = dot(vec2(u_xlat16_41), u_xlat10_3.yy);
    u_xlat16_9.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_20.x = u_xlat16_1.x + -0.5;
    u_xlat16_20.x = u_xlat16_20.x + u_xlat16_20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_20.x * -2.0 + 3.0;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_20.x;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_31;
    u_xlat16_41 = u_xlat16_41 + (-u_xlat16_9.x);
    u_xlat16_41 = u_xlat16_20.x * u_xlat16_41 + u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_20.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = u_xlat16_9.xx * u_xlat16_20.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_31 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_41 / u_xlat16_31;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_31 * 0.25;
    u_xlatb14.xz = lessThan(vec4(u_xlat16_41), u_xlat16_9.xxyy).xz;
    u_xlat16_10.xy = vec2(u_xlat16_41) + (-u_xlat16_9.xy);
    u_xlat16_41 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_41 = max(u_xlat16_41, 9.99999975e-05);
    u_xlat16_41 = u_xlat16_10.x / u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_10.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_41 = (u_xlatb14.z) ? u_xlat16_41 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb14.x) ? u_xlat16_31 : u_xlat16_41;
    u_xlat16_9.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_12.x = dot(u_xlat6.xyz, u_xlat16_12.xyz);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _SpecularShininess;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat33 = u_xlat16_12.x * u_xlat16_1.x;
    u_xlat16_23 = dFdx(u_xlat33);
    u_xlat16_34 = dFdy(u_xlat33);
    u_xlat16_23 = abs(u_xlat16_34) + abs(u_xlat16_23);
    u_xlat16_34 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_41 = (-u_xlat16_23) + u_xlat16_34;
    u_xlat16_23 = u_xlat16_23 + u_xlat16_34;
    u_xlat16_23 = (-u_xlat16_41) + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x + (-u_xlat16_41);
    u_xlat16_12.x = float(1.0) / u_xlat16_23;
    u_xlat16_1.x = u_xlat16_12.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_34 = _RimColor.w + -0.5;
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_9.x = (-u_xlat16_34) + 1.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_41;
    u_xlat16_41 = float(1.0) / u_xlat16_9.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_34 * -2.0 + 3.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_41 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_41 = inversesqrt(u_xlat16_41);
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat33 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_34 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_34<u_xlat33);
#else
    u_xlatb33 = u_xlat16_34<u_xlat33;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat33) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_33 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat33 = u_xlat10_33 * _SPNoiseScaler;
    u_xlat33 = u_xlat33 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat14.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat33));
    u_xlat14.xy = u_xlat14.xy + vec2(1.0, 1.0);
    u_xlat14.xy = floor(u_xlat14.xy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati14.xy = ivec2(u_xlat14.xy);
    u_xlat33 = u_xlat3.x * 1.70000005 + (-u_xlat33);
    u_xlat33 = u_xlat33 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati14.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat33 = (u_xlati14.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati14.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat33) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_10;
mediump vec3 u_xlat16_12;
vec2 u_xlat14;
ivec2 u_xlati14;
bvec3 u_xlatb14;
mediump vec2 u_xlat16_20;
lowp float u_xlat10_22;
bvec2 u_xlatb22;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb22.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb22.x){
        u_xlat10_22 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_22;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb22.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb22.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat7.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_8.xxx;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat6.xyz = vec3(u_xlat33) * vs_TEXCOORD4.xyz;
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.5;
    u_xlat16_41 = dot(vec2(u_xlat16_41), u_xlat10_3.yy);
    u_xlat16_9.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_20.x = u_xlat16_1.x + -0.5;
    u_xlat16_20.x = u_xlat16_20.x + u_xlat16_20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_20.x * -2.0 + 3.0;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_20.x;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_31;
    u_xlat16_41 = u_xlat16_41 + (-u_xlat16_9.x);
    u_xlat16_41 = u_xlat16_20.x * u_xlat16_41 + u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_20.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = u_xlat16_9.xx * u_xlat16_20.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_31 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_41 / u_xlat16_31;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_31 * 0.25;
    u_xlatb14.xz = lessThan(vec4(u_xlat16_41), u_xlat16_9.xxyy).xz;
    u_xlat16_10.xy = vec2(u_xlat16_41) + (-u_xlat16_9.xy);
    u_xlat16_41 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_41 = max(u_xlat16_41, 9.99999975e-05);
    u_xlat16_41 = u_xlat16_10.x / u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_10.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_41 = (u_xlatb14.z) ? u_xlat16_41 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb14.x) ? u_xlat16_31 : u_xlat16_41;
    u_xlat16_9.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_12.x = dot(u_xlat6.xyz, u_xlat16_12.xyz);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _SpecularShininess;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat33 = u_xlat16_12.x * u_xlat16_1.x;
    u_xlat16_23 = dFdx(u_xlat33);
    u_xlat16_34 = dFdy(u_xlat33);
    u_xlat16_23 = abs(u_xlat16_34) + abs(u_xlat16_23);
    u_xlat16_34 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_41 = (-u_xlat16_23) + u_xlat16_34;
    u_xlat16_23 = u_xlat16_23 + u_xlat16_34;
    u_xlat16_23 = (-u_xlat16_41) + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x + (-u_xlat16_41);
    u_xlat16_12.x = float(1.0) / u_xlat16_23;
    u_xlat16_1.x = u_xlat16_12.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_34 = _RimColor.w + -0.5;
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_9.x = (-u_xlat16_34) + 1.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_41;
    u_xlat16_41 = float(1.0) / u_xlat16_9.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_34 * -2.0 + 3.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_41 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_41 = inversesqrt(u_xlat16_41);
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat33 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_34 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_34<u_xlat33);
#else
    u_xlatb33 = u_xlat16_34<u_xlat33;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat33) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_33 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat33 = u_xlat10_33 * _SPNoiseScaler;
    u_xlat33 = u_xlat33 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat14.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat33));
    u_xlat14.xy = u_xlat14.xy + vec2(1.0, 1.0);
    u_xlat14.xy = floor(u_xlat14.xy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati14.xy = ivec2(u_xlat14.xy);
    u_xlat33 = u_xlat3.x * 1.70000005 + (-u_xlat33);
    u_xlat33 = u_xlat33 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati14.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat33 = (u_xlati14.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati14.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat33) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_10;
mediump vec3 u_xlat16_12;
vec2 u_xlat14;
ivec2 u_xlati14;
bvec3 u_xlatb14;
mediump vec2 u_xlat16_20;
lowp float u_xlat10_22;
bvec2 u_xlatb22;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb22.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb22.x){
        u_xlat10_22 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_22;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb22.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb22.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat7.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_8.xxx;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat6.xyz = vec3(u_xlat33) * vs_TEXCOORD4.xyz;
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.5;
    u_xlat16_41 = dot(vec2(u_xlat16_41), u_xlat10_3.yy);
    u_xlat16_9.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_20.x = u_xlat16_1.x + -0.5;
    u_xlat16_20.x = u_xlat16_20.x + u_xlat16_20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_20.x * -2.0 + 3.0;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_20.x;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_31;
    u_xlat16_41 = u_xlat16_41 + (-u_xlat16_9.x);
    u_xlat16_41 = u_xlat16_20.x * u_xlat16_41 + u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_20.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = u_xlat16_9.xx * u_xlat16_20.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_31 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_41 / u_xlat16_31;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_31 * 0.25;
    u_xlatb14.xz = lessThan(vec4(u_xlat16_41), u_xlat16_9.xxyy).xz;
    u_xlat16_10.xy = vec2(u_xlat16_41) + (-u_xlat16_9.xy);
    u_xlat16_41 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_41 = max(u_xlat16_41, 9.99999975e-05);
    u_xlat16_41 = u_xlat16_10.x / u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_10.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_41 = (u_xlatb14.z) ? u_xlat16_41 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb14.x) ? u_xlat16_31 : u_xlat16_41;
    u_xlat16_9.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_12.x = dot(u_xlat6.xyz, u_xlat16_12.xyz);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _SpecularShininess;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat33 = u_xlat16_12.x * u_xlat16_1.x;
    u_xlat16_23 = dFdx(u_xlat33);
    u_xlat16_34 = dFdy(u_xlat33);
    u_xlat16_23 = abs(u_xlat16_34) + abs(u_xlat16_23);
    u_xlat16_34 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_41 = (-u_xlat16_23) + u_xlat16_34;
    u_xlat16_23 = u_xlat16_23 + u_xlat16_34;
    u_xlat16_23 = (-u_xlat16_41) + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x + (-u_xlat16_41);
    u_xlat16_12.x = float(1.0) / u_xlat16_23;
    u_xlat16_1.x = u_xlat16_12.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_34 = _RimColor.w + -0.5;
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_9.x = (-u_xlat16_34) + 1.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_41;
    u_xlat16_41 = float(1.0) / u_xlat16_9.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_34 * -2.0 + 3.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_41 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_41 = inversesqrt(u_xlat16_41);
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat33 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_34 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_34<u_xlat33);
#else
    u_xlatb33 = u_xlat16_34<u_xlat33;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat33) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_33 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat33 = u_xlat10_33 * _SPNoiseScaler;
    u_xlat33 = u_xlat33 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat14.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat33));
    u_xlat14.xy = u_xlat14.xy + vec2(1.0, 1.0);
    u_xlat14.xy = floor(u_xlat14.xy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati14.xy = ivec2(u_xlat14.xy);
    u_xlat33 = u_xlat3.x * 1.70000005 + (-u_xlat33);
    u_xlat33 = u_xlat33 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati14.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat33 = (u_xlati14.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati14.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat33) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
}
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
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Character/Shared/TRANSPARENTALPHA"
 UsePass "Hidden/miHoYo/DLC/Character/Shared/TRANSPARENTOUTLINE"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARDONLY"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 75463
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
mediump vec2 u_xlat16_16;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_7.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_16.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_7.xy = u_xlat16_7.xx * u_xlat16_16.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_25 = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_25 = u_xlat16_33 / u_xlat16_25;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_7.xxyy).xz;
    u_xlat16_8.xy = vec2(u_xlat16_33) + (-u_xlat16_7.xy);
    u_xlat16_33 = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_8.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_7.x = (-u_xlat16_7.y) + 1.0;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.y / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb10.x) ? u_xlat16_25 : u_xlat16_33;
    u_xlat16_7.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_6.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
mediump vec2 u_xlat16_16;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_7.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_16.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_7.xy = u_xlat16_7.xx * u_xlat16_16.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_25 = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_25 = u_xlat16_33 / u_xlat16_25;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_7.xxyy).xz;
    u_xlat16_8.xy = vec2(u_xlat16_33) + (-u_xlat16_7.xy);
    u_xlat16_33 = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_8.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_7.x = (-u_xlat16_7.y) + 1.0;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.y / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb10.x) ? u_xlat16_25 : u_xlat16_33;
    u_xlat16_7.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_6.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
mediump vec2 u_xlat16_16;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_7.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_16.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_7.xy = u_xlat16_7.xx * u_xlat16_16.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_25 = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_25 = u_xlat16_33 / u_xlat16_25;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_7.xxyy).xz;
    u_xlat16_8.xy = vec2(u_xlat16_33) + (-u_xlat16_7.xy);
    u_xlat16_33 = (-u_xlat16_7.x) + u_xlat16_7.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_8.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_7.x = (-u_xlat16_7.y) + 1.0;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.y / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_7.x;
    u_xlat16_7.x = (u_xlatb10.x) ? u_xlat16_25 : u_xlat16_33;
    u_xlat16_7.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat3.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_7.x;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_6.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_34 = (-u_xlat10_2.x) + 1.0;
    u_xlat16_8.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = vec2(u_xlat16_34) * u_xlat16_8.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_33 / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_8.xxyy).xz;
    u_xlat16_26.xy = vec2(u_xlat16_33) + (-u_xlat16_8.xy);
    u_xlat16_33 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_26.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_26.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb10.x) ? u_xlat16_34 : u_xlat16_33;
    u_xlat16_8.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_34 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_8.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_34;
    u_xlat16_34 = float(1.0) / u_xlat16_8.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_34 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat16_34);
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat16_8.xyz);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_34 = (-u_xlat10_2.x) + 1.0;
    u_xlat16_8.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = vec2(u_xlat16_34) * u_xlat16_8.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_33 / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_8.xxyy).xz;
    u_xlat16_26.xy = vec2(u_xlat16_33) + (-u_xlat16_8.xy);
    u_xlat16_33 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_26.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_26.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb10.x) ? u_xlat16_34 : u_xlat16_33;
    u_xlat16_8.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_34 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_8.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_34;
    u_xlat16_34 = float(1.0) / u_xlat16_8.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_34 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat16_34);
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat16_8.xyz);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec3 u_xlatb10;
mediump float u_xlat16_15;
bvec2 u_xlatb18;
mediump float u_xlat16_24;
mediump vec2 u_xlat16_26;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat16_33 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_33 = inversesqrt(u_xlat16_33);
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_33 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.5;
    u_xlat16_33 = dot(vec2(u_xlat16_33), u_xlat10_1.yy);
    u_xlat16_34 = (-u_xlat10_2.x) + 1.0;
    u_xlat16_8.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = vec2(u_xlat16_34) * u_xlat16_8.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_33 / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb10.xz = lessThan(vec4(u_xlat16_33), u_xlat16_8.xxyy).xz;
    u_xlat16_26.xy = vec2(u_xlat16_33) + (-u_xlat16_8.xy);
    u_xlat16_33 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_33 = max(u_xlat16_33, 9.99999975e-05);
    u_xlat16_33 = u_xlat16_26.x / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_33 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_26.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_33 = (u_xlatb10.z) ? u_xlat16_33 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb10.x) ? u_xlat16_34 : u_xlat16_33;
    u_xlat16_8.y = 0.5;
    u_xlat10_2.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SpecularShininess;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_15 = dFdx(u_xlat16_6.x);
    u_xlat16_24 = dFdy(u_xlat16_6.x);
    u_xlat16_15 = abs(u_xlat16_24) + abs(u_xlat16_15);
    u_xlat16_24 = (-u_xlat10_1.z) + 1.0;
    u_xlat16_33 = (-u_xlat16_15) + u_xlat16_24;
    u_xlat16_6.y = u_xlat16_15 + u_xlat16_24;
    u_xlat16_6.xy = (-vec2(u_xlat16_33)) + u_xlat16_6.xy;
    u_xlat16_15 = float(1.0) / u_xlat16_6.y;
    u_xlat16_6.x = u_xlat16_15 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_15 = u_xlat16_6.x * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_15;
    u_xlat16_6.xyz = u_xlat16_6.xxx * _SpecularColor.xyz;
    u_xlat16_6.xyz = u_xlat10_1.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_6.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz;
    u_xlat16_33 = _RimColor.w + -0.5;
    u_xlat16_34 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat16_8.x = (-u_xlat16_33) + 1.0;
    u_xlat16_33 = (-u_xlat16_33) + u_xlat16_34;
    u_xlat16_34 = float(1.0) / u_xlat16_8.x;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_33 * -2.0 + 3.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_34 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat16_34);
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat16_8.xyz);
    u_xlat16_34 = (-u_xlat16_34) + 1.0;
    u_xlat27 = u_xlat16_33 * u_xlat16_34;
    u_xlat16_33 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_33<u_xlat27);
#else
    u_xlatb27 = u_xlat16_33<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat1.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat1.xyz = u_xlat10_2.yyy * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = u_xlat10_2.xzw * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(_RimPower) + u_xlat16_6.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_1.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_18;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat4.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_18;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat4.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_18;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat4.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_8.x;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump vec2 u_xlat16_29;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_38 = (-u_xlat10_3.x) + 1.0;
    u_xlat16_9.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = vec2(u_xlat16_38) * u_xlat16_9.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_37 / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_9.xxyy).xz;
    u_xlat16_29.xy = vec2(u_xlat16_37) + (-u_xlat16_9.xy);
    u_xlat16_37 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_29.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_29.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb12.x) ? u_xlat16_38 : u_xlat16_37;
    u_xlat16_9.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_38 = max(u_xlat16_38, 0.0);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat16_9.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_38;
    u_xlat16_38 = float(1.0) / u_xlat16_9.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_38 = inversesqrt(u_xlat16_38);
    u_xlat16_9.xyz = u_xlat4.xyz * vec3(u_xlat16_38);
    u_xlat16_38 = dot(u_xlat5.xyz, u_xlat16_9.xyz);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump vec2 u_xlat16_29;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_38 = (-u_xlat10_3.x) + 1.0;
    u_xlat16_9.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = vec2(u_xlat16_38) * u_xlat16_9.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_37 / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_9.xxyy).xz;
    u_xlat16_29.xy = vec2(u_xlat16_37) + (-u_xlat16_9.xy);
    u_xlat16_37 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_29.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_29.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb12.x) ? u_xlat16_38 : u_xlat16_37;
    u_xlat16_9.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_38 = max(u_xlat16_38, 0.0);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat16_9.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_38;
    u_xlat16_38 = float(1.0) / u_xlat16_9.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_38 = inversesqrt(u_xlat16_38);
    u_xlat16_9.xyz = u_xlat4.xyz * vec3(u_xlat16_38);
    u_xlat16_38 = dot(u_xlat5.xyz, u_xlat16_9.xyz);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
bvec3 u_xlatb12;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump float u_xlat16_17;
bvec2 u_xlatb20;
mediump float u_xlat16_27;
mediump vec2 u_xlat16_29;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_1.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_37 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_38 = (-u_xlat10_3.x) + 1.0;
    u_xlat16_9.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = vec2(u_xlat16_38) * u_xlat16_9.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_37 / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_9.xxyy).xz;
    u_xlat16_29.xy = vec2(u_xlat16_37) + (-u_xlat16_9.xy);
    u_xlat16_37 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_29.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_29.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb12.x) ? u_xlat16_38 : u_xlat16_37;
    u_xlat16_9.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_7.x = u_xlat16_7.x * _SpecularShininess;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_17 = dFdx(u_xlat16_7.x);
    u_xlat16_27 = dFdy(u_xlat16_7.x);
    u_xlat16_17 = abs(u_xlat16_27) + abs(u_xlat16_17);
    u_xlat16_27 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_17) + u_xlat16_27;
    u_xlat16_7.y = u_xlat16_17 + u_xlat16_27;
    u_xlat16_7.xy = (-vec2(u_xlat16_37)) + u_xlat16_7.xy;
    u_xlat16_17 = float(1.0) / u_xlat16_7.y;
    u_xlat16_7.x = u_xlat16_17 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_17;
    u_xlat16_7.xyz = u_xlat16_7.xxx * _SpecularColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat16_37 = _RimColor.w + -0.5;
    u_xlat16_38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_38 = max(u_xlat16_38, 0.0);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat16_9.x = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = (-u_xlat16_37) + u_xlat16_38;
    u_xlat16_38 = float(1.0) / u_xlat16_9.x;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_37 * -2.0 + 3.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_38 = inversesqrt(u_xlat16_38);
    u_xlat16_9.xyz = u_xlat4.xyz * vec3(u_xlat16_38);
    u_xlat16_38 = dot(u_xlat5.xyz, u_xlat16_9.xyz);
    u_xlat16_38 = (-u_xlat16_38) + 1.0;
    u_xlat30 = u_xlat16_37 * u_xlat16_38;
    u_xlat16_37 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_37<u_xlat30);
#else
    u_xlatb30 = u_xlat16_37<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_7.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = vec2(u_xlat3) * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3 * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_2 + u_xlat16_1;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
mediump vec3 u_xlat16_10;
bvec3 u_xlatb11;
mediump vec2 u_xlat16_16;
lowp float u_xlat10_18;
bvec2 u_xlatb18;
mediump float u_xlat16_19;
mediump vec2 u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18.x){
        u_xlat10_18 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_18;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb18.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb18.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb18.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb18.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb18.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_7.xxx;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_7.xx, u_xlat10_2.yy);
    u_xlat16_16.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_25.x = u_xlat16_1.x + -0.5;
    u_xlat16_25.x = u_xlat16_25.x + u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_25.x * -2.0 + 3.0;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_25.x;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_34;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_25.x * u_xlat16_7.x + u_xlat16_16.x;
    u_xlat16_16.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_25.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_16.xy = u_xlat16_16.xx * u_xlat16_25.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_7.x / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb11.xz = lessThan(u_xlat16_7.xxxx, u_xlat16_16.xxyy).xz;
    u_xlat16_8.xy = (-u_xlat16_16.xy) + u_xlat16_7.xx;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_16.y;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.x / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.25;
    u_xlat16_16.x = (-u_xlat16_16.y) + 1.0;
    u_xlat16_16.x = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_16.x = u_xlat16_8.y / u_xlat16_16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16.x = min(max(u_xlat16_16.x, 0.0), 1.0);
#else
    u_xlat16_16.x = clamp(u_xlat16_16.x, 0.0, 1.0);
#endif
    u_xlat16_16.x = u_xlat16_16.x * 0.25 + 0.75;
    u_xlat16_7.x = (u_xlatb11.z) ? u_xlat16_7.x : u_xlat16_16.x;
    u_xlat16_7.x = (u_xlatb11.x) ? u_xlat16_34 : u_xlat16_7.x;
    u_xlat16_7.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_10.x = dot(u_xlat5.xyz, u_xlat16_10.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.x = log2(u_xlat16_10.x);
    u_xlat16_10.x = u_xlat16_10.x * _SpecularShininess;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat27 = u_xlat16_10.x * u_xlat16_1.x;
    u_xlat16_19 = dFdx(u_xlat27);
    u_xlat16_28 = dFdy(u_xlat27);
    u_xlat16_19 = abs(u_xlat16_28) + abs(u_xlat16_19);
    u_xlat16_28 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_7.x = (-u_xlat16_19) + u_xlat16_28;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_28;
    u_xlat16_19 = (-u_xlat16_7.x) + u_xlat16_19;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x + (-u_xlat16_7.x);
    u_xlat16_10.x = float(1.0) / u_xlat16_19;
    u_xlat16_1.x = u_xlat16_10.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_28 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_28) + 1.0;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat4.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_28 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_28<u_xlat27);
#else
    u_xlatb27 = u_xlat16_28<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
mediump vec3 u_xlat16_10;
bvec3 u_xlatb11;
mediump vec2 u_xlat16_16;
lowp float u_xlat10_18;
bvec2 u_xlatb18;
mediump float u_xlat16_19;
mediump vec2 u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18.x){
        u_xlat10_18 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_18;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb18.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb18.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb18.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb18.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb18.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_7.xxx;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_7.xx, u_xlat10_2.yy);
    u_xlat16_16.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_25.x = u_xlat16_1.x + -0.5;
    u_xlat16_25.x = u_xlat16_25.x + u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_25.x * -2.0 + 3.0;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_25.x;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_34;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_25.x * u_xlat16_7.x + u_xlat16_16.x;
    u_xlat16_16.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_25.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_16.xy = u_xlat16_16.xx * u_xlat16_25.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_7.x / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb11.xz = lessThan(u_xlat16_7.xxxx, u_xlat16_16.xxyy).xz;
    u_xlat16_8.xy = (-u_xlat16_16.xy) + u_xlat16_7.xx;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_16.y;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.x / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.25;
    u_xlat16_16.x = (-u_xlat16_16.y) + 1.0;
    u_xlat16_16.x = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_16.x = u_xlat16_8.y / u_xlat16_16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16.x = min(max(u_xlat16_16.x, 0.0), 1.0);
#else
    u_xlat16_16.x = clamp(u_xlat16_16.x, 0.0, 1.0);
#endif
    u_xlat16_16.x = u_xlat16_16.x * 0.25 + 0.75;
    u_xlat16_7.x = (u_xlatb11.z) ? u_xlat16_7.x : u_xlat16_16.x;
    u_xlat16_7.x = (u_xlatb11.x) ? u_xlat16_34 : u_xlat16_7.x;
    u_xlat16_7.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_10.x = dot(u_xlat5.xyz, u_xlat16_10.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.x = log2(u_xlat16_10.x);
    u_xlat16_10.x = u_xlat16_10.x * _SpecularShininess;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat27 = u_xlat16_10.x * u_xlat16_1.x;
    u_xlat16_19 = dFdx(u_xlat27);
    u_xlat16_28 = dFdy(u_xlat27);
    u_xlat16_19 = abs(u_xlat16_28) + abs(u_xlat16_19);
    u_xlat16_28 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_7.x = (-u_xlat16_19) + u_xlat16_28;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_28;
    u_xlat16_19 = (-u_xlat16_7.x) + u_xlat16_19;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x + (-u_xlat16_7.x);
    u_xlat16_10.x = float(1.0) / u_xlat16_19;
    u_xlat16_1.x = u_xlat16_10.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_28 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_28) + 1.0;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat4.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_28 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_28<u_xlat27);
#else
    u_xlatb27 = u_xlat16_28<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
mediump vec3 u_xlat16_10;
bvec3 u_xlatb11;
mediump vec2 u_xlat16_16;
lowp float u_xlat10_18;
bvec2 u_xlatb18;
mediump float u_xlat16_19;
mediump vec2 u_xlat16_25;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
mediump float u_xlat16_34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb18.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb18.x){
        u_xlat10_18 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_18;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb18.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb18.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb18.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb18.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb18.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb18.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat16_10.xyz = u_xlat5.xyz * vec3(u_xlat27) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_7.xxx;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_7.xx, u_xlat10_2.yy);
    u_xlat16_16.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_25.x = u_xlat16_1.x + -0.5;
    u_xlat16_25.x = u_xlat16_25.x + u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_25.x * -2.0 + 3.0;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_25.x;
    u_xlat16_25.x = u_xlat16_25.x * u_xlat16_34;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_25.x * u_xlat16_7.x + u_xlat16_16.x;
    u_xlat16_16.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_25.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_16.xy = u_xlat16_16.xx * u_xlat16_25.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_34 = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_34 = u_xlat16_7.x / u_xlat16_34;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_34 = u_xlat16_34 * 0.25;
    u_xlatb11.xz = lessThan(u_xlat16_7.xxxx, u_xlat16_16.xxyy).xz;
    u_xlat16_8.xy = (-u_xlat16_16.xy) + u_xlat16_7.xx;
    u_xlat16_7.x = (-u_xlat16_16.x) + u_xlat16_16.y;
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_7.x = u_xlat16_8.x / u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + 0.25;
    u_xlat16_16.x = (-u_xlat16_16.y) + 1.0;
    u_xlat16_16.x = max(u_xlat16_16.x, 9.99999975e-05);
    u_xlat16_16.x = u_xlat16_8.y / u_xlat16_16.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16.x = min(max(u_xlat16_16.x, 0.0), 1.0);
#else
    u_xlat16_16.x = clamp(u_xlat16_16.x, 0.0, 1.0);
#endif
    u_xlat16_16.x = u_xlat16_16.x * 0.25 + 0.75;
    u_xlat16_7.x = (u_xlatb11.z) ? u_xlat16_7.x : u_xlat16_16.x;
    u_xlat16_7.x = (u_xlatb11.x) ? u_xlat16_34 : u_xlat16_7.x;
    u_xlat16_7.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_7.xy).xyz;
    u_xlat16_10.x = dot(u_xlat5.xyz, u_xlat16_10.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 0.0);
    u_xlat16_10.x = log2(u_xlat16_10.x);
    u_xlat16_10.x = u_xlat16_10.x * _SpecularShininess;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat27 = u_xlat16_10.x * u_xlat16_1.x;
    u_xlat16_19 = dFdx(u_xlat27);
    u_xlat16_28 = dFdy(u_xlat27);
    u_xlat16_19 = abs(u_xlat16_28) + abs(u_xlat16_19);
    u_xlat16_28 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_7.x = (-u_xlat16_19) + u_xlat16_28;
    u_xlat16_19 = u_xlat16_19 + u_xlat16_28;
    u_xlat16_19 = (-u_xlat16_7.x) + u_xlat16_19;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x + (-u_xlat16_7.x);
    u_xlat16_10.x = float(1.0) / u_xlat16_19;
    u_xlat16_1.x = u_xlat16_10.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_10.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_28 = _RimColor.w + -0.5;
    u_xlat16_7.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_16.x = (-u_xlat16_28) + 1.0;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_7.x;
    u_xlat16_7.x = float(1.0) / u_xlat16_16.x;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_28 * -2.0 + 3.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat4.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat16_7.xyz);
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat27 = u_xlat16_28 * u_xlat16_7.x;
    u_xlat16_28 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat16_28<u_xlat27);
#else
    u_xlatb27 = u_xlat16_28<u_xlat27;
#endif
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat27) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_7.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_7.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_7.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz + (-unity_SHC.xyz);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * _CharacterSHColor.www;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
bvec3 u_xlatb12;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump float u_xlat16_28;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_18.x = u_xlat16_1.x + -0.5;
    u_xlat16_18.x = u_xlat16_18.x + u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_18.x * -2.0 + 3.0;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_18.x;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_28;
    u_xlat16_37 = u_xlat16_37 + (-u_xlat16_8.x);
    u_xlat16_37 = u_xlat16_18.x * u_xlat16_37 + u_xlat16_8.x;
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat5.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_37) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_37);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_37 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_8.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_37;
    u_xlat16_37 = float(1.0) / u_xlat16_8.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
bvec3 u_xlatb12;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump float u_xlat16_28;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_18.x = u_xlat16_1.x + -0.5;
    u_xlat16_18.x = u_xlat16_18.x + u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_18.x * -2.0 + 3.0;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_18.x;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_28;
    u_xlat16_37 = u_xlat16_37 + (-u_xlat16_8.x);
    u_xlat16_37 = u_xlat16_18.x * u_xlat16_37 + u_xlat16_8.x;
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat5.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_37) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_37);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_37 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_8.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_37;
    u_xlat16_37 = float(1.0) / u_xlat16_8.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
bvec3 u_xlatb12;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump float u_xlat16_28;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_37;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_3.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat4.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat4.xyz = _CustomLightDir.www * u_xlat4.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * u_xlat5.xyz;
    u_xlat16_11.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat4.xyz;
    u_xlat16_7.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat5.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.5;
    u_xlat16_37 = dot(vec2(u_xlat16_37), u_xlat10_2.yy);
    u_xlat16_8.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_18.x = u_xlat16_1.x + -0.5;
    u_xlat16_18.x = u_xlat16_18.x + u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_18.x * -2.0 + 3.0;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_18.x;
    u_xlat16_18.x = u_xlat16_18.x * u_xlat16_28;
    u_xlat16_37 = u_xlat16_37 + (-u_xlat16_8.x);
    u_xlat16_37 = u_xlat16_18.x * u_xlat16_37 + u_xlat16_8.x;
    u_xlat16_8.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_8.xy = u_xlat16_8.xx * u_xlat16_18.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_28 = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_28 = u_xlat16_37 / u_xlat16_28;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_28 = u_xlat16_28 * 0.25;
    u_xlatb12.xz = lessThan(vec4(u_xlat16_37), u_xlat16_8.xxyy).xz;
    u_xlat16_9.xy = vec2(u_xlat16_37) + (-u_xlat16_8.xy);
    u_xlat16_37 = (-u_xlat16_8.x) + u_xlat16_8.y;
    u_xlat16_37 = max(u_xlat16_37, 9.99999975e-05);
    u_xlat16_37 = u_xlat16_9.x / u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_37 * 0.5 + 0.25;
    u_xlat16_8.x = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.y / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.25 + 0.75;
    u_xlat16_37 = (u_xlatb12.z) ? u_xlat16_37 : u_xlat16_8.x;
    u_xlat16_8.x = (u_xlatb12.x) ? u_xlat16_28 : u_xlat16_37;
    u_xlat16_8.y = 0.5;
    u_xlat10_3.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat5.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_2.z) + 1.0;
    u_xlat16_37 = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_37) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_37);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_37 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_8.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_37;
    u_xlat16_37 = float(1.0) / u_xlat16_8.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_37 = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = dot(u_xlat5.xyz, u_xlat16_8.xyz);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_37;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat2.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat2.xyz = u_xlat10_3.yyy * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_2.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_8.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
bvec3 u_xlatb13;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump vec2 u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
    u_xlat16_11.xyz = u_xlat6.xyz * vec3(u_xlat30) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_8.xxx;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.5;
    u_xlat16_8.x = dot(u_xlat16_8.xx, u_xlat10_3.yy);
    u_xlat16_18.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_28.x = u_xlat16_1.x + -0.5;
    u_xlat16_28.x = u_xlat16_28.x + u_xlat16_28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28.x = min(max(u_xlat16_28.x, 0.0), 1.0);
#else
    u_xlat16_28.x = clamp(u_xlat16_28.x, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_28.x * -2.0 + 3.0;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_28.x;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_38;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_28.x * u_xlat16_8.x + u_xlat16_18.x;
    u_xlat16_18.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_28.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_18.xy = u_xlat16_18.xx * u_xlat16_28.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_8.x / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb13.xz = lessThan(u_xlat16_8.xxxx, u_xlat16_18.xxyy).xz;
    u_xlat16_9.xy = (-u_xlat16_18.xy) + u_xlat16_8.xx;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_18.y;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.25;
    u_xlat16_18.x = (-u_xlat16_18.y) + 1.0;
    u_xlat16_18.x = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_18.x = u_xlat16_9.y / u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_18.x * 0.25 + 0.75;
    u_xlat16_8.x = (u_xlatb13.z) ? u_xlat16_8.x : u_xlat16_18.x;
    u_xlat16_8.x = (u_xlatb13.x) ? u_xlat16_38 : u_xlat16_8.x;
    u_xlat16_8.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat6.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_8.x = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_8.x) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_8.x);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat5.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3.x * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
bvec3 u_xlatb13;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump vec2 u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
    u_xlat16_11.xyz = u_xlat6.xyz * vec3(u_xlat30) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_8.xxx;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.5;
    u_xlat16_8.x = dot(u_xlat16_8.xx, u_xlat10_3.yy);
    u_xlat16_18.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_28.x = u_xlat16_1.x + -0.5;
    u_xlat16_28.x = u_xlat16_28.x + u_xlat16_28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28.x = min(max(u_xlat16_28.x, 0.0), 1.0);
#else
    u_xlat16_28.x = clamp(u_xlat16_28.x, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_28.x * -2.0 + 3.0;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_28.x;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_38;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_28.x * u_xlat16_8.x + u_xlat16_18.x;
    u_xlat16_18.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_28.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_18.xy = u_xlat16_18.xx * u_xlat16_28.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_8.x / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb13.xz = lessThan(u_xlat16_8.xxxx, u_xlat16_18.xxyy).xz;
    u_xlat16_9.xy = (-u_xlat16_18.xy) + u_xlat16_8.xx;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_18.y;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.25;
    u_xlat16_18.x = (-u_xlat16_18.y) + 1.0;
    u_xlat16_18.x = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_18.x = u_xlat16_9.y / u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_18.x * 0.25 + 0.75;
    u_xlat16_8.x = (u_xlatb13.z) ? u_xlat16_8.x : u_xlat16_18.x;
    u_xlat16_8.x = (u_xlatb13.x) ? u_xlat16_38 : u_xlat16_8.x;
    u_xlat16_8.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat6.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_8.x = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_8.x) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_8.x);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat5.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3.x * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD6.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
bvec3 u_xlatb13;
mediump vec2 u_xlat16_18;
lowp float u_xlat10_20;
bvec2 u_xlatb20;
mediump float u_xlat16_21;
mediump vec2 u_xlat16_28;
float u_xlat30;
lowp float u_xlat10_30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_38;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb20.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb20.x){
        u_xlat10_20 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_20;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb20.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb20.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb20.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb20.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb20.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb20.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb20.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb20.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
    u_xlat16_11.xyz = u_xlat6.xyz * vec3(u_xlat30) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_8.xxx;
    u_xlat30 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat6.xyz = vec3(u_xlat30) * vs_TEXCOORD4.xyz;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.5;
    u_xlat16_8.x = dot(u_xlat16_8.xx, u_xlat10_3.yy);
    u_xlat16_18.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_28.x = u_xlat16_1.x + -0.5;
    u_xlat16_28.x = u_xlat16_28.x + u_xlat16_28.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28.x = min(max(u_xlat16_28.x, 0.0), 1.0);
#else
    u_xlat16_28.x = clamp(u_xlat16_28.x, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_28.x * -2.0 + 3.0;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_28.x;
    u_xlat16_28.x = u_xlat16_28.x * u_xlat16_38;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_28.x * u_xlat16_8.x + u_xlat16_18.x;
    u_xlat16_18.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_28.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_18.xy = u_xlat16_18.xx * u_xlat16_28.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_38 = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_8.x / u_xlat16_38;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_38 * 0.25;
    u_xlatb13.xz = lessThan(u_xlat16_8.xxxx, u_xlat16_18.xxyy).xz;
    u_xlat16_9.xy = (-u_xlat16_18.xy) + u_xlat16_8.xx;
    u_xlat16_8.x = (-u_xlat16_18.x) + u_xlat16_18.y;
    u_xlat16_8.x = max(u_xlat16_8.x, 9.99999975e-05);
    u_xlat16_8.x = u_xlat16_9.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + 0.25;
    u_xlat16_18.x = (-u_xlat16_18.y) + 1.0;
    u_xlat16_18.x = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_18.x = u_xlat16_9.y / u_xlat16_18.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18.x = min(max(u_xlat16_18.x, 0.0), 1.0);
#else
    u_xlat16_18.x = clamp(u_xlat16_18.x, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_18.x * 0.25 + 0.75;
    u_xlat16_8.x = (u_xlatb13.z) ? u_xlat16_8.x : u_xlat16_18.x;
    u_xlat16_8.x = (u_xlatb13.x) ? u_xlat16_38 : u_xlat16_8.x;
    u_xlat16_8.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_8.xy).xyz;
    u_xlat16_11.x = dot(u_xlat6.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * _SpecularShininess;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat30 = u_xlat16_11.x * u_xlat16_1.x;
    u_xlat16_21 = dFdx(u_xlat30);
    u_xlat16_31 = dFdy(u_xlat30);
    u_xlat16_21 = abs(u_xlat16_31) + abs(u_xlat16_21);
    u_xlat16_31 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_8.x = (-u_xlat16_21) + u_xlat16_31;
    u_xlat16_21 = u_xlat16_21 + u_xlat16_31;
    u_xlat16_21 = (-u_xlat16_8.x) + u_xlat16_21;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x + (-u_xlat16_8.x);
    u_xlat16_11.x = float(1.0) / u_xlat16_21;
    u_xlat16_1.x = u_xlat16_11.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_31 = _RimColor.w + -0.5;
    u_xlat16_8.x = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat16_18.x = (-u_xlat16_31) + 1.0;
    u_xlat16_31 = (-u_xlat16_31) + u_xlat16_8.x;
    u_xlat16_8.x = float(1.0) / u_xlat16_18.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_31 * -2.0 + 3.0;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_8.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat5.xyz * u_xlat16_8.xxx;
    u_xlat16_8.x = dot(u_xlat6.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = (-u_xlat16_8.x) + 1.0;
    u_xlat30 = u_xlat16_31 * u_xlat16_8.x;
    u_xlat16_31 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat16_31<u_xlat30);
#else
    u_xlatb30 = u_xlat16_31<u_xlat30;
#endif
    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat30) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_8.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_8.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_8.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-unity_SHC.xyz);
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _CharacterSHColor.www;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_30 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat30 = u_xlat10_30 * _SPNoiseScaler;
    u_xlat30 = u_xlat30 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat30));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat30 = u_xlat3.x * 1.70000005 + (-u_xlat30);
    u_xlat30 = u_xlat30 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat30 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat30) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_10;
mediump vec3 u_xlat16_12;
vec2 u_xlat14;
ivec2 u_xlati14;
bvec3 u_xlatb14;
mediump vec2 u_xlat16_20;
lowp float u_xlat10_22;
bvec2 u_xlatb22;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb22.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb22.x){
        u_xlat10_22 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_22;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb22.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb22.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat7.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_8.xxx;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat6.xyz = vec3(u_xlat33) * vs_TEXCOORD4.xyz;
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.5;
    u_xlat16_41 = dot(vec2(u_xlat16_41), u_xlat10_3.yy);
    u_xlat16_9.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_20.x = u_xlat16_1.x + -0.5;
    u_xlat16_20.x = u_xlat16_20.x + u_xlat16_20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_20.x * -2.0 + 3.0;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_20.x;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_31;
    u_xlat16_41 = u_xlat16_41 + (-u_xlat16_9.x);
    u_xlat16_41 = u_xlat16_20.x * u_xlat16_41 + u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_20.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = u_xlat16_9.xx * u_xlat16_20.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_31 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_41 / u_xlat16_31;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_31 * 0.25;
    u_xlatb14.xz = lessThan(vec4(u_xlat16_41), u_xlat16_9.xxyy).xz;
    u_xlat16_10.xy = vec2(u_xlat16_41) + (-u_xlat16_9.xy);
    u_xlat16_41 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_41 = max(u_xlat16_41, 9.99999975e-05);
    u_xlat16_41 = u_xlat16_10.x / u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_10.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_41 = (u_xlatb14.z) ? u_xlat16_41 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb14.x) ? u_xlat16_31 : u_xlat16_41;
    u_xlat16_9.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_12.x = dot(u_xlat6.xyz, u_xlat16_12.xyz);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _SpecularShininess;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat33 = u_xlat16_12.x * u_xlat16_1.x;
    u_xlat16_23 = dFdx(u_xlat33);
    u_xlat16_34 = dFdy(u_xlat33);
    u_xlat16_23 = abs(u_xlat16_34) + abs(u_xlat16_23);
    u_xlat16_34 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_41 = (-u_xlat16_23) + u_xlat16_34;
    u_xlat16_23 = u_xlat16_23 + u_xlat16_34;
    u_xlat16_23 = (-u_xlat16_41) + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x + (-u_xlat16_41);
    u_xlat16_12.x = float(1.0) / u_xlat16_23;
    u_xlat16_1.x = u_xlat16_12.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_34 = _RimColor.w + -0.5;
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_9.x = (-u_xlat16_34) + 1.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_41;
    u_xlat16_41 = float(1.0) / u_xlat16_9.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_34 * -2.0 + 3.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_41 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_41 = inversesqrt(u_xlat16_41);
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat33 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_34 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_34<u_xlat33);
#else
    u_xlatb33 = u_xlat16_34<u_xlat33;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat33) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_33 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat33 = u_xlat10_33 * _SPNoiseScaler;
    u_xlat33 = u_xlat33 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat14.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat33));
    u_xlat14.xy = u_xlat14.xy + vec2(1.0, 1.0);
    u_xlat14.xy = floor(u_xlat14.xy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati14.xy = ivec2(u_xlat14.xy);
    u_xlat33 = u_xlat3.x * 1.70000005 + (-u_xlat33);
    u_xlat33 = u_xlat33 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati14.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat33 = (u_xlati14.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati14.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat33) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_10;
mediump vec3 u_xlat16_12;
vec2 u_xlat14;
ivec2 u_xlati14;
bvec3 u_xlatb14;
mediump vec2 u_xlat16_20;
lowp float u_xlat10_22;
bvec2 u_xlatb22;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb22.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb22.x){
        u_xlat10_22 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_22;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb22.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb22.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat7.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_8.xxx;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat6.xyz = vec3(u_xlat33) * vs_TEXCOORD4.xyz;
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.5;
    u_xlat16_41 = dot(vec2(u_xlat16_41), u_xlat10_3.yy);
    u_xlat16_9.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_20.x = u_xlat16_1.x + -0.5;
    u_xlat16_20.x = u_xlat16_20.x + u_xlat16_20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_20.x * -2.0 + 3.0;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_20.x;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_31;
    u_xlat16_41 = u_xlat16_41 + (-u_xlat16_9.x);
    u_xlat16_41 = u_xlat16_20.x * u_xlat16_41 + u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_20.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = u_xlat16_9.xx * u_xlat16_20.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_31 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_41 / u_xlat16_31;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_31 * 0.25;
    u_xlatb14.xz = lessThan(vec4(u_xlat16_41), u_xlat16_9.xxyy).xz;
    u_xlat16_10.xy = vec2(u_xlat16_41) + (-u_xlat16_9.xy);
    u_xlat16_41 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_41 = max(u_xlat16_41, 9.99999975e-05);
    u_xlat16_41 = u_xlat16_10.x / u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_10.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_41 = (u_xlatb14.z) ? u_xlat16_41 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb14.x) ? u_xlat16_31 : u_xlat16_41;
    u_xlat16_9.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_12.x = dot(u_xlat6.xyz, u_xlat16_12.xyz);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _SpecularShininess;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat33 = u_xlat16_12.x * u_xlat16_1.x;
    u_xlat16_23 = dFdx(u_xlat33);
    u_xlat16_34 = dFdy(u_xlat33);
    u_xlat16_23 = abs(u_xlat16_34) + abs(u_xlat16_23);
    u_xlat16_34 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_41 = (-u_xlat16_23) + u_xlat16_34;
    u_xlat16_23 = u_xlat16_23 + u_xlat16_34;
    u_xlat16_23 = (-u_xlat16_41) + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x + (-u_xlat16_41);
    u_xlat16_12.x = float(1.0) / u_xlat16_23;
    u_xlat16_1.x = u_xlat16_12.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_34 = _RimColor.w + -0.5;
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_9.x = (-u_xlat16_34) + 1.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_41;
    u_xlat16_41 = float(1.0) / u_xlat16_9.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_34 * -2.0 + 3.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_41 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_41 = inversesqrt(u_xlat16_41);
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat33 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_34 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_34<u_xlat33);
#else
    u_xlatb33 = u_xlat16_34<u_xlat33;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat33) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_33 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat33 = u_xlat10_33 * _SPNoiseScaler;
    u_xlat33 = u_xlat33 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat14.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat33));
    u_xlat14.xy = u_xlat14.xy + vec2(1.0, 1.0);
    u_xlat14.xy = floor(u_xlat14.xy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati14.xy = ivec2(u_xlat14.xy);
    u_xlat33 = u_xlat3.x * 1.70000005 + (-u_xlat33);
    u_xlat33 = u_xlat33 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati14.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat33 = (u_xlati14.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati14.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat33) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
vec2 u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat11.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat11.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD6.zw = u_xlat11.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD6.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD7.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump vec2 _DiffuseRanges;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump float _SpecularShininess;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _RimEdge;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _RimPower;
uniform 	mediump vec4 _CharacterSHColor;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _MaskMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _DiffuseRampTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec2 u_xlat16_10;
mediump vec3 u_xlat16_12;
vec2 u_xlat14;
ivec2 u_xlati14;
bvec3 u_xlatb14;
mediump vec2 u_xlat16_20;
lowp float u_xlat10_22;
bvec2 u_xlatb22;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
mediump float u_xlat16_34;
mediump float u_xlat16_41;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb22.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb22.x){
        u_xlat10_22 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_22;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb22.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb22.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _EnvColor;
    u_xlat16_2.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.w = min(max(u_xlat16_2.w, 0.0), 1.0);
#else
    u_xlat16_2.w = clamp(u_xlat16_2.w, 0.0, 1.0);
#endif
    u_xlat10_3.xyz = texture(_LightMap, vs_TEXCOORD0.xy).xyz;
    u_xlat10_4.xy = texture(_MaskMap, vs_TEXCOORD0.xy).xz;
    u_xlat5.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat5.xyz = _CustomLightDir.www * u_xlat5.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat7.xyz = vec3(u_xlat33) * u_xlat6.xyz;
    u_xlat16_12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat5.xyz;
    u_xlat16_8.x = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
    u_xlat16_8.x = inversesqrt(u_xlat16_8.x);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_8.xxx;
    u_xlat16_8.xyz = vs_TEXCOORD5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat6.xyz = vec3(u_xlat33) * vs_TEXCOORD4.xyz;
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.5;
    u_xlat16_41 = dot(vec2(u_xlat16_41), u_xlat10_3.yy);
    u_xlat16_9.x = u_xlat16_1.x * 0.099999994 + 0.400000006;
    u_xlat16_20.x = u_xlat16_1.x + -0.5;
    u_xlat16_20.x = u_xlat16_20.x + u_xlat16_20.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20.x = min(max(u_xlat16_20.x, 0.0), 1.0);
#else
    u_xlat16_20.x = clamp(u_xlat16_20.x, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_20.x * -2.0 + 3.0;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_20.x;
    u_xlat16_20.x = u_xlat16_20.x * u_xlat16_31;
    u_xlat16_41 = u_xlat16_41 + (-u_xlat16_9.x);
    u_xlat16_41 = u_xlat16_20.x * u_xlat16_41 + u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_20.xy = vec2((-_DiffuseRanges.xxyx.y) + float(_ShadowThreshold), (-float(_DiffuseRanges.y)) + float(_ShadowThreshold));
    u_xlat16_9.xy = u_xlat16_9.xx * u_xlat16_20.xy + vec2(_DiffuseRanges.x, _DiffuseRanges.y);
    u_xlat16_31 = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_31 = u_xlat16_41 / u_xlat16_31;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_31 * 0.25;
    u_xlatb14.xz = lessThan(vec4(u_xlat16_41), u_xlat16_9.xxyy).xz;
    u_xlat16_10.xy = vec2(u_xlat16_41) + (-u_xlat16_9.xy);
    u_xlat16_41 = (-u_xlat16_9.x) + u_xlat16_9.y;
    u_xlat16_41 = max(u_xlat16_41, 9.99999975e-05);
    u_xlat16_41 = u_xlat16_10.x / u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_41 * 0.5 + 0.25;
    u_xlat16_9.x = (-u_xlat16_9.y) + 1.0;
    u_xlat16_9.x = max(u_xlat16_9.x, 9.99999975e-05);
    u_xlat16_9.x = u_xlat16_10.y / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_9.x * 0.25 + 0.75;
    u_xlat16_41 = (u_xlatb14.z) ? u_xlat16_41 : u_xlat16_9.x;
    u_xlat16_9.x = (u_xlatb14.x) ? u_xlat16_31 : u_xlat16_41;
    u_xlat16_9.y = 0.5;
    u_xlat10_4.xzw = texture(_DiffuseRampTex, u_xlat16_9.xy).xyz;
    u_xlat16_12.x = dot(u_xlat6.xyz, u_xlat16_12.xyz);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_12.x = u_xlat16_12.x * _SpecularShininess;
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat33 = u_xlat16_12.x * u_xlat16_1.x;
    u_xlat16_23 = dFdx(u_xlat33);
    u_xlat16_34 = dFdy(u_xlat33);
    u_xlat16_23 = abs(u_xlat16_34) + abs(u_xlat16_23);
    u_xlat16_34 = (-u_xlat10_3.z) + 1.0;
    u_xlat16_41 = (-u_xlat16_23) + u_xlat16_34;
    u_xlat16_23 = u_xlat16_23 + u_xlat16_34;
    u_xlat16_23 = (-u_xlat16_41) + u_xlat16_23;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x + (-u_xlat16_41);
    u_xlat16_12.x = float(1.0) / u_xlat16_23;
    u_xlat16_1.x = u_xlat16_12.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_12.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_12.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _SpecularColor.xyz;
    u_xlat16_1.xyz = u_xlat10_3.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_SpecularIntensity, _SpecularIntensity, _SpecularIntensity));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_34 = _RimColor.w + -0.5;
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.0);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat16_9.x = (-u_xlat16_34) + 1.0;
    u_xlat16_34 = (-u_xlat16_34) + u_xlat16_41;
    u_xlat16_41 = float(1.0) / u_xlat16_9.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_41 = u_xlat16_34 * -2.0 + 3.0;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_41 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_41 = inversesqrt(u_xlat16_41);
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = (-u_xlat16_41) + 1.0;
    u_xlat33 = u_xlat16_34 * u_xlat16_41;
    u_xlat16_34 = (-_RimEdge) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_34<u_xlat33);
#else
    u_xlatb33 = u_xlat16_34<u_xlat33;
#endif
    u_xlat33 = u_xlatb33 ? 1.0 : float(0.0);
    u_xlat3.xyz = vec3(u_xlat33) * _RimColor.xyz;
    u_xlat3.xyz = u_xlat10_4.yyy * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat16_1.xyz = u_xlat10_4.xzw * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat3.xyz * vec3(_RimPower) + u_xlat16_1.xyz;
    u_xlat16_9.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_9.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_9.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-unity_SHC.xyz);
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_3.xyz * _CharacterSHColor.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * _CharacterSHColor.www;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD6.xy);
    u_xlat16_1.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_33 = texture(_SPNoiseTex, vs_TEXCOORD6.zw).x;
    u_xlat33 = u_xlat10_33 * _SPNoiseScaler;
    u_xlat33 = u_xlat33 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat14.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat33));
    u_xlat14.xy = u_xlat14.xy + vec2(1.0, 1.0);
    u_xlat14.xy = floor(u_xlat14.xy);
    u_xlat14.xy = max(u_xlat14.xy, vec2(0.0, 0.0));
    u_xlati14.xy = ivec2(u_xlat14.xy);
    u_xlat33 = u_xlat3.x * 1.70000005 + (-u_xlat33);
    u_xlat33 = u_xlat33 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat4.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz + u_xlat10_0.xyz;
    u_xlat16_8.xyz = (u_xlati14.y != 0) ? u_xlat10_0.xyz : u_xlat4.xyz;
    u_xlat33 = (u_xlati14.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_1.xyz = (u_xlati14.x != 0) ? u_xlat16_8.xyz : u_xlat10_0.xyz;
    u_xlat16_1 = (-u_xlat16_2) + u_xlat16_1;
    u_xlat0 = vec4(u_xlat33) * u_xlat16_1 + u_xlat16_2;
    SV_Target0.w = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
}
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
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}