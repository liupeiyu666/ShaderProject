//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Transparent" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_OpaquenessFromTexToggle ("Opaqueness From Tex Toggle", Range(0, 1)) = 0
[Toggle] _ZWrite ("Write Depth", Float) = 0
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_EmissionTintColor ("Emission Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (1,1,1,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_ClipPlane ("Clip Plane", Vector) = (0,0,0,0)
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
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 19549
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessFromTexToggle;
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
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
bvec2 u_xlatb16;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlatb8.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_8 = u_xlat10_8 * u_xlat16_1;
        u_xlat16_8 = u_xlat16_8;
    } else {
        u_xlat16_8 = u_xlat16_1;
    //ENDIF
    }
    if(u_xlatb8.y){
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
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    SV_Target0.w = u_xlat16_4.x * vs_COLOR1.y;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessFromTexToggle;
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
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
bvec2 u_xlatb16;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlatb8.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_8 = u_xlat10_8 * u_xlat16_1;
        u_xlat16_8 = u_xlat16_8;
    } else {
        u_xlat16_8 = u_xlat16_1;
    //ENDIF
    }
    if(u_xlatb8.y){
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
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    SV_Target0.w = u_xlat16_4.x * vs_COLOR1.y;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessFromTexToggle;
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
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
bvec2 u_xlatb16;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlatb8.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_8 = u_xlat10_8 * u_xlat16_1;
        u_xlat16_8 = u_xlat16_8;
    } else {
        u_xlat16_8 = u_xlat16_1;
    //ENDIF
    }
    if(u_xlatb8.y){
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
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    SV_Target0.w = u_xlat16_4.x * vs_COLOR1.y;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat9;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb9)));
    vs_TEXCOORD3.z = u_xlatb9 ? _DitherAlpha : float(0.0);
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat4 = u_xlat1.w + u_xlat1.y;
    u_xlat8.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat8.y = u_xlat0.x * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat8.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
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
uniform 	mediump float _OpaquenessFromTexToggle;
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
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bvec2 u_xlatb9;
vec2 u_xlat11;
ivec2 u_xlati11;
bvec2 u_xlatb18;
float u_xlat24;
lowp float u_xlat10_24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlatb9.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb9.x){
        u_xlat10_9 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_9 = u_xlat10_9 * u_xlat16_1.x;
        u_xlat16_9 = u_xlat16_9;
    } else {
        u_xlat16_9 = u_xlat16_1.x;
    //ENDIF
    }
    if(u_xlatb9.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
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
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    u_xlat16_1.w = u_xlat16_4.x * vs_COLOR1.y;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_24 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat24 = u_xlat10_24 * _SPNoiseScaler;
    u_xlat24 = u_xlat24 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat11.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat24));
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat24 = u_xlat3.x * 1.70000005 + (-u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = (u_xlati11.y != 0) ? u_xlat10_0.xyz : u_xlat7.xyz;
    u_xlat24 = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_4.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat24) * u_xlat16_2 + u_xlat16_1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat9;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb9)));
    vs_TEXCOORD3.z = u_xlatb9 ? _DitherAlpha : float(0.0);
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat4 = u_xlat1.w + u_xlat1.y;
    u_xlat8.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat8.y = u_xlat0.x * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat8.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
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
uniform 	mediump float _OpaquenessFromTexToggle;
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
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bvec2 u_xlatb9;
vec2 u_xlat11;
ivec2 u_xlati11;
bvec2 u_xlatb18;
float u_xlat24;
lowp float u_xlat10_24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlatb9.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb9.x){
        u_xlat10_9 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_9 = u_xlat10_9 * u_xlat16_1.x;
        u_xlat16_9 = u_xlat16_9;
    } else {
        u_xlat16_9 = u_xlat16_1.x;
    //ENDIF
    }
    if(u_xlatb9.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
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
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    u_xlat16_1.w = u_xlat16_4.x * vs_COLOR1.y;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_24 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat24 = u_xlat10_24 * _SPNoiseScaler;
    u_xlat24 = u_xlat24 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat11.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat24));
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat24 = u_xlat3.x * 1.70000005 + (-u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = (u_xlati11.y != 0) ? u_xlat10_0.xyz : u_xlat7.xyz;
    u_xlat24 = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_4.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat24) * u_xlat16_2 + u_xlat16_1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat9;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb9)));
    vs_TEXCOORD3.z = u_xlatb9 ? _DitherAlpha : float(0.0);
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat4 = u_xlat1.w + u_xlat1.y;
    u_xlat8.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat8.y = u_xlat0.x * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat8.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
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
uniform 	mediump float _OpaquenessFromTexToggle;
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
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bvec2 u_xlatb9;
vec2 u_xlat11;
ivec2 u_xlati11;
bvec2 u_xlatb18;
float u_xlat24;
lowp float u_xlat10_24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlatb9.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb9.x){
        u_xlat10_9 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_9 = u_xlat10_9 * u_xlat16_1.x;
        u_xlat16_9 = u_xlat16_9;
    } else {
        u_xlat16_9 = u_xlat16_1.x;
    //ENDIF
    }
    if(u_xlatb9.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
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
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    u_xlat16_1.w = u_xlat16_4.x * vs_COLOR1.y;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_24 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat24 = u_xlat10_24 * _SPNoiseScaler;
    u_xlat24 = u_xlat24 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat11.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat24));
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat24 = u_xlat3.x * 1.70000005 + (-u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = (u_xlati11.y != 0) ? u_xlat10_0.xyz : u_xlat7.xyz;
    u_xlat24 = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_4.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat24) * u_xlat16_2 + u_xlat16_1;
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
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 111491
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessFromTexToggle;
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
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
bvec2 u_xlatb16;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlatb8.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_8 = u_xlat10_8 * u_xlat16_1;
        u_xlat16_8 = u_xlat16_8;
    } else {
        u_xlat16_8 = u_xlat16_1;
    //ENDIF
    }
    if(u_xlatb8.y){
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
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    SV_Target0.w = u_xlat16_4.x * vs_COLOR1.y;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessFromTexToggle;
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
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
bvec2 u_xlatb16;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlatb8.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_8 = u_xlat10_8 * u_xlat16_1;
        u_xlat16_8 = u_xlat16_8;
    } else {
        u_xlat16_8 = u_xlat16_1;
    //ENDIF
    }
    if(u_xlatb8.y){
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
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    SV_Target0.w = u_xlat16_4.x * vs_COLOR1.y;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat8 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat8;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = u_xlat1.xyz / u_xlat1.www;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _OpaquenessFromTexToggle;
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
vec2 u_xlat2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
bvec2 u_xlatb16;
mediump float u_xlat16_25;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1 = _EmissionFactorFromTexToggle * u_xlat16_1 + _EmissionFactor;
    u_xlatb8.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_8 = u_xlat10_8 * u_xlat16_1;
        u_xlat16_8 = u_xlat16_8;
    } else {
        u_xlat16_8 = u_xlat16_1;
    //ENDIF
    }
    if(u_xlatb8.y){
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
            u_xlat3.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat3.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu2.y)]);
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_25 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_25 = max(u_xlat16_25, 0.00100000005);
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _Shininess;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_8) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    SV_Target0.w = u_xlat16_4.x * vs_COLOR1.y;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat9;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb9)));
    vs_TEXCOORD3.z = u_xlatb9 ? _DitherAlpha : float(0.0);
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat4 = u_xlat1.w + u_xlat1.y;
    u_xlat8.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat8.y = u_xlat0.x * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat8.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
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
uniform 	mediump float _OpaquenessFromTexToggle;
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
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bvec2 u_xlatb9;
vec2 u_xlat11;
ivec2 u_xlati11;
bvec2 u_xlatb18;
float u_xlat24;
lowp float u_xlat10_24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlatb9.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb9.x){
        u_xlat10_9 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_9 = u_xlat10_9 * u_xlat16_1.x;
        u_xlat16_9 = u_xlat16_9;
    } else {
        u_xlat16_9 = u_xlat16_1.x;
    //ENDIF
    }
    if(u_xlatb9.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
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
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    u_xlat16_1.w = u_xlat16_4.x * vs_COLOR1.y;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_24 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat24 = u_xlat10_24 * _SPNoiseScaler;
    u_xlat24 = u_xlat24 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat11.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat24));
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat24 = u_xlat3.x * 1.70000005 + (-u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = (u_xlati11.y != 0) ? u_xlat10_0.xyz : u_xlat7.xyz;
    u_xlat24 = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_4.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat24) * u_xlat16_2 + u_xlat16_1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat9;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb9)));
    vs_TEXCOORD3.z = u_xlatb9 ? _DitherAlpha : float(0.0);
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat4 = u_xlat1.w + u_xlat1.y;
    u_xlat8.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat8.y = u_xlat0.x * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat8.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
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
uniform 	mediump float _OpaquenessFromTexToggle;
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
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bvec2 u_xlatb9;
vec2 u_xlat11;
ivec2 u_xlati11;
bvec2 u_xlatb18;
float u_xlat24;
lowp float u_xlat10_24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlatb9.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb9.x){
        u_xlat10_9 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_9 = u_xlat10_9 * u_xlat16_1.x;
        u_xlat16_9 = u_xlat16_9;
    } else {
        u_xlat16_9 = u_xlat16_1.x;
    //ENDIF
    }
    if(u_xlatb9.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
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
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    u_xlat16_1.w = u_xlat16_4.x * vs_COLOR1.y;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_24 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat24 = u_xlat10_24 * _SPNoiseScaler;
    u_xlat24 = u_xlat24 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat11.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat24));
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat24 = u_xlat3.x * 1.70000005 + (-u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = (u_xlati11.y != 0) ? u_xlat10_0.xyz : u_xlat7.xyz;
    u_xlat24 = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_4.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat24) * u_xlat16_2 + u_xlat16_1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat4 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat4)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat4 = in_COLOR0.w + -1.0;
    u_xlat2.w = _VertexAlphaFactor * u_xlat4 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat9 = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat9;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    vs_TEXCOORD2.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(bvec3(u_xlatb9)));
    vs_TEXCOORD3.z = u_xlatb9 ? _DitherAlpha : float(0.0);
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    vs_COLOR1.y = u_xlat0.w * _Opaqueness;
    u_xlat4 = u_xlat1.w + u_xlat1.y;
    u_xlat8.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat8.y = u_xlat0.x * 0.25 + u_xlat4;
    vs_TEXCOORD4.zw = u_xlat8.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
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
uniform 	mediump float _OpaquenessFromTexToggle;
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
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
int u_xlati2;
uvec2 u_xlatu2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
bvec2 u_xlatb9;
vec2 u_xlat11;
ivec2 u_xlati11;
bvec2 u_xlatb18;
float u_xlat24;
lowp float u_xlat10_24;
mediump float u_xlat16_28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_1.x = _EmissionFactorFromTexToggle * u_xlat16_1.x + _EmissionFactor;
    u_xlatb9.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingBloomMask, _UsingDitherAlpha, _UsingBloomMask, _UsingBloomMask)).xy;
    if(u_xlatb9.x){
        u_xlat10_9 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_9 = u_xlat10_9 * u_xlat16_1.x;
        u_xlat16_9 = u_xlat16_9;
    } else {
        u_xlat16_9 = u_xlat16_1.x;
    //ENDIF
    }
    if(u_xlatb9.y){
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(vs_TEXCOORD3.z<0.949999988);
#else
        u_xlatb2 = vs_TEXCOORD3.z<0.949999988;
#endif
        if(u_xlatb2){
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
            u_xlat2.x = dot(u_xlat3, ImmCB_0_0_0[int(u_xlatu2.x)]);
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
    u_xlat16_4.x = vs_COLOR1.x + (-_LightArea);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = floor(u_xlat16_4.x);
    u_xlat16_4.x = max(u_xlat16_4.x, 0.0);
    u_xlati2 = int(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _ShadowMultColor.xyz;
    u_xlat16_4.xyz = (int(u_xlati2) != 0) ? u_xlat10_0.xyz : u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz * _EmissionTintColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = _OpaquenessFromTexToggle * u_xlat16_4.x + 1.0;
    u_xlat16_1.w = u_xlat16_4.x * vs_COLOR1.y;
    u_xlat10_0 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_0.w * _SPOpaqueness;
    u_xlat10_24 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat24 = u_xlat10_24 * _SPNoiseScaler;
    u_xlat24 = u_xlat24 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat11.xy = u_xlat3.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat24));
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat24 = u_xlat3.x * 1.70000005 + (-u_xlat24);
    u_xlat24 = u_xlat24 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat7.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat7.xyz = vec3(u_xlat24) * u_xlat7.xyz + u_xlat10_0.xyz;
    u_xlat16_4.xyz = (u_xlati11.y != 0) ? u_xlat10_0.xyz : u_xlat7.xyz;
    u_xlat24 = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_4.xyz : u_xlat10_0.xyz;
    u_xlat16_2 = (-u_xlat16_1) + u_xlat16_2;
    u_xlat0 = vec4(u_xlat24) * u_xlat16_2 + u_xlat16_1;
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
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 152467
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
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
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
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
mediump float u_xlat16_6;
lowp float u_xlat10_6;
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
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
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
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
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
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
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
mediump float u_xlat16_6;
lowp float u_xlat10_6;
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
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
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
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
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
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
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
mediump float u_xlat16_6;
lowp float u_xlat10_6;
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
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}