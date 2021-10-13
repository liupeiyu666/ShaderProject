//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Modify_Specular" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_LightMapTex ("Light Map Tex (RGB)", 2D) = "gray" { }
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_SecondShadow ("Second Shadow Threshold", Range(0, 1)) = 0.51
_FirstShadowMultColor ("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_SecondShadowMultColor ("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[KeywordEnum(Multi,Add)] _ModifySpec ("Modify Spec", Float) = 0
_ModifySpecMask ("Modify Specular Mask(R)", 2D) = "black" { }
_ModifySpecColor ("Modify Specular Color", Color) = (1,1,1,1)
_ModifySpecThreshold ("Modify Spec Threshold", Range(0, 1)) = 0.1
_MaxSpecGradient ("Max Spec Gradient", Range(0, 1)) = 1
_ModifySpecCoff ("Modify Spec Coff", Range(0, 10)) = 1
_ModifySpecPower ("Modify Spec Power", Range(0, 10)) = 1
[Toggle(LOOKUP_COLOR)] _LookupColor ("Lookup Color", Float) = 0
[Toggle(LOOKUP_COLOR_BILINEAR)] _LookupColorBilinear ("Lookup Color Bilinear", Float) = 0
_factorTex ("Factor Tex", 2D) = "white" { }
_indexTex ("Index Tex", 2D) = "white" { }
_tableTex ("Lookup Tex", 2D) = "white" { }
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
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
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(1, 9)) = 5
_DTPlaySpeed ("Distortion Play Speed", Float) = 0
_DTNormalDisplacment ("Distortion Normal Displacment", Float) = 0
_DTUVScaleInX ("Distortion UV Scale in X", Float) = 1
_DTUVScaleInY ("Distortion UV Scale in Y", Float) = 1
_DTFresnel ("Distortion Fresnel Params", Vector) = (1,1,0,0)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  GpuProgramID 53298
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec3 u_xlati6;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb13;
float u_xlat18;
bool u_xlatb18;
int u_xlati19;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat18 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat18 = floor(u_xlat18);
    u_xlat6.z = max(u_xlat18, 0.0);
    u_xlat16_8.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + (-_SecondShadow);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati19 = int(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_8.xyz = (int(u_xlati19) != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.xz = ivec2(u_xlat6.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati6.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati6.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati6.z != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb18 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat6.xxx + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb18)) ? u_xlat16_3.xyz : u_xlat5.xyz;
    u_xlat16_20 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6.x = u_xlat16_6 + 1.0;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.x = int(u_xlat6.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
            u_xlat16_20 = log2(u_xlat16_20);
            u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
            u_xlat16_20 = exp2(u_xlat16_20);
            u_xlat16_20 = (u_xlatb0) ? u_xlat16_20 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_20) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
                u_xlat16_20 = log2(u_xlat16_20);
                u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
                u_xlat16_20 = exp2(u_xlat16_20);
                u_xlat16_20 = (-u_xlat16_20) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb13.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb13.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb13.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec3 u_xlati6;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb13;
float u_xlat18;
bool u_xlatb18;
int u_xlati19;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat18 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat18 = floor(u_xlat18);
    u_xlat6.z = max(u_xlat18, 0.0);
    u_xlat16_8.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + (-_SecondShadow);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati19 = int(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_8.xyz = (int(u_xlati19) != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.xz = ivec2(u_xlat6.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati6.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati6.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati6.z != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb18 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat6.xxx + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb18)) ? u_xlat16_3.xyz : u_xlat5.xyz;
    u_xlat16_20 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6.x = u_xlat16_6 + 1.0;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.x = int(u_xlat6.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
            u_xlat16_20 = log2(u_xlat16_20);
            u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
            u_xlat16_20 = exp2(u_xlat16_20);
            u_xlat16_20 = (u_xlatb0) ? u_xlat16_20 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_20) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
                u_xlat16_20 = log2(u_xlat16_20);
                u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
                u_xlat16_20 = exp2(u_xlat16_20);
                u_xlat16_20 = (-u_xlat16_20) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb13.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb13.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb13.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec3 u_xlati6;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb13;
float u_xlat18;
bool u_xlatb18;
int u_xlati19;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat18 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat18 = floor(u_xlat18);
    u_xlat6.z = max(u_xlat18, 0.0);
    u_xlat16_8.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + (-_SecondShadow);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati19 = int(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_8.xyz = (int(u_xlati19) != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.xz = ivec2(u_xlat6.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati6.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati6.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati6.z != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb18 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat6.xxx + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb18)) ? u_xlat16_3.xyz : u_xlat5.xyz;
    u_xlat16_20 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6.x = u_xlat16_6 + 1.0;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.x = int(u_xlat6.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
            u_xlat16_20 = log2(u_xlat16_20);
            u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
            u_xlat16_20 = exp2(u_xlat16_20);
            u_xlat16_20 = (u_xlatb0) ? u_xlat16_20 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_20) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
                u_xlat16_20 = log2(u_xlat16_20);
                u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
                u_xlat16_20 = exp2(u_xlat16_20);
                u_xlat16_20 = (-u_xlat16_20) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb13.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb13.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb13.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec3 u_xlati6;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb13;
float u_xlat18;
bool u_xlatb18;
int u_xlati19;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat18 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat18 = floor(u_xlat18);
    u_xlat6.z = max(u_xlat18, 0.0);
    u_xlat16_8.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + (-_SecondShadow);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati19 = int(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_8.xyz = (int(u_xlati19) != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.xz = ivec2(u_xlat6.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati6.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati6.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati6.z != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb18 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat6.xxx + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb18)) ? u_xlat16_3.xyz : u_xlat5.xyz;
    u_xlat16_20 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6.x = u_xlat16_6 + 1.0;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.x = int(u_xlat6.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
            u_xlat16_20 = log2(u_xlat16_20);
            u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
            u_xlat16_20 = exp2(u_xlat16_20);
            u_xlat16_20 = (u_xlatb0) ? u_xlat16_20 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_20) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
                u_xlat16_20 = log2(u_xlat16_20);
                u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
                u_xlat16_20 = exp2(u_xlat16_20);
                u_xlat16_20 = (-u_xlat16_20) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb13.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb13.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb13.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec3 u_xlati6;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb13;
float u_xlat18;
bool u_xlatb18;
int u_xlati19;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat18 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat18 = floor(u_xlat18);
    u_xlat6.z = max(u_xlat18, 0.0);
    u_xlat16_8.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + (-_SecondShadow);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati19 = int(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_8.xyz = (int(u_xlati19) != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.xz = ivec2(u_xlat6.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati6.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati6.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati6.z != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb18 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat6.xxx + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb18)) ? u_xlat16_3.xyz : u_xlat5.xyz;
    u_xlat16_20 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6.x = u_xlat16_6 + 1.0;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.x = int(u_xlat6.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
            u_xlat16_20 = log2(u_xlat16_20);
            u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
            u_xlat16_20 = exp2(u_xlat16_20);
            u_xlat16_20 = (u_xlatb0) ? u_xlat16_20 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_20) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
                u_xlat16_20 = log2(u_xlat16_20);
                u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
                u_xlat16_20 = exp2(u_xlat16_20);
                u_xlat16_20 = (-u_xlat16_20) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb13.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb13.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb13.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec3 u_xlati6;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb13;
float u_xlat18;
bool u_xlatb18;
int u_xlati19;
mediump float u_xlat16_20;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat18 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat18 = floor(u_xlat18);
    u_xlat6.z = max(u_xlat18, 0.0);
    u_xlat16_8.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_8.x = u_xlat16_8.x * 0.5 + (-_SecondShadow);
    u_xlat16_8.x = u_xlat16_8.x + 1.0;
    u_xlat16_8.x = floor(u_xlat16_8.x);
    u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
    u_xlati19 = int(u_xlat16_8.x);
    u_xlat16_8.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_8.xyz = (int(u_xlati19) != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.xz = ivec2(u_xlat6.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati6.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati6.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati6.z != 0) ? u_xlat16_3.xyz : u_xlat16_8.xyz;
    u_xlat6.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat1.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb18 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat6.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat6.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat6.xxx + _CustomLightDir.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb18)) ? u_xlat16_3.xyz : u_xlat5.xyz;
    u_xlat16_20 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = max(u_xlat16_20, 0.0);
    u_xlat16_20 = log2(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * _Shininess;
    u_xlat16_20 = exp2(u_xlat16_20);
    u_xlat16_6 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_6 = (-u_xlat16_20) + u_xlat16_6;
    u_xlat6.x = u_xlat16_6 + 1.0;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlati6.x = int(u_xlat6.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati6.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
            u_xlat16_20 = log2(u_xlat16_20);
            u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
            u_xlat16_20 = exp2(u_xlat16_20);
            u_xlat16_20 = (u_xlatb0) ? u_xlat16_20 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_20) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_20 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_20 = max(u_xlat16_20, 0.0);
        u_xlat16_3.x = (-u_xlat16_20) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_20<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_20<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_20 = u_xlat16_20 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_20 = u_xlat16_20 / u_xlat16_3.x;
                u_xlat16_20 = log2(u_xlat16_20);
                u_xlat16_20 = u_xlat16_20 * _ModifySpecPower;
                u_xlat16_20 = exp2(u_xlat16_20);
                u_xlat16_20 = (-u_xlat16_20) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb13.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb13.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb13.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
bvec2 u_xlatb16;
float u_xlat21;
lowp float u_xlat10_21;
int u_xlati21;
float u_xlat22;
mediump float u_xlat16_22;
lowp float u_xlat10_22;
int u_xlati22;
bool u_xlatb22;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_21 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_21) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_24 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlati21 = int(u_xlat21);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat7 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7 = floor(u_xlat7);
    u_xlat1.x = max(u_xlat7, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat8.xy = vec2(u_xlat16_24) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_24 = (u_xlati1 != 0) ? u_xlat8.y : u_xlat8.x;
    u_xlat16_24 = u_xlat16_24 + vs_COLOR1;
    u_xlat16_25 = u_xlat16_24 * 0.5 + (-_LightArea);
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = floor(u_xlat16_25);
    u_xlat16_25 = max(u_xlat16_25, 0.0);
    u_xlati1 = int(u_xlat16_25);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat22) + _WorldSpaceLightPos0.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat6.xyz = vec3(u_xlat22) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb23 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat22) + (-_WorldSpaceLightPos0.xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat22) + _CustomLightDir.xyz;
    u_xlat16_25 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat16_5.xyz : u_xlat6.xyz;
    u_xlat16_25 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.0);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_25) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(_ModifySpec==0.0);
#else
    u_xlatb22 = _ModifySpec==0.0;
#endif
    if(u_xlatb22){
        u_xlat16_25 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_25 = max(u_xlat16_25, 0.0);
        u_xlat16_5.x = (-u_xlat16_25) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati22 = int(u_xlat16_5.x);
        if(u_xlati22 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(u_xlat16_25<_MaxSpecGradient);
#else
            u_xlatb22 = u_xlat16_25<_MaxSpecGradient;
#endif
            u_xlat16_25 = u_xlat16_25 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_25 = u_xlat16_25 / u_xlat16_5.x;
            u_xlat16_25 = log2(u_xlat16_25);
            u_xlat16_25 = u_xlat16_25 * _ModifySpecPower;
            u_xlat16_25 = exp2(u_xlat16_25);
            u_xlat16_25 = (u_xlatb22) ? u_xlat16_25 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_22 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_2.xyz = vec3(u_xlat10_22) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_25 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_25 = max(u_xlat16_25, 0.0);
        u_xlat16_5.x = (-u_xlat16_25) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati1 = int(u_xlat16_5.x);
        if(u_xlati1 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb1 = !!(u_xlat16_25<_MaxSpecGradient);
#else
            u_xlatb1 = u_xlat16_25<_MaxSpecGradient;
#endif
            if(u_xlatb1){
                u_xlat16_25 = u_xlat16_25 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_25 = u_xlat16_25 / u_xlat16_5.x;
                u_xlat16_25 = log2(u_xlat16_25);
                u_xlat16_25 = u_xlat16_25 * _ModifySpecPower;
                u_xlat16_25 = exp2(u_xlat16_25);
                u_xlat16_25 = (-u_xlat16_25) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_1.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_1.xyz = u_xlat10_1.xxx * u_xlat16_5.xyz;
                u_xlat16_1.xyz = u_xlat16_1.xyz;
            } else {
                u_xlat16_1.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_1.x = float(1.0);
            u_xlat16_1.y = float(1.0);
            u_xlat16_1.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_5.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_lightProbToggle);
#else
    u_xlatb2 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb2)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
bvec2 u_xlatb16;
float u_xlat21;
lowp float u_xlat10_21;
int u_xlati21;
float u_xlat22;
mediump float u_xlat16_22;
lowp float u_xlat10_22;
int u_xlati22;
bool u_xlatb22;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_21 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_21) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_24 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlati21 = int(u_xlat21);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat7 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7 = floor(u_xlat7);
    u_xlat1.x = max(u_xlat7, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat8.xy = vec2(u_xlat16_24) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_24 = (u_xlati1 != 0) ? u_xlat8.y : u_xlat8.x;
    u_xlat16_24 = u_xlat16_24 + vs_COLOR1;
    u_xlat16_25 = u_xlat16_24 * 0.5 + (-_LightArea);
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = floor(u_xlat16_25);
    u_xlat16_25 = max(u_xlat16_25, 0.0);
    u_xlati1 = int(u_xlat16_25);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat22) + _WorldSpaceLightPos0.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat6.xyz = vec3(u_xlat22) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb23 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat22) + (-_WorldSpaceLightPos0.xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat22) + _CustomLightDir.xyz;
    u_xlat16_25 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat16_5.xyz : u_xlat6.xyz;
    u_xlat16_25 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.0);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_25) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(_ModifySpec==0.0);
#else
    u_xlatb22 = _ModifySpec==0.0;
#endif
    if(u_xlatb22){
        u_xlat16_25 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_25 = max(u_xlat16_25, 0.0);
        u_xlat16_5.x = (-u_xlat16_25) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati22 = int(u_xlat16_5.x);
        if(u_xlati22 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(u_xlat16_25<_MaxSpecGradient);
#else
            u_xlatb22 = u_xlat16_25<_MaxSpecGradient;
#endif
            u_xlat16_25 = u_xlat16_25 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_25 = u_xlat16_25 / u_xlat16_5.x;
            u_xlat16_25 = log2(u_xlat16_25);
            u_xlat16_25 = u_xlat16_25 * _ModifySpecPower;
            u_xlat16_25 = exp2(u_xlat16_25);
            u_xlat16_25 = (u_xlatb22) ? u_xlat16_25 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_22 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_2.xyz = vec3(u_xlat10_22) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_25 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_25 = max(u_xlat16_25, 0.0);
        u_xlat16_5.x = (-u_xlat16_25) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati1 = int(u_xlat16_5.x);
        if(u_xlati1 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb1 = !!(u_xlat16_25<_MaxSpecGradient);
#else
            u_xlatb1 = u_xlat16_25<_MaxSpecGradient;
#endif
            if(u_xlatb1){
                u_xlat16_25 = u_xlat16_25 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_25 = u_xlat16_25 / u_xlat16_5.x;
                u_xlat16_25 = log2(u_xlat16_25);
                u_xlat16_25 = u_xlat16_25 * _ModifySpecPower;
                u_xlat16_25 = exp2(u_xlat16_25);
                u_xlat16_25 = (-u_xlat16_25) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_1.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_1.xyz = u_xlat10_1.xxx * u_xlat16_5.xyz;
                u_xlat16_1.xyz = u_xlat16_1.xyz;
            } else {
                u_xlat16_1.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_1.x = float(1.0);
            u_xlat16_1.y = float(1.0);
            u_xlat16_1.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_5.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_lightProbToggle);
#else
    u_xlatb2 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb2)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec2 u_xlat8;
bvec2 u_xlatb16;
float u_xlat21;
lowp float u_xlat10_21;
int u_xlati21;
float u_xlat22;
mediump float u_xlat16_22;
lowp float u_xlat10_22;
int u_xlati22;
bool u_xlatb22;
bool u_xlatb23;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_21 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_21) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_24 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlati21 = int(u_xlat21);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat7 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7 = floor(u_xlat7);
    u_xlat1.x = max(u_xlat7, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat8.xy = vec2(u_xlat16_24) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_24 = (u_xlati1 != 0) ? u_xlat8.y : u_xlat8.x;
    u_xlat16_24 = u_xlat16_24 + vs_COLOR1;
    u_xlat16_25 = u_xlat16_24 * 0.5 + (-_LightArea);
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = floor(u_xlat16_25);
    u_xlat16_25 = max(u_xlat16_25, 0.0);
    u_xlati1 = int(u_xlat16_25);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat22) + _WorldSpaceLightPos0.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat6.xyz = vec3(u_xlat22) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb23 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat22) + (-_WorldSpaceLightPos0.xyz);
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat22) + _CustomLightDir.xyz;
    u_xlat16_25 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb23)) ? u_xlat16_5.xyz : u_xlat6.xyz;
    u_xlat16_25 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.0);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_25) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(_ModifySpec==0.0);
#else
    u_xlatb22 = _ModifySpec==0.0;
#endif
    if(u_xlatb22){
        u_xlat16_25 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_25 = max(u_xlat16_25, 0.0);
        u_xlat16_5.x = (-u_xlat16_25) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati22 = int(u_xlat16_5.x);
        if(u_xlati22 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(u_xlat16_25<_MaxSpecGradient);
#else
            u_xlatb22 = u_xlat16_25<_MaxSpecGradient;
#endif
            u_xlat16_25 = u_xlat16_25 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_25 = u_xlat16_25 / u_xlat16_5.x;
            u_xlat16_25 = log2(u_xlat16_25);
            u_xlat16_25 = u_xlat16_25 * _ModifySpecPower;
            u_xlat16_25 = exp2(u_xlat16_25);
            u_xlat16_25 = (u_xlatb22) ? u_xlat16_25 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_22 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_2.xyz = vec3(u_xlat10_22) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_25 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_25 = max(u_xlat16_25, 0.0);
        u_xlat16_5.x = (-u_xlat16_25) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati1 = int(u_xlat16_5.x);
        if(u_xlati1 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb1 = !!(u_xlat16_25<_MaxSpecGradient);
#else
            u_xlatb1 = u_xlat16_25<_MaxSpecGradient;
#endif
            if(u_xlatb1){
                u_xlat16_25 = u_xlat16_25 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_25 = u_xlat16_25 / u_xlat16_5.x;
                u_xlat16_25 = log2(u_xlat16_25);
                u_xlat16_25 = u_xlat16_25 * _ModifySpecPower;
                u_xlat16_25 = exp2(u_xlat16_25);
                u_xlat16_25 = (-u_xlat16_25) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_1.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_1.xyz = u_xlat10_1.xxx * u_xlat16_5.xyz;
                u_xlat16_1.xyz = u_xlat16_1.xyz;
            } else {
                u_xlat16_1.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_1.x = float(1.0);
            u_xlat16_1.y = float(1.0);
            u_xlat16_1.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb2){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat2.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat2.x);
            u_xlat2.x = u_xlat2.x + 0.99000001;
            u_xlat2.x = floor(u_xlat2.x);
            u_xlat2.x = max(u_xlat2.x, 0.0);
            u_xlati2 = int(u_xlat2.x);
            if((u_xlati2)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_5.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.5<_lightProbToggle);
#else
    u_xlatb2 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb2)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
ivec3 u_xlati11;
mediump vec3 u_xlat16_18;
bvec2 u_xlatb23;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
int u_xlati34;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb33 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat11.xxx + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb33)) ? u_xlat16_8.xyz : u_xlat3.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_11 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_11 = (-u_xlat16_40) + u_xlat16_11;
    u_xlat11.x = u_xlat16_11 + 1.0;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.x = int(u_xlat11.x);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xyz * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb23.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb23.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_8.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
