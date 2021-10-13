//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Glitch" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_MainTex ("_MainTex", 2D) = "white" { }
_MainIndensity ("MainIndensity", Float) = 0
_MainOpacity ("MainOpacity", Range(0, 1)) = 0
_BgOpacity ("BgOpacity", Range(-2, 1)) = 0
_BackGroundColor ("BackGroundColor", Color) = (0,0,0,0)
_InsideTexture ("InsideTexture", 2D) = "white" { }
_insideTexR ("InsideTextureR", Float) = 1
_insideTexG ("InsideTextureG", Float) = 1
_insideTexB ("InsideTextureB", Float) = 1
_InsideColor ("InsideColor", Color) = (0,0,0,0)
_InsideIndensity ("InsideIndensity", Float) = 0
_InsideSpeed ("InsideSpeed", Vector) = (0,0,0,0)
_OffsetCtTexture ("OffsetCtTexture", 2D) = "white" { }
_OffsetIndensity ("OffsetIndensity", Range(-0.2, 1)) = 1
_OffsetTiling ("OffsetTiling", Vector) = (0,0,0,0)
_OffsetCtSpeed ("OffsetCtSpeed", Vector) = (0,0,0,0)
_NoiseTexture ("NoiseTexture", 2D) = "white" { }
_NoiseTilling ("NoiseTilling", Vector) = (1,1,0,0)
_BgMainTex ("BgMainTex", 2D) = "white" { }
_BgMainTexColor ("BgMainTexColor", Color) = (0.1260235,0.4452659,0.4528302,0)
_BgMainTexIntensity ("BgMainTexIntensity", Float) = 1
_BgMainTexSpeed ("BgMainTexSpeed", Vector) = (0,0.02,0,0)
_BgMainTexMaskSpeed ("BgMainTexMaskSpeed", Vector) = (0.01,0.61,0,0)
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_RMCCRect ("Rect Color Change Mask Rect", Vector) = (0,0,0,0)
_RMCCTransitWidth ("Rect Color Change Mask Transit Width", Vector) = (0,0,0,0)
_ColorChangeIntensity ("ColorChangeIntensity", Range(0, 10)) = 0
_ColorChangePow ("ColorChangePow", Range(0, 10)) = 0
_ColorMask ("Color Mask", Float) = 15
[Enum(UnityEngine.Rendering.BlendMode)] _DstFactor ("DstFactor", Float) = 10
}
SubShader {
 LOD 100
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  GpuProgramID 53463
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _MainOpacity;
uniform 	float _BgOpacity;
uniform 	vec4 _BackGroundColor;
uniform 	float _MainIndensity;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = (-u_xlat10_0.w) + 1.0;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_MainIndensity);
    u_xlat1.xyz = u_xlat0.xyz * _MainColor.xyz + _BackGroundColor.xyz;
    u_xlat1.w = _BgOpacity * u_xlat16_6 + _MainOpacity;
    SV_Target0 = u_xlat1;
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
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _MainOpacity;
uniform 	float _BgOpacity;
uniform 	vec4 _BackGroundColor;
uniform 	float _MainIndensity;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = (-u_xlat10_0.w) + 1.0;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_MainIndensity);
    u_xlat1.xyz = u_xlat0.xyz * _MainColor.xyz + _BackGroundColor.xyz;
    u_xlat1.w = _BgOpacity * u_xlat16_6 + _MainOpacity;
    SV_Target0 = u_xlat1;
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
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _MainOpacity;
uniform 	float _BgOpacity;
uniform 	vec4 _BackGroundColor;
uniform 	float _MainIndensity;
uniform 	vec4 _MainColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = (-u_xlat10_0.w) + 1.0;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(_MainIndensity);
    u_xlat1.xyz = u_xlat0.xyz * _MainColor.xyz + _BackGroundColor.xyz;
    u_xlat1.w = _BgOpacity * u_xlat16_6 + _MainOpacity;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD4;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump vec4 _RMCCRect;
