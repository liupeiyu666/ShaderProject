//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Common" {
Properties {
_AlphaCtrl ("AlphaCtrl", Range(0, 1)) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _SrcFactor ("SrcFactor()", Float) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _DstFactor ("DstFactor()", Float) = 10
[Enum(UnityEngine.Rendering.CullMode)] _CullMode ("消隐模式(CullMode)", Float) = 0
[Enum(LessEqual,4,Always,8)] _ZTestMode ("深度测试(ZTest)", Float) = 4
_Color ("Color", Color) = (1,1,1,1)
_Multiplier ("亮度", Range(1, 20)) = 1
_MainTex ("MainTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3,RGBA,4)] _Channel ("MainTex色彩通道", Float) = 0
[Toggle] _RgbAsAlpha ("颜色输出至透明(RgbAsAlpha)", Float) = 0
_MainTexRot ("Tex rotation", Range(0, 360)) = 0
_MainTexX ("TexUscroll", Float) = 0
_MainTexY ("TexVscroll", Float) = 0
_MaskTex ("mask", 2D) = "white" { }
_MaskTexRot ("mask_rotation", Range(0, 360)) = 0
_MaskTexX ("maskUscroll", Float) = 0
_MaskTexY ("maskVscroll", Float) = 0
_DissolveTex ("dissolveTex", 2D) = "white" { }
_Dissolve ("dissolveValue", Range(0, 1)) = 0
_DissolveColor1 ("dissolveColor1", Color) = (1,0,0,1)
_DissolveColor2 ("dissolveColor2", Color) = (0,0,0,1)
_DissolveRot ("dissolve rotation", Range(0, 360)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 51504
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bvec3 u_xlatb1;
float u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat9;
vec4 TempArray0[2];
void main()
{
    u_xlatb0.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb1.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 0.0)).xyz;
    u_xlat1.xyw = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb1.xyz));
    u_xlat9 = (u_xlatb1.z) ? -1.0 : -0.0;
    u_xlat2 = max(u_xlat0.x, u_xlat1.x);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat0.zw = u_xlat1.yx;
    u_xlat0.yz = vec2(u_xlat0.y * float(u_xlat2), u_xlat0.z * float(u_xlat2));
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.xyw = u_xlat1.www * u_xlat10_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3 = dot(u_xlat10_2, u_xlat0);
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat1.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_3 = u_xlat10_1 * u_xlat16_3;
    TempArray0[0].x = u_xlat16_3;
    u_xlat16_7 = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_7;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_3;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_3 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_3) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2 = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat1.x = u_xlat1.x * u_xlat16_4;
    u_xlat0.w = u_xlat1.x * _AlphaCtrl;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
