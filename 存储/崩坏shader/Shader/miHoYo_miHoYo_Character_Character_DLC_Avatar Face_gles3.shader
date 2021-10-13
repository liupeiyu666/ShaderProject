//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_DLC/Avatar Face" {
Properties {
[MHYHelpBox(Info, Vertex Color B (outline width))] [MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnits ("Polygon Offset Units", Float) = 0
_OutlinePolygonOffsetFactor ("Outline Polygon Offset Factor", Float) = 0
_OutlinePolygonOffsetUnits ("Outline Polygon Offset Units", Float) = 0
[MHYHeaderBox(MAPS)] [MHYHeader(Main Maps)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
[MHYSingleLineTextureNoScaleOffset] _LightMap ("Light Map |R (sepcular intensity) G (diffuse threshold) B (specular threshold)", 2D) = "grey" { }
[MHYSingleLineTextureNoScaleOffset] _FaceMap ("Face Map |A (distance field)", 2D) = "white" { }
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Float) = 1
[MHYHeaderBox(DIFFUSE)] [Toggle(_FACEMAP_ON)] _EnableFaceMap ("Enable Face Map", Float) = 1
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowThreshold ("Shadow Threshold", Range(0, 1)) = 0.5
_ShadowFeather ("Shadow Feather", Range(0.0001, 0.05)) = 0.0001
[MHYHeaderBox(OUTLINE)] _OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.1
[KeywordEnum(Normal, Tangent, UV2)] _OutlineNormalFrom ("Outline Normal From", Float) = 0
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
[MHYHeaderBox(DITHER)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 600
 Tags { "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  LOD 600
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 57777
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
bvec2 u_xlatb6;
lowp float u_xlat10_9;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_2.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_5.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999899983);
    u_xlat16_5.x = (-u_xlat16_2.x) + u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_1 + (-u_xlat16_2.x);
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_9 * u_xlat16_2.x;
    u_xlat16_5.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
bvec2 u_xlatb6;
lowp float u_xlat10_9;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_2.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_5.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999899983);
    u_xlat16_5.x = (-u_xlat16_2.x) + u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_1 + (-u_xlat16_2.x);
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_9 * u_xlat16_2.x;
    u_xlat16_5.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
bvec2 u_xlatb6;
lowp float u_xlat10_9;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_2.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_5.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999899983);
    u_xlat16_5.x = (-u_xlat16_2.x) + u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_1 + (-u_xlat16_2.x);
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_9 * u_xlat16_2.x;
    u_xlat16_5.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
mediump float u_xlat16_14;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_14 = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_14 = max(u_xlat16_14, 9.99999975e-05);
    u_xlat16_3.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999899983);
    u_xlat16_3.x = (-u_xlat16_14) + u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_1 + (-u_xlat16_14);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_14 * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_12 * u_xlat16_14;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
mediump float u_xlat16_14;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_14 = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_14 = max(u_xlat16_14, 9.99999975e-05);
    u_xlat16_3.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999899983);
    u_xlat16_3.x = (-u_xlat16_14) + u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_1 + (-u_xlat16_14);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_14 * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_12 * u_xlat16_14;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
