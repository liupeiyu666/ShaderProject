//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/CloudSea" {
Properties {
_Tex1 ("Tex 1", 2D) = "white" { }
_TexRColor1 ("Texture Color For R Channel 1", Color) = (1,1,1,1)
_TexGColor1 ("Texture Color For G Channel 1", Color) = (1,1,1,1)
_TexBColor1 ("Texture Color For B Channel 1", Color) = (1,1,1,1)
_Velocity1 ("Velocity 1", Float) = 0
_Tex2 ("Tex 2", 2D) = "white" { }
_TexRColor2 ("Texture Color For R Channel 2", Color) = (1,1,1,1)
_TexGColor2 ("Texture Color For G Channel 2", Color) = (1,1,1,1)
_TexBColor2 ("Texture Color For B Channel 2", Color) = (1,1,1,1)
_Velocity2 ("Velocity 2", Float) = 0
_SunDirAngle ("Sun Direction Angle", Range(0, 6.283)) = 0
_SunDistance ("Sun Distance", Range(0, 10)) = 1
_GradFrontColor ("Gradiant Front Color", Color) = (1,1,1,1)
_GradBackColor ("Gradiant Back Color", Color) = (1,1,1,1)
_GradRangeScale ("Gradiant Range Scale", Float) = 1
_PerspectiveAdjConst ("Perspective Adjust Constant", Float) = 1
_PerspectiveAdjLinear ("Perspective Adjust Linear", Float) = 1
_CloudMaskIntensity ("Cloud Mask Intensity", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
  GpuProgramID 49391
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _SkyBoxFogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
mediump vec2 u_xlat16_13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
    u_xlat0.xy = u_xlat0.xy * (-u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat10.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat10.x = _PerspectiveAdjLinear * u_xlat10.x + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat10.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat10.xy = u_xlat10.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = float(0.0);
    u_xlat12.x = float(0.0);
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat11.xy = fract(u_xlat2.xy);
    u_xlat1.xy = (-u_xlat11.xy) + u_xlat1.xy;
    u_xlat12.y = _Time.x * _Velocity2;
    u_xlat2.xy = fract(u_xlat12.xy);
    u_xlat1.zw = u_xlat10.xy + (-u_xlat2.xy);
    vs_TEXCOORD0 = u_xlat1;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _SkyBoxFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _FogEffectStart);
    u_xlat1.w = min(u_xlat0.x, _SkyBoxFogEffectLimit);
    u_xlat0.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
    u_xlat1.xyz = u_xlat0.yyy * u_xlat0.xzw + _FogColorFar.xyz;
    vs_COLOR1 = u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + vs_COLOR1.xyz;
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat10.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat10.x = u_xlat10.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat0.x>=u_xlat10.x);
#else
    u_xlatb10 = u_xlat0.x>=u_xlat10.x;
#endif
    u_xlat15 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta.w;
    u_xlat10.x = (u_xlatb10) ? u_xlat16 : u_xlat15;
    u_xlat10.x = log2(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * _Mihoyo_FogColor.w;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = min(u_xlat10.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat5 * -1.44269502;
    u_xlat10.y = exp2(u_xlat15);
    u_xlat10.xy = (-u_xlat10.xy) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat10.y / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5);
#endif
    u_xlat16_3 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat5 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat0.x) + 2.0;
    u_xlat16_8 = u_xlat0.x * u_xlat16_8;
    u_xlat0.x = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColDelta.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	vec4 _Tex1_ST;
uniform 	mediump float _Velocity1;
uniform 	vec4 _Tex2_ST;
uniform 	mediump float _Velocity2;
uniform 	mediump float _SunDirAngle;
uniform 	mediump float _SunDistance;
uniform 	float _PerspectiveAdjConst;
uniform 	float _PerspectiveAdjLinear;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
mediump vec2 u_xlat16_13;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = _PerspectiveAdjLinear * u_xlat15 + _PerspectiveAdjConst;
    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15) + vec2(0.5, 0.5);
    u_xlat11.xy = u_xlat1.xy * _Tex1_ST.xy + _Tex1_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    u_xlat2.x = 0.0;
    u_xlat2.y = _Time.x * _Velocity1;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat11.xy + (-u_xlat2.xy);
    u_xlat11.x = 0.0;
    u_xlat11.y = _Time.x * _Velocity2;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat2.zw = (-u_xlat11.xy) + u_xlat1.xy;
    vs_TEXCOORD0 = u_xlat2;
    u_xlat16_3 = sin(_SunDirAngle);
    u_xlat16_4 = cos(_SunDirAngle);
    u_xlat16_13.x = u_xlat16_4;
    u_xlat16_13.y = u_xlat16_3;
    u_xlat1.zw = u_xlat16_13.xy * vec2(vec2(_SunDistance, _SunDistance)) + vec2(0.5, 0.5);
    u_xlat1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColDelta3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColDelta2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TexRColor1;
uniform 	mediump vec4 _TexGColor1;
uniform 	mediump vec4 _TexBColor1;
uniform 	mediump vec4 _TexRColor2;
uniform 	mediump vec4 _TexGColor2;
uniform 	mediump vec4 _TexBColor2;
uniform 	mediump vec4 _GradFrontColor;
uniform 	mediump vec4 _GradBackColor;
uniform 	mediump float _GradRangeScale;
uniform 	mediump float _CloudMaskIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _SkyBoxColor;
uniform 	mediump float _SkyBoxColorScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _Tex1;
uniform lowp sampler2D _Tex2;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
lowp vec3 u_xlat10_8;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0.xy = vec2((-vs_TEXCOORD1.z) + vs_TEXCOORD1.x, (-vs_TEXCOORD1.w) + vs_TEXCOORD1.y);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GradRangeScale;
    u_xlat16_0.x = fract(u_xlat16_0.x);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.699999988;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1.x = u_xlat16_0.x + -1.0;
    u_xlat16_1.x = _CloudMaskIntensity * u_xlat16_1.x + 1.0;
    u_xlat10_8.xyz = texture(_Tex2, vs_TEXCOORD0.zw).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xxx * u_xlat10_8.xyz;
    u_xlat16_7.xyz = _TexRColor1.xyz * u_xlat16_1.xxx + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = (-_GradFrontColor.xyz) + _GradBackColor.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + _GradFrontColor.xyz;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat16_1.y * _TexGColor2.w;
    u_xlat16_3.xyz = _TexGColor2.xyz * u_xlat16_2.xyz + (-_TexRColor2.xyz);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz + _TexRColor2.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_1.zzz * _TexBColor2.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_6.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat10_8.xyz = texture(_Tex1, vs_TEXCOORD0.xy).xyz;
    u_xlat16_23 = u_xlat10_8.x * _TexRColor1.w;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_7.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = _TexGColor1.xyz * u_xlat16_2.xyz + (-u_xlat16_7.xyz);
    u_xlat16_23 = u_xlat10_8.y * _TexGColor1.w;
    u_xlat16_4.xyz = u_xlat10_8.zzz * _TexBColor1.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_7.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_21 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_21) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = _SkyBoxColor.xyz * vec3(_SkyBoxColorScaler);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * u_xlat16_2.xyz + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_1.xyz + u_xlat16_3.xyz;
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