//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Blit_Background" {
Properties {
[Toggle(MAINMENU_BG_NEED_REVERSE_Y)] _MainMenuBgNeedReverseY ("Main Menu BG Need ReverseY", Float) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Background+1" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Background+1" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 65325
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy / abs(in_POSITION0.xy);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _MainMenuBgNeedReverseY;
uniform lowp sampler2D _miHoYo_Background;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_MainMenuBgNeedReverseY);
#else
    u_xlatb0 = 0.0<_MainMenuBgNeedReverseY;
#endif
    u_xlat1 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0.y = (u_xlatb0) ? u_xlat1 : vs_TEXCOORD0.y;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_0 = texture(_miHoYo_Background, u_xlat0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy / abs(in_POSITION0.xy);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _MainMenuBgNeedReverseY;
uniform lowp sampler2D _miHoYo_Background;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_MainMenuBgNeedReverseY);
#else
    u_xlatb0 = 0.0<_MainMenuBgNeedReverseY;
#endif
    u_xlat1 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0.y = (u_xlatb0) ? u_xlat1 : vs_TEXCOORD0.y;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_0 = texture(_miHoYo_Background, u_xlat0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy / abs(in_POSITION0.xy);
    gl_Position.zw = vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _MainMenuBgNeedReverseY;
uniform lowp sampler2D _miHoYo_Background;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_MainMenuBgNeedReverseY);
#else
    u_xlatb0 = 0.0<_MainMenuBgNeedReverseY;
#endif
    u_xlat1 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0.y = (u_xlatb0) ? u_xlat1 : vs_TEXCOORD0.y;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat10_0 = texture(_miHoYo_Background, u_xlat0.xy);
    SV_Target0 = u_xlat10_0;
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