mediump float u_xlat16_14;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_14 = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_14 = max(u_xlat16_14, 9.99999975e-05);
    u_xlat16_3.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999899983);
    u_xlat16_3.x = (-u_xlat16_14) + u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_1 + (-u_xlat16_14);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_14 * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_12 * u_xlat16_14;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb6.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb6.x){
        u_xlat10_6 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_6;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb6.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb6.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_9;
    u_xlat16_4.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_4.x) + u_xlat16_7;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat10_2;
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_4.x = u_xlat16_7 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb6.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb6.x){
        u_xlat10_6 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_6;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb6.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb6.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_9;
    u_xlat16_4.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_4.x) + u_xlat16_7;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat10_2;
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_4.x = u_xlat16_7 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb6.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb6.x){
        u_xlat10_6 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_6;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb6.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb6.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_9;
    u_xlat16_4.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_4.x) + u_xlat16_7;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat10_2;
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_4.x = u_xlat16_7 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1 = u_xlat10_8;
    } else {
        u_xlat16_1 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb8.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb8.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_5.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_12;
    u_xlat16_3.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_3.x) + u_xlat16_7;
    u_xlat16_3.x = u_xlat10_2 + (-u_xlat16_3.x);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3.x = u_xlat16_7 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1 = u_xlat10_8;
    } else {
        u_xlat16_1 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb8.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb8.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_5.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_12;
    u_xlat16_3.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_3.x) + u_xlat16_7;
    u_xlat16_3.x = u_xlat10_2 + (-u_xlat16_3.x);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3.x = u_xlat16_7 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1 = u_xlat10_8;
    } else {
        u_xlat16_1 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb8.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb8.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_5.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_12;
    u_xlat16_3.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_3.x) + u_xlat16_7;
    u_xlat16_3.x = u_xlat10_2 + (-u_xlat16_3.x);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3.x = u_xlat16_7 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
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
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Character/Shared/OPAQUEOUTLINE"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "PerformanceChecks" = "False" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 108166
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb8;
mediump float u_xlat16_11;
float u_xlat12;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_7.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_7.x = max(u_xlat16_7.x, 9.99999975e-05);
    u_xlat16_11 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_3.z = min(u_xlat16_11, 0.999899983);
    u_xlat16_3.xz = (-u_xlat16_7.xx) + u_xlat16_3.xz;
    u_xlat16_7.x = float(1.0) / u_xlat16_3.z;
    u_xlat16_3.x = u_xlat16_7.x * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7.x;
    u_xlat16_7.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowThreshold;
uniform 	mediump float _ShadowFeather;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_17;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat15 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD4.xyz;
    u_xlat3.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat3.xyz = _CustomLightDir.www * u_xlat3.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_17 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 * 0.5 + 0.5;
    u_xlat16_4.x = _ShadowThreshold + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_9 = _ShadowThreshold + _ShadowFeather;
    u_xlat16_9 = min(u_xlat16_9, 0.999899983);
    u_xlat16_9 = (-u_xlat16_4.x) + u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 + (-u_xlat16_4.x);
    u_xlat16_4.x = float(1.0) / u_xlat16_9;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_17 * -2.0 + 3.0;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_17 = u_xlat16_17 * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_17) * u_xlat16_4.xyz + _ShadowColor.xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
bvec2 u_xlatb6;
lowp float u_xlat10_9;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_2.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_5.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999899983);
    u_xlat16_5.x = (-u_xlat16_2.x) + u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_1 + (-u_xlat16_2.x);
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_9 * u_xlat16_2.x;
    u_xlat16_5.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
bvec2 u_xlatb6;
lowp float u_xlat10_9;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_2.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_5.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999899983);
    u_xlat16_5.x = (-u_xlat16_2.x) + u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_1 + (-u_xlat16_2.x);
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_9 * u_xlat16_2.x;
    u_xlat16_5.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_5;
bvec2 u_xlatb6;
lowp float u_xlat10_9;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_2.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_5.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999899983);
    u_xlat16_5.x = (-u_xlat16_2.x) + u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_1 + (-u_xlat16_2.x);
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat16_2.x = u_xlat10_9 * u_xlat16_2.x;
    u_xlat16_5.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
mediump float u_xlat16_14;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_14 = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_14 = max(u_xlat16_14, 9.99999975e-05);
    u_xlat16_3.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999899983);
    u_xlat16_3.x = (-u_xlat16_14) + u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_1 + (-u_xlat16_14);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_14 * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_12 * u_xlat16_14;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
mediump float u_xlat16_14;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_14 = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_14 = max(u_xlat16_14, 9.99999975e-05);
    u_xlat16_3.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999899983);
    u_xlat16_3.x = (-u_xlat16_14) + u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_1 + (-u_xlat16_14);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_14 * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_12 * u_xlat16_14;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
mediump float u_xlat16_14;
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
        u_xlatb0 = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb0 = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_2.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_14 = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_14 = max(u_xlat16_14, 9.99999975e-05);
    u_xlat16_3.x = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_3.x = min(u_xlat16_3.x, 0.999899983);
    u_xlat16_3.x = (-u_xlat16_14) + u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_1 + (-u_xlat16_14);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_14 * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_3.x;
    u_xlat16_14 = u_xlat10_12 * u_xlat16_14;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_14) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb6.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb6.x){
        u_xlat10_6 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_6;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb6.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb6.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_9;
    u_xlat16_4.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_4.x) + u_xlat16_7;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat10_2;
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_4.x = u_xlat16_7 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb6.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb6.x){
        u_xlat10_6 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_6;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb6.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb6.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_9;
    u_xlat16_4.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_4.x) + u_xlat16_7;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat10_2;
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_4.x = u_xlat16_7 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb0) ? _DitherAlpha : u_xlat0.z;
    vs_TEXCOORD2.w = u_xlat0.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat0.xyz = _CustomLightDir.www * u_xlat0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat1.xy = vec2(u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat0.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat0.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat0.zz + u_xlat1.xy;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=0.899999976);