ivec3 u_xlati11;
mediump vec3 u_xlat16_18;
bvec2 u_xlatb23;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
int u_xlati34;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb33 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat11.xxx + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb33)) ? u_xlat16_8.xyz : u_xlat3.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_11 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_11 = (-u_xlat16_40) + u_xlat16_11;
    u_xlat11.x = u_xlat16_11 + 1.0;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.x = int(u_xlat11.x);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xyz * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb23.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb23.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_8.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
uvec2 u_xlatu1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
ivec3 u_xlati11;
mediump vec3 u_xlat16_18;
bvec2 u_xlatb23;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
int u_xlati34;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb33 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat11.xxx + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb33)) ? u_xlat16_8.xyz : u_xlat3.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_11 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_11 = (-u_xlat16_40) + u_xlat16_11;
    u_xlat11.x = u_xlat16_11 + 1.0;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.x = int(u_xlat11.x);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xyz * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb1){
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb1 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb1){
            u_xlat1.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat1.xy = u_xlat1.xy * _ScreenParams.yx;
            u_xlat1.xy = u_xlat1.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat1.xyxy, (-u_xlat1.xyxy)).xy;
            u_xlat1.xy = fract(abs(u_xlat1.xy));
            u_xlat1.x = (u_xlatb23.x) ? u_xlat1.x : (-u_xlat1.x);
            u_xlat1.y = (u_xlatb23.y) ? u_xlat1.y : (-u_xlat1.y);
            u_xlat1.xy = u_xlat1.xy * vec2(4.0, 4.0);
            u_xlatu1.xy = uvec2(u_xlat1.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu1.y)]);
            u_xlat1.x = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu1.x)]);
            u_xlat1.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat1.x);
            u_xlat1.x = u_xlat1.x + 0.99000001;
            u_xlat1.x = floor(u_xlat1.x);
            u_xlat1.x = max(u_xlat1.x, 0.0);
            u_xlati1 = int(u_xlat1.x);
            if((u_xlati1)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_8.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
uvec2 u_xlatu4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
ivec3 u_xlati7;
float u_xlat8;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat7.z = max(u_xlat21, 0.0);
    u_xlat16_9.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_9.x = u_xlat16_9.x * 0.5 + (-_SecondShadow);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlati22 = int(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_9.xyz = (int(u_xlati22) != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.xz = ivec2(u_xlat7.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati7.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati7.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati7.z != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat5.xyz = u_xlat7.xxx * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat6.xyz = u_xlat7.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb21 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat7.xxx + _CustomLightDir.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb21)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_23 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _Shininess;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_7 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_7 = (-u_xlat16_23) + u_xlat16_7;
    u_xlat7.x = u_xlat16_7 + 1.0;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.x = int(u_xlat7.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
            u_xlat16_23 = log2(u_xlat16_23);
            u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
            u_xlat16_23 = exp2(u_xlat16_23);
            u_xlat16_23 = (u_xlatb0) ? u_xlat16_23 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
                u_xlat16_23 = log2(u_xlat16_23);
                u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
                u_xlat16_23 = exp2(u_xlat16_23);
                u_xlat16_23 = (-u_xlat16_23) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb22 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb22){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb18.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb18.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat22 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat22 = vs_TEXCOORD3.z * 17.0 + (-u_xlat22);
            u_xlat22 = u_xlat22 + 0.99000001;
            u_xlat22 = floor(u_xlat22);
            u_xlat22 = max(u_xlat22, 0.0);
            u_xlati22 = int(u_xlat22);
            if((u_xlati22)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.5<_lightProbToggle);
#else
    u_xlatb22 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
uvec2 u_xlatu4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
ivec3 u_xlati7;
float u_xlat8;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat7.z = max(u_xlat21, 0.0);
    u_xlat16_9.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_9.x = u_xlat16_9.x * 0.5 + (-_SecondShadow);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlati22 = int(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_9.xyz = (int(u_xlati22) != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.xz = ivec2(u_xlat7.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati7.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati7.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati7.z != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat5.xyz = u_xlat7.xxx * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat6.xyz = u_xlat7.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb21 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat7.xxx + _CustomLightDir.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb21)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_23 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _Shininess;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_7 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_7 = (-u_xlat16_23) + u_xlat16_7;
    u_xlat7.x = u_xlat16_7 + 1.0;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.x = int(u_xlat7.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
            u_xlat16_23 = log2(u_xlat16_23);
            u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
            u_xlat16_23 = exp2(u_xlat16_23);
            u_xlat16_23 = (u_xlatb0) ? u_xlat16_23 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
                u_xlat16_23 = log2(u_xlat16_23);
                u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
                u_xlat16_23 = exp2(u_xlat16_23);
                u_xlat16_23 = (-u_xlat16_23) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb22 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb22){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb18.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb18.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat22 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat22 = vs_TEXCOORD3.z * 17.0 + (-u_xlat22);
            u_xlat22 = u_xlat22 + 0.99000001;
            u_xlat22 = floor(u_xlat22);
            u_xlat22 = max(u_xlat22, 0.0);
            u_xlati22 = int(u_xlat22);
            if((u_xlati22)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.5<_lightProbToggle);
#else
    u_xlatb22 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
uvec2 u_xlatu4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
ivec3 u_xlati7;
float u_xlat8;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat7.z = max(u_xlat21, 0.0);
    u_xlat16_9.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_9.x = u_xlat16_9.x * 0.5 + (-_SecondShadow);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlati22 = int(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_9.xyz = (int(u_xlati22) != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.xz = ivec2(u_xlat7.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati7.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati7.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati7.z != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat5.xyz = u_xlat7.xxx * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat6.xyz = u_xlat7.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb21 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat7.xxx + _CustomLightDir.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb21)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_23 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _Shininess;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_7 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_7 = (-u_xlat16_23) + u_xlat16_7;
    u_xlat7.x = u_xlat16_7 + 1.0;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.x = int(u_xlat7.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
            u_xlat16_23 = log2(u_xlat16_23);
            u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
            u_xlat16_23 = exp2(u_xlat16_23);
            u_xlat16_23 = (u_xlatb0) ? u_xlat16_23 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
                u_xlat16_23 = log2(u_xlat16_23);
                u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
                u_xlat16_23 = exp2(u_xlat16_23);
                u_xlat16_23 = (-u_xlat16_23) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb22 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb22){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb18.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb18.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat22 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat22 = vs_TEXCOORD3.z * 17.0 + (-u_xlat22);
            u_xlat22 = u_xlat22 + 0.99000001;
            u_xlat22 = floor(u_xlat22);
            u_xlat22 = max(u_xlat22, 0.0);
            u_xlati22 = int(u_xlat22);
            if((u_xlati22)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.5<_lightProbToggle);
#else
    u_xlatb22 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
uvec2 u_xlatu4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
ivec3 u_xlati7;
float u_xlat8;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat7.z = max(u_xlat21, 0.0);
    u_xlat16_9.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_9.x = u_xlat16_9.x * 0.5 + (-_SecondShadow);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlati22 = int(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_9.xyz = (int(u_xlati22) != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.xz = ivec2(u_xlat7.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati7.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati7.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati7.z != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat5.xyz = u_xlat7.xxx * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat6.xyz = u_xlat7.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb21 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat7.xxx + _CustomLightDir.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb21)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_23 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _Shininess;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_7 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_7 = (-u_xlat16_23) + u_xlat16_7;
    u_xlat7.x = u_xlat16_7 + 1.0;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.x = int(u_xlat7.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
            u_xlat16_23 = log2(u_xlat16_23);
            u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
            u_xlat16_23 = exp2(u_xlat16_23);
            u_xlat16_23 = (u_xlatb0) ? u_xlat16_23 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
                u_xlat16_23 = log2(u_xlat16_23);
                u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
                u_xlat16_23 = exp2(u_xlat16_23);
                u_xlat16_23 = (-u_xlat16_23) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb22 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb22){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb18.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb18.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat22 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat22 = vs_TEXCOORD3.z * 17.0 + (-u_xlat22);
            u_xlat22 = u_xlat22 + 0.99000001;
            u_xlat22 = floor(u_xlat22);
            u_xlat22 = max(u_xlat22, 0.0);
            u_xlati22 = int(u_xlat22);
            if((u_xlati22)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.5<_lightProbToggle);
#else
    u_xlatb22 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
uvec2 u_xlatu4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
ivec3 u_xlati7;
float u_xlat8;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat7.z = max(u_xlat21, 0.0);
    u_xlat16_9.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_9.x = u_xlat16_9.x * 0.5 + (-_SecondShadow);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlati22 = int(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_9.xyz = (int(u_xlati22) != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.xz = ivec2(u_xlat7.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati7.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati7.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati7.z != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat5.xyz = u_xlat7.xxx * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat6.xyz = u_xlat7.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb21 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat7.xxx + _CustomLightDir.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb21)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_23 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _Shininess;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_7 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_7 = (-u_xlat16_23) + u_xlat16_7;
    u_xlat7.x = u_xlat16_7 + 1.0;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.x = int(u_xlat7.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
            u_xlat16_23 = log2(u_xlat16_23);
            u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
            u_xlat16_23 = exp2(u_xlat16_23);
            u_xlat16_23 = (u_xlatb0) ? u_xlat16_23 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
                u_xlat16_23 = log2(u_xlat16_23);
                u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
                u_xlat16_23 = exp2(u_xlat16_23);
                u_xlat16_23 = (-u_xlat16_23) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb22 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb22){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb18.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb18.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat22 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat22 = vs_TEXCOORD3.z * 17.0 + (-u_xlat22);
            u_xlat22 = u_xlat22 + 0.99000001;
            u_xlat22 = floor(u_xlat22);
            u_xlat22 = max(u_xlat22, 0.0);
            u_xlati22 = int(u_xlat22);
            if((u_xlati22)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.5<_lightProbToggle);
#else
    u_xlatb22 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
uvec2 u_xlatu4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
ivec3 u_xlati7;
float u_xlat8;
mediump vec3 u_xlat16_9;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
int u_xlati22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat21 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat21 = floor(u_xlat21);
    u_xlat7.z = max(u_xlat21, 0.0);
    u_xlat16_9.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_9.x = u_xlat16_9.x * 0.5 + (-_SecondShadow);
    u_xlat16_9.x = u_xlat16_9.x + 1.0;
    u_xlat16_9.x = floor(u_xlat16_9.x);
    u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
    u_xlati22 = int(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_9.xyz = (int(u_xlati22) != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.xz = ivec2(u_xlat7.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati7.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati7.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati7.z != 0) ? u_xlat16_3.xyz : u_xlat16_9.xyz;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat5.xyz = u_xlat7.xxx * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat6.xyz = u_xlat7.xxx * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb21 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * u_xlat7.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat7.xxx + _CustomLightDir.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb21)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_23 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat16_23 = log2(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * _Shininess;
    u_xlat16_23 = exp2(u_xlat16_23);
    u_xlat16_7 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_7 = (-u_xlat16_23) + u_xlat16_7;
    u_xlat7.x = u_xlat16_7 + 1.0;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlati7.x = int(u_xlat7.x);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (u_xlati7.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
            u_xlat16_23 = log2(u_xlat16_23);
            u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
            u_xlat16_23 = exp2(u_xlat16_23);
            u_xlat16_23 = (u_xlatb0) ? u_xlat16_23 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_23 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_23 = max(u_xlat16_23, 0.0);
        u_xlat16_3.x = (-u_xlat16_23) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_23<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_23<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_23 = u_xlat16_23 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_23 = u_xlat16_23 / u_xlat16_3.x;
                u_xlat16_23 = log2(u_xlat16_23);
                u_xlat16_23 = u_xlat16_23 * _ModifySpecPower;
                u_xlat16_23 = exp2(u_xlat16_23);
                u_xlat16_23 = (-u_xlat16_23) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb22 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb22){
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb22 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb22){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb18.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb18.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat22 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat22 = vs_TEXCOORD3.z * 17.0 + (-u_xlat22);
            u_xlat22 = u_xlat22 + 0.99000001;
            u_xlat22 = floor(u_xlat22);
            u_xlat22 = max(u_xlat22, 0.0);
            u_xlati22 = int(u_xlat22);
            if((u_xlati22)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.5<_lightProbToggle);
#else
    u_xlatb22 = 0.5<_lightProbToggle;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb22)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_23 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_23 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat8;
vec2 u_xlat9;
bvec2 u_xlatb23;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
float u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
int u_xlati25;
bool u_xlatb25;
bool u_xlatb26;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_24 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_24) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_27 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat24 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat24 = floor(u_xlat24);
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlati24 = int(u_xlat24);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat8 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat8 = floor(u_xlat8);
    u_xlat1.x = max(u_xlat8, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat9.xy = vec2(u_xlat16_27) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_27 = (u_xlati1 != 0) ? u_xlat9.y : u_xlat9.x;
    u_xlat16_27 = u_xlat16_27 + vs_COLOR1;
    u_xlat16_28 = u_xlat16_27 * 0.5 + (-_LightArea);
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati1 = int(u_xlat16_28);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb26 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + (-_WorldSpaceLightPos0.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat25) + _CustomLightDir.xyz;
    u_xlat16_28 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb26)) ? u_xlat16_5.xyz : u_xlat7.xyz;
    u_xlat16_28 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_25 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_25 = (-u_xlat16_28) + u_xlat16_25;
    u_xlat25 = u_xlat16_25 + 1.0;
    u_xlat25 = floor(u_xlat25);
    u_xlat25 = max(u_xlat25, 0.0);
    u_xlati25 = int(u_xlat25);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati25) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_ModifySpec==0.0);
#else
    u_xlatb25 = _ModifySpec==0.0;
#endif
    if(u_xlatb25){
        u_xlat16_28 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_28 = max(u_xlat16_28, 0.0);
        u_xlat16_5.x = (-u_xlat16_28) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati25 = int(u_xlat16_5.x);
        if(u_xlati25 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb25 = !!(u_xlat16_28<_MaxSpecGradient);
#else
            u_xlatb25 = u_xlat16_28<_MaxSpecGradient;
#endif
            u_xlat16_28 = u_xlat16_28 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_28 = u_xlat16_28 / u_xlat16_5.x;
            u_xlat16_28 = log2(u_xlat16_28);
            u_xlat16_28 = u_xlat16_28 * _ModifySpecPower;
            u_xlat16_28 = exp2(u_xlat16_28);
            u_xlat16_28 = (u_xlatb25) ? u_xlat16_28 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_25 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_2.xyz = vec3(u_xlat10_25) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_28 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_28 = max(u_xlat16_28, 0.0);
        u_xlat16_5.x = (-u_xlat16_28) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati25 = int(u_xlat16_5.x);
        if(u_xlati25 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb25 = !!(u_xlat16_28<_MaxSpecGradient);
#else
            u_xlatb25 = u_xlat16_28<_MaxSpecGradient;
#endif
            if(u_xlatb25){
                u_xlat16_28 = u_xlat16_28 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_28 = u_xlat16_28 / u_xlat16_5.x;
                u_xlat16_28 = log2(u_xlat16_28);
                u_xlat16_28 = u_xlat16_28 * _ModifySpecPower;
                u_xlat16_28 = exp2(u_xlat16_28);
                u_xlat16_28 = (-u_xlat16_28) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_25 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_2.xyz = vec3(u_xlat10_25) * u_xlat16_5.xyz;
                u_xlat16_2.xyz = u_xlat16_2.xyz;
            } else {
                u_xlat16_2.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_2.x = float(1.0);
            u_xlat16_2.y = float(1.0);
            u_xlat16_2.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb25 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb25){
#ifdef UNITY_ADRENO_ES3
        u_xlatb25 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb25 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb25){
            u_xlat7.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat7.xy = u_xlat7.xy * _ScreenParams.yx;
            u_xlat7.xy = u_xlat7.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat7.xyxy, (-u_xlat7.xyxy)).xy;
            u_xlat7.xy = fract(abs(u_xlat7.xy));
            u_xlat7.x = (u_xlatb23.x) ? u_xlat7.x : (-u_xlat7.x);
            u_xlat7.y = (u_xlatb23.y) ? u_xlat7.y : (-u_xlat7.y);
            u_xlat7.xy = u_xlat7.xy * vec2(4.0, 4.0);
            u_xlatu7.xy = uvec2(u_xlat7.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat25 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu7.x)]);
            u_xlat25 = vs_TEXCOORD3.z * 17.0 + (-u_xlat25);
            u_xlat25 = u_xlat25 + 0.99000001;
            u_xlat25 = floor(u_xlat25);
            u_xlat25 = max(u_xlat25, 0.0);
            u_xlati25 = int(u_xlat25);
            if((u_xlati25)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_5.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.5<_lightProbToggle);
#else
    u_xlatb25 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb25)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_28 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat16_28 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = u_xlat9.xxx * u_xlat1.xzw + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat8;
vec2 u_xlat9;
bvec2 u_xlatb23;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
float u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
int u_xlati25;
bool u_xlatb25;
bool u_xlatb26;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_24 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_24) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_27 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat24 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat24 = floor(u_xlat24);
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlati24 = int(u_xlat24);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat8 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat8 = floor(u_xlat8);
    u_xlat1.x = max(u_xlat8, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat9.xy = vec2(u_xlat16_27) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_27 = (u_xlati1 != 0) ? u_xlat9.y : u_xlat9.x;
    u_xlat16_27 = u_xlat16_27 + vs_COLOR1;
    u_xlat16_28 = u_xlat16_27 * 0.5 + (-_LightArea);
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati1 = int(u_xlat16_28);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb26 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + (-_WorldSpaceLightPos0.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat25) + _CustomLightDir.xyz;
    u_xlat16_28 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb26)) ? u_xlat16_5.xyz : u_xlat7.xyz;
    u_xlat16_28 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_25 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_25 = (-u_xlat16_28) + u_xlat16_25;
    u_xlat25 = u_xlat16_25 + 1.0;
    u_xlat25 = floor(u_xlat25);
    u_xlat25 = max(u_xlat25, 0.0);
    u_xlati25 = int(u_xlat25);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati25) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_ModifySpec==0.0);
#else
    u_xlatb25 = _ModifySpec==0.0;
#endif
    if(u_xlatb25){
        u_xlat16_28 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_28 = max(u_xlat16_28, 0.0);
        u_xlat16_5.x = (-u_xlat16_28) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati25 = int(u_xlat16_5.x);
        if(u_xlati25 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb25 = !!(u_xlat16_28<_MaxSpecGradient);
#else
            u_xlatb25 = u_xlat16_28<_MaxSpecGradient;
#endif
            u_xlat16_28 = u_xlat16_28 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_28 = u_xlat16_28 / u_xlat16_5.x;
            u_xlat16_28 = log2(u_xlat16_28);
            u_xlat16_28 = u_xlat16_28 * _ModifySpecPower;
            u_xlat16_28 = exp2(u_xlat16_28);
            u_xlat16_28 = (u_xlatb25) ? u_xlat16_28 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_25 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_2.xyz = vec3(u_xlat10_25) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_28 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_28 = max(u_xlat16_28, 0.0);
        u_xlat16_5.x = (-u_xlat16_28) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati25 = int(u_xlat16_5.x);
        if(u_xlati25 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb25 = !!(u_xlat16_28<_MaxSpecGradient);
#else
            u_xlatb25 = u_xlat16_28<_MaxSpecGradient;
#endif
            if(u_xlatb25){
                u_xlat16_28 = u_xlat16_28 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_28 = u_xlat16_28 / u_xlat16_5.x;
                u_xlat16_28 = log2(u_xlat16_28);
                u_xlat16_28 = u_xlat16_28 * _ModifySpecPower;
                u_xlat16_28 = exp2(u_xlat16_28);
                u_xlat16_28 = (-u_xlat16_28) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_25 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_2.xyz = vec3(u_xlat10_25) * u_xlat16_5.xyz;
                u_xlat16_2.xyz = u_xlat16_2.xyz;
            } else {
                u_xlat16_2.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_2.x = float(1.0);
            u_xlat16_2.y = float(1.0);
            u_xlat16_2.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb25 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb25){
#ifdef UNITY_ADRENO_ES3
        u_xlatb25 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb25 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb25){
            u_xlat7.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat7.xy = u_xlat7.xy * _ScreenParams.yx;
            u_xlat7.xy = u_xlat7.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat7.xyxy, (-u_xlat7.xyxy)).xy;
            u_xlat7.xy = fract(abs(u_xlat7.xy));
            u_xlat7.x = (u_xlatb23.x) ? u_xlat7.x : (-u_xlat7.x);
            u_xlat7.y = (u_xlatb23.y) ? u_xlat7.y : (-u_xlat7.y);
            u_xlat7.xy = u_xlat7.xy * vec2(4.0, 4.0);
            u_xlatu7.xy = uvec2(u_xlat7.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat25 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu7.x)]);
            u_xlat25 = vs_TEXCOORD3.z * 17.0 + (-u_xlat25);
            u_xlat25 = u_xlat25 + 0.99000001;
            u_xlat25 = floor(u_xlat25);
            u_xlat25 = max(u_xlat25, 0.0);
            u_xlati25 = int(u_xlat25);
            if((u_xlati25)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_5.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.5<_lightProbToggle);
#else
    u_xlatb25 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb25)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_28 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat16_28 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = u_xlat9.xxx * u_xlat1.xzw + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat8;
vec2 u_xlat9;
bvec2 u_xlatb23;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
float u_xlat25;
mediump float u_xlat16_25;
lowp float u_xlat10_25;
int u_xlati25;
bool u_xlatb25;
bool u_xlatb26;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_24 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_24) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_27 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat24 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat24 = floor(u_xlat24);
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlati24 = int(u_xlat24);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat8 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat8 = floor(u_xlat8);
    u_xlat1.x = max(u_xlat8, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat9.xy = vec2(u_xlat16_27) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_27 = (u_xlati1 != 0) ? u_xlat9.y : u_xlat9.x;
    u_xlat16_27 = u_xlat16_27 + vs_COLOR1;
    u_xlat16_28 = u_xlat16_27 * 0.5 + (-_LightArea);
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati1 = int(u_xlat16_28);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat6.xyz = vec3(u_xlat25) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb26 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + (-_WorldSpaceLightPos0.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat25) + _CustomLightDir.xyz;
    u_xlat16_28 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb26)) ? u_xlat16_5.xyz : u_xlat7.xyz;
    u_xlat16_28 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_25 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_25 = (-u_xlat16_28) + u_xlat16_25;
    u_xlat25 = u_xlat16_25 + 1.0;
    u_xlat25 = floor(u_xlat25);
    u_xlat25 = max(u_xlat25, 0.0);
    u_xlati25 = int(u_xlat25);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati25) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_ModifySpec==0.0);
#else
    u_xlatb25 = _ModifySpec==0.0;
#endif
    if(u_xlatb25){
        u_xlat16_28 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_28 = max(u_xlat16_28, 0.0);
        u_xlat16_5.x = (-u_xlat16_28) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati25 = int(u_xlat16_5.x);
        if(u_xlati25 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb25 = !!(u_xlat16_28<_MaxSpecGradient);
#else
            u_xlatb25 = u_xlat16_28<_MaxSpecGradient;
#endif
            u_xlat16_28 = u_xlat16_28 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_28 = u_xlat16_28 / u_xlat16_5.x;
            u_xlat16_28 = log2(u_xlat16_28);
            u_xlat16_28 = u_xlat16_28 * _ModifySpecPower;
            u_xlat16_28 = exp2(u_xlat16_28);
            u_xlat16_28 = (u_xlatb25) ? u_xlat16_28 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_25 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_2.xyz = vec3(u_xlat10_25) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_28 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_28 = max(u_xlat16_28, 0.0);
        u_xlat16_5.x = (-u_xlat16_28) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati25 = int(u_xlat16_5.x);
        if(u_xlati25 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb25 = !!(u_xlat16_28<_MaxSpecGradient);
#else
            u_xlatb25 = u_xlat16_28<_MaxSpecGradient;
#endif
            if(u_xlatb25){
                u_xlat16_28 = u_xlat16_28 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_28 = u_xlat16_28 / u_xlat16_5.x;
                u_xlat16_28 = log2(u_xlat16_28);
                u_xlat16_28 = u_xlat16_28 * _ModifySpecPower;
                u_xlat16_28 = exp2(u_xlat16_28);
                u_xlat16_28 = (-u_xlat16_28) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_25 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_2.xyz = vec3(u_xlat10_25) * u_xlat16_5.xyz;
                u_xlat16_2.xyz = u_xlat16_2.xyz;
            } else {
                u_xlat16_2.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_2.x = float(1.0);
            u_xlat16_2.y = float(1.0);
            u_xlat16_2.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb25 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb25){
#ifdef UNITY_ADRENO_ES3
        u_xlatb25 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb25 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb25){
            u_xlat7.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat7.xy = u_xlat7.xy * _ScreenParams.yx;
            u_xlat7.xy = u_xlat7.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat7.xyxy, (-u_xlat7.xyxy)).xy;
            u_xlat7.xy = fract(abs(u_xlat7.xy));
            u_xlat7.x = (u_xlatb23.x) ? u_xlat7.x : (-u_xlat7.x);
            u_xlat7.y = (u_xlatb23.y) ? u_xlat7.y : (-u_xlat7.y);
            u_xlat7.xy = u_xlat7.xy * vec2(4.0, 4.0);
            u_xlatu7.xy = uvec2(u_xlat7.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat25 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu7.x)]);
            u_xlat25 = vs_TEXCOORD3.z * 17.0 + (-u_xlat25);
            u_xlat25 = u_xlat25 + 0.99000001;
            u_xlat25 = floor(u_xlat25);
            u_xlat25 = max(u_xlat25, 0.0);
            u_xlati25 = int(u_xlat25);
            if((u_xlati25)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_5.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(0.5<_lightProbToggle);
#else
    u_xlatb25 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb25)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_28 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat16_28 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = u_xlat9.xxx * u_xlat1.xzw + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
ivec3 u_xlati11;
float u_xlat12;
mediump vec3 u_xlat16_18;
bvec2 u_xlatb24;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb33 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat11.xxx + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb33)) ? u_xlat16_8.xyz : u_xlat4.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_11 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_11 = (-u_xlat16_40) + u_xlat16_11;
    u_xlat11.x = u_xlat16_11 + 1.0;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.x = int(u_xlat11.x);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xyz * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb24.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb24.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb24.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat34 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_8.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_40 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat16_40 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
ivec3 u_xlati11;
float u_xlat12;
mediump vec3 u_xlat16_18;
bvec2 u_xlatb24;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb33 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat11.xxx + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb33)) ? u_xlat16_8.xyz : u_xlat4.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_11 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_11 = (-u_xlat16_40) + u_xlat16_11;
    u_xlat11.x = u_xlat16_11 + 1.0;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.x = int(u_xlat11.x);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xyz * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb24.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb24.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb24.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat34 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_8.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_40 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat16_40 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
ivec3 u_xlati11;
float u_xlat12;
mediump vec3 u_xlat16_18;
bvec2 u_xlatb24;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat11.xxx * u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb33 = 0.5<_CustomLightDir.w;
#endif
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceLightPos0.xyz);
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat11.xxx + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb33)) ? u_xlat16_8.xyz : u_xlat4.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_11 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_11 = (-u_xlat16_40) + u_xlat16_11;
    u_xlat11.x = u_xlat16_11 + 1.0;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.x = int(u_xlat11.x);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xyz * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xyz = u_xlat16_0.xyz;
            } else {
                u_xlat16_0.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.y = float(1.0);
            u_xlat16_0.z = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb24.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb24.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb24.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat34 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_8.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_40 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat16_40 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
uvec2 u_xlatu5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
ivec3 u_xlati9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
float u_xlat18;
mediump float u_xlat16_18;
int u_xlati18;
bvec2 u_xlatb23;
float u_xlat27;
float u_xlat28;
int u_xlati28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat27 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat27 = floor(u_xlat27);
    u_xlat9.z = max(u_xlat27, 0.0);
    u_xlat16_11.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_11.x = u_xlat16_11.x * 0.5 + (-_SecondShadow);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati28 = int(u_xlat16_11.x);
    u_xlat16_11.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_11.xyz = (int(u_xlati28) != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat9.x = floor(u_xlat9.x);
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlati9.xz = ivec2(u_xlat9.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati9.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati9.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati9.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati9.z != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat1.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat9.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb28 = 0.5<_CustomLightDir.w;
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat27) + (-_WorldSpaceLightPos0.xyz);
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat27) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb28)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_29 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_18 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_18 = (-u_xlat16_29) + u_xlat16_18;
    u_xlat18 = u_xlat16_18 + 1.0;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
            u_xlat16_29 = log2(u_xlat16_29);
            u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
            u_xlat16_29 = exp2(u_xlat16_29);
            u_xlat16_29 = (u_xlatb0) ? u_xlat16_29 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_29) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
                u_xlat16_29 = log2(u_xlat16_29);
                u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
                u_xlat16_29 = exp2(u_xlat16_29);
                u_xlat16_29 = (-u_xlat16_29) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb28 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb28){
#ifdef UNITY_ADRENO_ES3
        u_xlatb28 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb28 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb28){
            u_xlat5.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat5.xy = u_xlat5.xy * _ScreenParams.yx;
            u_xlat5.xy = u_xlat5.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat5.xyxy, (-u_xlat5.xyxy)).xy;
            u_xlat5.xy = fract(abs(u_xlat5.xy));
            u_xlat5.x = (u_xlatb23.x) ? u_xlat5.x : (-u_xlat5.x);
            u_xlat5.y = (u_xlatb23.y) ? u_xlat5.y : (-u_xlat5.y);
            u_xlat5.xy = u_xlat5.xy * vec2(4.0, 4.0);
            u_xlatu5.xy = uvec2(u_xlat5.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat28 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu5.x)]);
            u_xlat28 = vs_TEXCOORD3.z * 17.0 + (-u_xlat28);
            u_xlat28 = u_xlat28 + 0.99000001;
            u_xlat28 = floor(u_xlat28);
            u_xlat28 = max(u_xlat28, 0.0);
            u_xlati28 = int(u_xlat28);
            if((u_xlati28)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_29 = u_xlat10_6.x * 1.99000001;
    u_xlat28 = u_xlat16_29 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat4.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_7.xyz;
    u_xlat4.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat4.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat28 = u_xlat4.x * 1.70000005 + (-u_xlat28);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat4.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat28 = u_xlat28 * u_xlat4.x + _BloomFactor;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat16_29 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat28;
    u_xlat28 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_29 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
uvec2 u_xlatu5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
ivec3 u_xlati9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
float u_xlat18;
mediump float u_xlat16_18;
int u_xlati18;
bvec2 u_xlatb23;
float u_xlat27;
float u_xlat28;
int u_xlati28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat27 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat27 = floor(u_xlat27);
    u_xlat9.z = max(u_xlat27, 0.0);
    u_xlat16_11.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_11.x = u_xlat16_11.x * 0.5 + (-_SecondShadow);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati28 = int(u_xlat16_11.x);
    u_xlat16_11.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_11.xyz = (int(u_xlati28) != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat9.x = floor(u_xlat9.x);
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlati9.xz = ivec2(u_xlat9.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati9.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati9.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati9.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati9.z != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat1.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat9.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb28 = 0.5<_CustomLightDir.w;
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat27) + (-_WorldSpaceLightPos0.xyz);
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat27) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb28)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_29 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_18 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_18 = (-u_xlat16_29) + u_xlat16_18;
    u_xlat18 = u_xlat16_18 + 1.0;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
            u_xlat16_29 = log2(u_xlat16_29);
            u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
            u_xlat16_29 = exp2(u_xlat16_29);
            u_xlat16_29 = (u_xlatb0) ? u_xlat16_29 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_29) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
                u_xlat16_29 = log2(u_xlat16_29);
                u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
                u_xlat16_29 = exp2(u_xlat16_29);
                u_xlat16_29 = (-u_xlat16_29) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb28 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb28){
#ifdef UNITY_ADRENO_ES3
        u_xlatb28 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb28 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb28){
            u_xlat5.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat5.xy = u_xlat5.xy * _ScreenParams.yx;
            u_xlat5.xy = u_xlat5.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat5.xyxy, (-u_xlat5.xyxy)).xy;
            u_xlat5.xy = fract(abs(u_xlat5.xy));
            u_xlat5.x = (u_xlatb23.x) ? u_xlat5.x : (-u_xlat5.x);
            u_xlat5.y = (u_xlatb23.y) ? u_xlat5.y : (-u_xlat5.y);
            u_xlat5.xy = u_xlat5.xy * vec2(4.0, 4.0);
            u_xlatu5.xy = uvec2(u_xlat5.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat28 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu5.x)]);
            u_xlat28 = vs_TEXCOORD3.z * 17.0 + (-u_xlat28);
            u_xlat28 = u_xlat28 + 0.99000001;
            u_xlat28 = floor(u_xlat28);
            u_xlat28 = max(u_xlat28, 0.0);
            u_xlati28 = int(u_xlat28);
            if((u_xlati28)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_29 = u_xlat10_6.x * 1.99000001;
    u_xlat28 = u_xlat16_29 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat4.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_7.xyz;
    u_xlat4.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat4.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat28 = u_xlat4.x * 1.70000005 + (-u_xlat28);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat4.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat28 = u_xlat28 * u_xlat4.x + _BloomFactor;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat16_29 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat28;
    u_xlat28 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_29 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
uvec2 u_xlatu5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
ivec3 u_xlati9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
float u_xlat18;
mediump float u_xlat16_18;
int u_xlati18;
bvec2 u_xlatb23;
float u_xlat27;
float u_xlat28;
int u_xlati28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat27 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat27 = floor(u_xlat27);
    u_xlat9.z = max(u_xlat27, 0.0);
    u_xlat16_11.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_11.x = u_xlat16_11.x * 0.5 + (-_SecondShadow);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati28 = int(u_xlat16_11.x);
    u_xlat16_11.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_11.xyz = (int(u_xlati28) != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat9.x = floor(u_xlat9.x);
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlati9.xz = ivec2(u_xlat9.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati9.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati9.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati9.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati9.z != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat1.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat9.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb28 = 0.5<_CustomLightDir.w;
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat27) + (-_WorldSpaceLightPos0.xyz);
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat27) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb28)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_29 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_18 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_18 = (-u_xlat16_29) + u_xlat16_18;
    u_xlat18 = u_xlat16_18 + 1.0;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
            u_xlat16_29 = log2(u_xlat16_29);
            u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
            u_xlat16_29 = exp2(u_xlat16_29);
            u_xlat16_29 = (u_xlatb0) ? u_xlat16_29 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_29) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
                u_xlat16_29 = log2(u_xlat16_29);
                u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
                u_xlat16_29 = exp2(u_xlat16_29);
                u_xlat16_29 = (-u_xlat16_29) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb28 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb28){
#ifdef UNITY_ADRENO_ES3
        u_xlatb28 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb28 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb28){
            u_xlat5.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat5.xy = u_xlat5.xy * _ScreenParams.yx;
            u_xlat5.xy = u_xlat5.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat5.xyxy, (-u_xlat5.xyxy)).xy;
            u_xlat5.xy = fract(abs(u_xlat5.xy));
            u_xlat5.x = (u_xlatb23.x) ? u_xlat5.x : (-u_xlat5.x);
            u_xlat5.y = (u_xlatb23.y) ? u_xlat5.y : (-u_xlat5.y);
            u_xlat5.xy = u_xlat5.xy * vec2(4.0, 4.0);
            u_xlatu5.xy = uvec2(u_xlat5.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat28 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu5.x)]);
            u_xlat28 = vs_TEXCOORD3.z * 17.0 + (-u_xlat28);
            u_xlat28 = u_xlat28 + 0.99000001;
            u_xlat28 = floor(u_xlat28);
            u_xlat28 = max(u_xlat28, 0.0);
            u_xlati28 = int(u_xlat28);
            if((u_xlati28)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_29 = u_xlat10_6.x * 1.99000001;
    u_xlat28 = u_xlat16_29 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat4.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_7.xyz;
    u_xlat4.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat4.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat28 = u_xlat4.x * 1.70000005 + (-u_xlat28);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat4.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat28 = u_xlat28 * u_xlat4.x + _BloomFactor;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat16_29 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat28;
    u_xlat28 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_29 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
uvec2 u_xlatu5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
ivec3 u_xlati9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
float u_xlat18;
mediump float u_xlat16_18;
int u_xlati18;
bvec2 u_xlatb23;
float u_xlat27;
float u_xlat28;
int u_xlati28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat27 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat27 = floor(u_xlat27);
    u_xlat9.z = max(u_xlat27, 0.0);
    u_xlat16_11.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_11.x = u_xlat16_11.x * 0.5 + (-_SecondShadow);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati28 = int(u_xlat16_11.x);
    u_xlat16_11.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_11.xyz = (int(u_xlati28) != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat9.x = floor(u_xlat9.x);
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlati9.xz = ivec2(u_xlat9.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati9.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati9.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati9.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati9.z != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat1.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat9.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb28 = 0.5<_CustomLightDir.w;
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat27) + (-_WorldSpaceLightPos0.xyz);
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat27) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb28)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_29 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_18 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_18 = (-u_xlat16_29) + u_xlat16_18;
    u_xlat18 = u_xlat16_18 + 1.0;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
            u_xlat16_29 = log2(u_xlat16_29);
            u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
            u_xlat16_29 = exp2(u_xlat16_29);
            u_xlat16_29 = (u_xlatb0) ? u_xlat16_29 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_29) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
                u_xlat16_29 = log2(u_xlat16_29);
                u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
                u_xlat16_29 = exp2(u_xlat16_29);
                u_xlat16_29 = (-u_xlat16_29) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb28 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb28){
#ifdef UNITY_ADRENO_ES3
        u_xlatb28 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb28 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb28){
            u_xlat5.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat5.xy = u_xlat5.xy * _ScreenParams.yx;
            u_xlat5.xy = u_xlat5.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat5.xyxy, (-u_xlat5.xyxy)).xy;
            u_xlat5.xy = fract(abs(u_xlat5.xy));
            u_xlat5.x = (u_xlatb23.x) ? u_xlat5.x : (-u_xlat5.x);
            u_xlat5.y = (u_xlatb23.y) ? u_xlat5.y : (-u_xlat5.y);
            u_xlat5.xy = u_xlat5.xy * vec2(4.0, 4.0);
            u_xlatu5.xy = uvec2(u_xlat5.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat28 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu5.x)]);
            u_xlat28 = vs_TEXCOORD3.z * 17.0 + (-u_xlat28);
            u_xlat28 = u_xlat28 + 0.99000001;
            u_xlat28 = floor(u_xlat28);
            u_xlat28 = max(u_xlat28, 0.0);
            u_xlati28 = int(u_xlat28);
            if((u_xlati28)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_29 = u_xlat10_6.x * 1.99000001;
    u_xlat28 = u_xlat16_29 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat4.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_7.xyz;
    u_xlat4.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat4.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat28 = u_xlat4.x * 1.70000005 + (-u_xlat28);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat4.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat28 = u_xlat28 * u_xlat4.x + _BloomFactor;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat16_29 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat28;
    u_xlat28 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_29 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
uvec2 u_xlatu5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
ivec3 u_xlati9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
float u_xlat18;
mediump float u_xlat16_18;
int u_xlati18;
bvec2 u_xlatb23;
float u_xlat27;
float u_xlat28;
int u_xlati28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat27 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat27 = floor(u_xlat27);
    u_xlat9.z = max(u_xlat27, 0.0);
    u_xlat16_11.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_11.x = u_xlat16_11.x * 0.5 + (-_SecondShadow);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati28 = int(u_xlat16_11.x);
    u_xlat16_11.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_11.xyz = (int(u_xlati28) != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat9.x = floor(u_xlat9.x);
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlati9.xz = ivec2(u_xlat9.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati9.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati9.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati9.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati9.z != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat1.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat9.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb28 = 0.5<_CustomLightDir.w;
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat27) + (-_WorldSpaceLightPos0.xyz);
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat27) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb28)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_29 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_18 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_18 = (-u_xlat16_29) + u_xlat16_18;
    u_xlat18 = u_xlat16_18 + 1.0;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
            u_xlat16_29 = log2(u_xlat16_29);
            u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
            u_xlat16_29 = exp2(u_xlat16_29);
            u_xlat16_29 = (u_xlatb0) ? u_xlat16_29 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_29) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
                u_xlat16_29 = log2(u_xlat16_29);
                u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
                u_xlat16_29 = exp2(u_xlat16_29);
                u_xlat16_29 = (-u_xlat16_29) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb28 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb28){
#ifdef UNITY_ADRENO_ES3
        u_xlatb28 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb28 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb28){
            u_xlat5.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat5.xy = u_xlat5.xy * _ScreenParams.yx;
            u_xlat5.xy = u_xlat5.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat5.xyxy, (-u_xlat5.xyxy)).xy;
            u_xlat5.xy = fract(abs(u_xlat5.xy));
            u_xlat5.x = (u_xlatb23.x) ? u_xlat5.x : (-u_xlat5.x);
            u_xlat5.y = (u_xlatb23.y) ? u_xlat5.y : (-u_xlat5.y);
            u_xlat5.xy = u_xlat5.xy * vec2(4.0, 4.0);
            u_xlatu5.xy = uvec2(u_xlat5.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat28 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu5.x)]);
            u_xlat28 = vs_TEXCOORD3.z * 17.0 + (-u_xlat28);
            u_xlat28 = u_xlat28 + 0.99000001;
            u_xlat28 = floor(u_xlat28);
            u_xlat28 = max(u_xlat28, 0.0);
            u_xlati28 = int(u_xlat28);
            if((u_xlati28)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_29 = u_xlat10_6.x * 1.99000001;
    u_xlat28 = u_xlat16_29 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat4.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_7.xyz;
    u_xlat4.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat4.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat28 = u_xlat4.x * 1.70000005 + (-u_xlat28);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat4.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat28 = u_xlat28 * u_xlat4.x + _BloomFactor;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat16_29 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat28;
    u_xlat28 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_29 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
uvec2 u_xlatu5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
ivec3 u_xlati9;
mediump vec3 u_xlat16_11;
vec2 u_xlat13;
ivec2 u_xlati13;
float u_xlat18;
mediump float u_xlat16_18;
int u_xlati18;
bvec2 u_xlatb23;
float u_xlat27;
float u_xlat28;
int u_xlati28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat27 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat27 = floor(u_xlat27);
    u_xlat9.z = max(u_xlat27, 0.0);
    u_xlat16_11.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_11.x = u_xlat16_11.x * 0.5 + (-_SecondShadow);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati28 = int(u_xlat16_11.x);
    u_xlat16_11.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_11.xyz = (int(u_xlati28) != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat9.x = floor(u_xlat9.x);
    u_xlat9.x = max(u_xlat9.x, 0.0);
    u_xlati9.xz = ivec2(u_xlat9.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati9.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati9.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati9.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati9.z != 0) ? u_xlat16_3.xyz : u_xlat16_11.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat1.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat9.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb28 = 0.5<_CustomLightDir.w;
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat27) + (-_WorldSpaceLightPos0.xyz);
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(u_xlat27) + _CustomLightDir.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb28)) ? u_xlat16_3.xyz : u_xlat6.xyz;
    u_xlat16_29 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = max(u_xlat16_29, 0.0);
    u_xlat16_29 = log2(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * _Shininess;
    u_xlat16_29 = exp2(u_xlat16_29);
    u_xlat16_18 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_18 = (-u_xlat16_29) + u_xlat16_18;
    u_xlat18 = u_xlat16_18 + 1.0;
    u_xlat18 = floor(u_xlat18);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlati18 = int(u_xlat18);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati18) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
            u_xlat16_29 = log2(u_xlat16_29);
            u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
            u_xlat16_29 = exp2(u_xlat16_29);
            u_xlat16_29 = (u_xlatb0) ? u_xlat16_29 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_29) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_29 = dot(u_xlat1.xyz, u_xlat6.xyz);
        u_xlat16_29 = max(u_xlat16_29, 0.0);
        u_xlat16_3.x = (-u_xlat16_29) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_29<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_29<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_29 = u_xlat16_29 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_29 = u_xlat16_29 / u_xlat16_3.x;
                u_xlat16_29 = log2(u_xlat16_29);
                u_xlat16_29 = u_xlat16_29 * _ModifySpecPower;
                u_xlat16_29 = exp2(u_xlat16_29);
                u_xlat16_29 = (-u_xlat16_29) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_29) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb28 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb28){
#ifdef UNITY_ADRENO_ES3
        u_xlatb28 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb28 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb28){
            u_xlat5.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat5.xy = u_xlat5.xy * _ScreenParams.yx;
            u_xlat5.xy = u_xlat5.xy * vec2(0.25, 0.25);
            u_xlatb23.xy = greaterThanEqual(u_xlat5.xyxy, (-u_xlat5.xyxy)).xy;
            u_xlat5.xy = fract(abs(u_xlat5.xy));
            u_xlat5.x = (u_xlatb23.x) ? u_xlat5.x : (-u_xlat5.x);
            u_xlat5.y = (u_xlatb23.y) ? u_xlat5.y : (-u_xlat5.y);
            u_xlat5.xy = u_xlat5.xy * vec2(4.0, 4.0);
            u_xlatu5.xy = uvec2(u_xlat5.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu5.y)]);
            u_xlat28 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu5.x)]);
            u_xlat28 = vs_TEXCOORD3.z * 17.0 + (-u_xlat28);
            u_xlat28 = u_xlat28 + 0.99000001;
            u_xlat28 = floor(u_xlat28);
            u_xlat28 = max(u_xlat28, 0.0);
            u_xlati28 = int(u_xlat28);
            if((u_xlati28)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_29 = u_xlat10_6.x * 1.99000001;
    u_xlat28 = u_xlat16_29 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat9.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat4.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_7.xyz;
    u_xlat4.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat4.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat28 = u_xlat4.x * 1.70000005 + (-u_xlat28);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat4.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat28 = u_xlat28 * u_xlat4.x + _BloomFactor;
    u_xlat16_7.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat16_29 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat28;
    u_xlat28 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati13.x != 0) ? u_xlat16_7.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_29 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) + u_xlat16_7.xyz;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
