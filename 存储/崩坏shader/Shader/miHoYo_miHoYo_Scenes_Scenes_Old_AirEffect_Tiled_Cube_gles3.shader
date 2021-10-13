//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_Tiled_Cube" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_ReflectFresnel ("Reflect Fresnel (base, power, scale)", Vector) = (1,1,0,0)
[Header(Circle)] _CircleColorScaler ("Circle Color", Color) = (1,1,1,1)
_CircleColorTex ("Base (Circle Color) Trans", 2D) = "white" { }
_CircleRadius ("Circle Radius", Range(1, 100)) = 14
[Header(Lighting)] _LightDir ("LightDir (xyz)", Vector) = (1,-1,0,0)
_Ambient ("Ambient", Range(0, 1)) = 0.7
_Diffuse ("Diffuse", Range(0, 1)) = 0.5
_Specular ("Specular", Range(0, 1)) = 0.1
_Shininess ("Shininess", Range(0.1, 100)) = 20
[Header(Camera)] _CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "RenderType" = "Opaque" }
  GpuProgramID 481
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat16;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat2.x * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat16 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat16 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat4.w = u_xlat22 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat16;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat2.x * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat16 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat16 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat4.w = u_xlat22 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat16;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat2.x * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat16 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat16 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat4.w = u_xlat22 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_5.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_5.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_5.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_5.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_5.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.x = sqrt(u_xlat21);
    u_xlat3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat1.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat1.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    u_xlat2 = u_xlat2.xzyz * in_TEXCOORD0.xyxy;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat3.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2 = (u_xlatb4.x) ? u_xlat3 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
        u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
        u_xlat2.xy = exp2(u_xlat2.xy);
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = u_xlat2.yyy * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat2.xy = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat21);
        u_xlat21 = u_xlat2.y * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat3.w = min(u_xlat21, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat2.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    u_xlat2.xy = u_xlat0.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat3.xz = (-u_xlat2.xy) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat4.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat4.z = dot(u_xlat2.xy, u_xlat3.xz);
    vs_TEXCOORD1.xy = u_xlat2.zw;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat4.y = u_xlat3.y;
    vs_TEXCOORD4.xyz = u_xlat4.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + vs_COLOR1.xyz;
    u_xlat16_5.xyz = vs_COLOR1.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat16;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat2.x * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat16 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat16 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat4.w = u_xlat22 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat16;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat2.x * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat16 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat16 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat4.w = u_xlat22 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _LerpFactor;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogParams3;
uniform 	vec4 _HeigtFogRamp2;
uniform 	vec4 _HeigtFogRamp3;
uniform 	vec4 _HeigtFogColBase2;
uniform 	vec4 _HeigtFogColBase3;
uniform 	vec4 _HeigtFogColDelta2;
uniform 	vec4 _HeigtFogColDelta3;
uniform 	vec4 _HeigtFogColParams2;
uniform 	vec4 _HeigtFogColParams3;
uniform 	vec4 _HeigtFogRadialCol2;
uniform 	vec4 _HeigtFogRadialCol3;
uniform 	vec4 _Mihoyo_FogColor2;
uniform 	vec4 _Mihoyo_FogColor3;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec4 u_xlat4;
bvec2 u_xlatb4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_12;
float u_xlat16;
bvec2 u_xlatb18;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.z = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.y = sqrt(u_xlat21);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = sqrt(u_xlat21);
    u_xlat2 = u_xlat1.xzyz * in_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat1.xy * in_TEXCOORD0.xy;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlatb4.xy = lessThan(vec4(0.5, 0.5, 0.0, 0.0), u_xlat3.yxyy).xy;
    u_xlatb18.xy = lessThan(u_xlat3.yxyx, vec4(-0.5, -0.5, -0.5, -0.5)).xy;
    vs_TEXCOORD2.xyz = u_xlat3.xyz;
    u_xlatb21 = u_xlatb4.y || u_xlatb18.y;
    u_xlat2.xy = (bool(u_xlatb21)) ? u_xlat2.xy : u_xlat2.zw;
    u_xlat2.xy = (u_xlatb18.x) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(0.0);
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1 = (u_xlatb4.x) ? u_xlat1 : u_xlat2;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = u_xlat1.zw;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat21) + 2.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta3.w;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat21>=u_xlat9);
#else
    u_xlatb9 = u_xlat21>=u_xlat9;
