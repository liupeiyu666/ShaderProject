//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/ScreenFilter_AlphaBlend" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
[Toggle(REVERSEU)] _ReverseU ("Reverse U Coord", Float) = 0
[Toggle(REVERSEV)] _ReverseV ("Reverse V Coord", Float) = 0
[Toggle(DISTORTION)] _Dissolve ("Dissolve", Float) = 0
_ScreenDissColor ("Dissolve Color", Color) = (0.5,0.5,0.5,0.5)
_ScreenDissRangeColor ("Dissolve Range Color", Color) = (0.5,0.5,0.5,0.5)
_RangeScale ("RangeScale Intensity", Range(0, 2)) = 1.6
_RangeNormal ("Range Normal", Range(0, 100)) = 10
_ScreenDissTex ("Screen Dissolve", 2D) = "" { }
_ScreenDissRange ("Screen Dissolve Range", Float) = 1
_BloomFactorDissolve ("BloomFactorDissolve", Float) = 1
TimeAdd ("TimeAdd", Float) = 0
TimeFlow ("TimeFlow", Range(0, 1)) = 0.5
_RotationSpeed ("RotationSpeed", Float) = 25
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 12277
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        SV_Target0.xyz = u_xlat16_2.xyz;
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
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

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        SV_Target0.xyz = u_xlat16_2.xyz;
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
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

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        SV_Target0.xyz = u_xlat16_2.xyz;
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        SV_Target0.xyz = u_xlat16_2.xyz;
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
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
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        SV_Target0.xyz = u_xlat16_2.xyz;
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
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
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        SV_Target0.xyz = u_xlat16_2.xyz;
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
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
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _ScreenDissColor;
uniform 	mediump vec4 _ScreenDissRangeColor;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat7;
lowp float u_xlat10_7;
mediump float u_xlat16_13;
mediump float u_xlat16_23;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(0.0<_Dissolve);
#else
    u_xlatb0.x = 0.0<_Dissolve;
#endif
    if(u_xlatb0.x){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_23 = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat7 = _Time.x * _RotationSpeed;
        u_xlat3.x = sin(u_xlat7);
        u_xlat4 = cos(u_xlat7);
        u_xlat5.x = sin((-u_xlat7));
        u_xlat5.y = u_xlat4;
        u_xlat5.z = u_xlat3.x;
        u_xlat3.x = dot(vs_TEXCOORD0.xy, u_xlat5.yz);
        u_xlat3.y = dot(vs_TEXCOORD0.xy, u_xlat5.xy);
        u_xlat10_7 = texture(_ScreenDissTex, u_xlat3.xy).z;
        u_xlat16_6.x = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6.x = _ScreenDissRange * 4.0 + u_xlat16_6.x;
        u_xlat16_13 = (-u_xlat10_7) * TimeFlow + TimeAdd;
        u_xlat16_13 = u_xlat16_13 + 1.70000005;
        u_xlat16_6.y = u_xlat16_6.x * u_xlat16_13;
        u_xlat16_6.x = u_xlat16_6.x * _RangeScale;
        u_xlatb0.xy = greaterThanEqual(vec4(u_xlat16_23), u_xlat16_6.yxyy).xy;
        u_xlat16_3 = (u_xlatb0.y) ? _ScreenDissRangeColor : _ScreenDissColor;
        u_xlat16_3 = (u_xlatb0.x) ? _ScreenDissColor : u_xlat16_3;
        u_xlatb0.x = u_xlatb0.x || u_xlatb0.y;
        u_xlat16_23 = (u_xlatb0.x) ? 1.0 : 0.0;
        u_xlat16_4.xyz = (-u_xlat16_2.xyz);
        u_xlat16_4.w = (-u_xlat16_1.w);
        u_xlat16_3 = u_xlat16_3 + u_xlat16_4;
        u_xlat16_3 = vec4(u_xlat16_23) * u_xlat16_3;
        u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_3.xyz;
        u_xlat16_23 = u_xlat16_0.w * vs_COLOR0.w + u_xlat16_3.w;
    } else {
        u_xlat16_23 = u_xlat16_1.w;
    //ENDIF
    }
    SV_Target0.w = u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 89208
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomFactorDissolve;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec2 u_xlat10_0;
ivec2 u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
float u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_Dissolve);
#else
    u_xlatb0 = 0.0<_Dissolve;