uvec2 u_xlatu7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec2 u_xlat11;
float u_xlat22;
bvec2 u_xlatb27;
float u_xlat30;
lowp float u_xlat10_30;
int u_xlati30;
float u_xlat31;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
int u_xlati32;
bool u_xlatb32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
bool u_xlatb36;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_30 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_30) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_33 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlati30 = int(u_xlat30);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat10 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10 = floor(u_xlat10);
    u_xlat1.x = max(u_xlat10, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat16_33) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_33 = (u_xlati1 != 0) ? u_xlat11.y : u_xlat11.x;
    u_xlat16_33 = u_xlat16_33 + vs_COLOR1;
    u_xlat16_34 = u_xlat16_33 * 0.5 + (-_LightArea);
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_34 = floor(u_xlat16_34);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlati1 = int(u_xlat16_34);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati30) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat31) + _WorldSpaceLightPos0.xyz;
    u_xlat32 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb36 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat32) + (-_WorldSpaceLightPos0.xyz);
    u_xlat32 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat32) + _CustomLightDir.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb36)) ? u_xlat16_5.xyz : u_xlat7.xyz;
    u_xlat16_34 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = log2(u_xlat16_34);
    u_xlat16_34 = u_xlat16_34 * _Shininess;
    u_xlat16_34 = exp2(u_xlat16_34);
    u_xlat16_32 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_32 = (-u_xlat16_34) + u_xlat16_32;
    u_xlat32 = u_xlat16_32 + 1.0;
    u_xlat32 = floor(u_xlat32);
    u_xlat32 = max(u_xlat32, 0.0);
    u_xlati32 = int(u_xlat32);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati32) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_ModifySpec==0.0);