#else
    u_xlatb0 = u_xlat0.x>=0.899999976;
#endif
    u_xlat2 = dot(vec2(-0.173649997, 0.984809995), u_xlat1.xy);
    u_xlat4.x = dot(vec2(0.984809995, 0.173649997), u_xlat1.xy);
    u_xlat6 = max(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat1.x = min(abs(u_xlat4.x), abs(u_xlat2));
    u_xlat6 = u_xlat6 * u_xlat1.x;
    u_xlat1.x = u_xlat6 * u_xlat6;
    u_xlat3 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat3 = u_xlat1.x * u_xlat3 + 0.180141002;
    u_xlat3 = u_xlat1.x * u_xlat3 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat3 + 0.999866009;
    u_xlat3 = u_xlat6 * u_xlat1.x;
    u_xlat3 = u_xlat3 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat4.x)<abs(u_xlat2));
#else
    u_xlatb5 = abs(u_xlat4.x)<abs(u_xlat2);
#endif
    u_xlat3 = u_xlatb5 ? u_xlat3 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat1.x + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat4.x<(-u_xlat4.x));
#else
    u_xlatb1 = u_xlat4.x<(-u_xlat4.x);
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat6 + u_xlat1.x;
    u_xlat1.x = min(u_xlat4.x, u_xlat2);
    u_xlat2 = max(u_xlat4.x, u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb4 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb4;
    u_xlat2 = (u_xlatb2) ? (-u_xlat6) : u_xlat6;
    u_xlat4.x = u_xlat2 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<(-u_xlat2));
#else
    u_xlatb2 = 0.0<(-u_xlat2);
#endif
    u_xlat4.x = max(abs(u_xlat4.x), 9.99999975e-05);
    u_xlat1.z = min(u_xlat4.x, 0.999899983);
    u_xlat4.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat1.xy = (bool(u_xlatb2)) ? u_xlat4.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : vec3(0.0, 1.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump float u_xlat16_7;
lowp float u_xlat10_9;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb6.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb6.x){
        u_xlat10_6 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1.x = u_xlat10_6;
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb6.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb6.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb6.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_9 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat10_9;
    u_xlat16_4.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_4.x = max(u_xlat16_4.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_4.x) + u_xlat16_7;
    u_xlat16_4.x = (-u_xlat16_4.x) + u_xlat10_2;
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_4.x = u_xlat16_7 * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_4.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1 = u_xlat10_8;
    } else {
        u_xlat16_1 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb8.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb8.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_5.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_12;
    u_xlat16_3.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_3.x) + u_xlat16_7;
    u_xlat16_3.x = u_xlat10_2 + (-u_xlat16_3.x);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3.x = u_xlat16_7 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1 = u_xlat10_8;
    } else {
        u_xlat16_1 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb8.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb8.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_5.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_12;
    u_xlat16_3.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_3.x) + u_xlat16_7;
    u_xlat16_3.x = u_xlat10_2 + (-u_xlat16_3.x);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3.x = u_xlat16_7 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _CustomLightDir;
uniform 	mediump float _UsingDitherAlpha;
uniform 	mediump float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat7;
float u_xlat12;
bool u_xlatb12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    vs_TEXCOORD2.z = (u_xlatb15) ? _DitherAlpha : u_xlat1.z;
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat2.xyz = (-_WorldSpaceLightPos0.xyz) + _CustomLightDir.xyz;
    u_xlat2.xyz = _CustomLightDir.www * u_xlat2.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat3.xy = vec2(u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].y, u_xlat2.y * hlslcc_mtx4x4unity_WorldToObject[1].z);
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[0].yz * u_xlat2.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_WorldToObject[2].yz * u_xlat2.zz + u_xlat3.xy;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=0.899999976);
#else
    u_xlatb15 = u_xlat15>=0.899999976;