#endif
    if(u_xlatb0){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.x = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat5 = _Time.x * _RotationSpeed;
        u_xlat2.x = sin(u_xlat5);
        u_xlat3 = cos(u_xlat5);
        u_xlat4.x = sin((-u_xlat5));
        u_xlat4.y = u_xlat3;
        u_xlat4.z = u_xlat2.x;
        u_xlat2.x = dot(vs_TEXCOORD0.xy, u_xlat4.yz);
        u_xlat2.y = dot(vs_TEXCOORD0.xy, u_xlat4.xy);
        u_xlat10_5 = texture(_ScreenDissTex, u_xlat2.xy).z;
        u_xlat16_6 = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6 = _ScreenDissRange * 4.0 + u_xlat16_6;
        u_xlat16_11 = (-u_xlat10_5) * TimeFlow + TimeAdd;
        u_xlat16_11 = u_xlat16_11 + 1.70000005;
        u_xlat16_11 = u_xlat16_11 * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_11 = u_xlat16_11 + 1.0;
        u_xlat16_11 = floor(u_xlat16_11);
        u_xlat16_1.z = max(u_xlat16_11, 0.0);
        u_xlat16_1.x = _RangeScale * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_1.x = u_xlat16_1.x + 1.0;
        u_xlat16_1.x = floor(u_xlat16_1.x);
        u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
        u_xlati0.xy = ivec2(u_xlat16_1.zx);
        u_xlati5 = (u_xlati0.y != 0) ? 0 : 1;
        u_xlati0.x = (u_xlati0.x != 0) ? u_xlati5 : 0;
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
        u_xlat16_1.x = u_xlat16_1.x * _BloomFactorDissolve;
    } else {
        u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
        u_xlat0 = u_xlat10_0.x + 0.99000001;
        u_xlat0 = floor(u_xlat0);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlati0.x = int(u_xlat0);
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
    //ENDIF
    }
    u_xlat16_1.y = 0.0;
    SV_Target0 = u_xlat16_1.yyyx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomFactorDissolve;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec2 u_xlat10_0;
ivec2 u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
float u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_Dissolve);
#else
    u_xlatb0 = 0.0<_Dissolve;
#endif
    if(u_xlatb0){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.x = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat5 = _Time.x * _RotationSpeed;
        u_xlat2.x = sin(u_xlat5);
        u_xlat3 = cos(u_xlat5);
        u_xlat4.x = sin((-u_xlat5));
        u_xlat4.y = u_xlat3;
        u_xlat4.z = u_xlat2.x;
        u_xlat2.x = dot(vs_TEXCOORD0.xy, u_xlat4.yz);
        u_xlat2.y = dot(vs_TEXCOORD0.xy, u_xlat4.xy);
        u_xlat10_5 = texture(_ScreenDissTex, u_xlat2.xy).z;
        u_xlat16_6 = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6 = _ScreenDissRange * 4.0 + u_xlat16_6;
        u_xlat16_11 = (-u_xlat10_5) * TimeFlow + TimeAdd;
        u_xlat16_11 = u_xlat16_11 + 1.70000005;
        u_xlat16_11 = u_xlat16_11 * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_11 = u_xlat16_11 + 1.0;
        u_xlat16_11 = floor(u_xlat16_11);
        u_xlat16_1.z = max(u_xlat16_11, 0.0);
        u_xlat16_1.x = _RangeScale * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_1.x = u_xlat16_1.x + 1.0;
        u_xlat16_1.x = floor(u_xlat16_1.x);
        u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
        u_xlati0.xy = ivec2(u_xlat16_1.zx);
        u_xlati5 = (u_xlati0.y != 0) ? 0 : 1;
        u_xlati0.x = (u_xlati0.x != 0) ? u_xlati5 : 0;
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
        u_xlat16_1.x = u_xlat16_1.x * _BloomFactorDissolve;
    } else {
        u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
        u_xlat0 = u_xlat10_0.x + 0.99000001;
        u_xlat0 = floor(u_xlat0);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlati0.x = int(u_xlat0);
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
    //ENDIF
    }
    u_xlat16_1.y = 0.0;
    SV_Target0 = u_xlat16_1.yyyx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
bvec2 u_xlatb0;
vec2 u_xlat1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlatb0.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = (-u_xlat4.xy) + vec2(1.0, 1.0);
    vs_TEXCOORD0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat4.x;
    vs_TEXCOORD0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat4.y;
    vs_TEXCOORD1 = in_COLOR0.w;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomFactorDissolve;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec2 u_xlat10_0;
ivec2 u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
float u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_Dissolve);
#else
    u_xlatb0 = 0.0<_Dissolve;