#else
    u_xlatb32 = _ModifySpec==0.0;
#endif
    if(u_xlatb32){
        u_xlat16_34 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_34 = max(u_xlat16_34, 0.0);
        u_xlat16_5.x = (-u_xlat16_34) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati32 = int(u_xlat16_5.x);
        if(u_xlati32 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(u_xlat16_34<_MaxSpecGradient);
#else
            u_xlatb32 = u_xlat16_34<_MaxSpecGradient;
#endif
            u_xlat16_34 = u_xlat16_34 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_34 = u_xlat16_34 / u_xlat16_5.x;
            u_xlat16_34 = log2(u_xlat16_34);
            u_xlat16_34 = u_xlat16_34 * _ModifySpecPower;
            u_xlat16_34 = exp2(u_xlat16_34);
            u_xlat16_34 = (u_xlatb32) ? u_xlat16_34 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_32 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_6.xyz = vec3(u_xlat10_32) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_6.xyz * vec3(u_xlat16_34) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_34 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_34 = max(u_xlat16_34, 0.0);
        u_xlat16_5.x = (-u_xlat16_34) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati32 = int(u_xlat16_5.x);
        if(u_xlati32 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(u_xlat16_34<_MaxSpecGradient);
#else
            u_xlatb32 = u_xlat16_34<_MaxSpecGradient;
#endif
            if(u_xlatb32){
                u_xlat16_34 = u_xlat16_34 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_34 = u_xlat16_34 / u_xlat16_5.x;
                u_xlat16_34 = log2(u_xlat16_34);
                u_xlat16_34 = u_xlat16_34 * _ModifySpecPower;
                u_xlat16_34 = exp2(u_xlat16_34);
                u_xlat16_34 = (-u_xlat16_34) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_32 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_6.xyz = vec3(u_xlat10_32) * u_xlat16_5.xyz;
                u_xlat16_6.xyz = u_xlat16_6.xyz;
            } else {
                u_xlat16_6.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_6.x = float(1.0);
            u_xlat16_6.y = float(1.0);
            u_xlat16_6.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb32 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb32){
#ifdef UNITY_ADRENO_ES3
        u_xlatb32 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb32 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb32){
            u_xlat7.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat7.xy = u_xlat7.xy * _ScreenParams.yx;
            u_xlat7.xy = u_xlat7.xy * vec2(0.25, 0.25);
            u_xlatb27.xy = greaterThanEqual(u_xlat7.xyxy, (-u_xlat7.xyxy)).xy;
            u_xlat7.xy = fract(abs(u_xlat7.xy));
            u_xlat7.x = (u_xlatb27.x) ? u_xlat7.x : (-u_xlat7.x);
            u_xlat7.y = (u_xlatb27.y) ? u_xlat7.y : (-u_xlat7.y);
            u_xlat7.xy = u_xlat7.xy * vec2(4.0, 4.0);
            u_xlatu7.xy = uvec2(u_xlat7.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat32 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu7.x)]);
            u_xlat32 = vs_TEXCOORD3.z * 17.0 + (-u_xlat32);
            u_xlat32 = u_xlat32 + 0.99000001;
            u_xlat32 = floor(u_xlat32);
            u_xlat32 = max(u_xlat32, 0.0);
            u_xlati32 = int(u_xlat32);
            if((u_xlati32)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_34 = u_xlat10_8.x * 1.99000001;
    u_xlat32 = u_xlat16_34 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_5.xyz;
    u_xlat31 = _SPNoiseScaler * _SPTransition;
    u_xlat2.xy = vec2(u_xlat31) * vec2(1.70000005, 1.5) + (-vec2(u_xlat32));
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
    u_xlati2.xy = ivec2(u_xlat2.xy);
    u_xlat31 = u_xlat31 * 1.70000005 + (-u_xlat32);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat22 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat31 = u_xlat31 * u_xlat22 + _BloomFactor;
    u_xlat16_5.xyz = (u_xlati2.y != 0) ? u_xlat1.xyz : u_xlat7.xyz;
    u_xlat16_34 = (u_xlati2.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati2.x != 0) ? u_xlat16_5.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati2.x != 0) ? u_xlat16_34 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
uvec2 u_xlatu7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec2 u_xlat11;
float u_xlat22;
bvec2 u_xlatb27;
float u_xlat30;
lowp float u_xlat10_30;
int u_xlati30;
float u_xlat31;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
int u_xlati32;
bool u_xlatb32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
bool u_xlatb36;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_30 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_30) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_33 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlati30 = int(u_xlat30);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat10 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10 = floor(u_xlat10);
    u_xlat1.x = max(u_xlat10, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat16_33) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_33 = (u_xlati1 != 0) ? u_xlat11.y : u_xlat11.x;
    u_xlat16_33 = u_xlat16_33 + vs_COLOR1;
    u_xlat16_34 = u_xlat16_33 * 0.5 + (-_LightArea);
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_34 = floor(u_xlat16_34);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlati1 = int(u_xlat16_34);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati30) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat31) + _WorldSpaceLightPos0.xyz;
    u_xlat32 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb36 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat32) + (-_WorldSpaceLightPos0.xyz);
    u_xlat32 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat32) + _CustomLightDir.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb36)) ? u_xlat16_5.xyz : u_xlat7.xyz;
    u_xlat16_34 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = log2(u_xlat16_34);
    u_xlat16_34 = u_xlat16_34 * _Shininess;
    u_xlat16_34 = exp2(u_xlat16_34);
    u_xlat16_32 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_32 = (-u_xlat16_34) + u_xlat16_32;
    u_xlat32 = u_xlat16_32 + 1.0;
    u_xlat32 = floor(u_xlat32);
    u_xlat32 = max(u_xlat32, 0.0);
    u_xlati32 = int(u_xlat32);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati32) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_ModifySpec==0.0);
#else
    u_xlatb32 = _ModifySpec==0.0;