#endif
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor3.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat16 = u_xlat2.x * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat16 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat16 = (-u_xlat2.x) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat4.w = u_xlat22 * u_xlat16;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat2.xxx + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xzw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xzw + u_xlat1.xyz;
    u_xlat22 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat22) + 2.0;
    u_xlat22 = u_xlat22 * u_xlat2.x;
    u_xlat2.x = u_xlat22 * _HeigtFogColDelta2.w;
    u_xlat22 = (u_xlatb9) ? u_xlat2.x : u_xlat22;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * _Mihoyo_FogColor2.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase2.w);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat2.x = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat3.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_5 = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_12 = (-u_xlat21) + 2.0;
    u_xlat16_12 = u_xlat21 * u_xlat16_12;
    u_xlat21 = u_xlat16_12 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_5 = u_xlat21 * u_xlat16_5;
    u_xlat21 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat2.w = u_xlat22 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat3.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.y = u_xlat0.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat2.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat1.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat2.y = u_xlat16_6.x;
    u_xlat1.z = dot(u_xlat2.xy, u_xlat0.xz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _Reflectivity;
uniform 	mediump vec4 _ReflectFresnel;
uniform 	vec4 _AvatarPosInWorldPos;
uniform 	vec4 _PrevAvatarPosInWorldPos;
uniform 	float _IsCurCircleBusy;
uniform 	float _IsPrevCircleBusy;
uniform 	float _CircleTime;
uniform 	float _PrevCircleTime;
uniform 	float _TimeIntervalRatio;
uniform 	vec4 _CircleColorTex_ST;
uniform 	float _CircleRadius;
uniform 	vec3 _LightDir;
uniform 	mediump float _Ambient;
uniform 	mediump float _Diffuse;
uniform 	mediump float _Specular;
uniform 	mediump float _Shininess;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CircleColorTex;
uniform lowp samplerCube _EnvTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
float u_xlat14;
bool u_xlatb14;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xy);
    u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 1.0);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
    u_xlat22 = dot(vec3(_LightDir.x, _LightDir.y, _LightDir.z), vec3(_LightDir.x, _LightDir.y, _LightDir.z));
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(float(u_xlat22) * _LightDir.xxyz.y, float(u_xlat22) * _LightDir.xxyz.z, float(u_xlat22) * float(_LightDir.z));
    u_xlat3.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat16_5.xyz = u_xlat3.xyz * vec3(u_xlat22) + (-u_xlat2.xyz);
    u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat1.xyz, (-u_xlat2.xyz));
    u_xlat16_26 = max(u_xlat16_26, 0.0);
    u_xlat16_26 = u_xlat16_26 * _Diffuse + _Ambient;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Shininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _Specular;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_26) + u_xlat16_5.xxx;
    u_xlatb0.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_IsCurCircleBusy, _IsPrevCircleBusy, _IsCurCircleBusy, _IsCurCircleBusy)).xy;
    if(u_xlatb0.x){
        u_xlat0.x = _CircleTime * _TimeIntervalRatio;
        u_xlat14 = u_xlat0.x * 1.57079506;
        u_xlat14 = sin(u_xlat14);
        u_xlat14 = u_xlat14 * _CircleRadius;
        u_xlat14 = floor(u_xlat14);
        u_xlat2.xyz = vs_TEXCOORD3.xyz + (-_AvatarPosInWorldPos.xyz);
        u_xlat22 = u_xlat2.y + -0.5;
        u_xlat2.xz = roundEven(u_xlat2.xz);
        u_xlat2.y = roundEven(u_xlat22);
        u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat22 = sqrt(u_xlat22);
        u_xlat14 = (-u_xlat14) + u_xlat22;
#ifdef UNITY_ADRENO_ES3
        u_xlatb22 = !!(abs(u_xlat14)<1.50999999);
#else
        u_xlatb22 = abs(u_xlat14)<1.50999999;
#endif
        if(u_xlatb22){
            u_xlat2.xy = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_2.xyz = texture(_CircleColorTex, u_xlat2.xy).xyz;
            u_xlat0.x = -abs(u_xlat14) + 1.5;
            u_xlat2.xyz = u_xlat0.xxx * u_xlat10_2.xyz;
            u_xlat0.x = (-_CircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat0.x = u_xlat0.x * u_xlat0.x;
            u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
            u_xlat16_2.xyz = u_xlat2.xyz;
        } else {
            u_xlat16_2.x = float(0.0);
            u_xlat16_2.y = float(0.0);
            u_xlat16_2.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb0.y){
        u_xlat0.x = _PrevCircleTime * _TimeIntervalRatio;
        u_xlat7 = u_xlat0.x * 1.57079506;
        u_xlat7 = sin(u_xlat7);
        u_xlat7 = u_xlat7 * _CircleRadius;
        u_xlat7 = floor(u_xlat7);
        u_xlat3.xyz = vs_TEXCOORD3.xyz + (-_PrevAvatarPosInWorldPos.xyz);
        u_xlat14 = u_xlat3.y + -0.5;
        u_xlat3.xz = roundEven(u_xlat3.xz);
        u_xlat3.y = roundEven(u_xlat14);
        u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat14 = sqrt(u_xlat14);
        u_xlat7 = (-u_xlat7) + u_xlat14;
#ifdef UNITY_ADRENO_ES3
        u_xlatb14 = !!(abs(u_xlat7)<1.50999999);
#else
        u_xlatb14 = abs(u_xlat7)<1.50999999;
#endif
        if(u_xlatb14){
            u_xlat0.xz = u_xlat0.xx * _CircleColorTex_ST.xy + _CircleColorTex_ST.zw;
            u_xlat10_3.xyz = texture(_CircleColorTex, u_xlat0.xz).xyz;
            u_xlat0.x = -abs(u_xlat7) + 1.5;
            u_xlat0.xyz = u_xlat0.xxx * u_xlat10_3.xyz;
            u_xlat22 = (-_PrevCircleTime) * _TimeIntervalRatio + 1.0;
            u_xlat22 = u_xlat22 * u_xlat22;
            u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
            u_xlat16_0.xyz = u_xlat0.xyz;
        } else {
            u_xlat16_0.x = float(0.0);
            u_xlat16_0.y = float(0.0);
            u_xlat16_0.z = float(0.0);
        //ENDIF
        }
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
    //ENDIF
    }
    u_xlat16_6.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat10_0.www + u_xlat16_5.xyz;
    u_xlat16_26 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_6.x = u_xlat16_26 + u_xlat16_26;
    u_xlat16_6.xyz = u_xlat1.xyz * (-u_xlat16_6.xxx) + u_xlat4.xyz;
    u_xlat16_1.x = -abs(u_xlat16_26) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ReflectFresnel.y + _ReflectFresnel.z;
    u_xlat10_8.xyz = texture(_EnvTex, u_xlat16_6.xyz).xyz;
    u_xlat16_8.xyz = u_xlat10_0.www * u_xlat10_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_Reflectivity, _Reflectivity, _Reflectivity)) + u_xlat16_5.xyz;
    u_xlat16_5.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx + vs_COLOR1.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = _BloomFactor;
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
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
}
}
}
}