uniform 	float _Multiplier;
uniform 	vec4 _MainTex_ST;
uniform 	float _MainTexRot;
uniform 	float _MainTexX;
uniform 	float _MainTexY;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTexRot;
uniform 	float _MaskTexX;
uniform 	float _MaskTexY;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveRot;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_9;
mediump vec2 u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(_MainTex_ST.w + float(0.5), _MainTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MainTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MainTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MainTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = _Time.zz * vec2(_MainTexX, _MainTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_MaskTex_ST.w + float(0.5), _MaskTex_ST.z + float(0.5));
    u_xlat0.xy = (-_MaskTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _MaskTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _MaskTexRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_10.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_10.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_10.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = _Time.zz * vec2(_MaskTexX, _MaskTexY) + u_xlat16_1.xy;
    u_xlat0.xy = vec2(_DissolveTex_ST.w + float(0.5), _DissolveTex_ST.z + float(0.5));
    u_xlat0.xy = (-_DissolveTex_ST.yx) * vec2(0.5, 0.5) + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.yx * _DissolveTex_ST.yx + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_9.x = _DissolveRot * 0.0174532868;
    u_xlat16_2.x = sin(u_xlat16_9.x);
    u_xlat16_3 = cos(u_xlat16_9.x);
    u_xlat16_9.xy = u_xlat16_1.xy * u_xlat16_2.xx;
    u_xlat16_2.x = u_xlat16_1.y * u_xlat16_3 + (-u_xlat16_9.x);
    u_xlat16_2.y = u_xlat16_1.x * u_xlat16_3 + u_xlat16_9.y;
    u_xlat16_1.xy = u_xlat16_2.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat16_1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0 * vec4(_Multiplier);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _AlphaCtrl;
uniform 	float _Channel;
uniform 	float _Dissolve;
uniform 	mediump vec4 _DissolveColor1;
uniform 	mediump vec4 _DissolveColor2;
uniform 	float _SrcFactor;
uniform 	float _RgbAsAlpha;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
bool u_xlatb2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec3 u_xlatb5;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec4 TempArray0[2];
void main()
{
    u_xlat10_0 = texture(_DissolveTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = _Dissolve * -1.20000005 + u_xlat10_0;
    u_xlat0.x = u_xlat0.x + 0.100000024;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat0.x<0.0);
#else
    u_xlatb5.x = u_xlat0.x<0.0;
#endif
    u_xlat0.x = u_xlat0.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb5.xy = greaterThanEqual(vec4(0.100000001, 1.10000002, 0.0, 0.0), vec4(vec4(_Channel, _Channel, _Channel, _Channel))).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb5.xyz = greaterThanEqual(vec4(vec4(_Channel, _Channel, _Channel, _Channel)), vec4(2.9000001, 1.89999998, 3.0999999, 3.0999999)).xyz;
    u_xlat2.xyz = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0), vec3(u_xlatb5.xyz));
    u_xlat5.x = (u_xlatb5.z) ? -1.0 : -0.0;
    u_xlat10 = max(u_xlat1.x, u_xlat2.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat1.zw = u_xlat2.yx;
    u_xlat1.yz = vec2(float(u_xlat10) * u_xlat1.y, float(u_xlat10) * u_xlat1.z);
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat2.zzz * u_xlat10_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4 = dot(u_xlat10_3, u_xlat1);
    u_xlat16_4 = u_xlat16_4 * vs_COLOR0.w;
    u_xlat5.xyz = u_xlat5.xxx + u_xlat2.xyz;
    u_xlat10_1 = texture(_MaskTex, vs_TEXCOORD0.zw).x;
    u_xlat16_4 = u_xlat10_1 * u_xlat16_4;
    TempArray0[0].x = u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.200000003<u_xlat0.x);
#else
    u_xlatb1 = 0.200000003<u_xlat0.x;
#endif
    u_xlat16_9.xyz = (-_DissolveColor1.xyz) + _DissolveColor2.xyz;
    u_xlat16_9.xyz = (bool(u_xlatb1)) ? u_xlat16_9.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + _DissolveColor1.xyz;
    u_xlat5.xyz = vs_COLOR0.xyz * u_xlat5.xyz + (-u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_Dissolve<0.00100000005);
#else
    u_xlatb1 = _Dissolve<0.00100000005;
#endif
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat16_9.x = dot(u_xlat0.xzy, vec3(0.330000013, 0.330000013, 0.340000004));
    TempArray0[1].x = u_xlat16_9.x;
    u_xlatu1 = uint(_RgbAsAlpha);
    u_xlat1.x = TempArray0[int(u_xlatu1)].x;
    u_xlat0.w = u_xlat1.x * u_xlat16_4;
    u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = (-u_xlat0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_SrcFactor==0.0);
#else
    u_xlatb2 = _SrcFactor==0.0;
#endif
    u_xlat16_4 = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = vec4(u_xlat16_4) * u_xlat16_1 + u_xlat0;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat2.x = u_xlat16_0.w * _AlphaCtrl;
    SV_Target0.w = u_xlat2.x;
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
Keywords { "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "MaskTex_On" "DissolveTex_On" "MultiplyBlend_On" "RT_PASS_ON" }
""
}
}
}
}
}