#endif
    if(u_xlatb32){
        u_xlat16_34 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_34 = max(u_xlat16_34, 0.0);
        u_xlat16_5.x = (-u_xlat16_34) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati32 = int(u_xlat16_5.x);
        if(u_xlati32 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(u_xlat16_34<_MaxSpecGradient);
#else
            u_xlatb32 = u_xlat16_34<_MaxSpecGradient;
#endif
            u_xlat16_34 = u_xlat16_34 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_34 = u_xlat16_34 / u_xlat16_5.x;
            u_xlat16_34 = log2(u_xlat16_34);
            u_xlat16_34 = u_xlat16_34 * _ModifySpecPower;
            u_xlat16_34 = exp2(u_xlat16_34);
            u_xlat16_34 = (u_xlatb32) ? u_xlat16_34 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_32 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_6.xyz = vec3(u_xlat10_32) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_6.xyz * vec3(u_xlat16_34) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_34 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_34 = max(u_xlat16_34, 0.0);
        u_xlat16_5.x = (-u_xlat16_34) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati32 = int(u_xlat16_5.x);
        if(u_xlati32 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(u_xlat16_34<_MaxSpecGradient);
#else
            u_xlatb32 = u_xlat16_34<_MaxSpecGradient;
#endif
            if(u_xlatb32){
                u_xlat16_34 = u_xlat16_34 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_34 = u_xlat16_34 / u_xlat16_5.x;
                u_xlat16_34 = log2(u_xlat16_34);
                u_xlat16_34 = u_xlat16_34 * _ModifySpecPower;
                u_xlat16_34 = exp2(u_xlat16_34);
                u_xlat16_34 = (-u_xlat16_34) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_32 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_6.xyz = vec3(u_xlat10_32) * u_xlat16_5.xyz;
                u_xlat16_6.xyz = u_xlat16_6.xyz;
            } else {
                u_xlat16_6.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_6.x = float(1.0);
            u_xlat16_6.y = float(1.0);
            u_xlat16_6.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb32 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb32){
#ifdef UNITY_ADRENO_ES3
        u_xlatb32 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb32 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb32){
            u_xlat7.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat7.xy = u_xlat7.xy * _ScreenParams.yx;
            u_xlat7.xy = u_xlat7.xy * vec2(0.25, 0.25);
            u_xlatb27.xy = greaterThanEqual(u_xlat7.xyxy, (-u_xlat7.xyxy)).xy;
            u_xlat7.xy = fract(abs(u_xlat7.xy));
            u_xlat7.x = (u_xlatb27.x) ? u_xlat7.x : (-u_xlat7.x);
            u_xlat7.y = (u_xlatb27.y) ? u_xlat7.y : (-u_xlat7.y);
            u_xlat7.xy = u_xlat7.xy * vec2(4.0, 4.0);
            u_xlatu7.xy = uvec2(u_xlat7.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat32 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu7.x)]);
            u_xlat32 = vs_TEXCOORD3.z * 17.0 + (-u_xlat32);
            u_xlat32 = u_xlat32 + 0.99000001;
            u_xlat32 = floor(u_xlat32);
            u_xlat32 = max(u_xlat32, 0.0);
            u_xlati32 = int(u_xlat32);
            if((u_xlati32)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_34 = u_xlat10_8.x * 1.99000001;
    u_xlat32 = u_xlat16_34 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_5.xyz;
    u_xlat31 = _SPNoiseScaler * _SPTransition;
    u_xlat2.xy = vec2(u_xlat31) * vec2(1.70000005, 1.5) + (-vec2(u_xlat32));
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
    u_xlati2.xy = ivec2(u_xlat2.xy);
    u_xlat31 = u_xlat31 * 1.70000005 + (-u_xlat32);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat22 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat31 = u_xlat31 * u_xlat22 + _BloomFactor;
    u_xlat16_5.xyz = (u_xlati2.y != 0) ? u_xlat1.xyz : u_xlat7.xyz;
    u_xlat16_34 = (u_xlati2.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati2.x != 0) ? u_xlat16_5.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati2.x != 0) ? u_xlat16_34 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
uvec2 u_xlatu7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec2 u_xlat11;
float u_xlat22;
bvec2 u_xlatb27;
float u_xlat30;
lowp float u_xlat10_30;
int u_xlati30;
float u_xlat31;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
int u_xlati32;
bool u_xlatb32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
bool u_xlatb36;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_30 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_30) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_33 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlati30 = int(u_xlat30);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat10 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10 = floor(u_xlat10);
    u_xlat1.x = max(u_xlat10, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat16_33) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_33 = (u_xlati1 != 0) ? u_xlat11.y : u_xlat11.x;
    u_xlat16_33 = u_xlat16_33 + vs_COLOR1;
    u_xlat16_34 = u_xlat16_33 * 0.5 + (-_LightArea);
    u_xlat16_34 = u_xlat16_34 + 1.0;
    u_xlat16_34 = floor(u_xlat16_34);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlati1 = int(u_xlat16_34);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati30) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat6.xyz = u_xlat2.xyz * vec3(u_xlat31) + _WorldSpaceLightPos0.xyz;
    u_xlat32 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb36 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat32) + (-_WorldSpaceLightPos0.xyz);
    u_xlat32 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat32) + _CustomLightDir.xyz;
    u_xlat16_34 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb36)) ? u_xlat16_5.xyz : u_xlat7.xyz;
    u_xlat16_34 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_34 = max(u_xlat16_34, 0.0);
    u_xlat16_34 = log2(u_xlat16_34);
    u_xlat16_34 = u_xlat16_34 * _Shininess;
    u_xlat16_34 = exp2(u_xlat16_34);
    u_xlat16_32 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_32 = (-u_xlat16_34) + u_xlat16_32;
    u_xlat32 = u_xlat16_32 + 1.0;
    u_xlat32 = floor(u_xlat32);
    u_xlat32 = max(u_xlat32, 0.0);
    u_xlati32 = int(u_xlat32);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati32) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_ModifySpec==0.0);
#else
    u_xlatb32 = _ModifySpec==0.0;
#endif
    if(u_xlatb32){
        u_xlat16_34 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_34 = max(u_xlat16_34, 0.0);
        u_xlat16_5.x = (-u_xlat16_34) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati32 = int(u_xlat16_5.x);
        if(u_xlati32 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(u_xlat16_34<_MaxSpecGradient);
#else
            u_xlatb32 = u_xlat16_34<_MaxSpecGradient;
#endif
            u_xlat16_34 = u_xlat16_34 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_34 = u_xlat16_34 / u_xlat16_5.x;
            u_xlat16_34 = log2(u_xlat16_34);
            u_xlat16_34 = u_xlat16_34 * _ModifySpecPower;
            u_xlat16_34 = exp2(u_xlat16_34);
            u_xlat16_34 = (u_xlatb32) ? u_xlat16_34 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_32 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_6.xyz = vec3(u_xlat10_32) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_6.xyz * vec3(u_xlat16_34) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_34 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_34 = max(u_xlat16_34, 0.0);
        u_xlat16_5.x = (-u_xlat16_34) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati32 = int(u_xlat16_5.x);
        if(u_xlati32 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb32 = !!(u_xlat16_34<_MaxSpecGradient);
#else
            u_xlatb32 = u_xlat16_34<_MaxSpecGradient;
#endif
            if(u_xlatb32){
                u_xlat16_34 = u_xlat16_34 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_34 = u_xlat16_34 / u_xlat16_5.x;
                u_xlat16_34 = log2(u_xlat16_34);
                u_xlat16_34 = u_xlat16_34 * _ModifySpecPower;
                u_xlat16_34 = exp2(u_xlat16_34);
                u_xlat16_34 = (-u_xlat16_34) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_34) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_32 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_6.xyz = vec3(u_xlat10_32) * u_xlat16_5.xyz;
                u_xlat16_6.xyz = u_xlat16_6.xyz;
            } else {
                u_xlat16_6.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_6.x = float(1.0);
            u_xlat16_6.y = float(1.0);
            u_xlat16_6.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb32 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb32){
#ifdef UNITY_ADRENO_ES3
        u_xlatb32 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb32 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb32){
            u_xlat7.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat7.xy = u_xlat7.xy * _ScreenParams.yx;
            u_xlat7.xy = u_xlat7.xy * vec2(0.25, 0.25);
            u_xlatb27.xy = greaterThanEqual(u_xlat7.xyxy, (-u_xlat7.xyxy)).xy;
            u_xlat7.xy = fract(abs(u_xlat7.xy));
            u_xlat7.x = (u_xlatb27.x) ? u_xlat7.x : (-u_xlat7.x);
            u_xlat7.y = (u_xlatb27.y) ? u_xlat7.y : (-u_xlat7.y);
            u_xlat7.xy = u_xlat7.xy * vec2(4.0, 4.0);
            u_xlatu7.xy = uvec2(u_xlat7.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu7.y)]);
            u_xlat32 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu7.x)]);
            u_xlat32 = vs_TEXCOORD3.z * 17.0 + (-u_xlat32);
            u_xlat32 = u_xlat32 + 0.99000001;
            u_xlat32 = floor(u_xlat32);
            u_xlat32 = max(u_xlat32, 0.0);
            u_xlati32 = int(u_xlat32);
            if((u_xlati32)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_34 = u_xlat10_8.x * 1.99000001;
    u_xlat32 = u_xlat16_34 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + (-_WorldSpaceCameraPos.xyz);
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + u_xlat8.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat31)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_5.xyz;
    u_xlat31 = _SPNoiseScaler * _SPTransition;
    u_xlat2.xy = vec2(u_xlat31) * vec2(1.70000005, 1.5) + (-vec2(u_xlat32));
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
    u_xlati2.xy = ivec2(u_xlat2.xy);
    u_xlat31 = u_xlat31 * 1.70000005 + (-u_xlat32);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat22 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat31 = u_xlat31 * u_xlat22 + _BloomFactor;
    u_xlat16_5.xyz = (u_xlati2.y != 0) ? u_xlat1.xyz : u_xlat7.xyz;
    u_xlat16_34 = (u_xlati2.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati2.x != 0) ? u_xlat16_5.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati2.x != 0) ? u_xlat16_34 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
uvec2 u_xlatu3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
ivec3 u_xlati11;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump vec3 u_xlat16_18;
float u_xlat22;
mediump float u_xlat16_22;
int u_xlati22;
bvec2 u_xlatb25;
float u_xlat33;
lowp float u_xlat10_33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb34 = 0.5<_CustomLightDir.w;
#endif
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat33) + (-_WorldSpaceLightPos0.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat33) + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? u_xlat16_8.xyz : u_xlat4.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_40) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xzw * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xzw * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat3.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat3.xy = u_xlat3.xy * _ScreenParams.yx;
            u_xlat3.xy = u_xlat3.xy * vec2(0.25, 0.25);
            u_xlatb25.xy = greaterThanEqual(u_xlat3.xyxy, (-u_xlat3.xyxy)).xy;
            u_xlat3.xy = fract(abs(u_xlat3.xy));
            u_xlat3.x = (u_xlatb25.x) ? u_xlat3.x : (-u_xlat3.x);
            u_xlat3.y = (u_xlatb25.y) ? u_xlat3.y : (-u_xlat3.y);
            u_xlat3.xy = u_xlat3.xy * vec2(4.0, 4.0);
            u_xlatu3.xy = uvec2(u_xlat3.xy);
            u_xlat4.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat34 = dot(u_xlat4, ImmCB_0_0_0[int(u_xlatu3.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_3.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_40 = u_xlat10_4.x * 1.99000001;
    u_xlat34 = u_xlat16_40 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat35 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat35 = u_xlat35 + u_xlat35;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat35)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_8.xyz;
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat34));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat34 = u_xlat2.x * 1.70000005 + (-u_xlat34);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat3.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat2.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat34 * u_xlat2.x + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat3.xyz;
    u_xlat16_40 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_40 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
uvec2 u_xlatu3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
ivec3 u_xlati11;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump vec3 u_xlat16_18;
float u_xlat22;
mediump float u_xlat16_22;
int u_xlati22;
bvec2 u_xlatb25;
float u_xlat33;
lowp float u_xlat10_33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb34 = 0.5<_CustomLightDir.w;
#endif
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat33) + (-_WorldSpaceLightPos0.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat33) + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? u_xlat16_8.xyz : u_xlat4.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_40) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xzw * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xzw * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat3.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat3.xy = u_xlat3.xy * _ScreenParams.yx;
            u_xlat3.xy = u_xlat3.xy * vec2(0.25, 0.25);
            u_xlatb25.xy = greaterThanEqual(u_xlat3.xyxy, (-u_xlat3.xyxy)).xy;
            u_xlat3.xy = fract(abs(u_xlat3.xy));
            u_xlat3.x = (u_xlatb25.x) ? u_xlat3.x : (-u_xlat3.x);
            u_xlat3.y = (u_xlatb25.y) ? u_xlat3.y : (-u_xlat3.y);
            u_xlat3.xy = u_xlat3.xy * vec2(4.0, 4.0);
            u_xlatu3.xy = uvec2(u_xlat3.xy);
            u_xlat4.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat34 = dot(u_xlat4, ImmCB_0_0_0[int(u_xlatu3.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_3.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_40 = u_xlat10_4.x * 1.99000001;
    u_xlat34 = u_xlat16_40 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat35 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat35 = u_xlat35 + u_xlat35;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat35)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_8.xyz;
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat34));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat34 = u_xlat2.x * 1.70000005 + (-u_xlat34);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat3.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat2.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat34 * u_xlat2.x + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat3.xyz;
    u_xlat16_40 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_40 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
uvec2 u_xlatu3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
ivec3 u_xlati11;
vec2 u_xlat13;
ivec2 u_xlati13;
mediump vec3 u_xlat16_18;
float u_xlat22;
mediump float u_xlat16_22;
int u_xlati22;
bvec2 u_xlatb25;
float u_xlat33;
lowp float u_xlat10_33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb34 = 0.5<_CustomLightDir.w;
#endif
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat33) + (-_WorldSpaceLightPos0.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_8.xyz = u_xlat3.xyz * vec3(u_xlat33) + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? u_xlat16_8.xyz : u_xlat4.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_40) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xzw * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xzw * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat3.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat3.xy = u_xlat3.xy * _ScreenParams.yx;
            u_xlat3.xy = u_xlat3.xy * vec2(0.25, 0.25);
            u_xlatb25.xy = greaterThanEqual(u_xlat3.xyxy, (-u_xlat3.xyxy)).xy;
            u_xlat3.xy = fract(abs(u_xlat3.xy));
            u_xlat3.x = (u_xlatb25.x) ? u_xlat3.x : (-u_xlat3.x);
            u_xlat3.y = (u_xlatb25.y) ? u_xlat3.y : (-u_xlat3.y);
            u_xlat3.xy = u_xlat3.xy * vec2(4.0, 4.0);
            u_xlatu3.xy = uvec2(u_xlat3.xy);
            u_xlat4.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat4.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu3.y)]);
            u_xlat34 = dot(u_xlat4, ImmCB_0_0_0[int(u_xlatu3.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_3.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_40 = u_xlat10_4.x * 1.99000001;
    u_xlat34 = u_xlat16_40 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat35 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat35 = u_xlat35 + u_xlat35;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat35)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_8.xyz;
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat13.xy = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat34));
    u_xlat13.xy = u_xlat13.xy + vec2(1.0, 1.0);
    u_xlat13.xy = floor(u_xlat13.xy);
    u_xlat13.xy = max(u_xlat13.xy, vec2(0.0, 0.0));
    u_xlati13.xy = ivec2(u_xlat13.xy);
    u_xlat34 = u_xlat2.x * 1.70000005 + (-u_xlat34);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat3.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat2.x = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat3.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat34 * u_xlat2.x + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati13.y != 0) ? u_xlat1.xyz : u_xlat3.xyz;
    u_xlat16_40 = (u_xlati13.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati13.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati13.x != 0) ? u_xlat16_8.xyz : u_xlat1.xyz;
    SV_Target0.w = (u_xlati13.x != 0) ? u_xlat16_40 : _BloomFactor;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_lightProbToggle);
#else
    u_xlatb1 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb1)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
ivec2 u_xlati6;
uvec2 u_xlatu6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
ivec3 u_xlati10;
float u_xlat11;
mediump vec3 u_xlat16_12;
float u_xlat20;
mediump float u_xlat16_20;
int u_xlati20;
bvec2 u_xlatb26;
float u_xlat30;
float u_xlat31;
int u_xlati31;
bool u_xlatb31;
mediump float u_xlat16_32;
float u_xlat34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat10.z = max(u_xlat30, 0.0);
    u_xlat16_12.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_12.x = u_xlat16_12.x * 0.5 + (-_SecondShadow);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati31 = int(u_xlat16_12.x);
    u_xlat16_12.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati31) != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10.x = floor(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlati10.xz = ivec2(u_xlat10.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati10.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati10.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati10.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati10.z != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat5.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb31 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat30) + (-_WorldSpaceLightPos0.xyz);
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat30) + _CustomLightDir.xyz;
    u_xlat16_32 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = inversesqrt(u_xlat16_32);
    u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb31)) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat16_32 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_32 = log2(u_xlat16_32);
    u_xlat16_32 = u_xlat16_32 * _Shininess;
    u_xlat16_32 = exp2(u_xlat16_32);
    u_xlat16_20 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_20 = (-u_xlat16_32) + u_xlat16_20;
    u_xlat20 = u_xlat16_20 + 1.0;
    u_xlat20 = floor(u_xlat20);
    u_xlat20 = max(u_xlat20, 0.0);
    u_xlati20 = int(u_xlat20);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati20) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
            u_xlat16_32 = log2(u_xlat16_32);
            u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
            u_xlat16_32 = exp2(u_xlat16_32);
            u_xlat16_32 = (u_xlatb0) ? u_xlat16_32 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_32) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
                u_xlat16_32 = log2(u_xlat16_32);
                u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
                u_xlat16_32 = exp2(u_xlat16_32);
                u_xlat16_32 = (-u_xlat16_32) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb31 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb31){
#ifdef UNITY_ADRENO_ES3
        u_xlatb31 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb31 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb31){
            u_xlat6.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat6.xy = u_xlat6.xy * _ScreenParams.yx;
            u_xlat6.xy = u_xlat6.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat6.xyxy, (-u_xlat6.xyxy)).xy;
            u_xlat6.xy = fract(abs(u_xlat6.xy));
            u_xlat6.x = (u_xlatb26.x) ? u_xlat6.x : (-u_xlat6.x);
            u_xlat6.y = (u_xlatb26.y) ? u_xlat6.y : (-u_xlat6.y);
            u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0);
            u_xlatu6.xy = uvec2(u_xlat6.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat31 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu6.x)]);
            u_xlat31 = vs_TEXCOORD3.z * 17.0 + (-u_xlat31);
            u_xlat31 = u_xlat31 + 0.99000001;
            u_xlat31 = floor(u_xlat31);
            u_xlat31 = max(u_xlat31, 0.0);
            u_xlati31 = int(u_xlat31);
            if((u_xlati31)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_6.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_7.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_32 = u_xlat10_7.x * 1.99000001;
    u_xlat31 = u_xlat16_32 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat10.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_8.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat31));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat31 = u_xlat34 * 1.70000005 + (-u_xlat31);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat34 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat31 = u_xlat31 * u_xlat34 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati6.y != 0) ? u_xlat4.xyz : u_xlat7.xyz;
    u_xlat16_32 = (u_xlati6.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati6.x != 0) ? u_xlat16_8.xyz : u_xlat4.xyz;
    SV_Target0.w = (u_xlati6.x != 0) ? u_xlat16_32 : _BloomFactor;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_8.xyz;
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_lightProbToggle);
#else
    u_xlatb31 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb31)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_32 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat16_32 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
ivec2 u_xlati6;
uvec2 u_xlatu6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
ivec3 u_xlati10;
float u_xlat11;
mediump vec3 u_xlat16_12;
float u_xlat20;
mediump float u_xlat16_20;
int u_xlati20;
bvec2 u_xlatb26;
float u_xlat30;
float u_xlat31;
int u_xlati31;
bool u_xlatb31;
mediump float u_xlat16_32;
float u_xlat34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat10.z = max(u_xlat30, 0.0);
    u_xlat16_12.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_12.x = u_xlat16_12.x * 0.5 + (-_SecondShadow);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati31 = int(u_xlat16_12.x);
    u_xlat16_12.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati31) != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10.x = floor(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlati10.xz = ivec2(u_xlat10.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati10.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati10.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati10.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati10.z != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat5.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb31 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat30) + (-_WorldSpaceLightPos0.xyz);
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat30) + _CustomLightDir.xyz;
    u_xlat16_32 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = inversesqrt(u_xlat16_32);
    u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb31)) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat16_32 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_32 = log2(u_xlat16_32);
    u_xlat16_32 = u_xlat16_32 * _Shininess;
    u_xlat16_32 = exp2(u_xlat16_32);
    u_xlat16_20 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_20 = (-u_xlat16_32) + u_xlat16_20;
    u_xlat20 = u_xlat16_20 + 1.0;
    u_xlat20 = floor(u_xlat20);
    u_xlat20 = max(u_xlat20, 0.0);
    u_xlati20 = int(u_xlat20);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati20) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
            u_xlat16_32 = log2(u_xlat16_32);
            u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
            u_xlat16_32 = exp2(u_xlat16_32);
            u_xlat16_32 = (u_xlatb0) ? u_xlat16_32 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_32) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
                u_xlat16_32 = log2(u_xlat16_32);
                u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
                u_xlat16_32 = exp2(u_xlat16_32);
                u_xlat16_32 = (-u_xlat16_32) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb31 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb31){
#ifdef UNITY_ADRENO_ES3
        u_xlatb31 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb31 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb31){
            u_xlat6.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat6.xy = u_xlat6.xy * _ScreenParams.yx;
            u_xlat6.xy = u_xlat6.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat6.xyxy, (-u_xlat6.xyxy)).xy;
            u_xlat6.xy = fract(abs(u_xlat6.xy));
            u_xlat6.x = (u_xlatb26.x) ? u_xlat6.x : (-u_xlat6.x);
            u_xlat6.y = (u_xlatb26.y) ? u_xlat6.y : (-u_xlat6.y);
            u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0);
            u_xlatu6.xy = uvec2(u_xlat6.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat31 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu6.x)]);
            u_xlat31 = vs_TEXCOORD3.z * 17.0 + (-u_xlat31);
            u_xlat31 = u_xlat31 + 0.99000001;
            u_xlat31 = floor(u_xlat31);
            u_xlat31 = max(u_xlat31, 0.0);
            u_xlati31 = int(u_xlat31);
            if((u_xlati31)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_6.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_7.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_32 = u_xlat10_7.x * 1.99000001;
    u_xlat31 = u_xlat16_32 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat10.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_8.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat31));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat31 = u_xlat34 * 1.70000005 + (-u_xlat31);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat34 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat31 = u_xlat31 * u_xlat34 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati6.y != 0) ? u_xlat4.xyz : u_xlat7.xyz;
    u_xlat16_32 = (u_xlati6.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati6.x != 0) ? u_xlat16_8.xyz : u_xlat4.xyz;
    SV_Target0.w = (u_xlati6.x != 0) ? u_xlat16_32 : _BloomFactor;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_8.xyz;
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_lightProbToggle);
#else
    u_xlatb31 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb31)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_32 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat16_32 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
