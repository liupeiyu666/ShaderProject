//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterMQCompact" {
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
  GpuProgramID 43865
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0119120004, -0.0119120004, -0.00476399995, -0.00476399995);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.308025986, 0.308025986, 0.308025986, 0.308025986);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00860899966, 0.00860899966, 0.00860899966, 0.00860899966) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(0.00154700002, 0.00154700002, 0.00823399983, 0.00823399983);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.607088029, 0.607088029, 0.607088029, 0.607088029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0758519992, 0.0758519992, 0.0758519992, 0.0758519992) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.015625, 0.015625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000425000006, 0.000425000006, 0.000425000006, 0.000425000006) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0119120004, -0.0119120004, -0.00476399995, -0.00476399995);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.308025986, 0.308025986, 0.308025986, 0.308025986);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00860899966, 0.00860899966, 0.00860899966, 0.00860899966) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(0.00154700002, 0.00154700002, 0.00823399983, 0.00823399983);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.607088029, 0.607088029, 0.607088029, 0.607088029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0758519992, 0.0758519992, 0.0758519992, 0.0758519992) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.015625, 0.015625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000425000006, 0.000425000006, 0.000425000006, 0.000425000006) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0119120004, -0.0119120004, -0.00476399995, -0.00476399995);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.308025986, 0.308025986, 0.308025986, 0.308025986);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00860899966, 0.00860899966, 0.00860899966, 0.00860899966) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(0.00154700002, 0.00154700002, 0.00823399983, 0.00823399983);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.607088029, 0.607088029, 0.607088029, 0.607088029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0758519992, 0.0758519992, 0.0758519992, 0.0758519992) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.015625, 0.015625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000425000006, 0.000425000006, 0.000425000006, 0.000425000006) + u_xlat16_0;
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
  GpuProgramID 66906
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
vec2 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0475560017, -0.0475560017, -0.0325350016, -0.0325350016);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0159489997, 0.0159489997, 0.0159489997, 0.0159489997);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0178779997, -0.0178779997, -0.00355400005, -0.00355400005);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.163608998, 0.163608998, 0.163608998, 0.163608998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.439938992, 0.439938992, 0.439938992, 0.439938992) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0106859999, 0.0106859999, 0.0251579992, 0.0251579992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.316579998, 0.316579998, 0.316579998, 0.316579998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0605119988, 0.0605119988, 0.0605119988, 0.0605119988) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0400049984, 0.0400049984, 0.0546879992, 0.0546879992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.00298199989, 0.00298199989, 0.00298199989, 0.00298199989) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(3.40000006e-05, 3.40000006e-05, 3.40000006e-05, 3.40000006e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
vec2 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0475560017, -0.0475560017, -0.0325350016, -0.0325350016);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0159489997, 0.0159489997, 0.0159489997, 0.0159489997);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0178779997, -0.0178779997, -0.00355400005, -0.00355400005);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.163608998, 0.163608998, 0.163608998, 0.163608998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.439938992, 0.439938992, 0.439938992, 0.439938992) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0106859999, 0.0106859999, 0.0251579992, 0.0251579992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.316579998, 0.316579998, 0.316579998, 0.316579998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0605119988, 0.0605119988, 0.0605119988, 0.0605119988) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0400049984, 0.0400049984, 0.0546879992, 0.0546879992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.00298199989, 0.00298199989, 0.00298199989, 0.00298199989) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(3.40000006e-05, 3.40000006e-05, 3.40000006e-05, 3.40000006e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
vec2 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0475560017, -0.0475560017, -0.0325350016, -0.0325350016);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0159489997, 0.0159489997, 0.0159489997, 0.0159489997);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0178779997, -0.0178779997, -0.00355400005, -0.00355400005);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.163608998, 0.163608998, 0.163608998, 0.163608998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.439938992, 0.439938992, 0.439938992, 0.439938992) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0106859999, 0.0106859999, 0.0251579992, 0.0251579992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.316579998, 0.316579998, 0.316579998, 0.316579998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0605119988, 0.0605119988, 0.0605119988, 0.0605119988) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0400049984, 0.0400049984, 0.0546879992, 0.0546879992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.00298199989, 0.00298199989, 0.00298199989, 0.00298199989) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(3.40000006e-05, 3.40000006e-05, 3.40000006e-05, 3.40000006e-05) + u_xlat16_0;
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
  GpuProgramID 175321
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.143375993, -0.143375993, -0.112940997, -0.112940997);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.00389300007, 0.00389300007, 0.00389300007, 0.00389300007);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000270999997, 0.000270999997, 0.000270999997, 0.000270999997) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0826620013, -0.0826620013, -0.0525240004, -0.0525240004);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0297420006, 0.0297420006, 0.0297420006, 0.0297420006) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.121250004, 0.121250004, 0.121250004, 0.121250004) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0224900004, -0.0224900004, 0.00749500003, 0.00749500003);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.264445007, 0.264445007, 0.264445007, 0.264445007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.309049994, 0.309049994, 0.309049994, 0.309049994) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.037498001, 0.037498001, 0.0675780028, 0.0675780028);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.193601996, 0.193601996, 0.193601996, 0.193601996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0649449974, 0.0649449974, 0.0649449974, 0.0649449974) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0977829993, 0.0977829993, 0.128139004, 0.128139004);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0116410004, 0.0116410004, 0.0116410004, 0.0116410004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00111199997, 0.00111199997, 0.00111199997, 0.00111199997) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.15625, 0.15625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(4.80000017e-05, 4.80000017e-05, 4.80000017e-05, 4.80000017e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.143375993, -0.143375993, -0.112940997, -0.112940997);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.00389300007, 0.00389300007, 0.00389300007, 0.00389300007);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000270999997, 0.000270999997, 0.000270999997, 0.000270999997) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0826620013, -0.0826620013, -0.0525240004, -0.0525240004);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0297420006, 0.0297420006, 0.0297420006, 0.0297420006) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.121250004, 0.121250004, 0.121250004, 0.121250004) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0224900004, -0.0224900004, 0.00749500003, 0.00749500003);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.264445007, 0.264445007, 0.264445007, 0.264445007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.309049994, 0.309049994, 0.309049994, 0.309049994) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.037498001, 0.037498001, 0.0675780028, 0.0675780028);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.193601996, 0.193601996, 0.193601996, 0.193601996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0649449974, 0.0649449974, 0.0649449974, 0.0649449974) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0977829993, 0.0977829993, 0.128139004, 0.128139004);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0116410004, 0.0116410004, 0.0116410004, 0.0116410004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00111199997, 0.00111199997, 0.00111199997, 0.00111199997) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.15625, 0.15625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(4.80000017e-05, 4.80000017e-05, 4.80000017e-05, 4.80000017e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.143375993, -0.143375993, -0.112940997, -0.112940997);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.00389300007, 0.00389300007, 0.00389300007, 0.00389300007);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000270999997, 0.000270999997, 0.000270999997, 0.000270999997) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0826620013, -0.0826620013, -0.0525240004, -0.0525240004);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0297420006, 0.0297420006, 0.0297420006, 0.0297420006) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.121250004, 0.121250004, 0.121250004, 0.121250004) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0224900004, -0.0224900004, 0.00749500003, 0.00749500003);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.264445007, 0.264445007, 0.264445007, 0.264445007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.309049994, 0.309049994, 0.309049994, 0.309049994) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.037498001, 0.037498001, 0.0675780028, 0.0675780028);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.193601996, 0.193601996, 0.193601996, 0.193601996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0649449974, 0.0649449974, 0.0649449974, 0.0649449974) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0977829993, 0.0977829993, 0.128139004, 0.128139004);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0116410004, 0.0116410004, 0.0116410004, 0.0116410004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00111199997, 0.00111199997, 0.00111199997, 0.00111199997) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.15625, 0.15625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(4.80000017e-05, 4.80000017e-05, 4.80000017e-05, 4.80000017e-05) + u_xlat16_0;
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
  GpuProgramID 225964
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.539946973, -0.539946973, -0.478147, -0.478147);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.000291000004, 0.000291000004, 0.000291000004, 0.000291000004);
    u_xlat16_0 = u_xlat10_0 * vec4(4.89999984e-05, 4.89999984e-05, 4.89999984e-05, 4.89999984e-05) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.416377991, -0.416377991, -0.354636997, -0.354636997);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00138300005, 0.00138300005, 0.00138300005, 0.00138300005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00529999984, 0.00529999984, 0.00529999984, 0.00529999984) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.29292199, -0.29292199, -0.231227994, -0.231227994);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0163780004, 0.0163780004, 0.0163780004, 0.0163780004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0408219993, 0.0408219993, 0.0408219993, 0.0408219993) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.169552997, -0.169552997, -0.107891001, -0.107891001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0820680037, 0.0820680037, 0.0820680037, 0.0820680037) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.133082002, 0.133082002, 0.133082002, 0.133082002) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0462369993, -0.0462369993, 0.015412, 0.015412);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.174079999, 0.174079999, 0.174079999, 0.174079999) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.183685005, 0.183685005, 0.183685005, 0.183685005) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0770630017, 0.0770630017, 0.138720006, 0.138720006);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.156350002, 0.156350002, 0.156350002, 0.156350002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.107352003, 0.107352003, 0.107352003, 0.107352003) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.200387999, 0.200387999, 0.262071997, 0.262071997);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0594570003, 0.0594570003, 0.0594570003, 0.0594570003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0265619997, 0.0265619997, 0.0265619997, 0.0265619997) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.323776007, 0.323776007, 0.385504007, 0.385504007);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.009571, 0.009571, 0.009571, 0.009571) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00278099999, 0.00278099999, 0.00278099999, 0.00278099999) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.447257996, 0.447257996, 0.509042978, 0.509042978);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.000652000017, 0.000652000017, 0.000652000017, 0.000652000017) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.000123000005, 0.000123000005, 0.000123000005, 0.000123000005) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.5625, 0.5625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.40000002e-05, 1.40000002e-05, 1.40000002e-05, 1.40000002e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.539946973, -0.539946973, -0.478147, -0.478147);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.000291000004, 0.000291000004, 0.000291000004, 0.000291000004);
    u_xlat16_0 = u_xlat10_0 * vec4(4.89999984e-05, 4.89999984e-05, 4.89999984e-05, 4.89999984e-05) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.416377991, -0.416377991, -0.354636997, -0.354636997);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00138300005, 0.00138300005, 0.00138300005, 0.00138300005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00529999984, 0.00529999984, 0.00529999984, 0.00529999984) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.29292199, -0.29292199, -0.231227994, -0.231227994);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0163780004, 0.0163780004, 0.0163780004, 0.0163780004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0408219993, 0.0408219993, 0.0408219993, 0.0408219993) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.169552997, -0.169552997, -0.107891001, -0.107891001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0820680037, 0.0820680037, 0.0820680037, 0.0820680037) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.133082002, 0.133082002, 0.133082002, 0.133082002) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0462369993, -0.0462369993, 0.015412, 0.015412);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.174079999, 0.174079999, 0.174079999, 0.174079999) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.183685005, 0.183685005, 0.183685005, 0.183685005) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0770630017, 0.0770630017, 0.138720006, 0.138720006);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.156350002, 0.156350002, 0.156350002, 0.156350002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.107352003, 0.107352003, 0.107352003, 0.107352003) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.200387999, 0.200387999, 0.262071997, 0.262071997);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0594570003, 0.0594570003, 0.0594570003, 0.0594570003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0265619997, 0.0265619997, 0.0265619997, 0.0265619997) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.323776007, 0.323776007, 0.385504007, 0.385504007);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.009571, 0.009571, 0.009571, 0.009571) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00278099999, 0.00278099999, 0.00278099999, 0.00278099999) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.447257996, 0.447257996, 0.509042978, 0.509042978);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.000652000017, 0.000652000017, 0.000652000017, 0.000652000017) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.000123000005, 0.000123000005, 0.000123000005, 0.000123000005) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.5625, 0.5625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.40000002e-05, 1.40000002e-05, 1.40000002e-05, 1.40000002e-05) + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _CompactBloomSRCMapping;
