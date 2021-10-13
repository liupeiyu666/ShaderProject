//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Face_Trans" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
[Header(Texture)] _MainTex ("Main Tex (RGB)", 2D) = "white" { }
_LightMapTex ("Light Map Tex (RGB)", 2D) = "white" { }
_LightMapRowState ("Light Map Row state (RGB)", 2D) = "white" { }
_LightMapRowStateIDSForPixels ("Light Map Row state ids for pixels (RGB)", 2D) = "white" { }
[Toggle(USINGRGTOGETROWSTATE)] _UsingRGToGetRowState ("Using rg to get rowstate index, otherwise ba", Float) = 0
[Toggle(ISFLIPLIGHTMAPINHORIZON)] _IsFlipLightMapInHorizon ("Is Flip LightMap InHorizon", Float) = 0
_DegreeInY ("Degree In Y", Float) = 0
[Header(Light)] _LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
[Header(Shadow)] _LightArea ("Light Area Threshold", Range(0, 1)) = 0.5
_FirstShadowMultColor ("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
[Header(Specular)] _Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
[Header(Prepass Lighting)] _PrelightThreshold ("Prepass Lighting Threshold (Log)", Range(0, 10)) = 0.5
_PrelightScaler ("Prepass Lighting Scaler", Range(0, 10)) = 1
[Header(Outline)] _OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
[Header(Camera Fade)] _FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
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
_Opaqueness ("Trans", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 39715
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
lowp vec2 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_10;
vec2 u_xlat14;
mediump float u_xlat16_14;
int u_xlati14;
uvec2 u_xlatu14;
bool u_xlatb14;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_24;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat21 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat21 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb14 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb14){
            u_xlat14.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat14.xy = u_xlat14.xy * _ScreenParams.yx;
            u_xlat14.xy = u_xlat14.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat14.xyxx, (-u_xlat14.xyxx)).xy;
            u_xlat14.xy = fract(abs(u_xlat14.xy));
            u_xlat14.x = (u_xlatb1.x) ? u_xlat14.x : (-u_xlat14.x);
            u_xlat14.y = (u_xlatb1.y) ? u_xlat14.y : (-u_xlat14.y);
            u_xlat14.xy = u_xlat14.xy * vec2(4.0, 4.0);
            u_xlatu14.xy = uvec2(u_xlat14.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu14.y)]);
            u_xlat14.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu14.x)]);
            u_xlat14.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat14.x);
            u_xlat14.x = u_xlat14.x + 0.99000001;
            u_xlat14.x = floor(u_xlat14.x);
            u_xlat14.x = max(u_xlat14.x, 0.0);
            u_xlati14 = int(u_xlat14.x);
            if((u_xlati14)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat7 = trunc(u_xlat2.w);
    u_xlat7 = exp2(u_xlat7);
    u_xlat0.x = u_xlat0.x / u_xlat7;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb7 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb7) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_7.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<u_xlat10_7.x);
#else
    u_xlatb7 = 0.5<u_xlat10_7.x;
#endif
    u_xlat16_14 = vs_COLOR0.x * u_xlat10_7.y + -0.5;
    u_xlat16_14 = u_xlat16_14 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_14 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati14 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati14 != 0) ? 1.0 : 0.0;
    u_xlat16_10 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb7) ? u_xlat16_10 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_4.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_24 = u_xlat10_4.x * 1.99000001;
    u_xlat22 = u_xlat16_24 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_2.xyz * _SPOldColor.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_5.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat1.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
    u_xlati1.xy = ivec2(u_xlat1.xy);
    u_xlat21 = u_xlat21 * 1.70000005 + (-u_xlat22);
    u_xlat21 = u_xlat21 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat16_5.xyz = (u_xlati1.y != 0) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat21 = (u_xlati1.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_5.xyz = (u_xlati1.x != 0) ? u_xlat16_5.xyz : u_xlat0.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) + u_xlat16_5.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _DegreeInY;
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
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat13;
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
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat13 = u_xlat2.x * in_POSITION0.x;
    u_xlat10.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat10.y = u_xlat13 * 0.25 + u_xlat8;
    vs_TEXCOORD3.zw = u_xlat10.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8 = _DegreeInY + 0.499000013;
    u_xlat8 = floor(u_xlat8);
    u_xlat13 = u_xlat8 * 0.03125;
    u_xlat6.x = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.x) * 32.0 + u_xlat8;
    u_xlat13 = u_xlat8 * 0.125;
    u_xlat6.y = floor(u_xlat13);
    u_xlat8 = (-u_xlat6.y) * 8.0 + u_xlat8;
    vs_TEXCOORD4.yz = u_xlat6.xy;
    vs_TEXCOORD4.w = (-u_xlat8) + 7.0;
    vs_TEXCOORD4.x = 8.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_CustomLightDir.w);