ivec2 u_xlati6;
uvec2 u_xlatu6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
ivec3 u_xlati10;
float u_xlat11;
mediump vec3 u_xlat16_12;
float u_xlat20;
mediump float u_xlat16_20;
int u_xlati20;
bvec2 u_xlatb26;
float u_xlat30;
float u_xlat31;
int u_xlati31;
bool u_xlatb31;
mediump float u_xlat16_32;
float u_xlat34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat10.z = max(u_xlat30, 0.0);
    u_xlat16_12.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_12.x = u_xlat16_12.x * 0.5 + (-_SecondShadow);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati31 = int(u_xlat16_12.x);
    u_xlat16_12.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati31) != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10.x = floor(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlati10.xz = ivec2(u_xlat10.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati10.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati10.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati10.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati10.z != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat5.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb31 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat30) + (-_WorldSpaceLightPos0.xyz);
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat30) + _CustomLightDir.xyz;
    u_xlat16_32 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = inversesqrt(u_xlat16_32);
    u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb31)) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat16_32 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_32 = log2(u_xlat16_32);
    u_xlat16_32 = u_xlat16_32 * _Shininess;
    u_xlat16_32 = exp2(u_xlat16_32);
    u_xlat16_20 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_20 = (-u_xlat16_32) + u_xlat16_20;
    u_xlat20 = u_xlat16_20 + 1.0;
    u_xlat20 = floor(u_xlat20);
    u_xlat20 = max(u_xlat20, 0.0);
    u_xlati20 = int(u_xlat20);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati20) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
            u_xlat16_32 = log2(u_xlat16_32);
            u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
            u_xlat16_32 = exp2(u_xlat16_32);
            u_xlat16_32 = (u_xlatb0) ? u_xlat16_32 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_32) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
                u_xlat16_32 = log2(u_xlat16_32);
                u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
                u_xlat16_32 = exp2(u_xlat16_32);
                u_xlat16_32 = (-u_xlat16_32) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb31 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb31){
#ifdef UNITY_ADRENO_ES3
        u_xlatb31 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb31 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb31){
            u_xlat6.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat6.xy = u_xlat6.xy * _ScreenParams.yx;
            u_xlat6.xy = u_xlat6.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat6.xyxy, (-u_xlat6.xyxy)).xy;
            u_xlat6.xy = fract(abs(u_xlat6.xy));
            u_xlat6.x = (u_xlatb26.x) ? u_xlat6.x : (-u_xlat6.x);
            u_xlat6.y = (u_xlatb26.y) ? u_xlat6.y : (-u_xlat6.y);
            u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0);
            u_xlatu6.xy = uvec2(u_xlat6.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat31 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu6.x)]);
            u_xlat31 = vs_TEXCOORD3.z * 17.0 + (-u_xlat31);
            u_xlat31 = u_xlat31 + 0.99000001;
            u_xlat31 = floor(u_xlat31);
            u_xlat31 = max(u_xlat31, 0.0);
            u_xlati31 = int(u_xlat31);
            if((u_xlati31)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_6.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_7.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_32 = u_xlat10_7.x * 1.99000001;
    u_xlat31 = u_xlat16_32 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat10.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_8.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat31));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat31 = u_xlat34 * 1.70000005 + (-u_xlat31);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat34 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat31 = u_xlat31 * u_xlat34 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati6.y != 0) ? u_xlat4.xyz : u_xlat7.xyz;
    u_xlat16_32 = (u_xlati6.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati6.x != 0) ? u_xlat16_8.xyz : u_xlat4.xyz;
    SV_Target0.w = (u_xlati6.x != 0) ? u_xlat16_32 : _BloomFactor;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_8.xyz;
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_lightProbToggle);
#else
    u_xlatb31 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb31)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_32 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat16_32 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
ivec2 u_xlati6;
uvec2 u_xlatu6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
ivec3 u_xlati10;
float u_xlat11;
mediump vec3 u_xlat16_12;
float u_xlat20;
mediump float u_xlat16_20;
int u_xlati20;
bvec2 u_xlatb26;
float u_xlat30;
float u_xlat31;
int u_xlati31;
bool u_xlatb31;
mediump float u_xlat16_32;
float u_xlat34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat10.z = max(u_xlat30, 0.0);
    u_xlat16_12.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_12.x = u_xlat16_12.x * 0.5 + (-_SecondShadow);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati31 = int(u_xlat16_12.x);
    u_xlat16_12.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati31) != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10.x = floor(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlati10.xz = ivec2(u_xlat10.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati10.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati10.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati10.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati10.z != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat5.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb31 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat30) + (-_WorldSpaceLightPos0.xyz);
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat30) + _CustomLightDir.xyz;
    u_xlat16_32 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = inversesqrt(u_xlat16_32);
    u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb31)) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat16_32 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_32 = log2(u_xlat16_32);
    u_xlat16_32 = u_xlat16_32 * _Shininess;
    u_xlat16_32 = exp2(u_xlat16_32);
    u_xlat16_20 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_20 = (-u_xlat16_32) + u_xlat16_20;
    u_xlat20 = u_xlat16_20 + 1.0;
    u_xlat20 = floor(u_xlat20);
    u_xlat20 = max(u_xlat20, 0.0);
    u_xlati20 = int(u_xlat20);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati20) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
            u_xlat16_32 = log2(u_xlat16_32);
            u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
            u_xlat16_32 = exp2(u_xlat16_32);
            u_xlat16_32 = (u_xlatb0) ? u_xlat16_32 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_32) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
                u_xlat16_32 = log2(u_xlat16_32);
                u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
                u_xlat16_32 = exp2(u_xlat16_32);
                u_xlat16_32 = (-u_xlat16_32) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb31 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb31){
#ifdef UNITY_ADRENO_ES3
        u_xlatb31 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb31 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb31){
            u_xlat6.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat6.xy = u_xlat6.xy * _ScreenParams.yx;
            u_xlat6.xy = u_xlat6.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat6.xyxy, (-u_xlat6.xyxy)).xy;
            u_xlat6.xy = fract(abs(u_xlat6.xy));
            u_xlat6.x = (u_xlatb26.x) ? u_xlat6.x : (-u_xlat6.x);
            u_xlat6.y = (u_xlatb26.y) ? u_xlat6.y : (-u_xlat6.y);
            u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0);
            u_xlatu6.xy = uvec2(u_xlat6.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat31 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu6.x)]);
            u_xlat31 = vs_TEXCOORD3.z * 17.0 + (-u_xlat31);
            u_xlat31 = u_xlat31 + 0.99000001;
            u_xlat31 = floor(u_xlat31);
            u_xlat31 = max(u_xlat31, 0.0);
            u_xlati31 = int(u_xlat31);
            if((u_xlati31)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_6.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_7.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_32 = u_xlat10_7.x * 1.99000001;
    u_xlat31 = u_xlat16_32 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat10.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_8.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat31));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat31 = u_xlat34 * 1.70000005 + (-u_xlat31);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat34 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat31 = u_xlat31 * u_xlat34 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati6.y != 0) ? u_xlat4.xyz : u_xlat7.xyz;
    u_xlat16_32 = (u_xlati6.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati6.x != 0) ? u_xlat16_8.xyz : u_xlat4.xyz;
    SV_Target0.w = (u_xlati6.x != 0) ? u_xlat16_32 : _BloomFactor;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_8.xyz;
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_lightProbToggle);
#else
    u_xlatb31 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb31)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_32 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat16_32 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
ivec2 u_xlati6;
uvec2 u_xlatu6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
ivec3 u_xlati10;
float u_xlat11;
mediump vec3 u_xlat16_12;
float u_xlat20;
mediump float u_xlat16_20;
int u_xlati20;
bvec2 u_xlatb26;
float u_xlat30;
float u_xlat31;
int u_xlati31;
bool u_xlatb31;
mediump float u_xlat16_32;
float u_xlat34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat10.z = max(u_xlat30, 0.0);
    u_xlat16_12.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_12.x = u_xlat16_12.x * 0.5 + (-_SecondShadow);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati31 = int(u_xlat16_12.x);
    u_xlat16_12.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati31) != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10.x = floor(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlati10.xz = ivec2(u_xlat10.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati10.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati10.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati10.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati10.z != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat5.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb31 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat30) + (-_WorldSpaceLightPos0.xyz);
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat30) + _CustomLightDir.xyz;
    u_xlat16_32 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = inversesqrt(u_xlat16_32);
    u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb31)) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat16_32 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_32 = log2(u_xlat16_32);
    u_xlat16_32 = u_xlat16_32 * _Shininess;
    u_xlat16_32 = exp2(u_xlat16_32);
    u_xlat16_20 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_20 = (-u_xlat16_32) + u_xlat16_20;
    u_xlat20 = u_xlat16_20 + 1.0;
    u_xlat20 = floor(u_xlat20);
    u_xlat20 = max(u_xlat20, 0.0);
    u_xlati20 = int(u_xlat20);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati20) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
            u_xlat16_32 = log2(u_xlat16_32);
            u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
            u_xlat16_32 = exp2(u_xlat16_32);
            u_xlat16_32 = (u_xlatb0) ? u_xlat16_32 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_32) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
                u_xlat16_32 = log2(u_xlat16_32);
                u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
                u_xlat16_32 = exp2(u_xlat16_32);
                u_xlat16_32 = (-u_xlat16_32) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb31 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb31){
#ifdef UNITY_ADRENO_ES3
        u_xlatb31 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb31 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb31){
            u_xlat6.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat6.xy = u_xlat6.xy * _ScreenParams.yx;
            u_xlat6.xy = u_xlat6.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat6.xyxy, (-u_xlat6.xyxy)).xy;
            u_xlat6.xy = fract(abs(u_xlat6.xy));
            u_xlat6.x = (u_xlatb26.x) ? u_xlat6.x : (-u_xlat6.x);
            u_xlat6.y = (u_xlatb26.y) ? u_xlat6.y : (-u_xlat6.y);
            u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0);
            u_xlatu6.xy = uvec2(u_xlat6.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat31 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu6.x)]);
            u_xlat31 = vs_TEXCOORD3.z * 17.0 + (-u_xlat31);
            u_xlat31 = u_xlat31 + 0.99000001;
            u_xlat31 = floor(u_xlat31);
            u_xlat31 = max(u_xlat31, 0.0);
            u_xlati31 = int(u_xlat31);
            if((u_xlati31)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_6.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_7.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_32 = u_xlat10_7.x * 1.99000001;
    u_xlat31 = u_xlat16_32 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat10.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_8.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat31));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat31 = u_xlat34 * 1.70000005 + (-u_xlat31);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat34 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat31 = u_xlat31 * u_xlat34 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati6.y != 0) ? u_xlat4.xyz : u_xlat7.xyz;
    u_xlat16_32 = (u_xlati6.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati6.x != 0) ? u_xlat16_8.xyz : u_xlat4.xyz;
    SV_Target0.w = (u_xlati6.x != 0) ? u_xlat16_32 : _BloomFactor;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_8.xyz;
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_lightProbToggle);
#else
    u_xlatb31 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb31)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_32 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat16_32 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
ivec2 u_xlati6;
uvec2 u_xlatu6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
ivec3 u_xlati10;
float u_xlat11;
mediump vec3 u_xlat16_12;
float u_xlat20;
mediump float u_xlat16_20;
int u_xlati20;
bvec2 u_xlatb26;
float u_xlat30;
float u_xlat31;
int u_xlati31;
bool u_xlatb31;
mediump float u_xlat16_32;
float u_xlat34;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat30 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat30 = floor(u_xlat30);
    u_xlat10.z = max(u_xlat30, 0.0);
    u_xlat16_12.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_12.x = u_xlat16_12.x * 0.5 + (-_SecondShadow);
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = floor(u_xlat16_12.x);
    u_xlat16_12.x = max(u_xlat16_12.x, 0.0);
    u_xlati31 = int(u_xlat16_12.x);
    u_xlat16_12.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_12.xyz = (int(u_xlati31) != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat10.x = floor(u_xlat10.x);
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlati10.xz = ivec2(u_xlat10.xz);
    u_xlat4.xy = u_xlat16_2.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_2.x = (u_xlati10.x != 0) ? u_xlat4.y : u_xlat4.x;
    u_xlat16_2.x = u_xlat16_2.x + vs_COLOR1;
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + (-_LightArea);
    u_xlat16_2.x = u_xlat16_2.x + 1.0;
    u_xlat16_2.x = floor(u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlati10.x = int(u_xlat16_2.x);
    u_xlat16_3.xyz = (u_xlati10.x != 0) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat16_2.xyz = (u_xlati10.z != 0) ? u_xlat16_3.xyz : u_xlat16_12.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat1.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat5.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * u_xlat10.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat7.xyz = vec3(u_xlat30) * u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb31 = 0.5<_CustomLightDir.w;
#endif
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat30) + (-_WorldSpaceLightPos0.xyz);
    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(u_xlat30) + _CustomLightDir.xyz;
    u_xlat16_32 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = inversesqrt(u_xlat16_32);
    u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb31)) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat16_32 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_32 = max(u_xlat16_32, 0.0);
    u_xlat16_32 = log2(u_xlat16_32);
    u_xlat16_32 = u_xlat16_32 * _Shininess;
    u_xlat16_32 = exp2(u_xlat16_32);
    u_xlat16_20 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_20 = (-u_xlat16_32) + u_xlat16_20;
    u_xlat20 = u_xlat16_20 + 1.0;
    u_xlat20 = floor(u_xlat20);
    u_xlat20 = max(u_xlat20, 0.0);
    u_xlati20 = int(u_xlat20);
    u_xlat16_3.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = (int(u_xlati20) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
            u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
            u_xlat16_32 = log2(u_xlat16_32);
            u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
            u_xlat16_32 = exp2(u_xlat16_32);
            u_xlat16_32 = (u_xlatb0) ? u_xlat16_32 : 1.0;
            u_xlat16_3.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
            u_xlat16_2.xyz = u_xlat16_0.xzw * vec3(u_xlat16_32) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = u_xlat16_2.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_32 = dot(u_xlat1.xyz, u_xlat7.xyz);
        u_xlat16_32 = max(u_xlat16_32, 0.0);
        u_xlat16_3.x = (-u_xlat16_32) + _ModifySpecThreshold;
        u_xlat16_3.x = u_xlat16_3.x + 1.0;
        u_xlat16_3.x = floor(u_xlat16_3.x);
        u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
        u_xlati0 = int(u_xlat16_3.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_32<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_32<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_32 = u_xlat16_32 + (-_ModifySpecThreshold);
                u_xlat16_3.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_32 = u_xlat16_32 / u_xlat16_3.x;
                u_xlat16_32 = log2(u_xlat16_32);
                u_xlat16_32 = u_xlat16_32 * _ModifySpecPower;
                u_xlat16_32 = exp2(u_xlat16_32);
                u_xlat16_32 = (-u_xlat16_32) + 1.0;
                u_xlat16_3.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_3.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz + _ModifySpecColor.xyz;
                u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_3.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_2.xyz = u_xlat16_0.xzw * u_xlat16_2.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb31 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb31){
#ifdef UNITY_ADRENO_ES3
        u_xlatb31 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb31 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb31){
            u_xlat6.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat6.xy = u_xlat6.xy * _ScreenParams.yx;
            u_xlat6.xy = u_xlat6.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat6.xyxy, (-u_xlat6.xyxy)).xy;
            u_xlat6.xy = fract(abs(u_xlat6.xy));
            u_xlat6.x = (u_xlatb26.x) ? u_xlat6.x : (-u_xlat6.x);
            u_xlat6.y = (u_xlatb26.y) ? u_xlat6.y : (-u_xlat6.y);
            u_xlat6.xy = u_xlat6.xy * vec2(4.0, 4.0);
            u_xlatu6.xy = uvec2(u_xlat6.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu6.y)]);
            u_xlat31 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu6.x)]);
            u_xlat31 = vs_TEXCOORD3.z * 17.0 + (-u_xlat31);
            u_xlat31 = u_xlat31 + 0.99000001;
            u_xlat31 = floor(u_xlat31);
            u_xlat31 = max(u_xlat31, 0.0);
            u_xlati31 = int(u_xlat31);
            if((u_xlati31)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_6.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_7.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_32 = u_xlat10_7.x * 1.99000001;
    u_xlat31 = u_xlat16_32 * _SPNoiseScaler + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat10.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat7.xyz = u_xlat10_7.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_8.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat31));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat31 = u_xlat34 * 1.70000005 + (-u_xlat31);
    u_xlat31 = u_xlat31 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat34 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat7.xyz = vec3(u_xlat31) * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat31 = u_xlat31 * u_xlat34 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati6.y != 0) ? u_xlat4.xyz : u_xlat7.xyz;
    u_xlat16_32 = (u_xlati6.y != 0) ? _BloomFactor : u_xlat31;
    u_xlat31 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati6.x != 0) ? u_xlat16_8.xyz : u_xlat4.xyz;
    SV_Target0.w = (u_xlati6.x != 0) ? u_xlat16_32 : _BloomFactor;
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_8.xyz;
    u_xlat4.xyz = vec3(u_xlat31) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(0.5<_lightProbToggle);