uniform 	mediump vec4 _RMCCTransitWidth;
uniform 	float _MainOpacity;
uniform 	float _BgOpacity;
uniform 	vec2 _InsideSpeed;
uniform 	vec2 _NoiseTilling;
uniform 	float _OffsetIndensity;
uniform 	vec2 _OffsetCtSpeed;
uniform 	vec2 _OffsetTiling;
uniform 	float _insideTexR;
uniform 	float _insideTexG;
uniform 	float _insideTexB;
uniform 	float _InsideIndensity;
uniform 	vec4 _BackGroundColor;
uniform 	vec4 _InsideColor;
uniform 	float _MainIndensity;
uniform 	vec4 _MainColor;
uniform 	vec4 _BgMainTex_ST;
uniform 	vec2 _BgMainTexMaskSpeed;
uniform 	vec2 _BgMainTexSpeed;
uniform 	vec4 _BgMainTexColor;
uniform 	float _BgMainTexIntensity;
uniform 	float _ColorChangeIntensity;
uniform 	float _ColorChangePow;
uniform lowp sampler2D _NoiseTexture;
uniform lowp sampler2D _OffsetCtTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _InsideTexture;
uniform lowp sampler2D _BgMainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_OffsetTiling.x), vs_TEXCOORD0.y * float(_OffsetTiling.y));
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat0.xy = _Time.yy * _OffsetCtSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_OffsetCtTexture, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _OffsetIndensity;
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_2 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_3 = vec4(u_xlat16_2.z + (-_RMRect.x), u_xlat16_2.w + (-_RMRect.y), u_xlat16_2.z + (-_RMRect.z), u_xlat16_2.w + (-_RMRect.w));
    u_xlat16_3 = u_xlat16_3 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
    u_xlat16_1.x = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.z * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _NoiseTilling.xy;
    u_xlat6.xy = _Time.yy * vec2(_InsideSpeed.x, _InsideSpeed.y) + u_xlat6.xy;
    u_xlat10_18 = texture(_NoiseTexture, u_xlat6.xy).x;
    u_xlat10_4.xyz = texture(_InsideTexture, u_xlat6.xy).xyz;
    u_xlat6.x = dot(u_xlat10_4.xyz, vec3(_insideTexR, _insideTexG, _insideTexB));
    u_xlat16_12 = u_xlat16_1.x * u_xlat10_18;
    u_xlat16_18 = (-u_xlat10_18) + 1.0;
    u_xlat4.x = u_xlat0.x * u_xlat16_12;
    u_xlat5.x = u_xlat16_12 * u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat0.x = u_xlat6.x * u_xlat4.x;
    u_xlat0.x = u_xlat16_18 * u_xlat0.x;
    u_xlat5.y = vs_TEXCOORD0.y;
    u_xlat10_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * _InsideIndensity;
    u_xlat6.x = u_xlat0.x * 50.0;
    u_xlat0.x = (-u_xlat0.x) * 50.0 + 1.0;
    u_xlat6.xyz = u_xlat6.xxx * _InsideColor.xyz;
    u_xlat6.xyz = u_xlat16_1.xxx * u_xlat6.xyz;
    u_xlat4.xyz = u_xlat10_3.xyz * vec3(_MainIndensity);
    u_xlat16_22 = (-u_xlat10_3.w) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_22;
    u_xlat3.w = _BgOpacity * u_xlat0.x + _MainOpacity;
    u_xlat0.xyz = u_xlat4.xyz * _MainColor.xyz + u_xlat6.xyz;
    u_xlat4 = vs_TEXCOORD0.xyxy * _BgMainTex_ST.xyxy + _BgMainTex_ST.zwzw;
    u_xlat4 = _Time.yyyy * vec4(_BgMainTexSpeed.x, _BgMainTexSpeed.y, _BgMainTexMaskSpeed.x, _BgMainTexMaskSpeed.y) + u_xlat4;
    u_xlat10_18 = texture(_BgMainTex, u_xlat4.zw).x;
    u_xlat10_4.x = texture(_BgMainTex, u_xlat4.xy).x;
    u_xlat18 = u_xlat10_18 * u_xlat10_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=0.100000001);