#else
    u_xlatb8 = 0.5<_CustomLightDir.w;
#endif
    u_xlat16_3.xyz = (bool(u_xlatb8)) ? _CustomLightDir.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat8 = u_xlat16_3.x * 0.497500002 + 0.5;
    vs_COLOR1 = u_xlat8;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD6.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb8)));
    vs_TEXCOORD6.z = u_xlatb8 ? _DitherAlpha : float(0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _LightArea;
uniform 	mediump vec3 _FirstShadowMultColor;
uniform 	mediump float _Opaqueness;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
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
uniform 	vec4 _LightMapRowState_TexelSize;
uniform 	float _UsingRGToGetRowState;
uniform 	float _IsFlipLightMapInHorizon;
uniform 	float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMapRowStateIDSForPixels;
uniform lowp sampler2D _LightMapRowState;
uniform lowp sampler2D _LightMapTex;
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
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp vec2 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_11;
vec2 u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
uvec2 u_xlatu16;
bool u_xlatb16;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_27;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlatb0.xyz = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsFlipLightMapInHorizon, _UsingRGToGetRowState, _UsingDitherAlpha, _IsFlipLightMapInHorizon)).xyz;
    u_xlat24 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat1.x = (u_xlatb0.x) ? u_xlat24 : vs_TEXCOORD0.x;
    if(u_xlatb0.y){
        u_xlat1.y = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xy).xy;
    } else {
        u_xlat1.z = vs_TEXCOORD0.y;
        u_xlat0.xy = texture(_LightMapRowStateIDSForPixels, u_xlat1.xz).zw;
    //ENDIF
    }
    if(u_xlatb0.z){
#ifdef UNITY_ADRENO_ES3
        u_xlatb16 = !!(vs_TEXCOORD6.z<0.949999988);
#else
        u_xlatb16 = vs_TEXCOORD6.z<0.949999988;
#endif
        if(u_xlatb16){
            u_xlat16.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
            u_xlat16.xy = u_xlat16.xy * _ScreenParams.yx;
            u_xlat16.xy = u_xlat16.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat16.xyxx, (-u_xlat16.xyxx)).xy;
            u_xlat16.xy = fract(abs(u_xlat16.xy));
            u_xlat16.x = (u_xlatb1.x) ? u_xlat16.x : (-u_xlat16.x);
            u_xlat16.y = (u_xlatb1.y) ? u_xlat16.y : (-u_xlat16.y);
            u_xlat16.xy = u_xlat16.xy * vec2(4.0, 4.0);
            u_xlatu16.xy = uvec2(u_xlat16.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu16.y)]);
            u_xlat16.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu16.x)]);
            u_xlat16.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat16.x);
            u_xlat16.x = u_xlat16.x + 0.99000001;
            u_xlat16.x = floor(u_xlat16.x);
            u_xlat16.x = max(u_xlat16.x, 0.0);
            u_xlati16 = int(u_xlat16.x);
            if((u_xlati16)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2 = vs_TEXCOORD4 + vec4(0.499000013, 0.499000013, 0.499000013, 0.499000013);
    u_xlati2.xyz = ivec3(u_xlat2.xyz);
    u_xlat0.xy = u_xlat0.xy * vec2(255.0, 255.0) + vec2(0.499000013, 0.499000013);
    u_xlati0 = int(u_xlat0.x);
    u_xlati0 = u_xlati0 * u_xlati2.x + u_xlati2.y;
    u_xlat2.x = float(u_xlati0);
    u_xlat2.y = trunc(u_xlat0.y);
    u_xlat0.xy = _LightMapRowState_TexelSize.xy * vec2(0.499000013, 0.499000013);
    u_xlat0.xy = u_xlat2.xy * _LightMapRowState_TexelSize.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_LightMapRowState, u_xlat0.xy);
    u_xlat0.x = dot(u_xlat10_0, ImmCB_0_0_0[u_xlati2.z]);
    u_xlat0.x = u_xlat0.x * 255.0 + 0.499000013;
    u_xlat0.x = trunc(u_xlat0.x);
    u_xlat8 = trunc(u_xlat2.w);
    u_xlat8 = exp2(u_xlat8);
    u_xlat0.x = u_xlat0.x / u_xlat8;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb8 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat10_8.xy = texture(_LightMapTex, vs_TEXCOORD0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<u_xlat10_8.x);
