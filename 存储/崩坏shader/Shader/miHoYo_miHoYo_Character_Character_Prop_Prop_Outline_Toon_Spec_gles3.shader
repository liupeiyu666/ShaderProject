//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Outline_Toon_Spec" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
[Toggle] _UseLightDir ("Use Light Dir", Float) = 0
_LightDir ("Light Dir (world space)", Vector) = (0.4,-0.2,0.9,0)
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_EmissionTintColor ("Emission Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
[Toggle(CLIP_PLANE_WORLD)] _ClipPlaneWorld ("Clip Plane In World Space", Float) = 0
_ClipPlane ("Clip Plane", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 0
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
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
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 48423
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat5.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-_ClipPlane.w);
    u_xlat5.xyz = (-u_xlat5.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_24;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat5.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-_ClipPlane.w);
    u_xlat5.xyz = (-u_xlat5.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_24;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat5.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-_ClipPlane.w);
    u_xlat5.xyz = (-u_xlat5.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_24;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat5.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat5.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat5.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat5.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_24;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat5.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat5.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat5.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat5.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_24;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat5.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat5.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat5.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat5.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
        u_xlat10_1 = texture(_BloomMaskTex, vs_TEXCOORD5.xy).x;
        u_xlat16_1 = u_xlat16_24 * u_xlat10_1;
        u_xlat16_1 = u_xlat16_1;
    } else {
        u_xlat16_1 = u_xlat16_24;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    SV_Target0.w = vs_COLOR1.y;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat5.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-_ClipPlane.w);
    u_xlat5.xyz = (-u_xlat5.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat5.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-_ClipPlane.w);
    u_xlat5.xyz = (-u_xlat5.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat5.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-_ClipPlane.w);
    u_xlat5.xyz = (-u_xlat5.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
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
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat5.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat5.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat5.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat5.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
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
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat5.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat5.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat5.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat5.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
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
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat5.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat5.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat5.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat5.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat5.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat5.xyz;
    u_xlat1 = u_xlat5.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat5.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat5.xy;
    u_xlat5.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat5.xy : vec2(0.0, 0.0);
    u_xlat5.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat5.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11);
    vs_TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat1.xy = u_xlat3.zz + u_xlat3.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat1.xyw, vec3(u_xlatb2.xxx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.z + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat1.x = u_xlat6 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_4.x = (u_xlatb6) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_4.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_4.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_4.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_4.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
uvec2 u_xlatu2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb18;
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
    u_xlat16_28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD6.xyz;
    u_xlat16_28 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_7.xyz;
    u_xlat16_28 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_28 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _Shininess;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_28 = (-u_xlat16_28) + 1.50999999;
    u_xlat16_28 = floor(u_xlat16_28);
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlati0 = int(u_xlat16_28);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat6.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
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
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat6.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
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
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat6.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
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
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat6.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[1].xyzz * _ClipPlane.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0].xyzz * _ClipPlane.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[2].xyzz * _ClipPlane.zzzz + u_xlat1;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat6.x = dot(in_POSITION0.xyz, u_xlat1.xyw);
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat1 = (-u_xlat0.xxxx) * u_xlat1 + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
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
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat6.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[1].xyzz * _ClipPlane.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0].xyzz * _ClipPlane.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[2].xyzz * _ClipPlane.zzzz + u_xlat1;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat6.x = dot(in_POSITION0.xyz, u_xlat1.xyw);
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat1 = (-u_xlat0.xxxx) * u_xlat1 + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
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
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat6.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[1].xyzz * _ClipPlane.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0].xyzz * _ClipPlane.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[2].xyzz * _ClipPlane.zzzz + u_xlat1;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat6.x = dot(in_POSITION0.xyz, u_xlat1.xyw);
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat1 = (-u_xlat0.xxxx) * u_xlat1 + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _EnvColor;
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
int u_xlati0;
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
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_6.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_6.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_6.xyz;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat16_1 + u_xlat16_0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat6.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
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
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat1 = (-u_xlat0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat1 + u_xlat0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat6.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
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
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat1 = (-u_xlat0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat1 + u_xlat0;
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat6.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0 = u_xlat0 * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
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
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat1 = (-u_xlat0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat1 + u_xlat0;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat6.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[1].xyzz * _ClipPlane.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0].xyzz * _ClipPlane.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[2].xyzz * _ClipPlane.zzzz + u_xlat1;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat6.x = dot(in_POSITION0.xyz, u_xlat1.xyw);
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat1 = (-u_xlat0.xxxx) * u_xlat1 + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
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
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat1 = (-u_xlat0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat1 + u_xlat0;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat6.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[1].xyzz * _ClipPlane.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0].xyzz * _ClipPlane.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[2].xyzz * _ClipPlane.zzzz + u_xlat1;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat6.x = dot(in_POSITION0.xyz, u_xlat1.xyw);
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat1 = (-u_xlat0.xxxx) * u_xlat1 + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
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
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat1 = (-u_xlat0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat1 + u_xlat0;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
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
uniform 	int _UseLightDir;
uniform 	mediump vec3 _LightDir;
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
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat6.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat6.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[1].xyzz * _ClipPlane.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0].xyzz * _ClipPlane.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[2].xyzz * _ClipPlane.zzzz + u_xlat1;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat6.x = dot(in_POSITION0.xyz, u_xlat1.xyw);
    u_xlat0.x = (-u_xlat0.x) + u_xlat6.x;
    u_xlat1 = (-u_xlat0.xxxx) * u_xlat1 + in_POSITION0.xyzz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
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
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat14 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat14);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat2.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat2.xyw, vec3(u_xlatb3.xxx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat1.x = u_xlat1.x * u_xlat2.x;
    u_xlat7 = u_xlat2.w + u_xlat2.y;
    u_xlat13.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat13.y = u_xlat1.x * 0.25 + u_xlat7;
    vs_TEXCOORD4.zw = u_xlat13.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat1.x = u_xlat1.x * in_POSITION0.y;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.x + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.z + u_xlat1.x;
    u_xlat7 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat7;
    u_xlat1.x = u_xlat7 * in_POSITION0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_FadeOffset);
    u_xlat1.x = u_xlat1.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb7 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5.x = (u_xlatb7) ? u_xlat1.x : 1.0;
    u_xlat1.x = 0.0;
    u_xlat0.x = (u_xlati0 != 0) ? u_xlat16_5.x : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    vs_COLOR1.y = u_xlat0.x * _Opaqueness;
    u_xlat16_5.x = dot(_LightDir.xyz, _LightDir.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightDir.xyz;
    u_xlat1.xyz = (_UseLightDir != 0) ? u_xlat16_5.xyz : _WorldSpaceLightPos0.xyz;
    u_xlat16_5.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat16_5.x * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
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
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
uvec2 u_xlatu2;
vec4 u_xlat3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat12;
bvec2 u_xlatb20;
vec2 u_xlat21;
ivec2 u_xlati21;
float u_xlat27;
mediump float u_xlat16_27;
int u_xlati27;
bool u_xlatb27;
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
    u_xlat16_31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_6.xyz = vec3(u_xlat16_31) * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_7.xyz = u_xlat0.xyz * vec3(u_xlat27) + vs_TEXCOORD6.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_6.xyz, u_xlat16_7.xyz);
    u_xlat16_31 = max(u_xlat16_31, 0.00100000005);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _Shininess;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = (-u_xlat16_31) + 1.50999999;
    u_xlat16_31 = floor(u_xlat16_31);
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlati0 = int(u_xlat16_31);
    u_xlat16_7.xyz = vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) * _LightSpecColor.xyz;
    u_xlat16_7.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_EmissionScaler) + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_7.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_6.xyz);
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
    u_xlat16_0.w = vs_COLOR1.y;
    u_xlat16_1.w = 1.0;
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat0 = u_xlat2.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat10_1 = texture(_SPTex, vs_TEXCOORD4.xy);
    u_xlat16_2.w = u_xlat10_1.w * _SPOpaqueness;
    u_xlat10_3 = texture(_SPNoiseTex, vs_TEXCOORD4.zw).x;
    u_xlat3.x = u_xlat10_3 * _SPNoiseScaler;
    u_xlat3.x = u_xlat3.x * 1.99000001 + -1.0;
    u_xlat12 = _SPNoiseScaler * _SPTransition;
    u_xlat21.xy = vec2(u_xlat12) * vec2(1.70000005, 1.5) + (-u_xlat3.xx);
    u_xlat21.xy = u_xlat21.xy + vec2(1.0, 1.0);
    u_xlat21.xy = floor(u_xlat21.xy);
    u_xlat21.xy = max(u_xlat21.xy, vec2(0.0, 0.0));
    u_xlati21.xy = ivec2(u_xlat21.xy);
    u_xlat3.x = u_xlat12 * 1.70000005 + (-u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat8.xyz = u_xlat3.xxx * u_xlat8.xyz + u_xlat10_1.xyz;
    u_xlat16_4.xyz = (u_xlati21.y != 0) ? u_xlat10_1.xyz : u_xlat8.xyz;
    u_xlat3.x = (u_xlati21.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_2.xyz = (u_xlati21.x != 0) ? u_xlat16_4.xyz : u_xlat10_1.xyz;
    u_xlat1 = (-u_xlat0) + u_xlat16_2;
    u_xlat0 = u_xlat3.xxxx * u_xlat1 + u_xlat0;
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
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
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
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" "CLIP_PLANE_WORLD" }
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" "CLIP_PLANE_WORLD" }
""
}
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 84321
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
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
float u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat8 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8;
    u_xlat8 = u_xlat8 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat8)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8 = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8 = u_xlat4.z * in_POSITION0.x + u_xlat8;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8 = u_xlat5.z * in_POSITION0.z + u_xlat8;
    u_xlat8 = u_xlat2.z * in_POSITION0.w + u_xlat8;
    u_xlat8 = (-u_xlat8) + (-_ProjectionParams.y);
    u_xlat8 = u_xlat8 + (-_FadeOffset);
    u_xlat8 = u_xlat8 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat8 * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8 = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
