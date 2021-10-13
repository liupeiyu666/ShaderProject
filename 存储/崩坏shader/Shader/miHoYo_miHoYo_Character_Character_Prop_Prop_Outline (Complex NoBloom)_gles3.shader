//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Outline (Complex NoBloom)" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_EmissionTintColor ("Emission Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_ClipPlane ("Clip Plane (Model Space)", Vector) = (0,0,0,0)
[Toggle] _UseCameraFade ("Use Camera Fade", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 0
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
[Toggle(EMISSION_OVERRIDE)] _EmissionOverride ("Emission Override (Only store param, need to do overriding in script)", Float) = 0
_EOEmissionScaler ("Overriding Emission Scaler", Range(1, 10)) = 1
_EOEmissionBloomFactor ("Overriding Emission Bloom Factor", Float) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
[Toggle(USINGBLOOMMASK)] _UsingBloomMask ("UsingBloomMask", Float) = 0
_BloomMaskTex ("Bloom Mask Tex", 2D) = "white" { }
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 30754
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y + _OpaquenessReduse;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y + _OpaquenessReduse;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y + _OpaquenessReduse;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
bvec2 u_xlatb18;
vec2 u_xlat19;
ivec2 u_xlati19;
float u_xlat24;
mediump float u_xlat16_24;
int u_xlati24;
bool u_xlatb24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_24 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_24 = _EmissionFactorFromTexToggle * u_xlat16_24 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_24 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_24;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb24 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb18.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb18.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat24 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat24 = vs_TEXCOORD3.z * 17.0 + (-u_xlat24);
            u_xlat24 = u_xlat24 + 0.99000001;
            u_xlat24 = floor(u_xlat24);
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlati24 = int(u_xlat24);
            if((u_xlati24)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati24 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat19.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
    u_xlat19.xy = floor(u_xlat19.xy);
    u_xlat19.xy = max(u_xlat19.xy, vec2(0.0, 0.0));
    u_xlati19.xy = ivec2(u_xlat19.xy);
    u_xlat3.x = u_xlat11 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati19.y != 0) ? u_xlat10_1.xyz : u_xlat7.xyz;
    u_xlat3.x = (u_xlati19.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati19.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
bvec2 u_xlatb18;
vec2 u_xlat19;
ivec2 u_xlati19;
float u_xlat24;
mediump float u_xlat16_24;
int u_xlati24;
bool u_xlatb24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_24 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_24 = _EmissionFactorFromTexToggle * u_xlat16_24 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_24 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_24;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb24 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb18.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb18.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat24 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat24 = vs_TEXCOORD3.z * 17.0 + (-u_xlat24);
            u_xlat24 = u_xlat24 + 0.99000001;
            u_xlat24 = floor(u_xlat24);
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlati24 = int(u_xlat24);
            if((u_xlati24)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati24 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat19.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
    u_xlat19.xy = floor(u_xlat19.xy);
    u_xlat19.xy = max(u_xlat19.xy, vec2(0.0, 0.0));
    u_xlati19.xy = ivec2(u_xlat19.xy);
    u_xlat3.x = u_xlat11 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati19.y != 0) ? u_xlat10_1.xyz : u_xlat7.xyz;
    u_xlat3.x = (u_xlati19.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati19.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat11;
bvec2 u_xlatb18;
vec2 u_xlat19;
ivec2 u_xlati19;
float u_xlat24;
mediump float u_xlat16_24;
int u_xlati24;
bool u_xlatb24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_24 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_24 = _EmissionFactorFromTexToggle * u_xlat16_24 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_24 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_24;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb24 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb18.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb18.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat24 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat24 = vs_TEXCOORD3.z * 17.0 + (-u_xlat24);
            u_xlat24 = u_xlat24 + 0.99000001;
            u_xlat24 = floor(u_xlat24);
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlati24 = int(u_xlat24);
            if((u_xlati24)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati24 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat19.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat19.xy = u_xlat19.xy + vec2(1.0, 1.0);
    u_xlat19.xy = floor(u_xlat19.xy);
    u_xlat19.xy = max(u_xlat19.xy, vec2(0.0, 0.0));
    u_xlati19.xy = ivec2(u_xlat19.xy);
    u_xlat3.x = u_xlat11 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati19.y != 0) ? u_xlat10_1.xyz : u_xlat7.xyz;
    u_xlat3.x = (u_xlati19.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati19.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb20;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
float u_xlat29;
lowp float u_xlat10_29;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_3.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_29 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat29 = u_xlat10_29 * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat7 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat7) * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat29 = u_xlat7 * 1.70000005 + (-u_xlat29);
    u_xlat29 = u_xlat29 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = vec3(u_xlat29) * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat29 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_3.xyz = (u_xlati16.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_3;
    u_xlat0 = vec4(u_xlat29) * u_xlat16_1 + u_xlat16_0;
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat1 = (-u_xlat0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb20;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
float u_xlat29;
lowp float u_xlat10_29;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_3.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_29 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat29 = u_xlat10_29 * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat7 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat7) * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat29 = u_xlat7 * 1.70000005 + (-u_xlat29);
    u_xlat29 = u_xlat29 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = vec3(u_xlat29) * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat29 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_3.xyz = (u_xlati16.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_3;
    u_xlat0 = vec4(u_xlat29) * u_xlat16_1 + u_xlat16_0;
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat1 = (-u_xlat0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
vec2 u_xlat16;
ivec2 u_xlati16;
bvec2 u_xlatb20;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
float u_xlat29;
lowp float u_xlat10_29;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_3.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_29 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat29 = u_xlat10_29 * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat7 = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = vec2(u_xlat7) * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat29 = u_xlat7 * 1.70000005 + (-u_xlat29);
    u_xlat29 = u_xlat29 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = vec3(u_xlat29) * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat29 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_3.xyz = (u_xlati16.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_3;
    u_xlat0 = vec4(u_xlat29) * u_xlat16_1 + u_xlat16_0;
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat1 = (-u_xlat0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat7.xyz = (-u_xlat7.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat7.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat1.xzy;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat1.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat1.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat1.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat1.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
float u_xlat14;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat7.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat14 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat7.x = u_xlat7.x / u_xlat14;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat2.x = u_xlat7.x * _UWFogColorHLIntensity;
    u_xlat14 = (-_UWHeightFogDensity) * u_xlat7.x + 1.0;
    u_xlat14 = u_xlat14 * _UWHeightFogEffectLimit;
    u_xlat14 = max(u_xlat14, _UWHeightFogEffectStart);
    u_xlat14 = min(u_xlat14, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb21 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat7.x = (-u_xlat7.x) * _UWHeightRatio + 1.0;
    u_xlat7.x = u_xlat7.x * vs_TEXCOORD6.y;
    u_xlat7.x = max(u_xlat7.x, _UWCriticalRange);
    u_xlat7.x = min(u_xlat7.x, 1.0);
    u_xlat16_25 = (u_xlatb21) ? u_xlat7.x : vs_TEXCOORD6.y;
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD6.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat9.xyz) + u_xlat16_4.xyz;
    u_xlat9.xyz = vec3(u_xlat16_25) * u_xlat3.xyz + u_xlat9.xyz;
    u_xlat3.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat9.xyz + (-u_xlat3.xyz);
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat7.xyz : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat7.xyz = (-u_xlat7.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat7.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat1.xzy;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat1.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat1.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat1.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat1.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
float u_xlat14;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat7.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat14 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat7.x = u_xlat7.x / u_xlat14;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat2.x = u_xlat7.x * _UWFogColorHLIntensity;
    u_xlat14 = (-_UWHeightFogDensity) * u_xlat7.x + 1.0;
    u_xlat14 = u_xlat14 * _UWHeightFogEffectLimit;
    u_xlat14 = max(u_xlat14, _UWHeightFogEffectStart);
    u_xlat14 = min(u_xlat14, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb21 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat7.x = (-u_xlat7.x) * _UWHeightRatio + 1.0;
    u_xlat7.x = u_xlat7.x * vs_TEXCOORD6.y;
    u_xlat7.x = max(u_xlat7.x, _UWCriticalRange);
    u_xlat7.x = min(u_xlat7.x, 1.0);
    u_xlat16_25 = (u_xlatb21) ? u_xlat7.x : vs_TEXCOORD6.y;
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD6.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat9.xyz) + u_xlat16_4.xyz;
    u_xlat9.xyz = vec3(u_xlat16_25) * u_xlat3.xyz + u_xlat9.xyz;
    u_xlat3.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat9.xyz + (-u_xlat3.xyz);
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat7.xyz : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat7.xyz = (-u_xlat7.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat7.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat1.xzy;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat1.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat1.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat1.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat1.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
float u_xlat14;
bvec2 u_xlatb16;
float u_xlat21;
mediump float u_xlat16_21;
int u_xlati21;
bool u_xlatb21;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_21 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_21 = _EmissionFactorFromTexToggle * u_xlat16_21 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_21 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_21;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb21 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb16.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb16.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb16.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat21 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat21 = vs_TEXCOORD3.z * 17.0 + (-u_xlat21);
            u_xlat21 = u_xlat21 + 0.99000001;
            u_xlat21 = floor(u_xlat21);
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlati21 = int(u_xlat21);
            if((u_xlati21)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati21 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati21) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat7.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat14 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat7.x = u_xlat7.x / u_xlat14;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat2.x = u_xlat7.x * _UWFogColorHLIntensity;
    u_xlat14 = (-_UWHeightFogDensity) * u_xlat7.x + 1.0;
    u_xlat14 = u_xlat14 * _UWHeightFogEffectLimit;
    u_xlat14 = max(u_xlat14, _UWHeightFogEffectStart);
    u_xlat14 = min(u_xlat14, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb21 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat7.x = (-u_xlat7.x) * _UWHeightRatio + 1.0;
    u_xlat7.x = u_xlat7.x * vs_TEXCOORD6.y;
    u_xlat7.x = max(u_xlat7.x, _UWCriticalRange);
    u_xlat7.x = min(u_xlat7.x, 1.0);
    u_xlat16_25 = (u_xlatb21) ? u_xlat7.x : vs_TEXCOORD6.y;
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD6.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = (-u_xlat9.xyz) + u_xlat16_4.xyz;
    u_xlat9.xyz = vec3(u_xlat16_25) * u_xlat3.xyz + u_xlat9.xyz;
    u_xlat3.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + _UWFogColorLow.xyz;
    u_xlat2.xyz = u_xlat9.xyz + (-u_xlat3.xyz);
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat7.xyz : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat7.xyz = (-u_xlat7.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat7.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat1.xzy;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat1.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat1.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat1.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat1.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat18;
bvec2 u_xlatb18;
float u_xlat24;
mediump float u_xlat16_24;
int u_xlati24;
bool u_xlatb24;
bool u_xlatb26;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_24 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_24 = _EmissionFactorFromTexToggle * u_xlat16_24 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_24;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb24 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb18.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb18.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat24 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat24 = vs_TEXCOORD3.z * 17.0 + (-u_xlat24);
            u_xlat24 = u_xlat24 + 0.99000001;
            u_xlat24 = floor(u_xlat24);
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlati24 = int(u_xlat24);
            if((u_xlati24)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati24 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb2 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat10.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat18 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat10.x = u_xlat10.x / u_xlat18;
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlat3.x = u_xlat10.x * _UWFogColorHLIntensity;
    u_xlat18 = (-_UWHeightFogDensity) * u_xlat10.x + 1.0;
    u_xlat18 = u_xlat18 * _UWHeightFogEffectLimit;
    u_xlat18 = max(u_xlat18, _UWHeightFogEffectStart);
    u_xlat18 = min(u_xlat18, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb26 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat10.x = (-u_xlat10.x) * _UWHeightRatio + 1.0;
    u_xlat10.x = u_xlat10.x * vs_TEXCOORD6.y;
    u_xlat10.x = max(u_xlat10.x, _UWCriticalRange);
    u_xlat10.x = min(u_xlat10.x, 1.0);
    u_xlat16_4.x = (u_xlatb26) ? u_xlat10.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat11.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat11.xyz = vs_TEXCOORD6.xxx * u_xlat11.xyz + _UWFogColorFar.xyz;
    u_xlat7.xyz = u_xlat0.xyz + (-u_xlat11.xyz);
    u_xlat11.xyz = u_xlat16_4.xxx * u_xlat7.xyz + u_xlat11.xyz;
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat11.xyz + (-u_xlat7.xyz);
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat7.xyz;
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat7.xyz = (-u_xlat7.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat7.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat1.xzy;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat1.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat1.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat1.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat1.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat18;
bvec2 u_xlatb18;
float u_xlat24;
mediump float u_xlat16_24;
int u_xlati24;
bool u_xlatb24;
bool u_xlatb26;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_24 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_24 = _EmissionFactorFromTexToggle * u_xlat16_24 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_24;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb24 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb18.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb18.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat24 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat24 = vs_TEXCOORD3.z * 17.0 + (-u_xlat24);
            u_xlat24 = u_xlat24 + 0.99000001;
            u_xlat24 = floor(u_xlat24);
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlati24 = int(u_xlat24);
            if((u_xlati24)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati24 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb2 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat10.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat18 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat10.x = u_xlat10.x / u_xlat18;
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlat3.x = u_xlat10.x * _UWFogColorHLIntensity;
    u_xlat18 = (-_UWHeightFogDensity) * u_xlat10.x + 1.0;
    u_xlat18 = u_xlat18 * _UWHeightFogEffectLimit;
    u_xlat18 = max(u_xlat18, _UWHeightFogEffectStart);
    u_xlat18 = min(u_xlat18, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb26 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat10.x = (-u_xlat10.x) * _UWHeightRatio + 1.0;
    u_xlat10.x = u_xlat10.x * vs_TEXCOORD6.y;
    u_xlat10.x = max(u_xlat10.x, _UWCriticalRange);
    u_xlat10.x = min(u_xlat10.x, 1.0);
    u_xlat16_4.x = (u_xlatb26) ? u_xlat10.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat11.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat11.xyz = vs_TEXCOORD6.xxx * u_xlat11.xyz + _UWFogColorFar.xyz;
    u_xlat7.xyz = u_xlat0.xyz + (-u_xlat11.xyz);
    u_xlat11.xyz = u_xlat16_4.xxx * u_xlat7.xyz + u_xlat11.xyz;
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat11.xyz + (-u_xlat7.xyz);
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat7.xyz;
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat7.xyz = (-u_xlat7.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat7.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat1.xzy;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat1.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat1.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat1.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat1.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat18;
bvec2 u_xlatb18;
float u_xlat24;
mediump float u_xlat16_24;
int u_xlati24;
bool u_xlatb24;
bool u_xlatb26;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_24 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_24 = _EmissionFactorFromTexToggle * u_xlat16_24 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_24;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb24 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb18.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb18.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb18.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat24 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat24 = vs_TEXCOORD3.z * 17.0 + (-u_xlat24);
            u_xlat24 = u_xlat24 + 0.99000001;
            u_xlat24 = floor(u_xlat24);
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlati24 = int(u_xlat24);
            if((u_xlati24)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati24 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati24) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb2 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat10.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat18 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat10.x = u_xlat10.x / u_xlat18;
    u_xlat10.x = max(u_xlat10.x, 0.0);
    u_xlat3.x = u_xlat10.x * _UWFogColorHLIntensity;
    u_xlat18 = (-_UWHeightFogDensity) * u_xlat10.x + 1.0;
    u_xlat18 = u_xlat18 * _UWHeightFogEffectLimit;
    u_xlat18 = max(u_xlat18, _UWHeightFogEffectStart);
    u_xlat18 = min(u_xlat18, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb26 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat10.x = (-u_xlat10.x) * _UWHeightRatio + 1.0;
    u_xlat10.x = u_xlat10.x * vs_TEXCOORD6.y;
    u_xlat10.x = max(u_xlat10.x, _UWCriticalRange);
    u_xlat10.x = min(u_xlat10.x, 1.0);
    u_xlat16_4.x = (u_xlatb26) ? u_xlat10.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat11.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat11.xyz = vs_TEXCOORD6.xxx * u_xlat11.xyz + _UWFogColorFar.xyz;
    u_xlat7.xyz = u_xlat0.xyz + (-u_xlat11.xyz);
    u_xlat11.xyz = u_xlat16_4.xxx * u_xlat7.xyz + u_xlat11.xyz;
    u_xlat7.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat11.xyz + (-u_xlat7.xyz);
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat3.xyz + u_xlat7.xyz;
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
vec2 u_xlat17;
float u_xlat19;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat8.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat2.xzy;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat8.xy;
    u_xlat8.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb4.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb4.y) ? u_xlat8.xy : vec2(0.0, 0.0);
    u_xlat8.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat8.xyz;
    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat19);
    vs_TEXCOORD1.xyz = u_xlat8.xyz;
    u_xlat16_5 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8.x = u_xlat16_5 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8.x;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    vs_TEXCOORD2.xyz = u_xlat5.xyz / u_xlat5.www;
    u_xlat8.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat8.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb4.x ? u_xlat3.w : float(0.0);
    u_xlat8.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat8.xy, vec2(u_xlatb4.xx));
    vs_TEXCOORD3.z = u_xlatb4.x ? _DitherAlpha : float(0.0);
    u_xlat3 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8.x = u_xlat1.x * u_xlat3.x;
    u_xlat16 = u_xlat3.w + u_xlat3.y;
    u_xlat17.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat17.y = u_xlat8.x * 0.25 + u_xlat16;
    vs_TEXCOORD4.zw = u_xlat17.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat8.x;
    u_xlat8.x = u_xlat8.x * in_POSITION0.y;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.x + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.z + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat8.x : 1.0;
    u_xlat8.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_7 : u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat2.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat2.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat16;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
bool u_xlatb30;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12.x = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = u_xlat12.xx * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12.x * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat7.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb3 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat12.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat21.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12.x = u_xlat12.x / u_xlat21.x;
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat7.x = u_xlat12.x * _UWFogColorHLIntensity;
    u_xlat21.x = (-_UWHeightFogDensity) * u_xlat12.x + 1.0;
    u_xlat21.x = u_xlat21.x * _UWHeightFogEffectLimit;
    u_xlat21.x = max(u_xlat21.x, _UWHeightFogEffectStart);
    u_xlat21.x = min(u_xlat21.x, _UWHeightFogEffectLimit);
    u_xlat7.x = u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb30 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat12.x = (-u_xlat12.x) * _UWHeightRatio + 1.0;
    u_xlat12.x = u_xlat12.x * vs_TEXCOORD6.y;
    u_xlat12.x = max(u_xlat12.x, _UWCriticalRange);
    u_xlat12.x = min(u_xlat12.x, 1.0);
    u_xlat16_4.x = (u_xlatb30) ? u_xlat12.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat16.xyz = vs_TEXCOORD6.xxx * u_xlat16.xyz + _UWFogColorFar.xyz;
    u_xlat8.xyz = u_xlat0.xyz + (-u_xlat16.xyz);
    u_xlat16.xyz = u_xlat16_4.xxx * u_xlat8.xyz + u_xlat16.xyz;
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat7.xyz = u_xlat16.xyz + (-u_xlat8.xyz);
    u_xlat12.xyz = u_xlat21.xxx * u_xlat7.xyz + u_xlat8.xyz;
    SV_Target0.xyz = (bool(u_xlatb3)) ? u_xlat12.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
vec2 u_xlat17;
float u_xlat19;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat8.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat2.xzy;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat8.xy;
    u_xlat8.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb4.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb4.y) ? u_xlat8.xy : vec2(0.0, 0.0);
    u_xlat8.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat8.xyz;
    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat19);
    vs_TEXCOORD1.xyz = u_xlat8.xyz;
    u_xlat16_5 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8.x = u_xlat16_5 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8.x;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    vs_TEXCOORD2.xyz = u_xlat5.xyz / u_xlat5.www;
    u_xlat8.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat8.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb4.x ? u_xlat3.w : float(0.0);
    u_xlat8.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat8.xy, vec2(u_xlatb4.xx));
    vs_TEXCOORD3.z = u_xlatb4.x ? _DitherAlpha : float(0.0);
    u_xlat3 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8.x = u_xlat1.x * u_xlat3.x;
    u_xlat16 = u_xlat3.w + u_xlat3.y;
    u_xlat17.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat17.y = u_xlat8.x * 0.25 + u_xlat16;
    vs_TEXCOORD4.zw = u_xlat17.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat8.x;
    u_xlat8.x = u_xlat8.x * in_POSITION0.y;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.x + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.z + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat8.x : 1.0;
    u_xlat8.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_7 : u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat2.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat2.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat16;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
bool u_xlatb30;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12.x = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = u_xlat12.xx * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12.x * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat7.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb3 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat12.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat21.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12.x = u_xlat12.x / u_xlat21.x;
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat7.x = u_xlat12.x * _UWFogColorHLIntensity;
    u_xlat21.x = (-_UWHeightFogDensity) * u_xlat12.x + 1.0;
    u_xlat21.x = u_xlat21.x * _UWHeightFogEffectLimit;
    u_xlat21.x = max(u_xlat21.x, _UWHeightFogEffectStart);
    u_xlat21.x = min(u_xlat21.x, _UWHeightFogEffectLimit);
    u_xlat7.x = u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb30 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat12.x = (-u_xlat12.x) * _UWHeightRatio + 1.0;
    u_xlat12.x = u_xlat12.x * vs_TEXCOORD6.y;
    u_xlat12.x = max(u_xlat12.x, _UWCriticalRange);
    u_xlat12.x = min(u_xlat12.x, 1.0);
    u_xlat16_4.x = (u_xlatb30) ? u_xlat12.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat16.xyz = vs_TEXCOORD6.xxx * u_xlat16.xyz + _UWFogColorFar.xyz;
    u_xlat8.xyz = u_xlat0.xyz + (-u_xlat16.xyz);
    u_xlat16.xyz = u_xlat16_4.xxx * u_xlat8.xyz + u_xlat16.xyz;
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat7.xyz = u_xlat16.xyz + (-u_xlat8.xyz);
    u_xlat12.xyz = u_xlat21.xxx * u_xlat7.xyz + u_xlat8.xyz;
    SV_Target0.xyz = (bool(u_xlatb3)) ? u_xlat12.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
vec2 u_xlat17;
float u_xlat19;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat8.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat2.xzy;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat8.xy;
    u_xlat8.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb4.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb4.y) ? u_xlat8.xy : vec2(0.0, 0.0);
    u_xlat8.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat8.xyz;
    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat19);
    vs_TEXCOORD1.xyz = u_xlat8.xyz;
    u_xlat16_5 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8.x = u_xlat16_5 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8.x;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    vs_TEXCOORD2.xyz = u_xlat5.xyz / u_xlat5.www;
    u_xlat8.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat8.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb4.x ? u_xlat3.w : float(0.0);
    u_xlat8.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat8.xy, vec2(u_xlatb4.xx));
    vs_TEXCOORD3.z = u_xlatb4.x ? _DitherAlpha : float(0.0);
    u_xlat3 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8.x = u_xlat1.x * u_xlat3.x;
    u_xlat16 = u_xlat3.w + u_xlat3.y;
    u_xlat17.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat17.y = u_xlat8.x * 0.25 + u_xlat16;
    vs_TEXCOORD4.zw = u_xlat17.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat8.x;
    u_xlat8.x = u_xlat8.x * in_POSITION0.y;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.x + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.z + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat8.x : 1.0;
    u_xlat8.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_7 : u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat2.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat2.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat12;
vec3 u_xlat16;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
bool u_xlatb30;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12.x = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = u_xlat12.xx * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12.x * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat7.xyz = u_xlat3.xxx * u_xlat7.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat7.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb3 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat12.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat21.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat12.x = u_xlat12.x / u_xlat21.x;
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat7.x = u_xlat12.x * _UWFogColorHLIntensity;
    u_xlat21.x = (-_UWHeightFogDensity) * u_xlat12.x + 1.0;
    u_xlat21.x = u_xlat21.x * _UWHeightFogEffectLimit;
    u_xlat21.x = max(u_xlat21.x, _UWHeightFogEffectStart);
    u_xlat21.x = min(u_xlat21.x, _UWHeightFogEffectLimit);
    u_xlat7.x = u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb30 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat12.x = (-u_xlat12.x) * _UWHeightRatio + 1.0;
    u_xlat12.x = u_xlat12.x * vs_TEXCOORD6.y;
    u_xlat12.x = max(u_xlat12.x, _UWCriticalRange);
    u_xlat12.x = min(u_xlat12.x, 1.0);
    u_xlat16_4.x = (u_xlatb30) ? u_xlat12.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat16.xyz = vs_TEXCOORD6.xxx * u_xlat16.xyz + _UWFogColorFar.xyz;
    u_xlat8.xyz = u_xlat0.xyz + (-u_xlat16.xyz);
    u_xlat16.xyz = u_xlat16_4.xxx * u_xlat8.xyz + u_xlat16.xyz;
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat7.xyz = u_xlat16.xyz + (-u_xlat8.xyz);
    u_xlat12.xyz = u_xlat21.xxx * u_xlat7.xyz + u_xlat8.xyz;
    SV_Target0.xyz = (bool(u_xlatb3)) ? u_xlat12.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
vec2 u_xlat17;
float u_xlat19;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat8.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat2.xzy;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat8.xy;
    u_xlat8.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb4.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb4.y) ? u_xlat8.xy : vec2(0.0, 0.0);
    u_xlat8.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat8.xyz;
    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat19);
    vs_TEXCOORD1.xyz = u_xlat8.xyz;
    u_xlat16_5 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8.x = u_xlat16_5 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8.x;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    vs_TEXCOORD2.xyz = u_xlat5.xyz / u_xlat5.www;
    u_xlat8.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat8.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb4.x ? u_xlat3.w : float(0.0);
    u_xlat8.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat8.xy, vec2(u_xlatb4.xx));
    vs_TEXCOORD3.z = u_xlatb4.x ? _DitherAlpha : float(0.0);
    u_xlat3 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8.x = u_xlat1.x * u_xlat3.x;
    u_xlat16 = u_xlat3.w + u_xlat3.y;
    u_xlat17.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat17.y = u_xlat8.x * 0.25 + u_xlat16;
    vs_TEXCOORD4.zw = u_xlat17.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat8.x;
    u_xlat8.x = u_xlat8.x * in_POSITION0.y;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.x + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.z + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat8.x : 1.0;
    u_xlat8.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_7 : u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat2.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat2.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat11;
vec3 u_xlat16;
ivec2 u_xlati16;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
float u_xlat29;
lowp float u_xlat10_29;
bool u_xlatb29;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_3.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_29 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat29 = u_xlat10_29 * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat7.x = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = u_xlat7.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat29 = u_xlat7.x * 1.70000005 + (-u_xlat29);
    u_xlat29 = u_xlat29 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = vec3(u_xlat29) * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat29 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_3.xyz = (u_xlati16.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_3;
    u_xlat0 = vec4(u_xlat29) * u_xlat16_1 + u_xlat16_0;
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat1 = (-u_xlat0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb2 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat11.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat20 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat11.x = u_xlat11.x / u_xlat20;
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlat7.x = u_xlat11.x * _UWFogColorHLIntensity;
    u_xlat20 = (-_UWHeightFogDensity) * u_xlat11.x + 1.0;
    u_xlat20 = u_xlat20 * _UWHeightFogEffectLimit;
    u_xlat20 = max(u_xlat20, _UWHeightFogEffectStart);
    u_xlat20 = min(u_xlat20, _UWHeightFogEffectLimit);
    u_xlat7.x = u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb29 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat11.x = (-u_xlat11.x) * _UWHeightRatio + 1.0;
    u_xlat11.x = u_xlat11.x * vs_TEXCOORD6.y;
    u_xlat11.x = max(u_xlat11.x, _UWCriticalRange);
    u_xlat11.x = min(u_xlat11.x, 1.0);
    u_xlat16_4.x = (u_xlatb29) ? u_xlat11.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat16.xyz = vs_TEXCOORD6.xxx * u_xlat16.xyz + _UWFogColorFar.xyz;
    u_xlat8.xyz = u_xlat0.xyz + (-u_xlat16.xyz);
    u_xlat16.xyz = u_xlat16_4.xxx * u_xlat8.xyz + u_xlat16.xyz;
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat7.xyz = u_xlat16.xyz + (-u_xlat8.xyz);
    u_xlat11.xyz = vec3(u_xlat20) * u_xlat7.xyz + u_xlat8.xyz;
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
vec2 u_xlat17;
float u_xlat19;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat8.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat2.xzy;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat8.xy;
    u_xlat8.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb4.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb4.y) ? u_xlat8.xy : vec2(0.0, 0.0);
    u_xlat8.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat8.xyz;
    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat19);
    vs_TEXCOORD1.xyz = u_xlat8.xyz;
    u_xlat16_5 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8.x = u_xlat16_5 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8.x;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    vs_TEXCOORD2.xyz = u_xlat5.xyz / u_xlat5.www;
    u_xlat8.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat8.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb4.x ? u_xlat3.w : float(0.0);
    u_xlat8.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat8.xy, vec2(u_xlatb4.xx));
    vs_TEXCOORD3.z = u_xlatb4.x ? _DitherAlpha : float(0.0);
    u_xlat3 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8.x = u_xlat1.x * u_xlat3.x;
    u_xlat16 = u_xlat3.w + u_xlat3.y;
    u_xlat17.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat17.y = u_xlat8.x * 0.25 + u_xlat16;
    vs_TEXCOORD4.zw = u_xlat17.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat8.x;
    u_xlat8.x = u_xlat8.x * in_POSITION0.y;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.x + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.z + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat8.x : 1.0;
    u_xlat8.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_7 : u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat2.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat2.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat11;
vec3 u_xlat16;
ivec2 u_xlati16;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
float u_xlat29;
lowp float u_xlat10_29;
bool u_xlatb29;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_3.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_29 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat29 = u_xlat10_29 * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat7.x = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = u_xlat7.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat29 = u_xlat7.x * 1.70000005 + (-u_xlat29);
    u_xlat29 = u_xlat29 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = vec3(u_xlat29) * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat29 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_3.xyz = (u_xlati16.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_3;
    u_xlat0 = vec4(u_xlat29) * u_xlat16_1 + u_xlat16_0;
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat1 = (-u_xlat0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb2 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat11.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat20 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat11.x = u_xlat11.x / u_xlat20;
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlat7.x = u_xlat11.x * _UWFogColorHLIntensity;
    u_xlat20 = (-_UWHeightFogDensity) * u_xlat11.x + 1.0;
    u_xlat20 = u_xlat20 * _UWHeightFogEffectLimit;
    u_xlat20 = max(u_xlat20, _UWHeightFogEffectStart);
    u_xlat20 = min(u_xlat20, _UWHeightFogEffectLimit);
    u_xlat7.x = u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb29 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat11.x = (-u_xlat11.x) * _UWHeightRatio + 1.0;
    u_xlat11.x = u_xlat11.x * vs_TEXCOORD6.y;
    u_xlat11.x = max(u_xlat11.x, _UWCriticalRange);
    u_xlat11.x = min(u_xlat11.x, 1.0);
    u_xlat16_4.x = (u_xlatb29) ? u_xlat11.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat16.xyz = vs_TEXCOORD6.xxx * u_xlat16.xyz + _UWFogColorFar.xyz;
    u_xlat8.xyz = u_xlat0.xyz + (-u_xlat16.xyz);
    u_xlat16.xyz = u_xlat16_4.xxx * u_xlat8.xyz + u_xlat16.xyz;
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat7.xyz = u_xlat16.xyz + (-u_xlat8.xyz);
    u_xlat11.xyz = vec3(u_xlat20) * u_xlat7.xyz + u_xlat8.xyz;
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
out mediump vec3 vs_TEXCOORD6;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
vec2 u_xlat17;
float u_xlat19;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat8.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat2.xzy;
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat8.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat8.xy;
    u_xlat8.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb4.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb4.y) ? u_xlat8.xy : vec2(0.0, 0.0);
    u_xlat8.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat8.xyz;
    u_xlat19 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat19);
    vs_TEXCOORD1.xyz = u_xlat8.xyz;
    u_xlat16_5 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8.x = u_xlat16_5 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8.x;
    u_xlat5 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat5;
    vs_TEXCOORD2.xyz = u_xlat5.xyz / u_xlat5.www;
    u_xlat8.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat6.w = u_xlat8.x * 0.5;
    u_xlat6.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb4.x ? u_xlat3.w : float(0.0);
    u_xlat8.xy = u_xlat6.zz + u_xlat6.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat8.xy, vec2(u_xlatb4.xx));
    vs_TEXCOORD3.z = u_xlatb4.x ? _DitherAlpha : float(0.0);
    u_xlat3 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat8.x = u_xlat1.x * u_xlat3.x;
    u_xlat16 = u_xlat3.w + u_xlat3.y;
    u_xlat17.x = u_xlat3.z * u_xlat3.z + u_xlat3.x;
    u_xlat17.y = u_xlat8.x * 0.25 + u_xlat16;
    vs_TEXCOORD4.zw = u_xlat17.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat8.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat8.x;
    u_xlat8.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat8.x;
    u_xlat8.x = u_xlat8.x * in_POSITION0.y;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.x + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.z + u_xlat8.x;
    u_xlat16 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat16;
    u_xlat16 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat16;
    u_xlat8.x = u_xlat16 * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat8.x : 1.0;
    u_xlat8.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_7 : u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_7;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat0.xy = u_xlat2.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_UWFogDistStart);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat0.xy);
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat2.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD6.xyz = u_xlat2.yzw;
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
uniform 	vec4 _UWFogColorNear;
uniform 	vec4 _UWFogColorFar;
uniform 	vec4 _UWFogColorHigh;
uniform 	vec4 _UWFogColorLow;
uniform 	float _UWFogColorHLIntensity;
uniform 	float _UWHeightFogDensity;
uniform 	float _UWHeightFogEffectStart;
uniform 	float _UWHeightFogEffectLimit;
uniform 	float _UWFogHeightEnd;
uniform 	float _WaterPlaneHeight;
uniform 	float _UWCriticalRange;
uniform 	float _UWHeightRatio;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessReduse;
uniform 	mediump vec4 _EmissionTintColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _LightArea;
uniform 	mediump vec4 _ShadowMultColor;
uniform 	mediump float _Shininess;
uniform 	mediump float _SpecMulti;
uniform 	mediump vec3 _LightSpecColor;
uniform 	float _UsingDitherAlpha;
uniform 	float _UsingBloomMask;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _BloomMaskTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat11;
vec3 u_xlat16;
ivec2 u_xlati16;
float u_xlat20;
bvec2 u_xlatb20;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
float u_xlat29;
lowp float u_xlat10_29;
bool u_xlatb29;
mediump float u_xlat16_31;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_27 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_27 = _EmissionFactorFromTexToggle * u_xlat16_27 + _EmissionFactor;
    u_xlatb1.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb1.x){
        u_xlat10_1.x = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1.x = u_xlat16_27 * u_xlat10_1.x;
        u_xlat16_1.x = u_xlat16_1.x;
    } else {
        u_xlat16_1.x = u_xlat16_27;
    //ENDIF
    }
    if(u_xlatb1.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb27 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb27 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb27){
            u_xlat2.xy = vs_TEXCOORD3.yx / vs_TEXCOORD3.ww;
            u_xlat2.xy = u_xlat2.xy * _ScreenParams.yx;
            u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
            u_xlatb20.xy = greaterThanEqual(u_xlat2.xyxy, (-u_xlat2.xyxy)).xy;
            u_xlat2.xy = fract(abs(u_xlat2.xy));
            u_xlat2.x = (u_xlatb20.x) ? u_xlat2.x : (-u_xlat2.x);
            u_xlat2.y = (u_xlatb20.y) ? u_xlat2.y : (-u_xlat2.y);
            u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
            u_xlatu2.xy = uvec2(u_xlat2.xy);
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat27 = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
            u_xlat27 = vs_TEXCOORD3.z * 17.0 + (-u_xlat27);
            u_xlat27 = u_xlat27 + 0.99000001;
            u_xlat27 = floor(u_xlat27);
            u_xlat27 = max(u_xlat27, 0.0);
            u_xlati27 = int(u_xlat27);
            if((u_xlati27)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati27 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati27) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_0.w = vs_COLOR1.y + _OpaquenessReduse;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_3.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_29 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat29 = u_xlat10_29 * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat7.x = _SPNoiseScaler * _SPTransition;
    u_xlat16.xy = u_xlat7.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat16.xy = u_xlat16.xy + vec2(1.0, 1.0);
    u_xlat16.xy = floor(u_xlat16.xy);
    u_xlat16.xy = max(u_xlat16.xy, vec2(0.0, 0.0));
    u_xlati16.xy = ivec2(u_xlat16.xy);
    u_xlat29 = u_xlat7.x * 1.70000005 + (-u_xlat29);
    u_xlat29 = u_xlat29 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = vec3(u_xlat29) * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati16.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat29 = (u_xlati16.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_3.xyz = (u_xlati16.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_3;
    u_xlat0 = vec4(u_xlat29) * u_xlat16_1 + u_xlat16_0;
    u_xlat2.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = (-u_xlat2.x) + 1.00100005;
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGShininess;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _RGScale + _RGBias;
    u_xlat16_1.xyz = u_xlat2.xxx * _RGColor.xyz;
    u_xlat16_4.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat16_4.x * _RGRatio;
    u_xlat16_1.w = 1.0;
    u_xlat1 = (-u_xlat0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat1 + u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD6.z<_WaterPlaneHeight);
#else
    u_xlatb2 = vs_TEXCOORD6.z<_WaterPlaneHeight;
#endif
    u_xlat11.x = (-vs_TEXCOORD6.z) + _WaterPlaneHeight;
    u_xlat20 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat11.x = u_xlat11.x / u_xlat20;
    u_xlat11.x = max(u_xlat11.x, 0.0);
    u_xlat7.x = u_xlat11.x * _UWFogColorHLIntensity;
    u_xlat20 = (-_UWHeightFogDensity) * u_xlat11.x + 1.0;
    u_xlat20 = u_xlat20 * _UWHeightFogEffectLimit;
    u_xlat20 = max(u_xlat20, _UWHeightFogEffectStart);
    u_xlat20 = min(u_xlat20, _UWHeightFogEffectLimit);
    u_xlat7.x = u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(0.99000001<vs_TEXCOORD6.y);
#else
    u_xlatb29 = 0.99000001<vs_TEXCOORD6.y;
#endif
    u_xlat11.x = (-u_xlat11.x) * _UWHeightRatio + 1.0;
    u_xlat11.x = u_xlat11.x * vs_TEXCOORD6.y;
    u_xlat11.x = max(u_xlat11.x, _UWCriticalRange);
    u_xlat11.x = min(u_xlat11.x, 1.0);
    u_xlat16_4.x = (u_xlatb29) ? u_xlat11.x : vs_TEXCOORD6.y;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat16.xyz = vs_TEXCOORD6.xxx * u_xlat16.xyz + _UWFogColorFar.xyz;
    u_xlat8.xyz = u_xlat0.xyz + (-u_xlat16.xyz);
    u_xlat16.xyz = u_xlat16_4.xxx * u_xlat8.xyz + u_xlat16.xyz;
    u_xlat8.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat8.xyz = u_xlat7.xxx * u_xlat8.xyz + _UWFogColorLow.xyz;
    u_xlat7.xyz = u_xlat16.xyz + (-u_xlat8.xyz);
    u_xlat11.xyz = vec3(u_xlat20) * u_xlat7.xyz + u_xlat8.xyz;
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "_UNDERWATER_FOG" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 88672
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
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
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
vec3 u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
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
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat4.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat8 = _ClipPlane.w + -0.00999999978;
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlati4 = int(u_xlat4.x);
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : 0.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
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
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
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
vec3 u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
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
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat4.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat8 = _ClipPlane.w + -0.00999999978;
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlati4 = int(u_xlat4.x);
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : 0.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
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
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
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
vec3 u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
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
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.x = u_xlat1.x * u_xlat16_3.x;
    u_xlat4.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat8 = _ClipPlane.w + -0.00999999978;
    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x + 1.0;
    u_xlat4.x = floor(u_xlat4.x);
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlati4 = int(u_xlat4.x);
    u_xlat0.x = (u_xlati4 != 0) ? u_xlat0.x : 0.0;
    vs_COLOR0.w = u_xlat0.x;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
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
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb8;
mediump float u_xlat16_11;
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
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.w = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = _ClipPlane.w + -0.00999999978;
    u_xlat5 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat1.x = (-u_xlat1.x) + u_xlat5;
    u_xlat5 = u_xlat5 + (-_ClipPlane.w);
    u_xlat3.xyz = (-vec3(u_xlat5)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat3.w = 0.0;
    u_xlat0 = (int(u_xlati1) != 0) ? u_xlat0 : u_xlat3;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat4.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
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
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb8;
mediump float u_xlat16_11;
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
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.w = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = _ClipPlane.w + -0.00999999978;
    u_xlat5 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat1.x = (-u_xlat1.x) + u_xlat5;
    u_xlat5 = u_xlat5 + (-_ClipPlane.w);
    u_xlat3.xyz = (-vec3(u_xlat5)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat3.w = 0.0;
    u_xlat0 = (int(u_xlati1) != 0) ? u_xlat0 : u_xlat3;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat4.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
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
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	mediump float _Opaqueness;
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
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb8;
mediump float u_xlat16_11;
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
    u_xlat1 = u_xlat0 / u_xlat0.wwww;
    u_xlat0.x = (-u_xlat0.z) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _OutlineColor.w;
    u_xlat4.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_11 = u_xlat4.x / _Scale;
    u_xlat4.x = inversesqrt(u_xlat16_11);
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat16_11 = _OutlineWidth * _Scale;
    u_xlat16_11 = u_xlat16_11 * in_COLOR0.w;
    u_xlat16_11 = u_xlat4.x * u_xlat16_11;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MaxOutlineZOffset);
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_Scale, _Scale, _Scale));
    u_xlat2.xy = vec2(in_COLOR0.w + float(-1.0), in_COLOR0.z + float(-0.5));
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.yyy + u_xlat1.xyz;
    u_xlat1.x = _VertexAlphaFactor * u_xlat2.x + 1.0;
    u_xlat4.xy = u_xlat16_3.xy * vec2(u_xlat16_11) + u_xlat4.xy;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat0.x : _OutlineColor.w;
    u_xlat16_3.x = u_xlat16_3.x * _Opaqueness;
    u_xlat0.w = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = _ClipPlane.w + -0.00999999978;
    u_xlat5 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat1.x = (-u_xlat1.x) + u_xlat5;
    u_xlat5 = u_xlat5 + (-_ClipPlane.w);
    u_xlat3.xyz = (-vec3(u_xlat5)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat3.w = 0.0;
    u_xlat0 = (int(u_xlati1) != 0) ? u_xlat0 : u_xlat3;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat4.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb8)));
    vs_TEXCOORD3.w = u_xlatb8 ? u_xlat2.w : float(0.0);
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
CustomEditor "MoleMole.PropShaderEditorBase"
}