#else
    u_xlatb8 = 0.5<u_xlat10_8.x;
#endif
    u_xlat16_16 = vs_COLOR0.x * u_xlat10_8.y + -0.5;
    u_xlat16_16 = u_xlat16_16 * 1.00999999 + 0.5;
    u_xlat16_3.x = u_xlat16_16 + vs_COLOR1;
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + (-_LightArea);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = floor(u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlati16 = int(u_xlat16_3.x);
    u_xlat16_3.x = (u_xlati16 != 0) ? 1.0 : 0.0;
    u_xlat16_11 = min(u_xlat0.x, u_xlat16_3.x);
    u_xlat16_3.x = (u_xlatb8) ? u_xlat16_11 : u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.5<u_xlat16_3.x);
#else
    u_xlatb0.x = 0.5<u_xlat16_3.x;
#endif
    u_xlat16_3.xyz = u_xlat1.xyz * _FirstShadowMultColor.xyz;
    u_xlat16_3.xyz = (u_xlatb0.x) ? u_xlat1.xyz : u_xlat16_3.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat10_4.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat16_27 = u_xlat10_5.x * 1.99000001;
    u_xlat25 = u_xlat16_27 * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat5.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + u_xlat1.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat24 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat24) * vec2(1.70000005, 1.5) + (-vec2(u_xlat25));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat24 = u_xlat24 * 1.70000005 + (-u_xlat25);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati4.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat24 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_6.xyz = (u_xlati4.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_3.xyz) + u_xlat16_6.xyz;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_27 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat16_27 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = _Opaqueness;
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
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 99437
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
uniform 	mediump float _Opaqueness;
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
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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
uniform 	mediump float _Opaqueness;
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
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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
uniform 	mediump float _Opaqueness;
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
    SV_Target0.w = vs_COLOR0.w * _Opaqueness;
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
uniform 	mediump float _Opaqueness;
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
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
uniform 	mediump float _Opaqueness;
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
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
uniform 	mediump float _Opaqueness;
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
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
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
 Pass {
  Name "CONSTANT_REPLACE_NOCUTOFF"
  LOD 200
  Tags { "Distortion" = "None" "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 166818
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat16_2 = _SPOpaqueness * _BloomFactor;
    u_xlat16_2 = (u_xlati3.z != 0) ? _BloomFactor : u_xlat16_2;
    u_xlat6 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat0 = u_xlat0 * u_xlat6 + _BloomFactor;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat16_2 = _SPOpaqueness * _BloomFactor;
    u_xlat16_2 = (u_xlati3.z != 0) ? _BloomFactor : u_xlat16_2;
    u_xlat6 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat0 = u_xlat0 * u_xlat6 + _BloomFactor;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _SPNoiseTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat16_2 = _SPOpaqueness * _BloomFactor;
    u_xlat16_2 = (u_xlati3.z != 0) ? _BloomFactor : u_xlat16_2;
    u_xlat6 = _SPTransitionBloomFactor + (-_BloomFactor);
    u_xlat0 = u_xlat0 * u_xlat6 + _BloomFactor;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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