#else
    u_xlatb18 = u_xlat18>=0.100000001;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 * _BgMainTexIntensity;
    u_xlat4.xyz = vec3(u_xlat18) * _BgMainTexColor.xyz;
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat4.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BackGroundColor.xyz;
    u_xlat16_1 = u_xlat16_2 + (-_RMCCRect);
    u_xlat16_2.x = (-u_xlat16_2.w) + 1.0;
    u_xlat16_18 = log2(u_xlat16_2.x);
    u_xlat18 = u_xlat16_18 * _ColorChangePow;
    u_xlat18 = exp2(u_xlat18);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMCCTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_1.x = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.z * u_xlat16_1.x;
    u_xlat16_7 = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_1.w + 1.0;
    u_xlat16_1.xzw = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_7);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(vec3(_ColorChangeIntensity, _ColorChangeIntensity, _ColorChangeIntensity)) + u_xlat16_1.xzw;
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD4;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump vec4 _RMCCRect;
uniform 	mediump vec4 _RMCCTransitWidth;
uniform 	float _MainOpacity;
uniform 	float _BgOpacity;
uniform 	vec2 _InsideSpeed;
uniform 	vec2 _NoiseTilling;
uniform 	float _OffsetIndensity;
uniform 	vec2 _OffsetCtSpeed;
uniform 	vec2 _OffsetTiling;
uniform 	float _insideTexR;
uniform 	float _insideTexG;
uniform 	float _insideTexB;
uniform 	float _InsideIndensity;
uniform 	vec4 _BackGroundColor;
uniform 	vec4 _InsideColor;
uniform 	float _MainIndensity;
uniform 	vec4 _MainColor;
uniform 	vec4 _BgMainTex_ST;
uniform 	vec2 _BgMainTexMaskSpeed;
uniform 	vec2 _BgMainTexSpeed;
uniform 	vec4 _BgMainTexColor;
uniform 	float _BgMainTexIntensity;
uniform 	float _ColorChangeIntensity;
uniform 	float _ColorChangePow;
uniform lowp sampler2D _NoiseTexture;
uniform lowp sampler2D _OffsetCtTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _InsideTexture;
uniform lowp sampler2D _BgMainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_OffsetTiling.x), vs_TEXCOORD0.y * float(_OffsetTiling.y));
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat0.xy = _Time.yy * _OffsetCtSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_OffsetCtTexture, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _OffsetIndensity;
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_2 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_3 = vec4(u_xlat16_2.z + (-_RMRect.x), u_xlat16_2.w + (-_RMRect.y), u_xlat16_2.z + (-_RMRect.z), u_xlat16_2.w + (-_RMRect.w));
    u_xlat16_3 = u_xlat16_3 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
    u_xlat16_1.x = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.z * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _NoiseTilling.xy;
    u_xlat6.xy = _Time.yy * vec2(_InsideSpeed.x, _InsideSpeed.y) + u_xlat6.xy;
    u_xlat10_18 = texture(_NoiseTexture, u_xlat6.xy).x;
    u_xlat10_4.xyz = texture(_InsideTexture, u_xlat6.xy).xyz;
    u_xlat6.x = dot(u_xlat10_4.xyz, vec3(_insideTexR, _insideTexG, _insideTexB));
    u_xlat16_12 = u_xlat16_1.x * u_xlat10_18;
    u_xlat16_18 = (-u_xlat10_18) + 1.0;
    u_xlat4.x = u_xlat0.x * u_xlat16_12;
    u_xlat5.x = u_xlat16_12 * u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat0.x = u_xlat6.x * u_xlat4.x;
    u_xlat0.x = u_xlat16_18 * u_xlat0.x;
    u_xlat5.y = vs_TEXCOORD0.y;
    u_xlat10_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * _InsideIndensity;
    u_xlat6.x = u_xlat0.x * 50.0;
    u_xlat0.x = (-u_xlat0.x) * 50.0 + 1.0;
    u_xlat6.xyz = u_xlat6.xxx * _InsideColor.xyz;
    u_xlat6.xyz = u_xlat16_1.xxx * u_xlat6.xyz;
    u_xlat4.xyz = u_xlat10_3.xyz * vec3(_MainIndensity);
    u_xlat16_22 = (-u_xlat10_3.w) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_22;
    u_xlat3.w = _BgOpacity * u_xlat0.x + _MainOpacity;
    u_xlat0.xyz = u_xlat4.xyz * _MainColor.xyz + u_xlat6.xyz;
    u_xlat4 = vs_TEXCOORD0.xyxy * _BgMainTex_ST.xyxy + _BgMainTex_ST.zwzw;
    u_xlat4 = _Time.yyyy * vec4(_BgMainTexSpeed.x, _BgMainTexSpeed.y, _BgMainTexMaskSpeed.x, _BgMainTexMaskSpeed.y) + u_xlat4;
    u_xlat10_18 = texture(_BgMainTex, u_xlat4.zw).x;
    u_xlat10_4.x = texture(_BgMainTex, u_xlat4.xy).x;
    u_xlat18 = u_xlat10_18 * u_xlat10_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=0.100000001);
