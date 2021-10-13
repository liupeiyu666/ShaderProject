//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/VisualizeWeatherMap" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 45952
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
uniform 	int _VisualizeOption;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VisualizeOption==1);
#else
    u_xlatb1 = _VisualizeOption==1;
#endif
    if(u_xlatb1){
        SV_Target0.xyz = u_xlat10_0.xxx;
        SV_Target0.w = 1.0;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(_VisualizeOption==2);
#else
        u_xlatb1 = _VisualizeOption==2;
#endif
        if(u_xlatb1){
            SV_Target0.xyz = u_xlat10_0.yyy;
            SV_Target0.w = 1.0;
            return;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb1 = !!(_VisualizeOption==3);
#else
            u_xlatb1 = _VisualizeOption==3;
#endif
            if(u_xlatb1){
                SV_Target0.xyz = u_xlat10_0.zzz;
                SV_Target0.w = 1.0;
                return;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb1 = !!(_VisualizeOption==4);
#else
                u_xlatb1 = _VisualizeOption==4;
#endif
                if(u_xlatb1){
                    SV_Target0.xyz = u_xlat10_0.www;
                    SV_Target0.w = 1.0;
                    return;
                } else {
                    SV_Target0 = u_xlat10_0;
                    return;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
uniform 	int _VisualizeOption;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VisualizeOption==1);
#else
    u_xlatb1 = _VisualizeOption==1;
#endif
    if(u_xlatb1){
        SV_Target0.xyz = u_xlat10_0.xxx;
        SV_Target0.w = 1.0;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(_VisualizeOption==2);
#else
        u_xlatb1 = _VisualizeOption==2;
#endif
        if(u_xlatb1){
            SV_Target0.xyz = u_xlat10_0.yyy;
            SV_Target0.w = 1.0;
            return;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb1 = !!(_VisualizeOption==3);
#else
            u_xlatb1 = _VisualizeOption==3;
#endif
            if(u_xlatb1){
                SV_Target0.xyz = u_xlat10_0.zzz;
                SV_Target0.w = 1.0;
                return;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb1 = !!(_VisualizeOption==4);
#else
                u_xlatb1 = _VisualizeOption==4;
#endif
                if(u_xlatb1){
                    SV_Target0.xyz = u_xlat10_0.www;
                    SV_Target0.w = 1.0;
                    return;
                } else {
                    SV_Target0 = u_xlat10_0;
                    return;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
uniform 	int _VisualizeOption;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VisualizeOption==1);
#else
    u_xlatb1 = _VisualizeOption==1;
#endif
    if(u_xlatb1){
        SV_Target0.xyz = u_xlat10_0.xxx;
        SV_Target0.w = 1.0;
        return;
    } else {
#ifdef UNITY_ADRENO_ES3
        u_xlatb1 = !!(_VisualizeOption==2);
#else
        u_xlatb1 = _VisualizeOption==2;
#endif
        if(u_xlatb1){
            SV_Target0.xyz = u_xlat10_0.yyy;
            SV_Target0.w = 1.0;
            return;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb1 = !!(_VisualizeOption==3);
#else
            u_xlatb1 = _VisualizeOption==3;
#endif
            if(u_xlatb1){
                SV_Target0.xyz = u_xlat10_0.zzz;
                SV_Target0.w = 1.0;
                return;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb1 = !!(_VisualizeOption==4);
#else
                u_xlatb1 = _VisualizeOption==4;
#endif
                if(u_xlatb1){
                    SV_Target0.xyz = u_xlat10_0.www;
                    SV_Target0.w = 1.0;
                    return;
                } else {
                    SV_Target0 = u_xlat10_0;
                    return;
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
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