#endif
    if(u_xlatb0){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.x = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat5 = _Time.x * _RotationSpeed;
        u_xlat2.x = sin(u_xlat5);
        u_xlat3 = cos(u_xlat5);
        u_xlat4.x = sin((-u_xlat5));
        u_xlat4.y = u_xlat3;
        u_xlat4.z = u_xlat2.x;
        u_xlat2.x = dot(vs_TEXCOORD0.xy, u_xlat4.yz);
        u_xlat2.y = dot(vs_TEXCOORD0.xy, u_xlat4.xy);
        u_xlat10_5 = texture(_ScreenDissTex, u_xlat2.xy).z;
        u_xlat16_6 = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6 = _ScreenDissRange * 4.0 + u_xlat16_6;
        u_xlat16_11 = (-u_xlat10_5) * TimeFlow + TimeAdd;
        u_xlat16_11 = u_xlat16_11 + 1.70000005;
        u_xlat16_11 = u_xlat16_11 * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_11 = u_xlat16_11 + 1.0;
        u_xlat16_11 = floor(u_xlat16_11);
        u_xlat16_1.z = max(u_xlat16_11, 0.0);
        u_xlat16_1.x = _RangeScale * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_1.x = u_xlat16_1.x + 1.0;
        u_xlat16_1.x = floor(u_xlat16_1.x);
        u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
        u_xlati0.xy = ivec2(u_xlat16_1.zx);
        u_xlati5 = (u_xlati0.y != 0) ? 0 : 1;
        u_xlati0.x = (u_xlati0.x != 0) ? u_xlati5 : 0;
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
        u_xlat16_1.x = u_xlat16_1.x * _BloomFactorDissolve;
    } else {
        u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
        u_xlat0 = u_xlat10_0.x + 0.99000001;
        u_xlat0 = floor(u_xlat0);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlati0.x = int(u_xlat0);
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
    //ENDIF
    }
    u_xlat16_1.y = 0.0;
    SV_Target0 = u_xlat16_1.yyyx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomFactorDissolve;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec2 u_xlat10_0;
ivec2 u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
float u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_Dissolve);
#else
    u_xlatb0 = 0.0<_Dissolve;
#endif
    if(u_xlatb0){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.x = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat5 = _Time.x * _RotationSpeed;
        u_xlat2.x = sin(u_xlat5);
        u_xlat3 = cos(u_xlat5);
        u_xlat4.x = sin((-u_xlat5));
        u_xlat4.y = u_xlat3;
        u_xlat4.z = u_xlat2.x;
        u_xlat2.x = dot(vs_TEXCOORD0.xy, u_xlat4.yz);
        u_xlat2.y = dot(vs_TEXCOORD0.xy, u_xlat4.xy);
        u_xlat10_5 = texture(_ScreenDissTex, u_xlat2.xy).z;
        u_xlat16_6 = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6 = _ScreenDissRange * 4.0 + u_xlat16_6;
        u_xlat16_11 = (-u_xlat10_5) * TimeFlow + TimeAdd;
        u_xlat16_11 = u_xlat16_11 + 1.70000005;
        u_xlat16_11 = u_xlat16_11 * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_11 = u_xlat16_11 + 1.0;
        u_xlat16_11 = floor(u_xlat16_11);
        u_xlat16_1.z = max(u_xlat16_11, 0.0);
        u_xlat16_1.x = _RangeScale * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_1.x = u_xlat16_1.x + 1.0;
        u_xlat16_1.x = floor(u_xlat16_1.x);
        u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
        u_xlati0.xy = ivec2(u_xlat16_1.zx);
        u_xlati5 = (u_xlati0.y != 0) ? 0 : 1;
        u_xlati0.x = (u_xlati0.x != 0) ? u_xlati5 : 0;
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
        u_xlat16_1.x = u_xlat16_1.x * _BloomFactorDissolve;
    } else {
        u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
        u_xlat0 = u_xlat10_0.x + 0.99000001;
        u_xlat0 = floor(u_xlat0);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlati0.x = int(u_xlat0);
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
    //ENDIF
    }
    u_xlat16_1.y = 0.0;
    SV_Target0 = u_xlat16_1.yyyx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomFactorDissolve;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec2 u_xlat10_0;
ivec2 u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
float u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_Dissolve);
#else
    u_xlatb0 = 0.0<_Dissolve;