#else
    u_xlatb18 = u_xlat18>=0.100000001;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 * _BgMainTexIntensity;
    u_xlat4.xyz = vec3(u_xlat18) * _BgMainTexColor.xyz;
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat4.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BackGroundColor.xyz;
    u_xlat16_1 = u_xlat16_2 + (-_RMCCRect);
    u_xlat16_2.x = (-u_xlat16_2.w) + 1.0;
    u_xlat16_18 = log2(u_xlat16_2.x);
    u_xlat18 = u_xlat16_18 * _ColorChangePow;
    u_xlat18 = exp2(u_xlat18);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMCCTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_1.x = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.z * u_xlat16_1.x;
    u_xlat16_7 = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_1.w + 1.0;
    u_xlat16_1.xzw = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_7);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(vec3(_ColorChangeIntensity, _ColorChangeIntensity, _ColorChangeIntensity)) + u_xlat16_1.xzw;
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD4;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump vec4 _RMCCRect;
uniform 	mediump vec4 _RMCCTransitWidth;
uniform 	float _MainOpacity;
uniform 	float _BgOpacity;
uniform 	vec2 _InsideSpeed;
uniform 	vec2 _NoiseTilling;
uniform 	float _OffsetIndensity;
uniform 	vec2 _OffsetCtSpeed;
uniform 	vec2 _OffsetTiling;
uniform 	float _insideTexR;
uniform 	float _insideTexG;
uniform 	float _insideTexB;
uniform 	float _InsideIndensity;
uniform 	vec4 _BackGroundColor;
uniform 	vec4 _InsideColor;
uniform 	float _MainIndensity;
uniform 	vec4 _MainColor;
uniform 	vec4 _BgMainTex_ST;
uniform 	vec2 _BgMainTexMaskSpeed;
uniform 	vec2 _BgMainTexSpeed;
uniform 	vec4 _BgMainTexColor;
uniform 	float _BgMainTexIntensity;
uniform 	float _ColorChangeIntensity;
uniform 	float _ColorChangePow;
uniform lowp sampler2D _NoiseTexture;
uniform lowp sampler2D _OffsetCtTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _InsideTexture;
uniform lowp sampler2D _BgMainTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.xy = vec2(vs_TEXCOORD0.x * float(_OffsetTiling.x), vs_TEXCOORD0.y * float(_OffsetTiling.y));
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat0.xy = _Time.yy * _OffsetCtSpeed.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_OffsetCtTexture, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _OffsetIndensity;
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_2 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_3 = vec4(u_xlat16_2.z + (-_RMRect.x), u_xlat16_2.w + (-_RMRect.y), u_xlat16_2.z + (-_RMRect.z), u_xlat16_2.w + (-_RMRect.w));
    u_xlat16_3 = u_xlat16_3 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
    u_xlat16_1.x = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.z * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _NoiseTilling.xy;
    u_xlat6.xy = _Time.yy * vec2(_InsideSpeed.x, _InsideSpeed.y) + u_xlat6.xy;
    u_xlat10_18 = texture(_NoiseTexture, u_xlat6.xy).x;
    u_xlat10_4.xyz = texture(_InsideTexture, u_xlat6.xy).xyz;
    u_xlat6.x = dot(u_xlat10_4.xyz, vec3(_insideTexR, _insideTexG, _insideTexB));
    u_xlat16_12 = u_xlat16_1.x * u_xlat10_18;
    u_xlat16_18 = (-u_xlat10_18) + 1.0;
    u_xlat4.x = u_xlat0.x * u_xlat16_12;
    u_xlat5.x = u_xlat16_12 * u_xlat0.x + vs_TEXCOORD0.x;
    u_xlat0.x = u_xlat6.x * u_xlat4.x;
    u_xlat0.x = u_xlat16_18 * u_xlat0.x;
    u_xlat5.y = vs_TEXCOORD0.y;
    u_xlat10_3 = texture(_MainTex, u_xlat5.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_3.z;
    u_xlat0.x = u_xlat0.x * _InsideIndensity;
    u_xlat6.x = u_xlat0.x * 50.0;
    u_xlat0.x = (-u_xlat0.x) * 50.0 + 1.0;
    u_xlat6.xyz = u_xlat6.xxx * _InsideColor.xyz;
    u_xlat6.xyz = u_xlat16_1.xxx * u_xlat6.xyz;
    u_xlat4.xyz = u_xlat10_3.xyz * vec3(_MainIndensity);
    u_xlat16_22 = (-u_xlat10_3.w) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_22;
    u_xlat3.w = _BgOpacity * u_xlat0.x + _MainOpacity;
    u_xlat0.xyz = u_xlat4.xyz * _MainColor.xyz + u_xlat6.xyz;
    u_xlat4 = vs_TEXCOORD0.xyxy * _BgMainTex_ST.xyxy + _BgMainTex_ST.zwzw;
    u_xlat4 = _Time.yyyy * vec4(_BgMainTexSpeed.x, _BgMainTexSpeed.y, _BgMainTexMaskSpeed.x, _BgMainTexMaskSpeed.y) + u_xlat4;
    u_xlat10_18 = texture(_BgMainTex, u_xlat4.zw).x;
    u_xlat10_4.x = texture(_BgMainTex, u_xlat4.xy).x;
    u_xlat18 = u_xlat10_18 * u_xlat10_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=0.100000001);
#else
    u_xlatb18 = u_xlat18>=0.100000001;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 * _BgMainTexIntensity;
    u_xlat4.xyz = vec3(u_xlat18) * _BgMainTexColor.xyz;
    u_xlat4.xyz = u_xlat16_1.xxx * u_xlat4.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat3.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _BackGroundColor.xyz;
    u_xlat16_1 = u_xlat16_2 + (-_RMCCRect);
    u_xlat16_2.x = (-u_xlat16_2.w) + 1.0;
    u_xlat16_18 = log2(u_xlat16_2.x);
    u_xlat18 = u_xlat16_18 * _ColorChangePow;
    u_xlat18 = exp2(u_xlat18);
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_2 = max(_RMCCTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_2;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat16_1.x = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.z * u_xlat16_1.x;
    u_xlat16_7 = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_1.w + 1.0;
    u_xlat16_1.xzw = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(u_xlat16_7);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(vec3(_ColorChangeIntensity, _ColorChangeIntensity, _ColorChangeIntensity)) + u_xlat16_1.xzw;
    SV_Target0 = u_xlat3;
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
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
}