SubProgram "gles3 hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
float u_xlat24;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat0.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    vs_COLOR0.w = u_xlat0.w;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat24 = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat24 / _Scale;
    u_xlat24 = inversesqrt(u_xlat16_7);
    u_xlat24 = float(1.0) / u_xlat24;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat24 * u_xlat16_7;
    u_xlat0.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat0.xy * u_xlat16_15.xx;
    u_xlat0.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xyw = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyw, vec3(bvec3(u_xlatb16)));
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8.x = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8.x = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	mediump float _OutlineWidth;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _Scale;
uniform 	mediump float _VertexAlphaFactor;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump float u_xlat16_7;
vec3 u_xlat8;
mediump vec2 u_xlat16_15;
float u_xlat16;
bool u_xlatb16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat8.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat8.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat8.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[3].wwww + u_xlat2;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat3;
    u_xlat8.x = u_xlat3.z * in_POSITION0.y;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat4;
    u_xlat8.x = u_xlat4.z * in_POSITION0.x + u_xlat8.x;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat5;
    u_xlat8.x = u_xlat5.z * in_POSITION0.z + u_xlat8.x;
    u_xlat8.x = u_xlat2.z * in_POSITION0.w + u_xlat8.x;
    u_xlat8.x = (-u_xlat8.x) + (-_ProjectionParams.y);
    u_xlat8.x = u_xlat8.x + (-_FadeOffset);
    u_xlat8.x = u_xlat8.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _OutlineColor.w;
    u_xlat16 = in_COLOR0.w + -1.0;
    u_xlat16 = _VertexAlphaFactor * u_xlat16 + 1.0;
    u_xlat6.w = u_xlat16 * u_xlat8.x;
    u_xlat6.xyz = in_POSITION0.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat6 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * u_xlat3;
    u_xlat3.xy = u_xlat3.xy * in_TANGENT0.yy;
    u_xlat3.xy = u_xlat4.xy * in_TANGENT0.xx + u_xlat3.xy;
    u_xlat1 = u_xlat4 * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = u_xlat5 * u_xlat0.zzzz + u_xlat1;
    u_xlat3.xy = u_xlat5.xy * in_TANGENT0.zz + u_xlat3.xy;
    u_xlat1 = u_xlat2 * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = (-u_xlat1.z) / hlslcc_mtx4x4unity_CameraProjection[1].y;
    u_xlat16_7 = u_xlat2.x / _Scale;
    u_xlat2.x = inversesqrt(u_xlat16_7);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat16_7 = _OutlineWidth * _Scale;
    u_xlat16_7 = u_xlat2.x * u_xlat16_7;
    u_xlat3.z = 0.00999999978;
    u_xlat16_15.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_15.x = inversesqrt(u_xlat16_15.x);
    u_xlat16_15.xy = u_xlat3.xy * u_xlat16_15.xx;
    u_xlat1.xy = u_xlat16_15.xy * vec2(u_xlat16_7) + u_xlat1.xy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.w = u_xlat0.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat2 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat8.x = u_xlat2.w + u_xlat2.y;
    u_xlat2.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat2.y = u_xlat0.x * 0.25 + u_xlat8.x;
    vs_TEXCOORD0.xy = u_xlat2.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat0.xy, vec2(bvec2(u_xlatb16)));
    vs_TEXCOORD3.w = u_xlatb16 ? u_xlat1.w : float(0.0);
    vs_TEXCOORD3.z = u_xlatb16 ? _DitherAlpha : float(0.0);
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
SubProgram "gles3 hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 174787
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
SubProgram "gles3 hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat3.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat3.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
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
Keywords { "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat3.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat3.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
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
    u_xlat3.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3.x;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat3.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
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
    u_xlat3.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3.x;
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
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(_ClipPlane.w)<0.00100000005);
#else
    u_xlatb0 = abs(_ClipPlane.w)<0.00100000005;
#endif
    u_xlat3.xyz = _ClipPlane.www * _ClipPlane.xyz;
    u_xlat0.xyz = (bool(u_xlatb0)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToObject[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _ClipPlane.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _ClipPlane.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _ClipPlane.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = dot(in_POSITION0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3.x;
    u_xlat1.xyz = (-u_xlat0.xxx) * u_xlat1.xyz + in_POSITION0.xyz;
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
    u_xlat3.x = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3.x;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.PropShaderEditorBase"
}