#endif
    u_xlat16 = dot(vec2(-0.173649997, 0.984809995), u_xlat3.xy);
    u_xlat2.x = dot(vec2(0.984809995, 0.173649997), u_xlat3.xy);
    u_xlat7 = max(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = float(1.0) / u_xlat7;
    u_xlat12 = min(abs(u_xlat16), abs(u_xlat2.x));
    u_xlat7 = u_xlat7 * u_xlat12;
    u_xlat12 = u_xlat7 * u_xlat7;
    u_xlat17 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat17 = u_xlat12 * u_xlat17 + 0.180141002;
    u_xlat17 = u_xlat12 * u_xlat17 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat17 + 0.999866009;
    u_xlat17 = u_xlat12 * u_xlat7;
    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat2.x)<abs(u_xlat16));
#else
    u_xlatb3 = abs(u_xlat2.x)<abs(u_xlat16);
#endif
    u_xlat17 = u_xlatb3 ? u_xlat17 : float(0.0);
    u_xlat7 = u_xlat7 * u_xlat12 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat2.x<(-u_xlat2.x));
#else
    u_xlatb12 = u_xlat2.x<(-u_xlat2.x);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat7 = u_xlat12 + u_xlat7;
    u_xlat12 = min(u_xlat16, u_xlat2.x);
    u_xlat16 = max(u_xlat16, u_xlat2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb2 = u_xlat12<(-u_xlat12);
#endif
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlat16 = (u_xlatb16) ? (-u_xlat7) : u_xlat7;
    u_xlat2.x = u_xlat16 * -0.318309903;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.0<(-u_xlat16));
#else
    u_xlatb16 = 0.0<(-u_xlat16);
#endif
    u_xlat2.x = max(abs(u_xlat2.x), 9.99999975e-05);
    u_xlat2.z = min(u_xlat2.x, 0.999899983);
    u_xlat3.xy = in_TEXCOORD0.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat2.xy = (bool(u_xlatb16)) ? u_xlat3.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD5.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vec3(0.0, 1.0, 0.0);
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _ReceiveDynamicShadow;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _ShadowFeather;
uniform 	mediump float _UsingDitherAlpha;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LightMap;
uniform lowp sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform lowp sampler2D _FaceMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_7;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
lowp float u_xlat10_12;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8.x = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8.x){
        u_xlat10_8 = texture(_DynamicCharacterShadowVolumeBuffer, u_xlat0.yx).x;
        u_xlat16_1 = u_xlat10_8;
    } else {
        u_xlat16_1 = 1.0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb8.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb8.x = !!(vs_TEXCOORD2.z<0.949999988);
#else
        u_xlatb8.x = vs_TEXCOORD2.z<0.949999988;
#endif
        if(u_xlatb8.x){
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat2.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat2.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat2, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = vs_TEXCOORD2.z * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + 0.99000001;
            u_xlat0.x = floor(u_xlat0.x);
            u_xlat0.x = max(u_xlat0.x, 0.0);
            u_xlati0 = int(u_xlat0.x);
            if((u_xlati0)==0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * _EnvColor.xyz;
    u_xlat10_12 = texture(_LightMap, vs_TEXCOORD0.xy).y;
    u_xlat16_5.xyz = vs_TEXCOORD6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat10_2 = texture(_FaceMap, vs_TEXCOORD5.xy).w;
    u_xlat16_1 = u_xlat16_1 * u_xlat10_12;
    u_xlat16_3.x = vs_TEXCOORD5.z + (-_ShadowFeather);
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_7 = vs_TEXCOORD5.z + _ShadowFeather;
    u_xlat16_7 = min(u_xlat16_7, 0.999899983);
    u_xlat16_7 = (-u_xlat16_3.x) + u_xlat16_7;
    u_xlat16_3.x = u_xlat10_2 + (-u_xlat16_3.x);
    u_xlat16_7 = float(1.0) / u_xlat16_7;
    u_xlat16_3.x = u_xlat16_7 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_7;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_3.xyz = (-_ShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz + _ShadowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomIntensity;
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
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_FACEMAP_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
CustomEditor "MoleMoleEditor.CharacterAvatarFaceShaderGUI"
}