#endif
    if(u_xlatb0){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.x = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat5 = _Time.x * _RotationSpeed;
        u_xlat2.x = sin(u_xlat5);
        u_xlat3 = cos(u_xlat5);
        u_xlat4.x = sin((-u_xlat5));
        u_xlat4.y = u_xlat3;
        u_xlat4.z = u_xlat2.x;
        u_xlat2.x = dot(vs_TEXCOORD0.xy, u_xlat4.yz);
        u_xlat2.y = dot(vs_TEXCOORD0.xy, u_xlat4.xy);
        u_xlat10_5 = texture(_ScreenDissTex, u_xlat2.xy).z;
        u_xlat16_6 = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6 = _ScreenDissRange * 4.0 + u_xlat16_6;
        u_xlat16_11 = (-u_xlat10_5) * TimeFlow + TimeAdd;
        u_xlat16_11 = u_xlat16_11 + 1.70000005;
        u_xlat16_11 = u_xlat16_11 * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_11 = u_xlat16_11 + 1.0;
        u_xlat16_11 = floor(u_xlat16_11);
        u_xlat16_1.z = max(u_xlat16_11, 0.0);
        u_xlat16_1.x = _RangeScale * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_1.x = u_xlat16_1.x + 1.0;
        u_xlat16_1.x = floor(u_xlat16_1.x);
        u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
        u_xlati0.xy = ivec2(u_xlat16_1.zx);
        u_xlati5 = (u_xlati0.y != 0) ? 0 : 1;
        u_xlati0.x = (u_xlati0.x != 0) ? u_xlati5 : 0;
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
        u_xlat16_1.x = u_xlat16_1.x * _BloomFactorDissolve;
    } else {
        u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
        u_xlat0 = u_xlat10_0.x + 0.99000001;
        u_xlat0 = floor(u_xlat0);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlati0.x = int(u_xlat0);
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
    //ENDIF
    }
    u_xlat16_1.y = 0.0;
    SV_Target0 = u_xlat16_1.yyyx;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ReverseU;
uniform 	mediump float _ReverseV;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec2 u_xlat4;
void main()
{
    gl_Position.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.z = 0.0;
    gl_Position.w = in_POSITION0.w;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = (-u_xlat0.xy) + vec2(1.0, 1.0);
    u_xlatb1.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_ReverseU, _ReverseV, _ReverseU, _ReverseU)).xy;
    vs_TEXCOORD0.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat0.x;
    vs_TEXCOORD0.y = (u_xlatb1.y) ? u_xlat4.y : u_xlat0.y;
    vs_TEXCOORD1 = in_COLOR0.w;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD2 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	mediump float _RangeScale;
uniform 	mediump float _RangeNormal;
uniform 	mediump float _ScreenDissRange;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _BloomFactorDissolve;
uniform 	mediump float _Dissolve;
uniform 	mediump float TimeAdd;
uniform 	mediump float TimeFlow;
uniform 	mediump float _RotationSpeed;
uniform lowp sampler2D _ScreenDissTex;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp vec2 u_xlat10_0;
ivec2 u_xlati0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
float u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD2.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD2.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD2.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD2.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0.x = int(u_xlat0);
    if((u_xlati0.x)==0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_Dissolve);
#else
    u_xlatb0 = 0.0<_Dissolve;
#endif
    if(u_xlatb0){
        u_xlat10_0.xy = texture(_ScreenDissTex, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.x = u_xlat10_0.y * 7.96000004 + -1.0;
        u_xlat5 = _Time.x * _RotationSpeed;
        u_xlat2.x = sin(u_xlat5);
        u_xlat3 = cos(u_xlat5);
        u_xlat4.x = sin((-u_xlat5));
        u_xlat4.y = u_xlat3;
        u_xlat4.z = u_xlat2.x;
        u_xlat2.x = dot(vs_TEXCOORD0.xy, u_xlat4.yz);
        u_xlat2.y = dot(vs_TEXCOORD0.xy, u_xlat4.xy);
        u_xlat10_5 = texture(_ScreenDissTex, u_xlat2.xy).z;
        u_xlat16_6 = u_xlat10_0.x * _RangeNormal;
        u_xlat16_6 = _ScreenDissRange * 4.0 + u_xlat16_6;
        u_xlat16_11 = (-u_xlat10_5) * TimeFlow + TimeAdd;
        u_xlat16_11 = u_xlat16_11 + 1.70000005;
        u_xlat16_11 = u_xlat16_11 * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_11 = u_xlat16_11 + 1.0;
        u_xlat16_11 = floor(u_xlat16_11);
        u_xlat16_1.z = max(u_xlat16_11, 0.0);
        u_xlat16_1.x = _RangeScale * u_xlat16_6 + (-u_xlat16_1.x);
        u_xlat16_1.x = u_xlat16_1.x + 1.0;
        u_xlat16_1.x = floor(u_xlat16_1.x);
        u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
        u_xlati0.xy = ivec2(u_xlat16_1.zx);
        u_xlati5 = (u_xlati0.y != 0) ? 0 : 1;
        u_xlati0.x = (u_xlati0.x != 0) ? u_xlati5 : 0;
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
        u_xlat16_1.x = u_xlat16_1.x * _BloomFactorDissolve;
    } else {
        u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
        u_xlat0 = u_xlat10_0.x + 0.99000001;
        u_xlat0 = floor(u_xlat0);
        u_xlat0 = max(u_xlat0, 0.0);
        u_xlati0.x = int(u_xlat0);
        if((u_xlati0.x)==0){discard;}
        u_xlat16_1.x = vs_TEXCOORD1 * _BloomFactor;
    //ENDIF
    }
    u_xlat16_1.y = 0.0;
    SV_Target0 = u_xlat16_1.yyyx;
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}