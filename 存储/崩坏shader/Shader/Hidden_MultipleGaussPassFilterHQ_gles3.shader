//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterHQ" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 37791
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.00592100015, -0.00592100015, -0.00231799996, -0.00231799996) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.297576994, 0.297576994, 0.297576994, 0.297576994);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00495600002, 0.00495600002, 0.00495600002, 0.00495600002) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.000742000004, 0.000742000004, 0.00406099996, 0.00406099996) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.636880994, 0.636880994, 0.636880994, 0.636880994) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0604300015, 0.0604300015, 0.0604300015, 0.0604300015) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.00781300012, 0.00781300012) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000155000002, 0.000155000002, 0.000155000002, 0.000155000002) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.00592100015, -0.00592100015, -0.00231799996, -0.00231799996) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.297576994, 0.297576994, 0.297576994, 0.297576994);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00495600002, 0.00495600002, 0.00495600002, 0.00495600002) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.000742000004, 0.000742000004, 0.00406099996, 0.00406099996) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.636880994, 0.636880994, 0.636880994, 0.636880994) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0604300015, 0.0604300015, 0.0604300015, 0.0604300015) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.00781300012, 0.00781300012) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000155000002, 0.000155000002, 0.000155000002, 0.000155000002) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.00592100015, -0.00592100015, -0.00231799996, -0.00231799996) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.297576994, 0.297576994, 0.297576994, 0.297576994);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00495600002, 0.00495600002, 0.00495600002, 0.00495600002) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.000742000004, 0.000742000004, 0.00406099996, 0.00406099996) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.636880994, 0.636880994, 0.636880994, 0.636880994) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0604300015, 0.0604300015, 0.0604300015, 0.0604300015) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.00781300012, 0.00781300012) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000155000002, 0.000155000002, 0.000155000002, 0.000155000002) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
}
}
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 72202
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0238710009, -0.0238710009, -0.0163729992, -0.0163729992) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0215799995, 0.0215799995, 0.0215799995, 0.0215799995);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00079999998, 0.00079999998, 0.00079999998, 0.00079999998) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0090239998, -0.0090239998, -0.00179699995, -0.00179699995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.172469005, 0.172469005, 0.172469005, 0.172469005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.417991012, 0.417991012, 0.417991012, 0.417991012) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0053989999, 0.0053989999, 0.0126799997, 0.0126799997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.311311007, 0.311311007, 0.311311007, 0.311311007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.070915997, 0.070915997, 0.070915997, 0.070915997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0201050006, 0.0201050006, 0.0273439996, 0.0273439996) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00484499987, 0.00484499987, 0.00484499987, 0.00484499987) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(8.9000001e-05, 8.9000001e-05, 8.9000001e-05, 8.9000001e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0238710009, -0.0238710009, -0.0163729992, -0.0163729992) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0215799995, 0.0215799995, 0.0215799995, 0.0215799995);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00079999998, 0.00079999998, 0.00079999998, 0.00079999998) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0090239998, -0.0090239998, -0.00179699995, -0.00179699995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.172469005, 0.172469005, 0.172469005, 0.172469005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.417991012, 0.417991012, 0.417991012, 0.417991012) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0053989999, 0.0053989999, 0.0126799997, 0.0126799997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.311311007, 0.311311007, 0.311311007, 0.311311007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.070915997, 0.070915997, 0.070915997, 0.070915997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0201050006, 0.0201050006, 0.0273439996, 0.0273439996) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00484499987, 0.00484499987, 0.00484499987, 0.00484499987) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(8.9000001e-05, 8.9000001e-05, 8.9000001e-05, 8.9000001e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0238710009, -0.0238710009, -0.0163729992, -0.0163729992) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0215799995, 0.0215799995, 0.0215799995, 0.0215799995);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00079999998, 0.00079999998, 0.00079999998, 0.00079999998) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0090239998, -0.0090239998, -0.00179699995, -0.00179699995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.172469005, 0.172469005, 0.172469005, 0.172469005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.417991012, 0.417991012, 0.417991012, 0.417991012) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0053989999, 0.0053989999, 0.0126799997, 0.0126799997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.311311007, 0.311311007, 0.311311007, 0.311311007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.070915997, 0.070915997, 0.070915997, 0.070915997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0201050006, 0.0201050006, 0.0273439996, 0.0273439996) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00484499987, 0.00484499987, 0.00484499987, 0.00484499987) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(8.9000001e-05, 8.9000001e-05, 8.9000001e-05, 8.9000001e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
}
}
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 177243
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0874369964, -0.0874369964, -0.0721379966, -0.0721379966) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00116500002, 0.00116500002, 0.00116500002, 0.00116500002);
    u_xlat16_0 = u_xlat10_0 * vec4(9.10000017e-05, 9.10000017e-05, 9.10000017e-05, 9.10000017e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0568859987, -0.0568859987, -0.0416759998, -0.0416759998) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00918000005, 0.00918000005, 0.00918000005, 0.00918000005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0444319993, 0.0444319993, 0.0444319993, 0.0444319993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0265030004, -0.0265030004, -0.0113540003, -0.0113540003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.132256001, 0.132256001, 0.132256001, 0.132256001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.242351994, 0.242351994, 0.242351994, 0.242351994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.00378399994, 0.00378399994, 0.0189260002, 0.0189260002) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.273552001, 0.273552001, 0.273552001, 0.273552001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.190216005, 0.190216005, 0.190216005, 0.190216005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0340860002, 0.0340860002, 0.0492760018, 0.0492760018) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0814540014, 0.0814540014, 0.0814540014, 0.0814540014) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0214629993, 0.0214629993, 0.0214629993, 0.0214629993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0645070001, 0.0645070001, 0.0797820017, 0.0797820017) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00347599993, 0.00347599993, 0.00347599993, 0.00347599993) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000345999986, 0.000345999986, 0.000345999986, 0.000345999986) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.09375, 0.09375) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.70000003e-05, 1.70000003e-05, 1.70000003e-05, 1.70000003e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0874369964, -0.0874369964, -0.0721379966, -0.0721379966) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00116500002, 0.00116500002, 0.00116500002, 0.00116500002);
    u_xlat16_0 = u_xlat10_0 * vec4(9.10000017e-05, 9.10000017e-05, 9.10000017e-05, 9.10000017e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0568859987, -0.0568859987, -0.0416759998, -0.0416759998) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00918000005, 0.00918000005, 0.00918000005, 0.00918000005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0444319993, 0.0444319993, 0.0444319993, 0.0444319993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0265030004, -0.0265030004, -0.0113540003, -0.0113540003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.132256001, 0.132256001, 0.132256001, 0.132256001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.242351994, 0.242351994, 0.242351994, 0.242351994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.00378399994, 0.00378399994, 0.0189260002, 0.0189260002) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.273552001, 0.273552001, 0.273552001, 0.273552001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.190216005, 0.190216005, 0.190216005, 0.190216005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0340860002, 0.0340860002, 0.0492760018, 0.0492760018) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0814540014, 0.0814540014, 0.0814540014, 0.0814540014) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0214629993, 0.0214629993, 0.0214629993, 0.0214629993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0645070001, 0.0645070001, 0.0797820017, 0.0797820017) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00347599993, 0.00347599993, 0.00347599993, 0.00347599993) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000345999986, 0.000345999986, 0.000345999986, 0.000345999986) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.09375, 0.09375) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.70000003e-05, 1.70000003e-05, 1.70000003e-05, 1.70000003e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0874369964, -0.0874369964, -0.0721379966, -0.0721379966) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00116500002, 0.00116500002, 0.00116500002, 0.00116500002);
    u_xlat16_0 = u_xlat10_0 * vec4(9.10000017e-05, 9.10000017e-05, 9.10000017e-05, 9.10000017e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0568859987, -0.0568859987, -0.0416759998, -0.0416759998) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00918000005, 0.00918000005, 0.00918000005, 0.00918000005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0444319993, 0.0444319993, 0.0444319993, 0.0444319993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0265030004, -0.0265030004, -0.0113540003, -0.0113540003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.132256001, 0.132256001, 0.132256001, 0.132256001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.242351994, 0.242351994, 0.242351994, 0.242351994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.00378399994, 0.00378399994, 0.0189260002, 0.0189260002) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.273552001, 0.273552001, 0.273552001, 0.273552001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.190216005, 0.190216005, 0.190216005, 0.190216005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0340860002, 0.0340860002, 0.0492760018, 0.0492760018) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0814540014, 0.0814540014, 0.0814540014, 0.0814540014) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0214629993, 0.0214629993, 0.0214629993, 0.0214629993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0645070001, 0.0645070001, 0.0797820017, 0.0797820017) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00347599993, 0.00347599993, 0.00347599993, 0.00347599993) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000345999986, 0.000345999986, 0.000345999986, 0.000345999986) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.09375, 0.09375) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.70000003e-05, 1.70000003e-05, 1.70000003e-05, 1.70000003e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
}
}
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 214037
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.285986006, -0.285986006, -0.255037993, -0.255037993) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002);
    u_xlat16_0 = u_xlat10_0 * vec4(8.2999999e-05, 8.2999999e-05, 8.2999999e-05, 8.2999999e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.224099994, -0.224099994, -0.193170995, -0.193170995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00156400003, 0.00156400003, 0.00156400003, 0.00156400003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0052029998, 0.0052029998, 0.0052029998, 0.0052029998) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.162249997, -0.162249997, -0.131336004, -0.131336004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0144809997, 0.0144809997, 0.0144809997, 0.0144809997) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0337300003, 0.0337300003, 0.0337300003, 0.0337300003) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.100428, -0.100428, -0.0695239976, -0.0695239976) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0657500029, 0.0657500029, 0.0657500029, 0.0657500029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.107267, 0.107267, 0.107267, 0.107267) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0386239998, -0.0386239998, -0.00772499992, -0.00772499992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.146464005, 0.146464005, 0.146464005, 0.146464005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.167380005, 0.167380005, 0.167380005, 0.167380005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0231740009, 0.0231740009, 0.0540740006, 0.0540740006) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.160096005, 0.160096005, 0.160096005, 0.160096005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.128162995, 0.128162995, 0.128162995, 0.128162995) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0849760026, 0.0849760026, 0.115882002, 0.115882002) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0858699977, 0.0858699977, 0.0858699977, 0.0858699977) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0481519997, 0.0481519997, 0.0481519997, 0.0481519997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.146792993, 0.146792993, 0.177709997, 0.177709997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0225980002, 0.0225980002, 0.0225980002, 0.0225980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0088759996, 0.0088759996, 0.0088759996, 0.0088759996) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.208635002, 0.208635002, 0.239567995, 0.239567995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00291700009, 0.00291700009, 0.00291700009, 0.00291700009) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000801999995, 0.000801999995, 0.000801999995, 0.000801999995) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.270511001, 0.270511001, 0.296875, 0.296875) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.000184999997, 0.000184999997, 0.000184999997, 0.000184999997) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(2.49999994e-05, 2.49999994e-05, 2.49999994e-05, 2.49999994e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.285986006, -0.285986006, -0.255037993, -0.255037993) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002);
    u_xlat16_0 = u_xlat10_0 * vec4(8.2999999e-05, 8.2999999e-05, 8.2999999e-05, 8.2999999e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.224099994, -0.224099994, -0.193170995, -0.193170995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00156400003, 0.00156400003, 0.00156400003, 0.00156400003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0052029998, 0.0052029998, 0.0052029998, 0.0052029998) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.162249997, -0.162249997, -0.131336004, -0.131336004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0144809997, 0.0144809997, 0.0144809997, 0.0144809997) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0337300003, 0.0337300003, 0.0337300003, 0.0337300003) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.100428, -0.100428, -0.0695239976, -0.0695239976) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0657500029, 0.0657500029, 0.0657500029, 0.0657500029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.107267, 0.107267, 0.107267, 0.107267) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0386239998, -0.0386239998, -0.00772499992, -0.00772499992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.146464005, 0.146464005, 0.146464005, 0.146464005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.167380005, 0.167380005, 0.167380005, 0.167380005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0231740009, 0.0231740009, 0.0540740006, 0.0540740006) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.160096005, 0.160096005, 0.160096005, 0.160096005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.128162995, 0.128162995, 0.128162995, 0.128162995) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0849760026, 0.0849760026, 0.115882002, 0.115882002) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0858699977, 0.0858699977, 0.0858699977, 0.0858699977) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0481519997, 0.0481519997, 0.0481519997, 0.0481519997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.146792993, 0.146792993, 0.177709997, 0.177709997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0225980002, 0.0225980002, 0.0225980002, 0.0225980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0088759996, 0.0088759996, 0.0088759996, 0.0088759996) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.208635002, 0.208635002, 0.239567995, 0.239567995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00291700009, 0.00291700009, 0.00291700009, 0.00291700009) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000801999995, 0.000801999995, 0.000801999995, 0.000801999995) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.270511001, 0.270511001, 0.296875, 0.296875) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.000184999997, 0.000184999997, 0.000184999997, 0.000184999997) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(2.49999994e-05, 2.49999994e-05, 2.49999994e-05, 2.49999994e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.285986006, -0.285986006, -0.255037993, -0.255037993) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002);
    u_xlat16_0 = u_xlat10_0 * vec4(8.2999999e-05, 8.2999999e-05, 8.2999999e-05, 8.2999999e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.224099994, -0.224099994, -0.193170995, -0.193170995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00156400003, 0.00156400003, 0.00156400003, 0.00156400003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0052029998, 0.0052029998, 0.0052029998, 0.0052029998) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.162249997, -0.162249997, -0.131336004, -0.131336004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0144809997, 0.0144809997, 0.0144809997, 0.0144809997) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0337300003, 0.0337300003, 0.0337300003, 0.0337300003) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.100428, -0.100428, -0.0695239976, -0.0695239976) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0657500029, 0.0657500029, 0.0657500029, 0.0657500029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.107267, 0.107267, 0.107267, 0.107267) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0386239998, -0.0386239998, -0.00772499992, -0.00772499992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.146464005, 0.146464005, 0.146464005, 0.146464005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.167380005, 0.167380005, 0.167380005, 0.167380005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0231740009, 0.0231740009, 0.0540740006, 0.0540740006) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.160096005, 0.160096005, 0.160096005, 0.160096005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.128162995, 0.128162995, 0.128162995, 0.128162995) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0849760026, 0.0849760026, 0.115882002, 0.115882002) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0858699977, 0.0858699977, 0.0858699977, 0.0858699977) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0481519997, 0.0481519997, 0.0481519997, 0.0481519997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.146792993, 0.146792993, 0.177709997, 0.177709997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0225980002, 0.0225980002, 0.0225980002, 0.0225980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0088759996, 0.0088759996, 0.0088759996, 0.0088759996) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.208635002, 0.208635002, 0.239567995, 0.239567995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00291700009, 0.00291700009, 0.00291700009, 0.00291700009) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000801999995, 0.000801999995, 0.000801999995, 0.000801999995) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.270511001, 0.270511001, 0.296875, 0.296875) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.000184999997, 0.000184999997, 0.000184999997, 0.000184999997) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(2.49999994e-05, 2.49999994e-05, 2.49999994e-05, 2.49999994e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
}
}
}
}