#else
    u_xlatb31 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb31)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_32 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat16_32 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_2.xyz);
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xzw + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
ivec2 u_xlati8;
uvec2 u_xlatu8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec2 u_xlat12;
bvec2 u_xlatb30;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_35;
lowp float u_xlat10_35;
int u_xlati35;
bool u_xlatb35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
bool u_xlatb39;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_33 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_33) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_36 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat33 = max(u_xlat33, 0.0);
    u_xlati33 = int(u_xlat33);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat11 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11 = floor(u_xlat11);
    u_xlat1.x = max(u_xlat11, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat12.xy = vec2(u_xlat16_36) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_36 = (u_xlati1 != 0) ? u_xlat12.y : u_xlat12.x;
    u_xlat16_36 = u_xlat16_36 + vs_COLOR1;
    u_xlat16_37 = u_xlat16_36 * 0.5 + (-_LightArea);
    u_xlat16_37 = u_xlat16_37 + 1.0;
    u_xlat16_37 = floor(u_xlat16_37);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlati1 = int(u_xlat16_37);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati33) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat2.xyz;
    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat34) + _WorldSpaceLightPos0.xyz;
    u_xlat35 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat8.xyz = vec3(u_xlat35) * u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb39 = 0.5<_CustomLightDir.w;
#endif
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat35) + (-_WorldSpaceLightPos0.xyz);
    u_xlat35 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_5.xyz = u_xlat7.xyz * vec3(u_xlat35) + _CustomLightDir.xyz;
    u_xlat16_37 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_5.xyz = vec3(u_xlat16_37) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb39)) ? u_xlat16_5.xyz : u_xlat8.xyz;
    u_xlat16_37 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = log2(u_xlat16_37);
    u_xlat16_37 = u_xlat16_37 * _Shininess;
    u_xlat16_37 = exp2(u_xlat16_37);
    u_xlat16_35 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_35 = (-u_xlat16_37) + u_xlat16_35;
    u_xlat35 = u_xlat16_35 + 1.0;
    u_xlat35 = floor(u_xlat35);
    u_xlat35 = max(u_xlat35, 0.0);
    u_xlati35 = int(u_xlat35);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati35) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(_ModifySpec==0.0);
#else
    u_xlatb35 = _ModifySpec==0.0;
#endif
    if(u_xlatb35){
        u_xlat16_37 = dot(u_xlat1.xyz, u_xlat8.xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_5.x = (-u_xlat16_37) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati35 = int(u_xlat16_5.x);
        if(u_xlati35 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb35 = !!(u_xlat16_37<_MaxSpecGradient);
#else
            u_xlatb35 = u_xlat16_37<_MaxSpecGradient;
#endif
            u_xlat16_37 = u_xlat16_37 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_37 = u_xlat16_37 / u_xlat16_5.x;
            u_xlat16_37 = log2(u_xlat16_37);
            u_xlat16_37 = u_xlat16_37 * _ModifySpecPower;
            u_xlat16_37 = exp2(u_xlat16_37);
            u_xlat16_37 = (u_xlatb35) ? u_xlat16_37 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_35 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_7.xyz = vec3(u_xlat10_35) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_7.xyz * vec3(u_xlat16_37) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_37 = dot(u_xlat1.xyz, u_xlat8.xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_5.x = (-u_xlat16_37) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati35 = int(u_xlat16_5.x);
        if(u_xlati35 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb35 = !!(u_xlat16_37<_MaxSpecGradient);
#else
            u_xlatb35 = u_xlat16_37<_MaxSpecGradient;
#endif
            if(u_xlatb35){
                u_xlat16_37 = u_xlat16_37 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_37 = u_xlat16_37 / u_xlat16_5.x;
                u_xlat16_37 = log2(u_xlat16_37);
                u_xlat16_37 = u_xlat16_37 * _ModifySpecPower;
                u_xlat16_37 = exp2(u_xlat16_37);
                u_xlat16_37 = (-u_xlat16_37) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_37) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_35 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_7.xyz = vec3(u_xlat10_35) * u_xlat16_5.xyz;
                u_xlat16_7.xyz = u_xlat16_7.xyz;
            } else {
                u_xlat16_7.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_7.x = float(1.0);
            u_xlat16_7.y = float(1.0);
            u_xlat16_7.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb35 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb35){
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb35 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb35){
            u_xlat8.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat8.xy = u_xlat8.xy * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb30.xy = greaterThanEqual(u_xlat8.xyxy, (-u_xlat8.xyxy)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb30.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb30.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat35 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat35 = vs_TEXCOORD3.z * 17.0 + (-u_xlat35);
            u_xlat35 = u_xlat35 + 0.99000001;
            u_xlat35 = floor(u_xlat35);
            u_xlat35 = max(u_xlat35, 0.0);
            u_xlati35 = int(u_xlat35);
            if((u_xlati35)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_8.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_9.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_37 = u_xlat10_9.x * 1.99000001;
    u_xlat35 = u_xlat16_37 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat34) + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat9.xyz = u_xlat10_9.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat34) + u_xlat9.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_8.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_5.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat8.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat35));
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat8.xy = floor(u_xlat8.xy);
    u_xlat8.xy = max(u_xlat8.xy, vec2(0.0, 0.0));
    u_xlati8.xy = ivec2(u_xlat8.xy);
    u_xlat34 = u_xlat34 * 1.70000005 + (-u_xlat35);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat9.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat35 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat9.xyz = vec3(u_xlat34) * u_xlat9.xyz + u_xlat2.xyz;
    u_xlat34 = u_xlat34 * u_xlat35 + _BloomFactor;
    u_xlat16_5.xyz = (u_xlati8.y != 0) ? u_xlat2.xyz : u_xlat9.xyz;
    u_xlat16_37 = (u_xlati8.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati8.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati8.x != 0) ? u_xlat16_5.xyz : u_xlat2.xyz;
    SV_Target0.w = (u_xlati8.x != 0) ? u_xlat16_37 : _BloomFactor;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_37 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat16_37 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xzw + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
ivec2 u_xlati8;
uvec2 u_xlatu8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec2 u_xlat12;
bvec2 u_xlatb30;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_35;
lowp float u_xlat10_35;
int u_xlati35;
bool u_xlatb35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
bool u_xlatb39;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_33 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_33) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_36 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat33 = max(u_xlat33, 0.0);
    u_xlati33 = int(u_xlat33);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat11 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11 = floor(u_xlat11);
    u_xlat1.x = max(u_xlat11, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat12.xy = vec2(u_xlat16_36) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_36 = (u_xlati1 != 0) ? u_xlat12.y : u_xlat12.x;
    u_xlat16_36 = u_xlat16_36 + vs_COLOR1;
    u_xlat16_37 = u_xlat16_36 * 0.5 + (-_LightArea);
    u_xlat16_37 = u_xlat16_37 + 1.0;
    u_xlat16_37 = floor(u_xlat16_37);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlati1 = int(u_xlat16_37);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati33) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat2.xyz;
    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat34) + _WorldSpaceLightPos0.xyz;
    u_xlat35 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat8.xyz = vec3(u_xlat35) * u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb39 = 0.5<_CustomLightDir.w;
#endif
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat35) + (-_WorldSpaceLightPos0.xyz);
    u_xlat35 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_5.xyz = u_xlat7.xyz * vec3(u_xlat35) + _CustomLightDir.xyz;
    u_xlat16_37 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_5.xyz = vec3(u_xlat16_37) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb39)) ? u_xlat16_5.xyz : u_xlat8.xyz;
    u_xlat16_37 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = log2(u_xlat16_37);
    u_xlat16_37 = u_xlat16_37 * _Shininess;
    u_xlat16_37 = exp2(u_xlat16_37);
    u_xlat16_35 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_35 = (-u_xlat16_37) + u_xlat16_35;
    u_xlat35 = u_xlat16_35 + 1.0;
    u_xlat35 = floor(u_xlat35);
    u_xlat35 = max(u_xlat35, 0.0);
    u_xlati35 = int(u_xlat35);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati35) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(_ModifySpec==0.0);
#else
    u_xlatb35 = _ModifySpec==0.0;
#endif
    if(u_xlatb35){
        u_xlat16_37 = dot(u_xlat1.xyz, u_xlat8.xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_5.x = (-u_xlat16_37) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati35 = int(u_xlat16_5.x);
        if(u_xlati35 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb35 = !!(u_xlat16_37<_MaxSpecGradient);
#else
            u_xlatb35 = u_xlat16_37<_MaxSpecGradient;
#endif
            u_xlat16_37 = u_xlat16_37 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_37 = u_xlat16_37 / u_xlat16_5.x;
            u_xlat16_37 = log2(u_xlat16_37);
            u_xlat16_37 = u_xlat16_37 * _ModifySpecPower;
            u_xlat16_37 = exp2(u_xlat16_37);
            u_xlat16_37 = (u_xlatb35) ? u_xlat16_37 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_35 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_7.xyz = vec3(u_xlat10_35) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_7.xyz * vec3(u_xlat16_37) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_37 = dot(u_xlat1.xyz, u_xlat8.xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_5.x = (-u_xlat16_37) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati35 = int(u_xlat16_5.x);
        if(u_xlati35 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb35 = !!(u_xlat16_37<_MaxSpecGradient);
#else
            u_xlatb35 = u_xlat16_37<_MaxSpecGradient;
#endif
            if(u_xlatb35){
                u_xlat16_37 = u_xlat16_37 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_37 = u_xlat16_37 / u_xlat16_5.x;
                u_xlat16_37 = log2(u_xlat16_37);
                u_xlat16_37 = u_xlat16_37 * _ModifySpecPower;
                u_xlat16_37 = exp2(u_xlat16_37);
                u_xlat16_37 = (-u_xlat16_37) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_37) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_35 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_7.xyz = vec3(u_xlat10_35) * u_xlat16_5.xyz;
                u_xlat16_7.xyz = u_xlat16_7.xyz;
            } else {
                u_xlat16_7.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_7.x = float(1.0);
            u_xlat16_7.y = float(1.0);
            u_xlat16_7.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb35 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb35){
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb35 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb35){
            u_xlat8.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat8.xy = u_xlat8.xy * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb30.xy = greaterThanEqual(u_xlat8.xyxy, (-u_xlat8.xyxy)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb30.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb30.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat35 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat35 = vs_TEXCOORD3.z * 17.0 + (-u_xlat35);
            u_xlat35 = u_xlat35 + 0.99000001;
            u_xlat35 = floor(u_xlat35);
            u_xlat35 = max(u_xlat35, 0.0);
            u_xlati35 = int(u_xlat35);
            if((u_xlati35)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_8.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_9.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_37 = u_xlat10_9.x * 1.99000001;
    u_xlat35 = u_xlat16_37 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat34) + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat9.xyz = u_xlat10_9.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat34) + u_xlat9.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_8.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_5.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat8.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat35));
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat8.xy = floor(u_xlat8.xy);
    u_xlat8.xy = max(u_xlat8.xy, vec2(0.0, 0.0));
    u_xlati8.xy = ivec2(u_xlat8.xy);
    u_xlat34 = u_xlat34 * 1.70000005 + (-u_xlat35);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat9.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat35 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat9.xyz = vec3(u_xlat34) * u_xlat9.xyz + u_xlat2.xyz;
    u_xlat34 = u_xlat34 * u_xlat35 + _BloomFactor;
    u_xlat16_5.xyz = (u_xlati8.y != 0) ? u_xlat2.xyz : u_xlat9.xyz;
    u_xlat16_37 = (u_xlati8.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati8.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati8.x != 0) ? u_xlat16_5.xyz : u_xlat2.xyz;
    SV_Target0.w = (u_xlati8.x != 0) ? u_xlat16_37 : _BloomFactor;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_37 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat16_37 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xzw + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
int u_xlati1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
ivec2 u_xlati8;
uvec2 u_xlatu8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec2 u_xlat12;
bvec2 u_xlatb30;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_35;
lowp float u_xlat10_35;
int u_xlati35;
bool u_xlatb35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
bool u_xlatb39;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_33 = texture(_factorTex, vs_TEXCOORD0.xy).x;
    u_xlat1.x = texture(_indexTex, vs_TEXCOORD0.xy).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_2.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_33) * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_36 = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat33 = max(u_xlat33, 0.0);
    u_xlati33 = int(u_xlat33);
    u_xlat16_4.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_4.x = u_xlat16_4.x * 0.5 + (-_SecondShadow);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati1 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_3.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati1) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat11 = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11 = floor(u_xlat11);
    u_xlat1.x = max(u_xlat11, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat12.xy = vec2(u_xlat16_36) * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_36 = (u_xlati1 != 0) ? u_xlat12.y : u_xlat12.x;
    u_xlat16_36 = u_xlat16_36 + vs_COLOR1;
    u_xlat16_37 = u_xlat16_36 * 0.5 + (-_LightArea);
    u_xlat16_37 = u_xlat16_37 + 1.0;
    u_xlat16_37 = floor(u_xlat16_37);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlati1 = int(u_xlat16_37);
    u_xlat16_5.xyz = (int(u_xlati1) != 0) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
    u_xlat16_4.xyz = (int(u_xlati33) != 0) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat6.xyz = vec3(u_xlat34) * u_xlat2.xyz;
    u_xlat7.xyz = u_xlat2.xyz * vec3(u_xlat34) + _WorldSpaceLightPos0.xyz;
    u_xlat35 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat8.xyz = vec3(u_xlat35) * u_xlat7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb39 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb39 = 0.5<_CustomLightDir.w;
#endif
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat35) + (-_WorldSpaceLightPos0.xyz);
    u_xlat35 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_5.xyz = u_xlat7.xyz * vec3(u_xlat35) + _CustomLightDir.xyz;
    u_xlat16_37 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_5.xyz = vec3(u_xlat16_37) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (bool(u_xlatb39)) ? u_xlat16_5.xyz : u_xlat8.xyz;
    u_xlat16_37 = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_37 = max(u_xlat16_37, 0.0);
    u_xlat16_37 = log2(u_xlat16_37);
    u_xlat16_37 = u_xlat16_37 * _Shininess;
    u_xlat16_37 = exp2(u_xlat16_37);
    u_xlat16_35 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_35 = (-u_xlat16_37) + u_xlat16_35;
    u_xlat35 = u_xlat16_35 + 1.0;
    u_xlat35 = floor(u_xlat35);
    u_xlat35 = max(u_xlat35, 0.0);
    u_xlati35 = int(u_xlat35);
    u_xlat16_5.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = (int(u_xlati35) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(_ModifySpec==0.0);
#else
    u_xlatb35 = _ModifySpec==0.0;
#endif
    if(u_xlatb35){
        u_xlat16_37 = dot(u_xlat1.xyz, u_xlat8.xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_5.x = (-u_xlat16_37) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati35 = int(u_xlat16_5.x);
        if(u_xlati35 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb35 = !!(u_xlat16_37<_MaxSpecGradient);
#else
            u_xlatb35 = u_xlat16_37<_MaxSpecGradient;
#endif
            u_xlat16_37 = u_xlat16_37 + (-_ModifySpecThreshold);
            u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_37 = u_xlat16_37 / u_xlat16_5.x;
            u_xlat16_37 = log2(u_xlat16_37);
            u_xlat16_37 = u_xlat16_37 * _ModifySpecPower;
            u_xlat16_37 = exp2(u_xlat16_37);
            u_xlat16_37 = (u_xlatb35) ? u_xlat16_37 : 1.0;
            u_xlat16_5.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_35 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_7.xyz = vec3(u_xlat10_35) * u_xlat16_5.xyz;
            u_xlat16_4.xyz = u_xlat16_7.xyz * vec3(u_xlat16_37) + u_xlat16_4.xyz;
            u_xlat16_4.xyz = u_xlat16_4.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_37 = dot(u_xlat1.xyz, u_xlat8.xyz);
        u_xlat16_37 = max(u_xlat16_37, 0.0);
        u_xlat16_5.x = (-u_xlat16_37) + _ModifySpecThreshold;
        u_xlat16_5.x = u_xlat16_5.x + 1.0;
        u_xlat16_5.x = floor(u_xlat16_5.x);
        u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
        u_xlati35 = int(u_xlat16_5.x);
        if(u_xlati35 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb35 = !!(u_xlat16_37<_MaxSpecGradient);
#else
            u_xlatb35 = u_xlat16_37<_MaxSpecGradient;
#endif
            if(u_xlatb35){
                u_xlat16_37 = u_xlat16_37 + (-_ModifySpecThreshold);
                u_xlat16_5.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_37 = u_xlat16_37 / u_xlat16_5.x;
                u_xlat16_37 = log2(u_xlat16_37);
                u_xlat16_37 = u_xlat16_37 * _ModifySpecPower;
                u_xlat16_37 = exp2(u_xlat16_37);
                u_xlat16_37 = (-u_xlat16_37) + 1.0;
                u_xlat16_5.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_5.xyz = vec3(u_xlat16_37) * u_xlat16_5.xyz + _ModifySpecColor.xyz;
                u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_35 = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_7.xyz = vec3(u_xlat10_35) * u_xlat16_5.xyz;
                u_xlat16_7.xyz = u_xlat16_7.xyz;
            } else {
                u_xlat16_7.xyz = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_7.x = float(1.0);
            u_xlat16_7.y = float(1.0);
            u_xlat16_7.z = float(1.0);
        //ENDIF
        }
        u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb35 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb35){
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb35 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb35){
            u_xlat8.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat8.xy = u_xlat8.xy * _ScreenParams.yx;
            u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
            u_xlatb30.xy = greaterThanEqual(u_xlat8.xyxy, (-u_xlat8.xyxy)).xy;
            u_xlat8.xy = fract(abs(u_xlat8.xy));
            u_xlat8.x = (u_xlatb30.x) ? u_xlat8.x : (-u_xlat8.x);
            u_xlat8.y = (u_xlatb30.y) ? u_xlat8.y : (-u_xlat8.y);
            u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
            u_xlatu8.xy = uvec2(u_xlat8.xy);
            u_xlat0.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat0.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu8.y)]);
            u_xlat35 = dot(u_xlat0, ImmCB_0_0_0[int(u_xlatu8.x)]);
            u_xlat35 = vs_TEXCOORD3.z * 17.0 + (-u_xlat35);
            u_xlat35 = u_xlat35 + 0.99000001;
            u_xlat35 = floor(u_xlat35);
            u_xlat35 = max(u_xlat35, 0.0);
            u_xlati35 = int(u_xlat35);
            if((u_xlati35)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_8.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_9.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_37 = u_xlat10_9.x * 1.99000001;
    u_xlat35 = u_xlat16_37 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat34) + (-_WorldSpaceCameraPos.xyz);
    u_xlat34 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat9.xyz = u_xlat10_9.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat34) + u_xlat9.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat34 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat34 = u_xlat34 + u_xlat34;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat34)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_8.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_5.xyz;
    u_xlat34 = _SPNoiseScaler * _SPTransition;
    u_xlat8.xy = vec2(u_xlat34) * vec2(1.70000005, 1.5) + (-vec2(u_xlat35));
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat8.xy = floor(u_xlat8.xy);
    u_xlat8.xy = max(u_xlat8.xy, vec2(0.0, 0.0));
    u_xlati8.xy = ivec2(u_xlat8.xy);
    u_xlat34 = u_xlat34 * 1.70000005 + (-u_xlat35);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat9.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat35 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat9.xyz = vec3(u_xlat34) * u_xlat9.xyz + u_xlat2.xyz;
    u_xlat34 = u_xlat34 * u_xlat35 + _BloomFactor;
    u_xlat16_5.xyz = (u_xlati8.y != 0) ? u_xlat2.xyz : u_xlat9.xyz;
    u_xlat16_37 = (u_xlati8.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati8.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati8.x != 0) ? u_xlat16_5.xyz : u_xlat2.xyz;
    SV_Target0.w = (u_xlati8.x != 0) ? u_xlat16_37 : _BloomFactor;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xyz;
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_37 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat16_37 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xzw + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
uvec2 u_xlatu4;
vec4 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
ivec3 u_xlati11;
float u_xlat12;
mediump vec3 u_xlat16_18;
float u_xlat22;
mediump float u_xlat16_22;
int u_xlati22;
bvec2 u_xlatb26;
float u_xlat33;
lowp float u_xlat10_33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
    u_xlat4.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat5.xyz = vec3(u_xlat33) * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb34 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + (-_WorldSpaceLightPos0.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat33) + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? u_xlat16_8.xyz : u_xlat5.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_40) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xzw * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xzw * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb26.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb26.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat5.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat34 = dot(u_xlat5, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_40 = u_xlat10_5.x * 1.99000001;
    u_xlat34 = u_xlat16_40 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat35 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat35 = u_xlat35 + u_xlat35;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat35)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_8.xyz;
    u_xlat35 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat35) * vec2(1.70000005, 1.5) + (-vec2(u_xlat34));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat34 = u_xlat35 * 1.70000005 + (-u_xlat34);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat35 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat34 = u_xlat34 * u_xlat35 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati4.y != 0) ? u_xlat2.xyz : u_xlat5.xyz;
    u_xlat16_40 = (u_xlati4.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati4.x != 0) ? u_xlat16_8.xyz : u_xlat2.xyz;
    SV_Target0.w = (u_xlati4.x != 0) ? u_xlat16_40 : _BloomFactor;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_40 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat16_40 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
