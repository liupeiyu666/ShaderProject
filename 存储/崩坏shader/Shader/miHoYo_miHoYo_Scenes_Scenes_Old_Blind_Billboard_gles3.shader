//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Blind_Billboard" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ScaleTime ("Scale Time", Range(0, 1)) = 1
_UMin ("U Min", Float) = 0
_UMax ("U Max", Float) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 30410
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScaleTime;
uniform 	mediump float _UMin;
uniform 	mediump float _UMax;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
ivec2 u_xlati1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_5;
ivec2 u_xlati5;
bool u_xlatb5;
bool u_xlatb9;
void main()
{
    u_xlat16_0 = (-_UMin) + _UMax;
    u_xlat16_4 = u_xlat16_0 * 0.0250000004;
    u_xlat16_1 = u_xlat16_0 * 0.0250000004 + _UMin;
    u_xlat1.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_1;
    u_xlat1.x = u_xlat16_4 * _ScaleTime + u_xlat16_1;
    u_xlat1.xy = u_xlat1.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vs_TEXCOORD0.x>=u_xlat1.y);
#else
    u_xlatb5 = vs_TEXCOORD0.x>=u_xlat1.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=vs_TEXCOORD0.x);
#else
    u_xlatb1 = u_xlat1.x>=vs_TEXCOORD0.x;
#endif
    u_xlati1.x = int(uint(u_xlatb1) * 0xffffffffu & uint(u_xlatb5) * 0xffffffffu);
    if(u_xlati1.x != 0) {
        u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_2 = u_xlat10_2;
    //ENDIF
    }
    if(u_xlati1.x == 0) {
        u_xlat16_5 = u_xlat16_0 * 0.0500000007 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.100000001 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.150000006 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.200000003 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.25 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.300000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.349999994 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.400000006 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.450000018 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.5 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.550000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.600000024 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.650000036 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.699999988 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.75 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.800000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.850000024 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.900000036 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.949999988 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.x = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.x != 0) {
            u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
            SV_Target0 = u_xlat10_0;
        } else {
            SV_Target0 = u_xlat16_2;
        //ENDIF
        }
    } else {
        SV_Target0 = u_xlat16_2;
    //ENDIF
    }
    if(u_xlati1.x != 0) {return;}
    if((-1)!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScaleTime;
uniform 	mediump float _UMin;
uniform 	mediump float _UMax;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
ivec2 u_xlati1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_5;
ivec2 u_xlati5;
bool u_xlatb5;
bool u_xlatb9;
void main()
{
    u_xlat16_0 = (-_UMin) + _UMax;
    u_xlat16_4 = u_xlat16_0 * 0.0250000004;
    u_xlat16_1 = u_xlat16_0 * 0.0250000004 + _UMin;
    u_xlat1.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_1;
    u_xlat1.x = u_xlat16_4 * _ScaleTime + u_xlat16_1;
    u_xlat1.xy = u_xlat1.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vs_TEXCOORD0.x>=u_xlat1.y);
#else
    u_xlatb5 = vs_TEXCOORD0.x>=u_xlat1.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=vs_TEXCOORD0.x);
#else
    u_xlatb1 = u_xlat1.x>=vs_TEXCOORD0.x;
