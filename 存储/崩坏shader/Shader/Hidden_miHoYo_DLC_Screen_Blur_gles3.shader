//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Screen/Blur" {
Properties {
}
SubShader {
 Pass {
  Name "BLUR VERTICAL"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 43493
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _BlurScale;
uniform 	int _BlurTaps;
uniform 	float _BlurWeights[16];
uniform 	vec4 _BlurOffsets[8];
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
int u_xlati2;
bool u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb9;
void main()
{
    u_xlat0 = vec4(_BlurScale) * vec4(0.0, 1.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0<_BlurTaps);
#else
    u_xlatb1 = 0<_BlurTaps;
#endif
    if(u_xlatb1){
        u_xlat1 = _BlurOffsets[0] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
        u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
        u_xlat1 = u_xlat10_1 * vec4(_BlurWeights[1]);
        u_xlat1 = u_xlat10_2 * vec4(_BlurWeights[0]) + u_xlat1;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 1;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_1.w = float(0.0);
        u_xlati2 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb3 = u_xlati2<_BlurTaps;
#endif
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[1] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[2]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[3]) + u_xlat5;
        u_xlat16_1 = u_xlat4;
        u_xlati2 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[2] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[4]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[5]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[3] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[6]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[7]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[4] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[8]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[9]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[5] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[10]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[11]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[6] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[12]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[13]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat0 = _BlurOffsets[7] * u_xlat0 + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[14]) + u_xlat16_1;
        u_xlat10_0 = texture(_MainTex, u_xlat0.zw);
        u_xlat0 = u_xlat10_0 * vec4(_BlurWeights[15]) + u_xlat2;
        SV_Target0 = u_xlat0;
    } else {
        SV_Target0 = u_xlat16_1;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _BlurScale;
uniform 	int _BlurTaps;
uniform 	float _BlurWeights[16];
uniform 	vec4 _BlurOffsets[8];
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
int u_xlati2;
bool u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb9;
void main()
{
    u_xlat0 = vec4(_BlurScale) * vec4(0.0, 1.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0<_BlurTaps);
#else
    u_xlatb1 = 0<_BlurTaps;
#endif
    if(u_xlatb1){
        u_xlat1 = _BlurOffsets[0] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
        u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
        u_xlat1 = u_xlat10_1 * vec4(_BlurWeights[1]);
        u_xlat1 = u_xlat10_2 * vec4(_BlurWeights[0]) + u_xlat1;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 1;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_1.w = float(0.0);
        u_xlati2 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb3 = u_xlati2<_BlurTaps;
#endif
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[1] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[2]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[3]) + u_xlat5;
        u_xlat16_1 = u_xlat4;
        u_xlati2 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[2] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[4]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[5]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[3] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[6]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[7]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[4] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[8]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[9]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[5] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[10]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[11]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[6] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[12]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[13]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat0 = _BlurOffsets[7] * u_xlat0 + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[14]) + u_xlat16_1;
        u_xlat10_0 = texture(_MainTex, u_xlat0.zw);
        u_xlat0 = u_xlat10_0 * vec4(_BlurWeights[15]) + u_xlat2;
        SV_Target0 = u_xlat0;
    } else {
        SV_Target0 = u_xlat16_1;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _BlurScale;
uniform 	int _BlurTaps;
uniform 	float _BlurWeights[16];
uniform 	vec4 _BlurOffsets[8];
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
int u_xlati2;
bool u_xlatb3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb9;
void main()
{
    u_xlat0 = vec4(_BlurScale) * vec4(0.0, 1.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0<_BlurTaps);
#else
    u_xlatb1 = 0<_BlurTaps;
#endif
    if(u_xlatb1){
        u_xlat1 = _BlurOffsets[0] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
        u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
        u_xlat1 = u_xlat10_1 * vec4(_BlurWeights[1]);
        u_xlat1 = u_xlat10_2 * vec4(_BlurWeights[0]) + u_xlat1;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 1;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_1.w = float(0.0);
        u_xlati2 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb3 = u_xlati2<_BlurTaps;
#endif
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[1] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[2]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[3]) + u_xlat5;
        u_xlat16_1 = u_xlat4;
        u_xlati2 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[2] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[4]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[5]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[3] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[6]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[7]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[4] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[8]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[9]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[5] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[10]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[11]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat4 = _BlurOffsets[6] * u_xlat0.zwzw + vs_TEXCOORD0.xyxy;
        u_xlat10_5 = texture(_MainTex, u_xlat4.xy);
        u_xlat5 = u_xlat10_5 * vec4(_BlurWeights[12]) + u_xlat16_1;
        u_xlat10_4 = texture(_MainTex, u_xlat4.zw);
        u_xlat1 = u_xlat10_4 * vec4(_BlurWeights[13]) + u_xlat5;
        u_xlat16_1 = u_xlat1;
        u_xlati2 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati2<_BlurTaps);
#else
    u_xlatb9 = u_xlati2<_BlurTaps;
#endif
    u_xlatb3 = u_xlatb9 && u_xlatb3;
    if(u_xlatb3){
        u_xlat0 = _BlurOffsets[7] * u_xlat0 + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[14]) + u_xlat16_1;
        u_xlat10_0 = texture(_MainTex, u_xlat0.zw);
        u_xlat0 = u_xlat10_0 * vec4(_BlurWeights[15]) + u_xlat2;
        SV_Target0 = u_xlat0;
    } else {
        SV_Target0 = u_xlat16_1;
    //ENDIF
    }
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
  Name "BLUR HORIZONTAL"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 67897
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _BlurTaps;
uniform 	float _BlurWeights[16];
uniform 	vec4 _BlurOffsets[8];
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bool u_xlatb6;
bool u_xlatb7;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<_BlurTaps);
#else
    u_xlatb0 = 0<_BlurTaps;