uvec2 u_xlatu4;
vec4 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
ivec3 u_xlati11;
float u_xlat12;
mediump vec3 u_xlat16_18;
float u_xlat22;
mediump float u_xlat16_22;
int u_xlati22;
bvec2 u_xlatb26;
float u_xlat33;
lowp float u_xlat10_33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
    u_xlat4.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat5.xyz = vec3(u_xlat33) * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb34 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + (-_WorldSpaceLightPos0.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat33) + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? u_xlat16_8.xyz : u_xlat5.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_40) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xzw * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xzw * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb26.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb26.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat5.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat34 = dot(u_xlat5, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_40 = u_xlat10_5.x * 1.99000001;
    u_xlat34 = u_xlat16_40 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat35 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat35 = u_xlat35 + u_xlat35;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat35)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_8.xyz;
    u_xlat35 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat35) * vec2(1.70000005, 1.5) + (-vec2(u_xlat34));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat34 = u_xlat35 * 1.70000005 + (-u_xlat34);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat35 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat34 = u_xlat34 * u_xlat35 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati4.y != 0) ? u_xlat2.xyz : u_xlat5.xyz;
    u_xlat16_40 = (u_xlati4.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati4.x != 0) ? u_xlat16_8.xyz : u_xlat2.xyz;
    SV_Target0.w = (u_xlati4.x != 0) ? u_xlat16_40 : _BloomFactor;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_40 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat16_40 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_COLOR1;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4 = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat10.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat10.y = u_xlat12 * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb0 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat0.x = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat0.x;
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
uniform 	mediump float _lightProbToggle;
uniform 	mediump vec4 _lightProbColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump float _SecondShadow;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump vec3 _SecondShadowMultColor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _indexTex_TexelSize;
uniform 	mediump vec4 _ModifySpecColor;
uniform 	mediump float _ModifySpecThreshold;
uniform 	mediump float _MaxSpecGradient;
uniform 	mediump float _ModifySpecPower;
uniform 	mediump float _ModifySpecCoff;
uniform 	float _UsingDitherAlpha;
uniform 	mediump float _ModifySpec;
uniform lowp sampler2D _LightMapTex;
uniform lowp sampler2D _factorTex;
uniform lowp sampler2D _indexTex;
uniform lowp sampler2D _tableTex;
uniform lowp sampler2D _ModifySpecMask;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_COLOR1;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
uvec2 u_xlatu4;
vec4 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
ivec3 u_xlati11;
float u_xlat12;
mediump vec3 u_xlat16_18;
float u_xlat22;
mediump float u_xlat16_22;
int u_xlati22;
bvec2 u_xlatb26;
float u_xlat33;
lowp float u_xlat10_33;
float u_xlat34;
int u_xlati34;
bool u_xlatb34;
float u_xlat35;
mediump float u_xlat16_40;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0.xyz = texture(_LightMapTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1 = vec4(float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w, float(1.0) / _indexTex_TexelSize.z, float(1.0) / _indexTex_TexelSize.w);
    u_xlat2.xy = vs_TEXCOORD0.xy * _indexTex_TexelSize.zw + vec2(-0.5, -0.5);
    u_xlat3 = floor(u_xlat2.xyxy);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat4 = vec4(u_xlat3.z + float(0.5), u_xlat3.w + float(0.5), u_xlat3.z + float(1.5), u_xlat3.w + float(0.5));
    u_xlat4 = u_xlat1 * u_xlat4;
    u_xlat10_33 = texture(_factorTex, u_xlat4.xy).x;
    u_xlat5.x = texture(_indexTex, u_xlat4.xy).w;
    u_xlat5.y = float(0.0);
    u_xlat5.z = float(1.0);
    u_xlat10_6.xyz = texture(_tableTex, u_xlat5.xy).xyz;
    u_xlat10_5.xyz = texture(_tableTex, u_xlat5.xz).xyz;
    u_xlat16_7.xyz = (-u_xlat10_6.xyz) + u_xlat10_5.xyz;
    u_xlat16_7.xyz = vec3(u_xlat10_33) * u_xlat16_7.xyz + u_xlat10_6.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat4.zw).x;
    u_xlat4.x = texture(_indexTex, u_xlat4.zw).w;
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(1.0);
    u_xlat10_5.xyz = texture(_tableTex, u_xlat4.xy).xyz;
    u_xlat10_4.xyz = texture(_tableTex, u_xlat4.xz).xyz;
    u_xlat16_8.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_8.xyz = vec3(u_xlat10_33) * u_xlat16_8.xyz + u_xlat10_5.xyz;
    u_xlat3 = u_xlat3 + vec4(0.5, 1.5, 1.5, 1.5);
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat10_33 = texture(_factorTex, u_xlat1.xy).x;
    u_xlat3.x = texture(_indexTex, u_xlat1.xy).w;
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat10_4.xyz = texture(_tableTex, u_xlat3.xy).xyz;
    u_xlat10_3.xyz = texture(_tableTex, u_xlat3.xz).xyz;
    u_xlat16_9.xyz = (-u_xlat10_4.xyz) + u_xlat10_3.xyz;
    u_xlat16_9.xyz = vec3(u_xlat10_33) * u_xlat16_9.xyz + u_xlat10_4.xyz;
    u_xlat10_33 = texture(_factorTex, u_xlat1.zw).x;
    u_xlat1.x = texture(_indexTex, u_xlat1.zw).w;
    u_xlat1.y = float(0.0);
    u_xlat1.z = float(1.0);
    u_xlat10_3.xyz = texture(_tableTex, u_xlat1.xy).xyz;
    u_xlat10_1.xyz = texture(_tableTex, u_xlat1.xz).xyz;
    u_xlat16_10.xyz = (-u_xlat10_3.xyz) + u_xlat10_1.xyz;
    u_xlat16_10.xyz = vec3(u_xlat10_33) * u_xlat16_10.xyz + u_xlat10_3.xyz;
    u_xlat16_1.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = (-u_xlat16_9.xyz) + u_xlat16_10.xyz;
    u_xlat2.xzw = u_xlat2.xxx * u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + u_xlat2.xzw;
    u_xlat1.xyz = u_xlat2.yyy * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat16_7.x = u_xlat10_0.y * vs_COLOR0.x;
    u_xlat33 = vs_COLOR0.x * u_xlat10_0.y + 0.909999967;
    u_xlat33 = floor(u_xlat33);
    u_xlat11.z = max(u_xlat33, 0.0);
    u_xlat16_18.x = vs_COLOR0.x * u_xlat10_0.y + vs_COLOR1;
    u_xlat16_18.x = u_xlat16_18.x * 0.5 + (-_SecondShadow);
    u_xlat16_18.x = u_xlat16_18.x + 1.0;
    u_xlat16_18.x = floor(u_xlat16_18.x);
    u_xlat16_18.x = max(u_xlat16_18.x, 0.0);
    u_xlati34 = int(u_xlat16_18.x);
    u_xlat16_18.xyz = u_xlat1.xyz * _SecondShadowMultColor.xyz;
    u_xlat16_8.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_18.xyz = (int(u_xlati34) != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = (-vs_COLOR0.x) * u_xlat10_0.y + 1.5;
    u_xlat11.x = floor(u_xlat11.x);
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlati11.xz = ivec2(u_xlat11.xz);
    u_xlat2.xy = u_xlat16_7.xx * vec2(1.20000005, 1.25) + vec2(-0.100000001, -0.125);
    u_xlat16_7.x = (u_xlati11.x != 0) ? u_xlat2.y : u_xlat2.x;
    u_xlat16_7.x = u_xlat16_7.x + vs_COLOR1;
    u_xlat16_7.x = u_xlat16_7.x * 0.5 + (-_LightArea);
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
    u_xlat16_7.x = floor(u_xlat16_7.x);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlati11.x = int(u_xlat16_7.x);
    u_xlat16_8.xyz = (u_xlati11.x != 0) ? u_xlat1.xyz : u_xlat16_8.xyz;
    u_xlat16_7.xyz = (u_xlati11.z != 0) ? u_xlat16_8.xyz : u_xlat16_18.xyz;
    u_xlat11.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat1.xyz = u_xlat11.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat3.xyz = u_xlat11.xxx * u_xlat2.xyz;
    u_xlat4.xyz = u_xlat2.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat5.xyz = vec3(u_xlat33) * u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb34 = 0.5<_CustomLightDir.w;
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + (-_WorldSpaceLightPos0.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_8.xyz = u_xlat4.xyz * vec3(u_xlat33) + _CustomLightDir.xyz;
    u_xlat16_40 = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? u_xlat16_8.xyz : u_xlat5.xyz;
    u_xlat16_40 = dot(u_xlat1.xyz, u_xlat16_8.xyz);
    u_xlat16_40 = max(u_xlat16_40, 0.0);
    u_xlat16_40 = log2(u_xlat16_40);
    u_xlat16_40 = u_xlat16_40 * _Shininess;
    u_xlat16_40 = exp2(u_xlat16_40);
    u_xlat16_22 = (-u_xlat10_0.z) + 1.0;
    u_xlat16_22 = (-u_xlat16_40) + u_xlat16_22;
    u_xlat22 = u_xlat16_22 + 1.0;
    u_xlat22 = floor(u_xlat22);
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlati22 = int(u_xlat22);
    u_xlat16_8.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_8.xyz = u_xlat10_0.xxx * u_xlat16_8.xyz;
    u_xlat16_8.xyz = (int(u_xlati22) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ModifySpec==0.0);
#else
    u_xlatb0 = _ModifySpec==0.0;
#endif
    if(u_xlatb0){
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
            u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
            u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
            u_xlat16_40 = log2(u_xlat16_40);
            u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
            u_xlat16_40 = exp2(u_xlat16_40);
            u_xlat16_40 = (u_xlatb0) ? u_xlat16_40 : 1.0;
            u_xlat16_8.xyz = _ModifySpecColor.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
            u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti));
            u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
            u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
            u_xlat16_7.xyz = u_xlat16_0.xzw * vec3(u_xlat16_40) + u_xlat16_7.xyz;
            u_xlat16_7.xyz = u_xlat16_7.xyz;
        //ENDIF
        }
    } else {
        u_xlat16_40 = dot(u_xlat1.xyz, u_xlat5.xyz);
        u_xlat16_40 = max(u_xlat16_40, 0.0);
        u_xlat16_8.x = (-u_xlat16_40) + _ModifySpecThreshold;
        u_xlat16_8.x = u_xlat16_8.x + 1.0;
        u_xlat16_8.x = floor(u_xlat16_8.x);
        u_xlat16_8.x = max(u_xlat16_8.x, 0.0);
        u_xlati0 = int(u_xlat16_8.x);
        if(u_xlati0 == 0) {
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat16_40<_MaxSpecGradient);
#else
            u_xlatb0 = u_xlat16_40<_MaxSpecGradient;
#endif
            if(u_xlatb0){
                u_xlat16_40 = u_xlat16_40 + (-_ModifySpecThreshold);
                u_xlat16_8.x = (-_ModifySpecThreshold) + _MaxSpecGradient;
                u_xlat16_40 = u_xlat16_40 / u_xlat16_8.x;
                u_xlat16_40 = log2(u_xlat16_40);
                u_xlat16_40 = u_xlat16_40 * _ModifySpecPower;
                u_xlat16_40 = exp2(u_xlat16_40);
                u_xlat16_40 = (-u_xlat16_40) + 1.0;
                u_xlat16_8.xyz = (-_ModifySpecColor.xyz) + vec3(1.0, 1.0, 1.0);
                u_xlat16_8.xyz = vec3(u_xlat16_40) * u_xlat16_8.xyz + _ModifySpecColor.xyz;
                u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(vec3(_ModifySpecCoff, _ModifySpecCoff, _ModifySpecCoff));
                u_xlat10_0.x = texture(_ModifySpecMask, vs_TEXCOORD0.xy).x;
                u_xlat16_0.xzw = u_xlat10_0.xxx * u_xlat16_8.xyz;
                u_xlat16_0.xzw = u_xlat16_0.xzw;
            } else {
                u_xlat16_0.xzw = _ModifySpecColor.xyz;
            //ENDIF
            }
        } else {
            u_xlat16_0.x = float(1.0);
            u_xlat16_0.z = float(1.0);
            u_xlat16_0.w = float(1.0);
        //ENDIF
        }
        u_xlat16_7.xyz = u_xlat16_0.xzw * u_xlat16_7.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb34 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb34){
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb34 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb34){
            u_xlat4.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat4.xy = u_xlat4.xy * _ScreenParams.yx;
            u_xlat4.xy = u_xlat4.xy * vec2(0.25, 0.25);
            u_xlatb26.xy = greaterThanEqual(u_xlat4.xyxy, (-u_xlat4.xyxy)).xy;
            u_xlat4.xy = fract(abs(u_xlat4.xy));
            u_xlat4.x = (u_xlatb26.x) ? u_xlat4.x : (-u_xlat4.x);
            u_xlat4.y = (u_xlatb26.y) ? u_xlat4.y : (-u_xlat4.y);
            u_xlat4.xy = u_xlat4.xy * vec2(4.0, 4.0);
            u_xlatu4.xy = uvec2(u_xlat4.xy);
            u_xlat5.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat5.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu4.y)]);
            u_xlat34 = dot(u_xlat5, ImmCB_0_0_0[int(u_xlatu4.x)]);
            u_xlat34 = vs_TEXCOORD3.z * 17.0 + (-u_xlat34);
            u_xlat34 = u_xlat34 + 0.99000001;
            u_xlat34 = floor(u_xlat34);
            u_xlat34 = max(u_xlat34, 0.0);
            u_xlati34 = int(u_xlat34);
            if((u_xlati34)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat16_40 = u_xlat10_5.x * 1.99000001;
    u_xlat34 = u_xlat16_40 * _SPNoiseScaler + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat11.xxx + (-_WorldSpaceCameraPos.xyz);
    u_xlat35 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat35 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat35 = u_xlat35 + u_xlat35;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat35)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_9.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_8.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_8.xyz;
    u_xlat35 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat35) * vec2(1.70000005, 1.5) + (-vec2(u_xlat34));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat34 = u_xlat35 * 1.70000005 + (-u_xlat34);
    u_xlat34 = u_xlat34 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat35 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat5.xyz = vec3(u_xlat34) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat34 = u_xlat34 * u_xlat35 + _BloomFactor;
    u_xlat16_8.xyz = (u_xlati4.y != 0) ? u_xlat2.xyz : u_xlat5.xyz;
    u_xlat16_40 = (u_xlati4.y != 0) ? _BloomFactor : u_xlat34;
    u_xlat34 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_8.xyz = (u_xlati4.x != 0) ? u_xlat16_8.xyz : u_xlat2.xyz;
    SV_Target0.w = (u_xlati4.x != 0) ? u_xlat16_40 : _BloomFactor;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_7.xyz = u_xlat2.xyz * u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.5<_lightProbToggle);
#else
    u_xlatb34 = 0.5<_lightProbToggle;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb34)) ? _lightProbColor.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_8.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_40 = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_40 = min(max(u_xlat16_40, 0.0), 1.0);
#else
    u_xlat16_40 = clamp(u_xlat16_40, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat16_40 * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat1.xyz;
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
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "Reflected" = "Reflected" "RenderType" = "Opaque" }
  ZWrite Off
  Cull Front
  GpuProgramID 95966
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_COLOR0.w = 1.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_COLOR0.w = 1.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_COLOR0.w = 1.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    SV_Target0.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target0.w = vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat5;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_COLOR0.w = 1.0;
    u_xlat1 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat1.w + u_xlat1.y;
    u_xlat5 = u_xlat1.x * in_POSITION0.x;
    u_xlat2.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat2.y = u_xlat5 * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat5;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_COLOR0.w = 1.0;
    u_xlat1 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat1.w + u_xlat1.y;
    u_xlat5 = u_xlat1.x * in_POSITION0.x;
    u_xlat2.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat2.y = u_xlat5 * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _MaxOutlineZOffset;
uniform 	mediump float _Scale;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat5;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy * in_TANGENT0.yy;
    u_xlat0 = u_xlat0 * in_POSITION0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.xx + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.xxxx + u_xlat0;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1.xy = u_xlat2.xy * in_TANGENT0.zz + u_xlat1.xy;
    u_xlat0 = u_xlat2 * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.z = 0.00999999978;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat1.xy * u_xlat16_3.xx;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_MaxOutlineZOffset);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat13 = in_COLOR0.z + -0.5;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13) + u_xlat0.xyz;
    u_xlat0.x = (-u_xlat0.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat0.x / _Scale;
    u_xlat0.x = inversesqrt(u_xlat16_11);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat0.x * u_xlat16_11;
    u_xlat0.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    vs_COLOR0.w = 1.0;
    u_xlat1 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat1.w + u_xlat1.y;
    u_xlat5 = u_xlat1.x * in_POSITION0.x;
    u_xlat2.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat2.y = u_xlat5 * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD3.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.x = vs_COLOR0.w + 0.99000001;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    if((u_xlati0)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD3.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * _Color.xyz;
    SV_Target0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.CharacterShaderEditorBase"
}