#endif
    u_xlati1.x = int(uint(u_xlatb1) * 0xffffffffu & uint(u_xlatb5) * 0xffffffffu);
    if(u_xlati1.x != 0) {
        u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_2 = u_xlat10_2;
    //ENDIF
    }
    if(u_xlati1.x == 0) {
        u_xlat16_5 = u_xlat16_0 * 0.0500000007 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.100000001 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.150000006 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.200000003 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.25 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.300000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.349999994 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.400000006 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.450000018 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.5 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.550000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.600000024 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.650000036 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.699999988 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.75 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.800000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.850000024 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.900000036 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.949999988 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.x = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.x != 0) {
            u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
            SV_Target0 = u_xlat10_0;
        } else {
            SV_Target0 = u_xlat16_2;
        //ENDIF
        }
    } else {
        SV_Target0 = u_xlat16_2;
    //ENDIF
    }
    if(u_xlati1.x != 0) {return;}
    if((-1)!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScaleTime;
uniform 	mediump float _UMin;
uniform 	mediump float _UMax;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
ivec2 u_xlati1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_5;
ivec2 u_xlati5;
bool u_xlatb5;
bool u_xlatb9;
void main()
{
    u_xlat16_0 = (-_UMin) + _UMax;
    u_xlat16_4 = u_xlat16_0 * 0.0250000004;
    u_xlat16_1 = u_xlat16_0 * 0.0250000004 + _UMin;
    u_xlat1.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_1;
    u_xlat1.x = u_xlat16_4 * _ScaleTime + u_xlat16_1;
    u_xlat1.xy = u_xlat1.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(vs_TEXCOORD0.x>=u_xlat1.y);
#else
    u_xlatb5 = vs_TEXCOORD0.x>=u_xlat1.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=vs_TEXCOORD0.x);
#else
    u_xlatb1 = u_xlat1.x>=vs_TEXCOORD0.x;
#endif
    u_xlati1.x = int(uint(u_xlatb1) * 0xffffffffu & uint(u_xlatb5) * 0xffffffffu);
    if(u_xlati1.x != 0) {
        u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat16_2 = u_xlat10_2;
    //ENDIF
    }
    if(u_xlati1.x == 0) {
        u_xlat16_5 = u_xlat16_0 * 0.0500000007 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.100000001 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.150000006 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.200000003 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.25 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.300000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.349999994 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.400000006 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.450000018 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.5 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.550000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.600000024 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.650000036 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.699999988 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.75 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.800000012 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.850000024 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.900000036 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat16_2 = u_xlat10_2;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati5.xy = ~u_xlati1.yx;
    u_xlati5.x = int(uint(u_xlati5.y) & uint(u_xlati5.x));
    if(u_xlati5.x != 0) {
        u_xlat16_5 = u_xlat16_0 * 0.949999988 + _UMin;
        u_xlat16_5 = u_xlat16_0 * 0.0250000004 + u_xlat16_5;
        u_xlat5.y = (-u_xlat16_4) * _ScaleTime + u_xlat16_5;
        u_xlat5.x = u_xlat16_4 * _ScaleTime + u_xlat16_5;
        u_xlat5.xy = u_xlat5.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb9 = !!(vs_TEXCOORD0.x>=u_xlat5.y);
#else
        u_xlatb9 = vs_TEXCOORD0.x>=u_xlat5.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x>=vs_TEXCOORD0.x);
#else
        u_xlatb5 = u_xlat5.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.x = int(uint(u_xlatb5) * 0xffffffffu & uint(u_xlatb9) * 0xffffffffu);
        if(u_xlati1.x != 0) {
            u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
            SV_Target0 = u_xlat10_0;
        } else {
            SV_Target0 = u_xlat16_2;
        //ENDIF
        }
    } else {
        SV_Target0 = u_xlat16_2;
    //ENDIF
    }
    if(u_xlati1.x != 0) {return;}
    if((-1)!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScaleTime;
uniform 	mediump float _UMin;
uniform 	mediump float _UMax;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
ivec2 u_xlati1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
bool u_xlatb6;
float u_xlat11;
bool u_xlatb11;
void main()
{
    u_xlat16_0 = (-_UMin) + _UMax;
    u_xlat16_5 = u_xlat16_0 * 0.0250000004;
    u_xlat16_1 = u_xlat16_0 * 0.0250000004 + _UMin;
    u_xlat1.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_1;
    u_xlat1.x = u_xlat16_5 * _ScaleTime + u_xlat16_1;
    u_xlat1.xy = u_xlat1.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vs_TEXCOORD0.x>=u_xlat1.y);
#else
    u_xlatb6 = vs_TEXCOORD0.x>=u_xlat1.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=vs_TEXCOORD0.x);
#else
    u_xlatb1 = u_xlat1.x>=vs_TEXCOORD0.x;
#endif
    u_xlati1.x = int(uint(u_xlatb1) * 0xffffffffu & uint(u_xlatb6) * 0xffffffffu);
    if(u_xlati1.x != 0) {
        u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat6.x = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
        u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat6.xxx;
        u_xlat2.xyz = vec3(_LumiFactor) * u_xlat6.xyz + u_xlat2.xyz;
        u_xlat16_2 = u_xlat2;
    //ENDIF
    }
    if(u_xlati1.x == 0) {
        u_xlat16_6 = u_xlat16_0 * 0.0500000007 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.100000001 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.150000006 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.200000003 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.25 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.300000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.349999994 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.400000006 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.450000018 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.5 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.550000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.600000024 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.650000036 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.699999988 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.75 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.800000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.850000024 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.900000036 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.949999988 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.x = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.x != 0) {
            u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat6.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat6.xyz = (-u_xlat0.xyz) + u_xlat6.xxx;
            u_xlat0.xyz = vec3(_LumiFactor) * u_xlat6.xyz + u_xlat0.xyz;
            SV_Target0 = u_xlat0;
        } else {
            SV_Target0 = u_xlat16_2;
        //ENDIF
        }
    } else {
        SV_Target0 = u_xlat16_2;
    //ENDIF
    }
    if(u_xlati1.x != 0) {return;}
    if((-1)!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScaleTime;
uniform 	mediump float _UMin;
uniform 	mediump float _UMax;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
ivec2 u_xlati1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
bool u_xlatb6;
float u_xlat11;
bool u_xlatb11;
void main()
{
    u_xlat16_0 = (-_UMin) + _UMax;
    u_xlat16_5 = u_xlat16_0 * 0.0250000004;
    u_xlat16_1 = u_xlat16_0 * 0.0250000004 + _UMin;
    u_xlat1.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_1;
    u_xlat1.x = u_xlat16_5 * _ScaleTime + u_xlat16_1;
    u_xlat1.xy = u_xlat1.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vs_TEXCOORD0.x>=u_xlat1.y);
#else
    u_xlatb6 = vs_TEXCOORD0.x>=u_xlat1.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=vs_TEXCOORD0.x);