#endif
    if(u_xlatb0){
        u_xlat0 = _BlurOffsets[0] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_1 = texture(_MainTex, u_xlat0.xy);
        u_xlat10_0 = texture(_MainTex, u_xlat0.zw);
        u_xlat0 = u_xlat10_0 * vec4(_BlurWeights[1]);
        u_xlat0 = u_xlat10_1 * vec4(_BlurWeights[0]) + u_xlat0;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 1;
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
        u_xlat16_0.w = float(0.0);
        u_xlati1 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb6 = u_xlati1<_BlurTaps;
#endif
    if(u_xlatb6){
        u_xlat2 = _BlurOffsets[1] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_3 = texture(_MainTex, u_xlat2.xy);
        u_xlat3 = u_xlat10_3 * vec4(_BlurWeights[2]) + u_xlat16_0;
        u_xlat10_2 = texture(_MainTex, u_xlat2.zw);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[3]) + u_xlat3;
        u_xlat16_0 = u_xlat2;
        u_xlati1 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb2 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb6 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[2] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[4]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat3 = u_xlat10_3 * vec4(_BlurWeights[5]) + u_xlat4;
        u_xlat16_0 = u_xlat3;
        u_xlati1 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[3] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[6]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[7]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[4] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[8]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[9]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[5] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[10]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[11]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[6] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[12]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[13]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat1 = _BlurOffsets[7] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[14]) + u_xlat16_0;
        u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
        u_xlat1 = u_xlat10_1 * vec4(_BlurWeights[15]) + u_xlat2;
        SV_Target0 = u_xlat1;
    } else {
        SV_Target0 = u_xlat16_0;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _BlurTaps;
uniform 	float _BlurWeights[16];
uniform 	vec4 _BlurOffsets[8];
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bool u_xlatb6;
bool u_xlatb7;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<_BlurTaps);
#else
    u_xlatb0 = 0<_BlurTaps;
