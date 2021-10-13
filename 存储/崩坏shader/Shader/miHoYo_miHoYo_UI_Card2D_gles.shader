//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Card2D" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_MainMask ("Main Mask", 2D) = "white" { }
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Space(10)] [KeywordEnum(None,Disturb,Motion,Rotation)] _Layer0 ("Layer0 Effect", Float) = 0
_LayerTex0 ("Layer Tex 0", 2D) = "white" { }
_NoiseIntensity0 ("Noise Intensity 0", Range(0, 1)) = 0
_NoiseSpeedX0 ("Noise Speed X 0", Range(-1, 1)) = 0
_NoiseSpeedY0 ("Noise Speed Y 0", Range(-1, 1)) = 0
_ColorTint0 ("Color Tint 0", Color) = (1,1,1,1)
_MotionSpeedX0 ("Motion Speed X 0", Range(-1, 1)) = 0
_MotionSpeedY0 ("Motion Speed Y 0", Range(-1, 1)) = 0
_RotateDegree0 ("Rotate Degree 0", Range(-180, 180)) = 0
_RotateSpeed0 ("Rotate Speed 0", Range(-1, 1)) = 0
_OffsetX0 ("Offset X 0", Range(-1, 1)) = 0
_OffsetY0 ("Offset Y 0", Range(-1, 1)) = 0
_ColorParam0 ("Color Param 0", Vector) = (1,0,0,0)
[KeywordEnum(Add,Blend)] _Compose0 ("Compose Method 0", Float) = 0
[Space(10)] [KeywordEnum(None,Motion,Rotation)] _Layer1 ("Layer1 Effect", Float) = 0
_LayerTex1 ("Layer Tex 1", 2D) = "white" { }
_ColorTint1 ("Color Tint 1", Color) = (1,1,1,1)
_MotionSpeedX1 ("Motion Speed X 1", Range(-1, 1)) = 0
_MotionSpeedY1 ("Motion Speed Y 1", Range(-1, 1)) = 0
_RotateDegree1 ("Rotate Degree 1", Range(-180, 180)) = 0
_RotateSpeed1 ("Rotate Speed 1", Range(-1, 1)) = 0
_OffsetX1 ("Offset X 1", Range(-1, 1)) = 0
_OffsetY1 ("Offset Y 1", Range(-1, 1)) = 0
_ColorParam1 ("Color Param 1", Vector) = (1,0,0,0)
[KeywordEnum(Add,Blend)] _Compose1 ("Compose Method 1", Float) = 0
[Space(10)] [KeywordEnum(None,Motion,Rotation)] _Layer2 ("Layer2 Effect", Float) = 0
_LayerTex2 ("Layer Tex 2", 2D) = "white" { }
_ColorTint2 ("Color Tint 2", Color) = (1,1,1,1)
_MotionSpeedX2 ("Motion Speed X 2", Range(-1, 1)) = 0
_MotionSpeedY2 ("Motion Speed Y 2", Range(-1, 1)) = 0
_RotateDegree2 ("Rotate Degree 2", Range(-180, 180)) = 0
_RotateSpeed2 ("Rotate Speed 2", Range(-1, 1)) = 0
_OffsetX2 ("Offset X 2", Range(-1, 1)) = 0
_OffsetY2 ("Offset Y 2", Range(-1, 1)) = 0
_ColorParam2 ("Color Param 2", Vector) = (1,0,0,0)
[KeywordEnum(Add,Blend)] _Compose2 ("Compose Method 2", Float) = 0
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 14386
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _LayerTex0_ST;
uniform highp vec4 _LayerTex1_ST;
uniform highp vec4 _LayerTex2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _LayerTex0_ST.xy) + _LayerTex0_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _LayerTex1_ST.xy) + _LayerTex1_ST.zw);
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _LayerTex2_ST.xy) + _LayerTex2_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MainMask;
uniform sampler2D _LayerTex0;
uniform sampler2D _LayerTex1;
uniform sampler2D _LayerTex2;
uniform mediump float _NoiseIntensity0;
uniform mediump float _NoiseSpeedX0;
uniform mediump float _NoiseSpeedY0;
uniform mediump vec4 _ColorTint0;
uniform mediump float _MotionSpeedX0;
uniform mediump float _MotionSpeedY0;
uniform mediump float _RotateDegree0;
uniform mediump vec4 _ColorParam0;
uniform mediump float _RotateSpeed0;
uniform mediump float _OffsetX0;
uniform mediump float _OffsetY0;
uniform mediump vec4 _ColorTint1;
uniform mediump float _MotionSpeedX1;
uniform mediump float _MotionSpeedY1;
uniform mediump float _RotateDegree1;
uniform mediump vec4 _ColorParam1;
uniform mediump float _RotateSpeed1;
uniform mediump float _OffsetX1;
uniform mediump float _OffsetY1;
uniform mediump vec4 _ColorTint2;
uniform mediump float _MotionSpeedX2;
uniform mediump float _MotionSpeedY2;
uniform mediump float _RotateDegree2;
uniform mediump vec4 _ColorParam2;
uniform mediump float _RotateSpeed2;
uniform mediump float _OffsetX2;
uniform mediump float _OffsetY2;
uniform mediump float _Layer0;
uniform mediump float _Layer1;
uniform mediump float _Layer2;
uniform mediump float _Compose0;
uniform mediump float _Compose1;
uniform mediump float _Compose2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 noiseOffset_2;
  mediump vec4 layer2Color_3;
  mediump vec4 layer1Color_4;
  mediump vec4 layer0Color_5;
  mediump vec4 outColor_6;
  mediump vec4 mainMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainMask, xlv_TEXCOORD0);
  mainMask_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_6 = tmpvar_9;
  layer0Color_5 = vec4(0.0, 0.0, 0.0, 0.0);
  layer1Color_4 = vec4(0.0, 0.0, 0.0, 0.0);
  layer2Color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  noiseOffset_2 = vec2(0.0, 0.0);
  if ((_Layer0 == 0.0)) {
    tmpvar_1 = outColor_6;
  } else {
    if ((_Layer0 == 1.0)) {
      mediump vec2 noiseUV_10;
      mediump vec2 tmpvar_11;
      tmpvar_11.x = _NoiseSpeedX0;
      tmpvar_11.y = _NoiseSpeedY0;
      highp vec2 tmpvar_12;
      tmpvar_12 = (xlv_TEXCOORD1 + (_Time.y * tmpvar_11));
      noiseUV_10 = tmpvar_12;
      lowp vec4 tmpvar_13;
      tmpvar_13 = texture2D (_LayerTex0, noiseUV_10);
      noiseOffset_2 = tmpvar_13.xy;
      noiseOffset_2 = (((noiseOffset_2 * 2.0) - 1.0) * _NoiseIntensity0);
    } else {
      if ((_Layer0 == 2.0)) {
        mediump vec2 motion0UV_14;
        mediump vec2 oldUV_15;
        oldUV_15 = xlv_TEXCOORD1;
        mediump float tmpvar_16;
        tmpvar_16 = (_RotateDegree0 * 57.29578);
        mediump float tmpvar_17;
        tmpvar_17 = cos(tmpvar_16);
        mediump float tmpvar_18;
        tmpvar_18 = sin(tmpvar_16);
        mediump mat2 tmpvar_19;
        tmpvar_19[0].x = tmpvar_17;
        tmpvar_19[0].y = tmpvar_18;
        tmpvar_19[1].x = -(tmpvar_18);
        tmpvar_19[1].y = tmpvar_17;
        mediump vec2 tmpvar_20;
        tmpvar_20.x = _MotionSpeedX0;
        tmpvar_20.y = _MotionSpeedY0;
        motion0UV_14 = (((tmpvar_19 * 
          (oldUV_15 - vec2(0.5, 0.5))
        ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_20));
        lowp vec4 tmpvar_21;
        tmpvar_21 = texture2D (_LayerTex0, motion0UV_14);
        layer0Color_5 = ((tmpvar_21 * _ColorTint0) * mainMask_7.x);
      } else {
        if ((_Layer0 == 3.0)) {
          mediump vec2 rotation0UV_22;
          mediump vec2 tmpvar_23;
          tmpvar_23.x = _OffsetX0;
          tmpvar_23.y = _OffsetY0;
          highp vec2 tmpvar_24;
          tmpvar_24 = (xlv_TEXCOORD1 + tmpvar_23);
          rotation0UV_22 = tmpvar_24;
          mediump float rotateDegree_25;
          rotateDegree_25 = (_Time.y * _RotateSpeed0);
          mediump float tmpvar_26;
          tmpvar_26 = (rotateDegree_25 * 57.29578);
          mediump float tmpvar_27;
          tmpvar_27 = cos(tmpvar_26);
          mediump float tmpvar_28;
          tmpvar_28 = sin(tmpvar_26);
          mediump mat2 tmpvar_29;
          tmpvar_29[0].x = tmpvar_27;
          tmpvar_29[0].y = tmpvar_28;
          tmpvar_29[1].x = -(tmpvar_28);
          tmpvar_29[1].y = tmpvar_27;
          mediump vec2 tmpvar_30;
          tmpvar_30 = ((tmpvar_29 * (rotation0UV_22 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
          rotation0UV_22 = tmpvar_30;
          lowp vec4 tmpvar_31;
          tmpvar_31 = texture2D (_LayerTex0, tmpvar_30);
          layer0Color_5 = ((tmpvar_31 * _ColorTint0) * mainMask_7.x);
        };
      };
    };
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, sin((
      (_Time.y * _ColorParam0.z)
     + _ColorParam0.w)));
    layer0Color_5 = (layer0Color_5 * (_ColorParam0.x + (_ColorParam0.y * tmpvar_32)));
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = (xlv_TEXCOORD0 + (noiseOffset_2 * mainMask_7.x));
    tmpvar_33 = texture2D (_MainTex, P_34);
    outColor_6 = tmpvar_33;
    if ((_Compose0 == 0.0)) {
      outColor_6.xyz = (outColor_6.xyz + layer0Color_5.xyz);
    } else {
      outColor_6.xyz = ((layer0Color_5.xyz * layer0Color_5.w) + (outColor_6.xyz * (1.0 - layer0Color_5.w)));
    };
    if ((_Layer1 == 0.0)) {
      tmpvar_1 = outColor_6;
    } else {
      if ((_Layer1 == 1.0)) {
        mediump vec2 motion1UV_35;
        mediump vec2 oldUV_36;
        oldUV_36 = xlv_TEXCOORD2;
        mediump float tmpvar_37;
        tmpvar_37 = (_RotateDegree1 * 57.29578);
        mediump float tmpvar_38;
        tmpvar_38 = cos(tmpvar_37);
        mediump float tmpvar_39;
        tmpvar_39 = sin(tmpvar_37);
        mediump mat2 tmpvar_40;
        tmpvar_40[0].x = tmpvar_38;
        tmpvar_40[0].y = tmpvar_39;
        tmpvar_40[1].x = -(tmpvar_39);
        tmpvar_40[1].y = tmpvar_38;
        mediump vec2 tmpvar_41;
        tmpvar_41.x = _MotionSpeedX1;
        tmpvar_41.y = _MotionSpeedY1;
        motion1UV_35 = (((tmpvar_40 * 
          (oldUV_36 - vec2(0.5, 0.5))
        ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_41));
        lowp vec4 tmpvar_42;
        mediump vec2 P_43;
        P_43 = (motion1UV_35 + noiseOffset_2);
        tmpvar_42 = texture2D (_LayerTex1, P_43);
        layer1Color_4 = ((tmpvar_42 * _ColorTint1) * mainMask_7.y);
      } else {
        if ((_Layer1 == 2.0)) {
          mediump vec2 rotation1UV_44;
          mediump vec2 tmpvar_45;
          tmpvar_45.x = _OffsetX1;
          tmpvar_45.y = _OffsetY1;
          highp vec2 tmpvar_46;
          tmpvar_46 = (xlv_TEXCOORD2 + tmpvar_45);
          rotation1UV_44 = tmpvar_46;
          mediump float rotateDegree_47;
          rotateDegree_47 = (_Time.y * _RotateSpeed1);
          mediump float tmpvar_48;
          tmpvar_48 = (rotateDegree_47 * 57.29578);
          mediump float tmpvar_49;
          tmpvar_49 = cos(tmpvar_48);
          mediump float tmpvar_50;
          tmpvar_50 = sin(tmpvar_48);
          mediump mat2 tmpvar_51;
          tmpvar_51[0].x = tmpvar_49;
          tmpvar_51[0].y = tmpvar_50;
          tmpvar_51[1].x = -(tmpvar_50);
          tmpvar_51[1].y = tmpvar_49;
          mediump vec2 tmpvar_52;
          tmpvar_52 = ((tmpvar_51 * (rotation1UV_44 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
          rotation1UV_44 = tmpvar_52;
          lowp vec4 tmpvar_53;
          mediump vec2 P_54;
          P_54 = (tmpvar_52 + noiseOffset_2);
          tmpvar_53 = texture2D (_LayerTex1, P_54);
          layer1Color_4 = ((tmpvar_53 * _ColorTint1) * mainMask_7.y);
        };
      };
      highp float tmpvar_55;
      tmpvar_55 = max (0.0, sin((
        (_Time.y * _ColorParam1.z)
       + _ColorParam1.w)));
      layer1Color_4 = (layer1Color_4 * (_ColorParam1.x + (_ColorParam1.y * tmpvar_55)));
      if ((_Compose1 == 0.0)) {
        outColor_6.xyz = (outColor_6.xyz + layer1Color_4.xyz);
      } else {
        outColor_6.xyz = ((layer1Color_4.xyz * layer1Color_4.w) + (outColor_6.xyz * (1.0 - layer1Color_4.w)));
      };
      if ((_Layer2 == 0.0)) {
        tmpvar_1 = outColor_6;
      } else {
        if ((_Layer2 == 1.0)) {
          mediump vec2 motion2UV_56;
          mediump vec2 oldUV_57;
          oldUV_57 = xlv_TEXCOORD3;
          mediump float tmpvar_58;
          tmpvar_58 = (_RotateDegree2 * 57.29578);
          mediump float tmpvar_59;
          tmpvar_59 = cos(tmpvar_58);
          mediump float tmpvar_60;
          tmpvar_60 = sin(tmpvar_58);
          mediump mat2 tmpvar_61;
          tmpvar_61[0].x = tmpvar_59;
          tmpvar_61[0].y = tmpvar_60;
          tmpvar_61[1].x = -(tmpvar_60);
          tmpvar_61[1].y = tmpvar_59;
          mediump vec2 tmpvar_62;
          tmpvar_62.x = _MotionSpeedX2;
          tmpvar_62.y = _MotionSpeedY2;
          motion2UV_56 = (((tmpvar_61 * 
            (oldUV_57 - vec2(0.5, 0.5))
          ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_62));
          lowp vec4 tmpvar_63;
          mediump vec2 P_64;
          P_64 = (motion2UV_56 + noiseOffset_2);
          tmpvar_63 = texture2D (_LayerTex2, P_64);
          layer2Color_3 = ((tmpvar_63 * _ColorTint2) * mainMask_7.z);
        } else {
          if ((_Layer2 == 2.0)) {
            mediump vec2 rotation2UV_65;
            mediump vec2 tmpvar_66;
            tmpvar_66.x = _OffsetX2;
            tmpvar_66.y = _OffsetY2;
            highp vec2 tmpvar_67;
            tmpvar_67 = (xlv_TEXCOORD3 + tmpvar_66);
            rotation2UV_65 = tmpvar_67;
            mediump float rotateDegree_68;
            rotateDegree_68 = (_Time.y * _RotateSpeed2);
            mediump float tmpvar_69;
            tmpvar_69 = (rotateDegree_68 * 57.29578);
            mediump float tmpvar_70;
            tmpvar_70 = cos(tmpvar_69);
            mediump float tmpvar_71;
            tmpvar_71 = sin(tmpvar_69);
            mediump mat2 tmpvar_72;
            tmpvar_72[0].x = tmpvar_70;
            tmpvar_72[0].y = tmpvar_71;
            tmpvar_72[1].x = -(tmpvar_71);
            tmpvar_72[1].y = tmpvar_70;
            mediump vec2 tmpvar_73;
            tmpvar_73 = ((tmpvar_72 * (rotation2UV_65 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
            rotation2UV_65 = tmpvar_73;
            lowp vec4 tmpvar_74;
            mediump vec2 P_75;
            P_75 = (tmpvar_73 + noiseOffset_2);
            tmpvar_74 = texture2D (_LayerTex2, P_75);
            layer2Color_3 = ((tmpvar_74 * _ColorTint2) * mainMask_7.z);
          };
        };
        highp float tmpvar_76;
        tmpvar_76 = max (0.0, sin((
          (_Time.y * _ColorParam2.z)
         + _ColorParam2.w)));
        layer2Color_3 = (layer2Color_3 * (_ColorParam2.x + (_ColorParam2.y * tmpvar_76)));
        if ((_Compose2 == 0.0)) {
          outColor_6.xyz = (outColor_6.xyz + layer2Color_3.xyz);
        } else {
          outColor_6.xyz = ((layer2Color_3.xyz * layer2Color_3.w) + (outColor_6.xyz * (1.0 - layer2Color_3.w)));
        };
        outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
        tmpvar_1 = outColor_6;
      };
    };
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _LayerTex0_ST;
uniform highp vec4 _LayerTex1_ST;
uniform highp vec4 _LayerTex2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _LayerTex0_ST.xy) + _LayerTex0_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _LayerTex1_ST.xy) + _LayerTex1_ST.zw);
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _LayerTex2_ST.xy) + _LayerTex2_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MainMask;
uniform sampler2D _LayerTex0;
uniform sampler2D _LayerTex1;
uniform sampler2D _LayerTex2;
uniform mediump float _NoiseIntensity0;
uniform mediump float _NoiseSpeedX0;
uniform mediump float _NoiseSpeedY0;
uniform mediump vec4 _ColorTint0;
uniform mediump float _MotionSpeedX0;
uniform mediump float _MotionSpeedY0;
uniform mediump float _RotateDegree0;
uniform mediump vec4 _ColorParam0;
uniform mediump float _RotateSpeed0;
uniform mediump float _OffsetX0;
uniform mediump float _OffsetY0;
uniform mediump vec4 _ColorTint1;
uniform mediump float _MotionSpeedX1;
uniform mediump float _MotionSpeedY1;
uniform mediump float _RotateDegree1;
uniform mediump vec4 _ColorParam1;
uniform mediump float _RotateSpeed1;
uniform mediump float _OffsetX1;
uniform mediump float _OffsetY1;
uniform mediump vec4 _ColorTint2;
uniform mediump float _MotionSpeedX2;
uniform mediump float _MotionSpeedY2;
uniform mediump float _RotateDegree2;
uniform mediump vec4 _ColorParam2;
uniform mediump float _RotateSpeed2;
uniform mediump float _OffsetX2;
uniform mediump float _OffsetY2;
uniform mediump float _Layer0;
uniform mediump float _Layer1;
uniform mediump float _Layer2;
uniform mediump float _Compose0;
uniform mediump float _Compose1;
uniform mediump float _Compose2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 noiseOffset_2;
  mediump vec4 layer2Color_3;
  mediump vec4 layer1Color_4;
  mediump vec4 layer0Color_5;
  mediump vec4 outColor_6;
  mediump vec4 mainMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainMask, xlv_TEXCOORD0);
  mainMask_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_6 = tmpvar_9;
  layer0Color_5 = vec4(0.0, 0.0, 0.0, 0.0);
  layer1Color_4 = vec4(0.0, 0.0, 0.0, 0.0);
  layer2Color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  noiseOffset_2 = vec2(0.0, 0.0);
  if ((_Layer0 == 0.0)) {
    tmpvar_1 = outColor_6;
  } else {
    if ((_Layer0 == 1.0)) {
      mediump vec2 noiseUV_10;
      mediump vec2 tmpvar_11;
      tmpvar_11.x = _NoiseSpeedX0;
      tmpvar_11.y = _NoiseSpeedY0;
      highp vec2 tmpvar_12;
      tmpvar_12 = (xlv_TEXCOORD1 + (_Time.y * tmpvar_11));
      noiseUV_10 = tmpvar_12;
      lowp vec4 tmpvar_13;
      tmpvar_13 = texture2D (_LayerTex0, noiseUV_10);
      noiseOffset_2 = tmpvar_13.xy;
      noiseOffset_2 = (((noiseOffset_2 * 2.0) - 1.0) * _NoiseIntensity0);
    } else {
      if ((_Layer0 == 2.0)) {
        mediump vec2 motion0UV_14;
        mediump vec2 oldUV_15;
        oldUV_15 = xlv_TEXCOORD1;
        mediump float tmpvar_16;
        tmpvar_16 = (_RotateDegree0 * 57.29578);
        mediump float tmpvar_17;
        tmpvar_17 = cos(tmpvar_16);
        mediump float tmpvar_18;
        tmpvar_18 = sin(tmpvar_16);
        mediump mat2 tmpvar_19;
        tmpvar_19[0].x = tmpvar_17;
        tmpvar_19[0].y = tmpvar_18;
        tmpvar_19[1].x = -(tmpvar_18);
        tmpvar_19[1].y = tmpvar_17;
        mediump vec2 tmpvar_20;
        tmpvar_20.x = _MotionSpeedX0;
        tmpvar_20.y = _MotionSpeedY0;
        motion0UV_14 = (((tmpvar_19 * 
          (oldUV_15 - vec2(0.5, 0.5))
        ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_20));
        lowp vec4 tmpvar_21;
        tmpvar_21 = texture2D (_LayerTex0, motion0UV_14);
        layer0Color_5 = ((tmpvar_21 * _ColorTint0) * mainMask_7.x);
      } else {
        if ((_Layer0 == 3.0)) {
          mediump vec2 rotation0UV_22;
          mediump vec2 tmpvar_23;
          tmpvar_23.x = _OffsetX0;
          tmpvar_23.y = _OffsetY0;
          highp vec2 tmpvar_24;
          tmpvar_24 = (xlv_TEXCOORD1 + tmpvar_23);
          rotation0UV_22 = tmpvar_24;
          mediump float rotateDegree_25;
          rotateDegree_25 = (_Time.y * _RotateSpeed0);
          mediump float tmpvar_26;
          tmpvar_26 = (rotateDegree_25 * 57.29578);
          mediump float tmpvar_27;
          tmpvar_27 = cos(tmpvar_26);
          mediump float tmpvar_28;
          tmpvar_28 = sin(tmpvar_26);
          mediump mat2 tmpvar_29;
          tmpvar_29[0].x = tmpvar_27;
          tmpvar_29[0].y = tmpvar_28;
          tmpvar_29[1].x = -(tmpvar_28);
          tmpvar_29[1].y = tmpvar_27;
          mediump vec2 tmpvar_30;
          tmpvar_30 = ((tmpvar_29 * (rotation0UV_22 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
          rotation0UV_22 = tmpvar_30;
          lowp vec4 tmpvar_31;
          tmpvar_31 = texture2D (_LayerTex0, tmpvar_30);
          layer0Color_5 = ((tmpvar_31 * _ColorTint0) * mainMask_7.x);
        };
      };
    };
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, sin((
      (_Time.y * _ColorParam0.z)
     + _ColorParam0.w)));
    layer0Color_5 = (layer0Color_5 * (_ColorParam0.x + (_ColorParam0.y * tmpvar_32)));
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = (xlv_TEXCOORD0 + (noiseOffset_2 * mainMask_7.x));
    tmpvar_33 = texture2D (_MainTex, P_34);
    outColor_6 = tmpvar_33;
    if ((_Compose0 == 0.0)) {
      outColor_6.xyz = (outColor_6.xyz + layer0Color_5.xyz);
    } else {
      outColor_6.xyz = ((layer0Color_5.xyz * layer0Color_5.w) + (outColor_6.xyz * (1.0 - layer0Color_5.w)));
    };
    if ((_Layer1 == 0.0)) {
      tmpvar_1 = outColor_6;
    } else {
      if ((_Layer1 == 1.0)) {
        mediump vec2 motion1UV_35;
        mediump vec2 oldUV_36;
        oldUV_36 = xlv_TEXCOORD2;
        mediump float tmpvar_37;
        tmpvar_37 = (_RotateDegree1 * 57.29578);
        mediump float tmpvar_38;
        tmpvar_38 = cos(tmpvar_37);
        mediump float tmpvar_39;
        tmpvar_39 = sin(tmpvar_37);
        mediump mat2 tmpvar_40;
        tmpvar_40[0].x = tmpvar_38;
        tmpvar_40[0].y = tmpvar_39;
        tmpvar_40[1].x = -(tmpvar_39);
        tmpvar_40[1].y = tmpvar_38;
        mediump vec2 tmpvar_41;
        tmpvar_41.x = _MotionSpeedX1;
        tmpvar_41.y = _MotionSpeedY1;
        motion1UV_35 = (((tmpvar_40 * 
          (oldUV_36 - vec2(0.5, 0.5))
        ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_41));
        lowp vec4 tmpvar_42;
        mediump vec2 P_43;
        P_43 = (motion1UV_35 + noiseOffset_2);
        tmpvar_42 = texture2D (_LayerTex1, P_43);
        layer1Color_4 = ((tmpvar_42 * _ColorTint1) * mainMask_7.y);
      } else {
        if ((_Layer1 == 2.0)) {
          mediump vec2 rotation1UV_44;
          mediump vec2 tmpvar_45;
          tmpvar_45.x = _OffsetX1;
          tmpvar_45.y = _OffsetY1;
          highp vec2 tmpvar_46;
          tmpvar_46 = (xlv_TEXCOORD2 + tmpvar_45);
          rotation1UV_44 = tmpvar_46;
          mediump float rotateDegree_47;
          rotateDegree_47 = (_Time.y * _RotateSpeed1);
          mediump float tmpvar_48;
          tmpvar_48 = (rotateDegree_47 * 57.29578);
          mediump float tmpvar_49;
          tmpvar_49 = cos(tmpvar_48);
          mediump float tmpvar_50;
          tmpvar_50 = sin(tmpvar_48);
          mediump mat2 tmpvar_51;
          tmpvar_51[0].x = tmpvar_49;
          tmpvar_51[0].y = tmpvar_50;
          tmpvar_51[1].x = -(tmpvar_50);
          tmpvar_51[1].y = tmpvar_49;
          mediump vec2 tmpvar_52;
          tmpvar_52 = ((tmpvar_51 * (rotation1UV_44 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
          rotation1UV_44 = tmpvar_52;
          lowp vec4 tmpvar_53;
          mediump vec2 P_54;
          P_54 = (tmpvar_52 + noiseOffset_2);
          tmpvar_53 = texture2D (_LayerTex1, P_54);
          layer1Color_4 = ((tmpvar_53 * _ColorTint1) * mainMask_7.y);
        };
      };
      highp float tmpvar_55;
      tmpvar_55 = max (0.0, sin((
        (_Time.y * _ColorParam1.z)
       + _ColorParam1.w)));
      layer1Color_4 = (layer1Color_4 * (_ColorParam1.x + (_ColorParam1.y * tmpvar_55)));
      if ((_Compose1 == 0.0)) {
        outColor_6.xyz = (outColor_6.xyz + layer1Color_4.xyz);
      } else {
        outColor_6.xyz = ((layer1Color_4.xyz * layer1Color_4.w) + (outColor_6.xyz * (1.0 - layer1Color_4.w)));
      };
      if ((_Layer2 == 0.0)) {
        tmpvar_1 = outColor_6;
      } else {
        if ((_Layer2 == 1.0)) {
          mediump vec2 motion2UV_56;
          mediump vec2 oldUV_57;
          oldUV_57 = xlv_TEXCOORD3;
          mediump float tmpvar_58;
          tmpvar_58 = (_RotateDegree2 * 57.29578);
          mediump float tmpvar_59;
          tmpvar_59 = cos(tmpvar_58);
          mediump float tmpvar_60;
          tmpvar_60 = sin(tmpvar_58);
          mediump mat2 tmpvar_61;
          tmpvar_61[0].x = tmpvar_59;
          tmpvar_61[0].y = tmpvar_60;
          tmpvar_61[1].x = -(tmpvar_60);
          tmpvar_61[1].y = tmpvar_59;
          mediump vec2 tmpvar_62;
          tmpvar_62.x = _MotionSpeedX2;
          tmpvar_62.y = _MotionSpeedY2;
          motion2UV_56 = (((tmpvar_61 * 
            (oldUV_57 - vec2(0.5, 0.5))
          ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_62));
          lowp vec4 tmpvar_63;
          mediump vec2 P_64;
          P_64 = (motion2UV_56 + noiseOffset_2);
          tmpvar_63 = texture2D (_LayerTex2, P_64);
          layer2Color_3 = ((tmpvar_63 * _ColorTint2) * mainMask_7.z);
        } else {
          if ((_Layer2 == 2.0)) {
            mediump vec2 rotation2UV_65;
            mediump vec2 tmpvar_66;
            tmpvar_66.x = _OffsetX2;
            tmpvar_66.y = _OffsetY2;
            highp vec2 tmpvar_67;
            tmpvar_67 = (xlv_TEXCOORD3 + tmpvar_66);
            rotation2UV_65 = tmpvar_67;
            mediump float rotateDegree_68;
            rotateDegree_68 = (_Time.y * _RotateSpeed2);
            mediump float tmpvar_69;
            tmpvar_69 = (rotateDegree_68 * 57.29578);
            mediump float tmpvar_70;
            tmpvar_70 = cos(tmpvar_69);
            mediump float tmpvar_71;
            tmpvar_71 = sin(tmpvar_69);
            mediump mat2 tmpvar_72;
            tmpvar_72[0].x = tmpvar_70;
            tmpvar_72[0].y = tmpvar_71;
            tmpvar_72[1].x = -(tmpvar_71);
            tmpvar_72[1].y = tmpvar_70;
            mediump vec2 tmpvar_73;
            tmpvar_73 = ((tmpvar_72 * (rotation2UV_65 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
            rotation2UV_65 = tmpvar_73;
            lowp vec4 tmpvar_74;
            mediump vec2 P_75;
            P_75 = (tmpvar_73 + noiseOffset_2);
            tmpvar_74 = texture2D (_LayerTex2, P_75);
            layer2Color_3 = ((tmpvar_74 * _ColorTint2) * mainMask_7.z);
          };
        };
        highp float tmpvar_76;
        tmpvar_76 = max (0.0, sin((
          (_Time.y * _ColorParam2.z)
         + _ColorParam2.w)));
        layer2Color_3 = (layer2Color_3 * (_ColorParam2.x + (_ColorParam2.y * tmpvar_76)));
        if ((_Compose2 == 0.0)) {
          outColor_6.xyz = (outColor_6.xyz + layer2Color_3.xyz);
        } else {
          outColor_6.xyz = ((layer2Color_3.xyz * layer2Color_3.w) + (outColor_6.xyz * (1.0 - layer2Color_3.w)));
        };
        outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
        tmpvar_1 = outColor_6;
      };
    };
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _LayerTex0_ST;
uniform highp vec4 _LayerTex1_ST;
uniform highp vec4 _LayerTex2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _LayerTex0_ST.xy) + _LayerTex0_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _LayerTex1_ST.xy) + _LayerTex1_ST.zw);
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _LayerTex2_ST.xy) + _LayerTex2_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _MainMask;
uniform sampler2D _LayerTex0;
uniform sampler2D _LayerTex1;
uniform sampler2D _LayerTex2;
uniform mediump float _NoiseIntensity0;
uniform mediump float _NoiseSpeedX0;
uniform mediump float _NoiseSpeedY0;
uniform mediump vec4 _ColorTint0;
uniform mediump float _MotionSpeedX0;
uniform mediump float _MotionSpeedY0;
uniform mediump float _RotateDegree0;
uniform mediump vec4 _ColorParam0;
uniform mediump float _RotateSpeed0;
uniform mediump float _OffsetX0;
uniform mediump float _OffsetY0;
uniform mediump vec4 _ColorTint1;
uniform mediump float _MotionSpeedX1;
uniform mediump float _MotionSpeedY1;
uniform mediump float _RotateDegree1;
uniform mediump vec4 _ColorParam1;
uniform mediump float _RotateSpeed1;
uniform mediump float _OffsetX1;
uniform mediump float _OffsetY1;
uniform mediump vec4 _ColorTint2;
uniform mediump float _MotionSpeedX2;
uniform mediump float _MotionSpeedY2;
uniform mediump float _RotateDegree2;
uniform mediump vec4 _ColorParam2;
uniform mediump float _RotateSpeed2;
uniform mediump float _OffsetX2;
uniform mediump float _OffsetY2;
uniform mediump float _Layer0;
uniform mediump float _Layer1;
uniform mediump float _Layer2;
uniform mediump float _Compose0;
uniform mediump float _Compose1;
uniform mediump float _Compose2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 noiseOffset_2;
  mediump vec4 layer2Color_3;
  mediump vec4 layer1Color_4;
  mediump vec4 layer0Color_5;
  mediump vec4 outColor_6;
  mediump vec4 mainMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainMask, xlv_TEXCOORD0);
  mainMask_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_6 = tmpvar_9;
  layer0Color_5 = vec4(0.0, 0.0, 0.0, 0.0);
  layer1Color_4 = vec4(0.0, 0.0, 0.0, 0.0);
  layer2Color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  noiseOffset_2 = vec2(0.0, 0.0);
  if ((_Layer0 == 0.0)) {
    tmpvar_1 = outColor_6;
  } else {
    if ((_Layer0 == 1.0)) {
      mediump vec2 noiseUV_10;
      mediump vec2 tmpvar_11;
      tmpvar_11.x = _NoiseSpeedX0;
      tmpvar_11.y = _NoiseSpeedY0;
      highp vec2 tmpvar_12;
      tmpvar_12 = (xlv_TEXCOORD1 + (_Time.y * tmpvar_11));
      noiseUV_10 = tmpvar_12;
      lowp vec4 tmpvar_13;
      tmpvar_13 = texture2D (_LayerTex0, noiseUV_10);
      noiseOffset_2 = tmpvar_13.xy;
      noiseOffset_2 = (((noiseOffset_2 * 2.0) - 1.0) * _NoiseIntensity0);
    } else {
      if ((_Layer0 == 2.0)) {
        mediump vec2 motion0UV_14;
        mediump vec2 oldUV_15;
        oldUV_15 = xlv_TEXCOORD1;
        mediump float tmpvar_16;
        tmpvar_16 = (_RotateDegree0 * 57.29578);
        mediump float tmpvar_17;
        tmpvar_17 = cos(tmpvar_16);
        mediump float tmpvar_18;
        tmpvar_18 = sin(tmpvar_16);
        mediump mat2 tmpvar_19;
        tmpvar_19[0].x = tmpvar_17;
        tmpvar_19[0].y = tmpvar_18;
        tmpvar_19[1].x = -(tmpvar_18);
        tmpvar_19[1].y = tmpvar_17;
        mediump vec2 tmpvar_20;
        tmpvar_20.x = _MotionSpeedX0;
        tmpvar_20.y = _MotionSpeedY0;
        motion0UV_14 = (((tmpvar_19 * 
          (oldUV_15 - vec2(0.5, 0.5))
        ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_20));
        lowp vec4 tmpvar_21;
        tmpvar_21 = texture2D (_LayerTex0, motion0UV_14);
        layer0Color_5 = ((tmpvar_21 * _ColorTint0) * mainMask_7.x);
      } else {
        if ((_Layer0 == 3.0)) {
          mediump vec2 rotation0UV_22;
          mediump vec2 tmpvar_23;
          tmpvar_23.x = _OffsetX0;
          tmpvar_23.y = _OffsetY0;
          highp vec2 tmpvar_24;
          tmpvar_24 = (xlv_TEXCOORD1 + tmpvar_23);
          rotation0UV_22 = tmpvar_24;
          mediump float rotateDegree_25;
          rotateDegree_25 = (_Time.y * _RotateSpeed0);
          mediump float tmpvar_26;
          tmpvar_26 = (rotateDegree_25 * 57.29578);
          mediump float tmpvar_27;
          tmpvar_27 = cos(tmpvar_26);
          mediump float tmpvar_28;
          tmpvar_28 = sin(tmpvar_26);
          mediump mat2 tmpvar_29;
          tmpvar_29[0].x = tmpvar_27;
          tmpvar_29[0].y = tmpvar_28;
          tmpvar_29[1].x = -(tmpvar_28);
          tmpvar_29[1].y = tmpvar_27;
          mediump vec2 tmpvar_30;
          tmpvar_30 = ((tmpvar_29 * (rotation0UV_22 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
          rotation0UV_22 = tmpvar_30;
          lowp vec4 tmpvar_31;
          tmpvar_31 = texture2D (_LayerTex0, tmpvar_30);
          layer0Color_5 = ((tmpvar_31 * _ColorTint0) * mainMask_7.x);
        };
      };
    };
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, sin((
      (_Time.y * _ColorParam0.z)
     + _ColorParam0.w)));
    layer0Color_5 = (layer0Color_5 * (_ColorParam0.x + (_ColorParam0.y * tmpvar_32)));
    lowp vec4 tmpvar_33;
    highp vec2 P_34;
    P_34 = (xlv_TEXCOORD0 + (noiseOffset_2 * mainMask_7.x));
    tmpvar_33 = texture2D (_MainTex, P_34);
    outColor_6 = tmpvar_33;
    if ((_Compose0 == 0.0)) {
      outColor_6.xyz = (outColor_6.xyz + layer0Color_5.xyz);
    } else {
      outColor_6.xyz = ((layer0Color_5.xyz * layer0Color_5.w) + (outColor_6.xyz * (1.0 - layer0Color_5.w)));
    };
    if ((_Layer1 == 0.0)) {
      tmpvar_1 = outColor_6;
    } else {
      if ((_Layer1 == 1.0)) {
        mediump vec2 motion1UV_35;
        mediump vec2 oldUV_36;
        oldUV_36 = xlv_TEXCOORD2;
        mediump float tmpvar_37;
        tmpvar_37 = (_RotateDegree1 * 57.29578);
        mediump float tmpvar_38;
        tmpvar_38 = cos(tmpvar_37);
        mediump float tmpvar_39;
        tmpvar_39 = sin(tmpvar_37);
        mediump mat2 tmpvar_40;
        tmpvar_40[0].x = tmpvar_38;
        tmpvar_40[0].y = tmpvar_39;
        tmpvar_40[1].x = -(tmpvar_39);
        tmpvar_40[1].y = tmpvar_38;
        mediump vec2 tmpvar_41;
        tmpvar_41.x = _MotionSpeedX1;
        tmpvar_41.y = _MotionSpeedY1;
        motion1UV_35 = (((tmpvar_40 * 
          (oldUV_36 - vec2(0.5, 0.5))
        ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_41));
        lowp vec4 tmpvar_42;
        mediump vec2 P_43;
        P_43 = (motion1UV_35 + noiseOffset_2);
        tmpvar_42 = texture2D (_LayerTex1, P_43);
        layer1Color_4 = ((tmpvar_42 * _ColorTint1) * mainMask_7.y);
      } else {
        if ((_Layer1 == 2.0)) {
          mediump vec2 rotation1UV_44;
          mediump vec2 tmpvar_45;
          tmpvar_45.x = _OffsetX1;
          tmpvar_45.y = _OffsetY1;
          highp vec2 tmpvar_46;
          tmpvar_46 = (xlv_TEXCOORD2 + tmpvar_45);
          rotation1UV_44 = tmpvar_46;
          mediump float rotateDegree_47;
          rotateDegree_47 = (_Time.y * _RotateSpeed1);
          mediump float tmpvar_48;
          tmpvar_48 = (rotateDegree_47 * 57.29578);
          mediump float tmpvar_49;
          tmpvar_49 = cos(tmpvar_48);
          mediump float tmpvar_50;
          tmpvar_50 = sin(tmpvar_48);
          mediump mat2 tmpvar_51;
          tmpvar_51[0].x = tmpvar_49;
          tmpvar_51[0].y = tmpvar_50;
          tmpvar_51[1].x = -(tmpvar_50);
          tmpvar_51[1].y = tmpvar_49;
          mediump vec2 tmpvar_52;
          tmpvar_52 = ((tmpvar_51 * (rotation1UV_44 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
          rotation1UV_44 = tmpvar_52;
          lowp vec4 tmpvar_53;
          mediump vec2 P_54;
          P_54 = (tmpvar_52 + noiseOffset_2);
          tmpvar_53 = texture2D (_LayerTex1, P_54);
          layer1Color_4 = ((tmpvar_53 * _ColorTint1) * mainMask_7.y);
        };
      };
      highp float tmpvar_55;
      tmpvar_55 = max (0.0, sin((
        (_Time.y * _ColorParam1.z)
       + _ColorParam1.w)));
      layer1Color_4 = (layer1Color_4 * (_ColorParam1.x + (_ColorParam1.y * tmpvar_55)));
      if ((_Compose1 == 0.0)) {
        outColor_6.xyz = (outColor_6.xyz + layer1Color_4.xyz);
      } else {
        outColor_6.xyz = ((layer1Color_4.xyz * layer1Color_4.w) + (outColor_6.xyz * (1.0 - layer1Color_4.w)));
      };
      if ((_Layer2 == 0.0)) {
        tmpvar_1 = outColor_6;
      } else {
        if ((_Layer2 == 1.0)) {
          mediump vec2 motion2UV_56;
          mediump vec2 oldUV_57;
          oldUV_57 = xlv_TEXCOORD3;
          mediump float tmpvar_58;
          tmpvar_58 = (_RotateDegree2 * 57.29578);
          mediump float tmpvar_59;
          tmpvar_59 = cos(tmpvar_58);
          mediump float tmpvar_60;
          tmpvar_60 = sin(tmpvar_58);
          mediump mat2 tmpvar_61;
          tmpvar_61[0].x = tmpvar_59;
          tmpvar_61[0].y = tmpvar_60;
          tmpvar_61[1].x = -(tmpvar_60);
          tmpvar_61[1].y = tmpvar_59;
          mediump vec2 tmpvar_62;
          tmpvar_62.x = _MotionSpeedX2;
          tmpvar_62.y = _MotionSpeedY2;
          motion2UV_56 = (((tmpvar_61 * 
            (oldUV_57 - vec2(0.5, 0.5))
          ) + vec2(0.5, 0.5)) + (_Time.y * tmpvar_62));
          lowp vec4 tmpvar_63;
          mediump vec2 P_64;
          P_64 = (motion2UV_56 + noiseOffset_2);
          tmpvar_63 = texture2D (_LayerTex2, P_64);
          layer2Color_3 = ((tmpvar_63 * _ColorTint2) * mainMask_7.z);
        } else {
          if ((_Layer2 == 2.0)) {
            mediump vec2 rotation2UV_65;
            mediump vec2 tmpvar_66;
            tmpvar_66.x = _OffsetX2;
            tmpvar_66.y = _OffsetY2;
            highp vec2 tmpvar_67;
            tmpvar_67 = (xlv_TEXCOORD3 + tmpvar_66);
            rotation2UV_65 = tmpvar_67;
            mediump float rotateDegree_68;
            rotateDegree_68 = (_Time.y * _RotateSpeed2);
            mediump float tmpvar_69;
            tmpvar_69 = (rotateDegree_68 * 57.29578);
            mediump float tmpvar_70;
            tmpvar_70 = cos(tmpvar_69);
            mediump float tmpvar_71;
            tmpvar_71 = sin(tmpvar_69);
            mediump mat2 tmpvar_72;
            tmpvar_72[0].x = tmpvar_70;
            tmpvar_72[0].y = tmpvar_71;
            tmpvar_72[1].x = -(tmpvar_71);
            tmpvar_72[1].y = tmpvar_70;
            mediump vec2 tmpvar_73;
            tmpvar_73 = ((tmpvar_72 * (rotation2UV_65 - vec2(0.5, 0.5))) + vec2(0.5, 0.5));
            rotation2UV_65 = tmpvar_73;
            lowp vec4 tmpvar_74;
            mediump vec2 P_75;
            P_75 = (tmpvar_73 + noiseOffset_2);
            tmpvar_74 = texture2D (_LayerTex2, P_75);
            layer2Color_3 = ((tmpvar_74 * _ColorTint2) * mainMask_7.z);
          };
        };
        highp float tmpvar_76;
        tmpvar_76 = max (0.0, sin((
          (_Time.y * _ColorParam2.z)
         + _ColorParam2.w)));
        layer2Color_3 = (layer2Color_3 * (_ColorParam2.x + (_ColorParam2.y * tmpvar_76)));
        if ((_Compose2 == 0.0)) {
          outColor_6.xyz = (outColor_6.xyz + layer2Color_3.xyz);
        } else {
          outColor_6.xyz = ((layer2Color_3.xyz * layer2Color_3.w) + (outColor_6.xyz * (1.0 - layer2Color_3.w)));
        };
        outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
        tmpvar_1 = outColor_6;
      };
    };
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
CustomEditor "MoleMole.Card2DEffectEditor"
}