#else
    u_xlatb1 = u_xlat1.x>=vs_TEXCOORD0.x;
#endif
    u_xlati1.x = int(uint(u_xlatb1) * 0xffffffffu & uint(u_xlatb6) * 0xffffffffu);
    if(u_xlati1.x != 0) {
        u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat6.x = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
        u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat6.xxx;
        u_xlat2.xyz = vec3(_LumiFactor) * u_xlat6.xyz + u_xlat2.xyz;
        u_xlat16_2 = u_xlat2;
    //ENDIF
    }
    if(u_xlati1.x == 0) {
        u_xlat16_6 = u_xlat16_0 * 0.0500000007 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.100000001 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.150000006 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.200000003 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.25 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.300000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.349999994 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.400000006 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.450000018 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.5 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.550000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.600000024 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.650000036 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.699999988 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.75 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.800000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.850000024 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.900000036 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.949999988 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.x = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.x != 0) {
            u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat6.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat6.xyz = (-u_xlat0.xyz) + u_xlat6.xxx;
            u_xlat0.xyz = vec3(_LumiFactor) * u_xlat6.xyz + u_xlat0.xyz;
            SV_Target0 = u_xlat0;
        } else {
            SV_Target0 = u_xlat16_2;
        //ENDIF
        }
    } else {
        SV_Target0 = u_xlat16_2;
    //ENDIF
    }
    if(u_xlati1.x != 0) {return;}
    if((-1)!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _ScaleTime;
uniform 	mediump float _UMin;
uniform 	mediump float _UMax;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
ivec2 u_xlati1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
ivec2 u_xlati6;
bool u_xlatb6;
float u_xlat11;
bool u_xlatb11;
void main()
{
    u_xlat16_0 = (-_UMin) + _UMax;
    u_xlat16_5 = u_xlat16_0 * 0.0250000004;
    u_xlat16_1 = u_xlat16_0 * 0.0250000004 + _UMin;
    u_xlat1.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_1;
    u_xlat1.x = u_xlat16_5 * _ScaleTime + u_xlat16_1;
    u_xlat1.xy = u_xlat1.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(vs_TEXCOORD0.x>=u_xlat1.y);
#else
    u_xlatb6 = vs_TEXCOORD0.x>=u_xlat1.y;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=vs_TEXCOORD0.x);
#else
    u_xlatb1 = u_xlat1.x>=vs_TEXCOORD0.x;
#endif
    u_xlati1.x = int(uint(u_xlatb1) * 0xffffffffu & uint(u_xlatb6) * 0xffffffffu);
    if(u_xlati1.x != 0) {
        u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
        u_xlat6.x = dot(u_xlat2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
        u_xlat6.xyz = (-u_xlat2.xyz) + u_xlat6.xxx;
        u_xlat2.xyz = vec3(_LumiFactor) * u_xlat6.xyz + u_xlat2.xyz;
        u_xlat16_2 = u_xlat2;
    //ENDIF
    }
    if(u_xlati1.x == 0) {
        u_xlat16_6 = u_xlat16_0 * 0.0500000007 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.100000001 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.150000006 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.200000003 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.25 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.300000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.349999994 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.400000006 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.450000018 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.5 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.550000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.600000024 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.650000036 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.699999988 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.75 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.800000012 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.850000024 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.900000036 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.y = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.y != 0) {
            u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat11 = dot(u_xlat3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat4.xyz = (-u_xlat3.xyz) + vec3(u_xlat11);
            u_xlat3.xyz = vec3(_LumiFactor) * u_xlat4.xyz + u_xlat3.xyz;
            u_xlat16_2 = u_xlat3;
        //ENDIF
        }
        u_xlati1.x = u_xlati1.y;
    } else {
        u_xlati1.y = -1;
    //ENDIF
    }
    u_xlati6.xy = ~u_xlati1.yx;
    u_xlati6.x = int(uint(u_xlati6.y) & uint(u_xlati6.x));
    if(u_xlati6.x != 0) {
        u_xlat16_6 = u_xlat16_0 * 0.949999988 + _UMin;
        u_xlat16_6 = u_xlat16_0 * 0.0250000004 + u_xlat16_6;
        u_xlat6.y = (-u_xlat16_5) * _ScaleTime + u_xlat16_6;
        u_xlat6.x = u_xlat16_5 * _ScaleTime + u_xlat16_6;
        u_xlat6.xy = u_xlat6.xy + _MainTex_ST.zz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb11 = !!(vs_TEXCOORD0.x>=u_xlat6.y);
#else
        u_xlatb11 = vs_TEXCOORD0.x>=u_xlat6.y;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb6 = !!(u_xlat6.x>=vs_TEXCOORD0.x);
#else
        u_xlatb6 = u_xlat6.x>=vs_TEXCOORD0.x;
#endif
        u_xlati1.x = int(uint(u_xlatb6) * 0xffffffffu & uint(u_xlatb11) * 0xffffffffu);
        if(u_xlati1.x != 0) {
            u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
            u_xlat6.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
            u_xlat6.xyz = (-u_xlat0.xyz) + u_xlat6.xxx;
            u_xlat0.xyz = vec3(_LumiFactor) * u_xlat6.xyz + u_xlat0.xyz;
            SV_Target0 = u_xlat0;
        } else {
            SV_Target0 = u_xlat16_2;
        //ENDIF
        }
    } else {
        SV_Target0 = u_xlat16_2;
    //ENDIF
    }
    if(u_xlati1.x != 0) {return;}
    if((-1)!=0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
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
}
}
}
}