#endif
    if(u_xlatb0){
        u_xlat0 = _BlurOffsets[0] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_1 = texture(_MainTex, u_xlat0.xy);
        u_xlat10_0 = texture(_MainTex, u_xlat0.zw);
        u_xlat0 = u_xlat10_0 * vec4(_BlurWeights[1]);
        u_xlat0 = u_xlat10_1 * vec4(_BlurWeights[0]) + u_xlat0;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 1;
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
        u_xlat16_0.w = float(0.0);
        u_xlati1 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb6 = u_xlati1<_BlurTaps;
#endif
    if(u_xlatb6){
        u_xlat2 = _BlurOffsets[1] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_3 = texture(_MainTex, u_xlat2.xy);
        u_xlat3 = u_xlat10_3 * vec4(_BlurWeights[2]) + u_xlat16_0;
        u_xlat10_2 = texture(_MainTex, u_xlat2.zw);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[3]) + u_xlat3;
        u_xlat16_0 = u_xlat2;
        u_xlati1 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb2 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb6 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[2] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[4]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat3 = u_xlat10_3 * vec4(_BlurWeights[5]) + u_xlat4;
        u_xlat16_0 = u_xlat3;
        u_xlati1 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[3] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[6]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[7]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[4] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[8]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[9]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[5] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[10]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[11]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[6] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[12]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[13]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat1 = _BlurOffsets[7] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[14]) + u_xlat16_0;
        u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
        u_xlat1 = u_xlat10_1 * vec4(_BlurWeights[15]) + u_xlat2;
        SV_Target0 = u_xlat1;
    } else {
        SV_Target0 = u_xlat16_0;
    //ENDIF
    }
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _BlurTaps;
uniform 	float _BlurWeights[16];
uniform 	vec4 _BlurOffsets[8];
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
bool u_xlatb6;
bool u_xlatb7;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0<_BlurTaps);
#else
    u_xlatb0 = 0<_BlurTaps;
#endif
    if(u_xlatb0){
        u_xlat0 = _BlurOffsets[0] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_1 = texture(_MainTex, u_xlat0.xy);
        u_xlat10_0 = texture(_MainTex, u_xlat0.zw);
        u_xlat0 = u_xlat10_0 * vec4(_BlurWeights[1]);
        u_xlat0 = u_xlat10_1 * vec4(_BlurWeights[0]) + u_xlat0;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 1;
    } else {
        u_xlat16_0.x = float(0.0);
        u_xlat16_0.y = float(0.0);
        u_xlat16_0.z = float(0.0);
        u_xlat16_0.w = float(0.0);
        u_xlati1 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb6 = u_xlati1<_BlurTaps;
#endif
    if(u_xlatb6){
        u_xlat2 = _BlurOffsets[1] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_3 = texture(_MainTex, u_xlat2.xy);
        u_xlat3 = u_xlat10_3 * vec4(_BlurWeights[2]) + u_xlat16_0;
        u_xlat10_2 = texture(_MainTex, u_xlat2.zw);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[3]) + u_xlat3;
        u_xlat16_0 = u_xlat2;
        u_xlati1 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb2 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb6 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[2] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[4]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat3 = u_xlat10_3 * vec4(_BlurWeights[5]) + u_xlat4;
        u_xlat16_0 = u_xlat3;
        u_xlati1 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[3] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[6]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[7]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[4] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[8]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[9]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[5] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[10]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[11]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat3 = _BlurOffsets[6] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_4 = texture(_MainTex, u_xlat3.xy);
        u_xlat4 = u_xlat10_4 * vec4(_BlurWeights[12]) + u_xlat16_0;
        u_xlat10_3 = texture(_MainTex, u_xlat3.zw);
        u_xlat0 = u_xlat10_3 * vec4(_BlurWeights[13]) + u_xlat4;
        u_xlat16_0 = u_xlat0;
        u_xlati1 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlati1<_BlurTaps);
#else
    u_xlatb7 = u_xlati1<_BlurTaps;
#endif
    u_xlatb2 = u_xlatb7 && u_xlatb2;
    if(u_xlatb2){
        u_xlat1 = _BlurOffsets[7] * vec4(1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
        u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
        u_xlat2 = u_xlat10_2 * vec4(_BlurWeights[14]) + u_xlat16_0;
        u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
        u_xlat1 = u_xlat10_1 * vec4(_BlurWeights[15]) + u_xlat2;
        SV_Target0 = u_xlat1;
    } else {
        SV_Target0 = u_xlat16_0;
    //ENDIF
    }
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