uniform 	vec4 _CompactBloomTARMapping;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat1.z = u_xlat0.y * _CompactBloomTARMapping.z;
    u_xlat1.x = u_xlat0.x * _CompactBloomTARMapping.y + _CompactBloomTARMapping.x;
    vs_TEXCOORD0.xy = vec2(u_xlat0.x * _CompactBloomSRCMapping.y, u_xlat0.y * _CompactBloomSRCMapping.z);
    gl_Position.xy = u_xlat1.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform 	vec4 _CompactBloomSRCMapping;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
lowp vec4 u_xlat10_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.539946973, -0.539946973, -0.478147, -0.478147);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.000291000004, 0.000291000004, 0.000291000004, 0.000291000004);
    u_xlat16_0 = u_xlat10_0 * vec4(4.89999984e-05, 4.89999984e-05, 4.89999984e-05, 4.89999984e-05) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.416377991, -0.416377991, -0.354636997, -0.354636997);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00138300005, 0.00138300005, 0.00138300005, 0.00138300005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00529999984, 0.00529999984, 0.00529999984, 0.00529999984) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.29292199, -0.29292199, -0.231227994, -0.231227994);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0163780004, 0.0163780004, 0.0163780004, 0.0163780004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0408219993, 0.0408219993, 0.0408219993, 0.0408219993) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.169552997, -0.169552997, -0.107891001, -0.107891001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0820680037, 0.0820680037, 0.0820680037, 0.0820680037) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.133082002, 0.133082002, 0.133082002, 0.133082002) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0462369993, -0.0462369993, 0.015412, 0.015412);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.174079999, 0.174079999, 0.174079999, 0.174079999) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.183685005, 0.183685005, 0.183685005, 0.183685005) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0770630017, 0.0770630017, 0.138720006, 0.138720006);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.156350002, 0.156350002, 0.156350002, 0.156350002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.107352003, 0.107352003, 0.107352003, 0.107352003) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.200387999, 0.200387999, 0.262071997, 0.262071997);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat6.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0594570003, 0.0594570003, 0.0594570003, 0.0594570003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0265619997, 0.0265619997, 0.0265619997, 0.0265619997) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.323776007, 0.323776007, 0.385504007, 0.385504007);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.009571, 0.009571, 0.009571, 0.009571) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00278099999, 0.00278099999, 0.00278099999, 0.00278099999) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.447257996, 0.447257996, 0.509042978, 0.509042978);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.000652000017, 0.000652000017, 0.000652000017, 0.000652000017) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.000123000005, 0.000123000005, 0.000123000005, 0.000123000005) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.5625, 0.5625);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.40000002e-05, 1.40000002e-05, 1.40000002e-05, 1.40000002e-05) + u_xlat16_0;
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