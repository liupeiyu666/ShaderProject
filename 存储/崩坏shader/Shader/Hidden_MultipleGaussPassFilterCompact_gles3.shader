//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterCompact" {
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
  GpuProgramID 17671
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
vec2 u_xlat9;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0159309991, -0.0159309991, -0.00269700005, -0.00269700005);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat0.zw = min(u_xlat9.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.xy = max(u_xlat1.xy, _CompactBloomSRCMapping.xx);
    u_xlat9.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat9.xx, u_xlat1.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.68936801, 0.68936801, 0.68936801, 0.68936801);
    u_xlat16_0 = u_xlat10_0 * vec4(0.0363150015, 0.0363150015, 0.0363150015, 0.0363150015) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0088109998, 0.0088109998, 0.0234379992, 0.0234379992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.xy = max(u_xlat1.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat9.xx, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.272895008, 0.272895008, 0.272895008, 0.272895008) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.001422, 0.001422, 0.001422, 0.001422) + u_xlat16_0;
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
vec2 u_xlat9;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0159309991, -0.0159309991, -0.00269700005, -0.00269700005);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat0.zw = min(u_xlat9.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.xy = max(u_xlat1.xy, _CompactBloomSRCMapping.xx);
    u_xlat9.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat9.xx, u_xlat1.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.68936801, 0.68936801, 0.68936801, 0.68936801);
    u_xlat16_0 = u_xlat10_0 * vec4(0.0363150015, 0.0363150015, 0.0363150015, 0.0363150015) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0088109998, 0.0088109998, 0.0234379992, 0.0234379992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.xy = max(u_xlat1.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat9.xx, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.272895008, 0.272895008, 0.272895008, 0.272895008) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.001422, 0.001422, 0.001422, 0.001422) + u_xlat16_0;
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
vec2 u_xlat9;
void main()
{
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0159309991, -0.0159309991, -0.00269700005, -0.00269700005);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat0.zw = min(u_xlat9.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.xy = max(u_xlat1.xy, _CompactBloomSRCMapping.xx);
    u_xlat9.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat9.xx, u_xlat1.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.68936801, 0.68936801, 0.68936801, 0.68936801);
    u_xlat16_0 = u_xlat10_0 * vec4(0.0363150015, 0.0363150015, 0.0363150015, 0.0363150015) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0088109998, 0.0088109998, 0.0234379992, 0.0234379992);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.xy = max(u_xlat1.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat9.xx, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.272895008, 0.272895008, 0.272895008, 0.272895008) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.001422, 0.001422, 0.001422, 0.001422) + u_xlat16_0;
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
  GpuProgramID 83561
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0796450004, -0.0796450004, -0.049922999, -0.049922999);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0509780012, 0.0509780012, 0.0509780012, 0.0509780012);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00178000005, 0.00178000005, 0.00178000005, 0.00178000005) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0211350005, -0.0211350005, 0.00702399993, 0.00702399993);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.32029599, 0.32029599, 0.32029599, 0.32029599) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.46124199, 0.46124199, 0.46124199, 0.46124199) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0354139991, 0.0354139991, 0.0646739975, 0.0646739975);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.153980002, 0.153980002, 0.153980002, 0.153980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0115499999, 0.0115499999, 0.0115499999, 0.0115499999) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.09375, 0.09375);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000172999993, 0.000172999993, 0.000172999993, 0.000172999993) + u_xlat16_0;
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0796450004, -0.0796450004, -0.049922999, -0.049922999);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0509780012, 0.0509780012, 0.0509780012, 0.0509780012);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00178000005, 0.00178000005, 0.00178000005, 0.00178000005) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0211350005, -0.0211350005, 0.00702399993, 0.00702399993);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.32029599, 0.32029599, 0.32029599, 0.32029599) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.46124199, 0.46124199, 0.46124199, 0.46124199) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0354139991, 0.0354139991, 0.0646739975, 0.0646739975);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.153980002, 0.153980002, 0.153980002, 0.153980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0115499999, 0.0115499999, 0.0115499999, 0.0115499999) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.09375, 0.09375);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000172999993, 0.000172999993, 0.000172999993, 0.000172999993) + u_xlat16_0;
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.0796450004, -0.0796450004, -0.049922999, -0.049922999);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat11.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat11.xy = max(u_xlat11.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat11.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.0509780012, 0.0509780012, 0.0509780012, 0.0509780012);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00178000005, 0.00178000005, 0.00178000005, 0.00178000005) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0211350005, -0.0211350005, 0.00702399993, 0.00702399993);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.32029599, 0.32029599, 0.32029599, 0.32029599) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.46124199, 0.46124199, 0.46124199, 0.46124199) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0354139991, 0.0354139991, 0.0646739975, 0.0646739975);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat6.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat6.xy = max(u_xlat6.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat6.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.153980002, 0.153980002, 0.153980002, 0.153980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0115499999, 0.0115499999, 0.0115499999, 0.0115499999) + u_xlat16_0;
    u_xlat16_4.xy = _scaler.xy * vec2(0.09375, 0.09375);
    u_xlat6.xy = u_xlat16_4.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat6.x = u_xlat6.x + _CompactBloomSRCMapping.x;
    u_xlat11.x = max(u_xlat6.y, 0.0);
    u_xlat3.y = min(u_xlat11.x, _CompactBloomSRCMapping.z);
    u_xlat6.x = max(u_xlat6.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat6.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000172999993, 0.000172999993, 0.000172999993, 0.000172999993) + u_xlat16_0;
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
  GpuProgramID 143652
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.254662991, -0.254662991, -0.194030002, -0.194030002);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.00571999978, 0.00571999978, 0.00571999978, 0.00571999978);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000302, 0.000302, 0.000302, 0.000302) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.133894995, -0.133894995, -0.074210003, -0.074210003);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0490350015, 0.0490350015, 0.0490350015, 0.0490350015) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.191699997, 0.191699997, 0.191699997, 0.191699997) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0148259997, -0.0148259997, 0.0444939993, 0.0444939993);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.343513995, 0.343513995, 0.343513995, 0.343513995) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.28283599, 0.28283599, 0.28283599, 0.28283599) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.104002997, 0.104002997, 0.163901001, 0.163901001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.106913, 0.106913, 0.106913, 0.106913) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0184819996, 0.0184819996, 0.0184819996, 0.0184819996) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.224285007, 0.224285007, 0.28125, 0.28125);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.001453, 0.001453, 0.001453, 0.001453) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(4.50000007e-05, 4.50000007e-05, 4.50000007e-05, 4.50000007e-05) + u_xlat16_0;
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.254662991, -0.254662991, -0.194030002, -0.194030002);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.00571999978, 0.00571999978, 0.00571999978, 0.00571999978);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000302, 0.000302, 0.000302, 0.000302) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.133894995, -0.133894995, -0.074210003, -0.074210003);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0490350015, 0.0490350015, 0.0490350015, 0.0490350015) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.191699997, 0.191699997, 0.191699997, 0.191699997) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0148259997, -0.0148259997, 0.0444939993, 0.0444939993);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.343513995, 0.343513995, 0.343513995, 0.343513995) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.28283599, 0.28283599, 0.28283599, 0.28283599) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.104002997, 0.104002997, 0.163901001, 0.163901001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.106913, 0.106913, 0.106913, 0.106913) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0184819996, 0.0184819996, 0.0184819996, 0.0184819996) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.224285007, 0.224285007, 0.28125, 0.28125);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.001453, 0.001453, 0.001453, 0.001453) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(4.50000007e-05, 4.50000007e-05, 4.50000007e-05, 4.50000007e-05) + u_xlat16_0;
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.254662991, -0.254662991, -0.194030002, -0.194030002);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.00571999978, 0.00571999978, 0.00571999978, 0.00571999978);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000302, 0.000302, 0.000302, 0.000302) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.133894995, -0.133894995, -0.074210003, -0.074210003);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0490350015, 0.0490350015, 0.0490350015, 0.0490350015) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.191699997, 0.191699997, 0.191699997, 0.191699997) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.0148259997, -0.0148259997, 0.0444939993, 0.0444939993);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.343513995, 0.343513995, 0.343513995, 0.343513995) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.28283599, 0.28283599, 0.28283599, 0.28283599) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.104002997, 0.104002997, 0.163901001, 0.163901001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.106913, 0.106913, 0.106913, 0.106913) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0184819996, 0.0184819996, 0.0184819996, 0.0184819996) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.224285007, 0.224285007, 0.28125, 0.28125);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_1 * vec4(0.001453, 0.001453, 0.001453, 0.001453) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(4.50000007e-05, 4.50000007e-05, 4.50000007e-05, 4.50000007e-05) + u_xlat16_0;
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
  GpuProgramID 255667
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.954254985, -0.954254985, -0.830891013, -0.830891013);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.000602999993, 0.000602999993, 0.000602999993, 0.000602999993);
    u_xlat16_0 = u_xlat10_0 * vec4(9.50000031e-05, 9.50000031e-05, 9.50000031e-05, 9.50000031e-05) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.707616985, -0.707616985, -0.584424019, -0.584424019);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00297000003, 0.00297000003, 0.00297000003, 0.00297000003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0113390004, 0.0113390004, 0.0113390004, 0.0113390004) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.461302012, -0.461302012, -0.338239014, -0.338239014);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0335289985, 0.0335289985, 0.0335289985, 0.0335289985) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0768119991, 0.0768119991, 0.0768119991, 0.0768119991) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.215221003, -0.215221003, -0.0922319964, -0.0922319964);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.136344001, 0.136344001, 0.136344001, 0.136344001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.187530994, 0.187530994, 0.187530994, 0.187530994) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0307439994, 0.0307439994, 0.153724, 0.153724);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.199875996, 0.199875996, 0.199875996, 0.199875996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.165081993, 0.165081993, 0.165081993, 0.165081993) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.276726007, 0.276726007, 0.399764001, 0.399764001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.105653003, 0.105653003, 0.105653003, 0.105653003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0523930006, 0.0523930006, 0.0523930006, 0.0523930006) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.522854984, 0.522854984, 0.646010995, 0.646010995);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0201299991, 0.0201299991, 0.0201299991, 0.0201299991) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00599199999, 0.00599199999, 0.00599199999, 0.00599199999) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.769243002, 0.769243002, 0.892561018, 0.892561018);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00138100004, 0.00138100004, 0.00138100004, 0.00138100004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.000246999989, 0.000246999989, 0.000246999989, 0.000246999989) + u_xlat16_0;
    u_xlat5.xy = _scaler.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat5.x = u_xlat5.x + _CompactBloomSRCMapping.x;
    u_xlat9.x = max(u_xlat5.y, 0.0);
    u_xlat3.y = min(u_xlat9.x, _CompactBloomSRCMapping.z);
    u_xlat5.x = max(u_xlat5.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat5.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.954254985, -0.954254985, -0.830891013, -0.830891013);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.000602999993, 0.000602999993, 0.000602999993, 0.000602999993);
    u_xlat16_0 = u_xlat10_0 * vec4(9.50000031e-05, 9.50000031e-05, 9.50000031e-05, 9.50000031e-05) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.707616985, -0.707616985, -0.584424019, -0.584424019);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00297000003, 0.00297000003, 0.00297000003, 0.00297000003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0113390004, 0.0113390004, 0.0113390004, 0.0113390004) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.461302012, -0.461302012, -0.338239014, -0.338239014);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0335289985, 0.0335289985, 0.0335289985, 0.0335289985) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0768119991, 0.0768119991, 0.0768119991, 0.0768119991) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.215221003, -0.215221003, -0.0922319964, -0.0922319964);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.136344001, 0.136344001, 0.136344001, 0.136344001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.187530994, 0.187530994, 0.187530994, 0.187530994) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0307439994, 0.0307439994, 0.153724, 0.153724);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.199875996, 0.199875996, 0.199875996, 0.199875996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.165081993, 0.165081993, 0.165081993, 0.165081993) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.276726007, 0.276726007, 0.399764001, 0.399764001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.105653003, 0.105653003, 0.105653003, 0.105653003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0523930006, 0.0523930006, 0.0523930006, 0.0523930006) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.522854984, 0.522854984, 0.646010995, 0.646010995);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0201299991, 0.0201299991, 0.0201299991, 0.0201299991) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00599199999, 0.00599199999, 0.00599199999, 0.00599199999) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.769243002, 0.769243002, 0.892561018, 0.892561018);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00138100004, 0.00138100004, 0.00138100004, 0.00138100004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.000246999989, 0.000246999989, 0.000246999989, 0.000246999989) + u_xlat16_0;
    u_xlat5.xy = _scaler.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat5.x = u_xlat5.x + _CompactBloomSRCMapping.x;
    u_xlat9.x = max(u_xlat5.y, 0.0);
    u_xlat3.y = min(u_xlat9.x, _CompactBloomSRCMapping.z);
    u_xlat5.x = max(u_xlat5.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat5.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
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
    u_xlat16_0 = _scaler.xyxy * vec4(-0.954254985, -0.954254985, -0.830891013, -0.830891013);
    u_xlat0 = u_xlat16_0 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat1.xy = max(u_xlat0.yw, vec2(0.0, 0.0));
    u_xlat9.xy = u_xlat0.xz + _CompactBloomSRCMapping.xx;
    u_xlat9.xy = max(u_xlat9.xy, _CompactBloomSRCMapping.xx);
    u_xlat0.zw = min(u_xlat1.xy, _CompactBloomSRCMapping.zz);
    u_xlat1.x = _CompactBloomSRCMapping.y + _CompactBloomSRCMapping.x;
    u_xlat0.xy = min(u_xlat1.xx, u_xlat9.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.yw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xz);
    u_xlat16_2 = u_xlat10_2 * vec4(0.000602999993, 0.000602999993, 0.000602999993, 0.000602999993);
    u_xlat16_0 = u_xlat10_0 * vec4(9.50000031e-05, 9.50000031e-05, 9.50000031e-05, 9.50000031e-05) + u_xlat16_2;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.707616985, -0.707616985, -0.584424019, -0.584424019);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00297000003, 0.00297000003, 0.00297000003, 0.00297000003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0113390004, 0.0113390004, 0.0113390004, 0.0113390004) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.461302012, -0.461302012, -0.338239014, -0.338239014);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0335289985, 0.0335289985, 0.0335289985, 0.0335289985) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0768119991, 0.0768119991, 0.0768119991, 0.0768119991) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(-0.215221003, -0.215221003, -0.0922319964, -0.0922319964);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.136344001, 0.136344001, 0.136344001, 0.136344001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.187530994, 0.187530994, 0.187530994, 0.187530994) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.0307439994, 0.0307439994, 0.153724, 0.153724);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.199875996, 0.199875996, 0.199875996, 0.199875996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.165081993, 0.165081993, 0.165081993, 0.165081993) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.276726007, 0.276726007, 0.399764001, 0.399764001);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat3.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat3.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat3.xy);
    u_xlat2.zw = min(u_xlat5.xy, _CompactBloomSRCMapping.zz);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.105653003, 0.105653003, 0.105653003, 0.105653003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.0523930006, 0.0523930006, 0.0523930006, 0.0523930006) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.522854984, 0.522854984, 0.646010995, 0.646010995);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.0201299991, 0.0201299991, 0.0201299991, 0.0201299991) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.00599199999, 0.00599199999, 0.00599199999, 0.00599199999) + u_xlat16_0;
    u_xlat16_2 = _scaler.xyxy * vec4(0.769243002, 0.769243002, 0.892561018, 0.892561018);
    u_xlat2 = u_xlat16_2 * _CompactBloomSRCMapping.yzyz + vs_TEXCOORD0.xyxy;
    u_xlat5.xy = u_xlat2.xz + _CompactBloomSRCMapping.xx;
    u_xlat3.xy = max(u_xlat2.yw, vec2(0.0, 0.0));
    u_xlat2.zw = min(u_xlat3.xy, _CompactBloomSRCMapping.zz);
    u_xlat5.xy = max(u_xlat5.xy, _CompactBloomSRCMapping.xx);
    u_xlat2.xy = min(u_xlat1.xx, u_xlat5.xy);
    u_xlat10_3 = texture(_MainTex, u_xlat2.xz);
    u_xlat10_2 = texture(_MainTex, u_xlat2.yw);
    u_xlat16_0 = u_xlat10_3 * vec4(0.00138100004, 0.00138100004, 0.00138100004, 0.00138100004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_2 * vec4(0.000246999989, 0.000246999989, 0.000246999989, 0.000246999989) + u_xlat16_0;
    u_xlat5.xy = _scaler.xy * _CompactBloomSRCMapping.yz + vs_TEXCOORD0.xy;
    u_xlat5.x = u_xlat5.x + _CompactBloomSRCMapping.x;
    u_xlat9.x = max(u_xlat5.y, 0.0);
    u_xlat3.y = min(u_xlat9.x, _CompactBloomSRCMapping.z);
    u_xlat5.x = max(u_xlat5.x, _CompactBloomSRCMapping.x);
    u_xlat3.x = min(u_xlat1.x, u_xlat5.x);
    u_xlat10_1 = texture(_MainTex, u_xlat3.xy);
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