//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Outline_Complex_Pass2" {
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
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 9967
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