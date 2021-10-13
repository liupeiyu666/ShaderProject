//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Unlit/Opaque (texture+color support) - Android OES ONLY" {
Properties {
_MainTex ("Base (RGB)", 2D) = "black" { }
_ChromaTex ("Chroma", 2D) = "gray" { }
_Color ("Main Color", Color) = (1,1,1,1)
[KeywordEnum(None, Top_Bottom, Left_Right)] Stereo ("Stereo Mode", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 15708
Program "vp" {
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA_OFF" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA_OFF 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 22

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA_OFF" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA_OFF 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA_OFF" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA_OFF 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 22

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA_OFF" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA_OFF 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 22

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA_OFF" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA_OFF 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA_OFF" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA_OFF 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 22

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
SubProgram "gles3 " {
Keywords { "APPLY_GAMMA" }
"#version 300 es
#extension GL_OES_EGL_image_external : require
#extension GL_OES_EGL_image_external_essl3 : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_ENABLE_REFLECTION_BUFFERS 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define APPLY_GAMMA 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 21

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 19
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

			// #pragma only_renderers gles gles3

			// #pragma multi_compile APPLY_GAMMA_OFF APPLY_GAMMA

			
			
			precision mediump float;

			 

			      
				
			
// default float precision for fragment shader is patched on runtime as some drivers have issues with highp

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


   #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


#ifdef VERTEX

// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)

#endif // VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 33

   #define SHADERLAB_GLSL
   #line 1
//-----------------------------------------------------------------------------
// Copyright 2015-2017 RenderHeads Ltd.  All rights reserverd.
//-----------------------------------------------------------------------------

#if defined (SHADERLAB_GLSL)
 #define INLINE 
 #define HALF float
 #define HALF2 vec2
 #define HALF3 vec3
 #define HALF4 vec4
 #define FLOAT2 vec2
 #define FLOAT3 vec3
 #define FLOAT4 vec4
 #define FLOAT3X3 mat3
 #define FLOAT4X4 mat4
#else
 #define INLINE inline
 #define HALF half
 #define HALF2 half2
 #define HALF3 half3
 #define HALF4 half4
 #define FLOAT2 float2
 #define FLOAT3 float3
 #define FLOAT4 float4
 #define FLOAT3X3 float3x3
 #define FLOAT4X4 float4x4
#endif

// Specify this so Unity doesn't automatically update our shaders.
#define UNITY_SHADER_NO_UPGRADE 1

// We use this method so that when Unity automatically updates the shader from the old
// mul(UNITY_MATRIX_MVP.. to UnityObjectToClipPos that it only changes in one place.
INLINE FLOAT4 XFormObjectToClip(FLOAT4 vertex)
{
#if defined(SHADERLAB_GLSL)
 return gl_ModelViewProjectionMatrix * vertex;
#else
#if (UNITY_VERSION >= 560)
 return UnityObjectToClipPos(vertex);
#else
 return mul(UNITY_MATRIX_MVP, vertex);
#endif
#endif
}

INLINE bool IsStereoEyeLeft(FLOAT3 worldNosePosition, FLOAT3 worldCameraRight)
{
#if defined(FORCEEYE_LEFT)
 return true;
#elif defined(FORCEEYE_RIGHT)
 return false;
#elif defined(UNITY_SINGLE_PASS_STEREO) || defined (UNITY_STEREO_INSTANCING_ENABLED)
 // Unity 5.4 has this new variable
 return (unity_StereoEyeIndex == 0);
#elif defined (UNITY_DECLARE_MULTIVIEW)
 // OVR_multiview extension
 return (UNITY_VIEWID == 0);
#else

//#if (UNITY_VERSION > 540) && defined(GOOGLEVR) && !defined(SHADERLAB_GLSL)
 // Daydream support uses the skew component of the projection matrix
 // (But unity_CameraProjection doesn't seem to be declared when using GLSL)
 // NOTE: we've had to remove this minor optimisationg as it was causing too many isues.  
 //       eg. Unity 5.4.1 in GLSL mode complained UNITY_VERSION and unity_CameraProjection aren't defined
 //return (unity_CameraProjection[0][2] > 0.0);
//#else
 // worldNosePosition is the camera positon passed in from Unity via script
 // We need to determine whether _WorldSpaceCameraPos (Unity shader variable) is to the left or to the right of _cameraPosition
 float dRight = distance(worldNosePosition + worldCameraRight, _WorldSpaceCameraPos);
 float dLeft = distance(worldNosePosition - worldCameraRight, _WorldSpaceCameraPos);
 return (dRight > dLeft);
//#endif

#endif
}

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT)
FLOAT4 GetStereoScaleOffset(bool isLeftEye, bool isYFlipped)
{
 FLOAT2 scale = FLOAT2(1.0, 1.0);
 FLOAT2 offset = FLOAT2(0.0, 0.0);

 // Top-Bottom
#if defined(STEREO_TOP_BOTTOM)

 scale.y = 0.5;
 offset.y = 0.0;

 if (!isLeftEye)
 {
  offset.y = 0.5;
 }

#if !defined(SHADERLAB_GLSL) 
//#if !defined(UNITY_UV_STARTS_AT_TOP) // UNITY_UV_STARTS_AT_TOP is for directx
 if (!isYFlipped)
 {
  // Currently this only runs for Android and Windows using DirectShow
  offset.y = 0.5 - offset.y;
 }
//#endif
#endif

 // Left-Right 
#elif defined(STEREO_LEFT_RIGHT)

 scale.x = 0.5;
 offset.x = 0.0;
 if (!isLeftEye)
 {
  offset.x = 0.5;
 }

#endif

 return FLOAT4(scale, offset);
}
#endif

#if defined(STEREO_DEBUG)
INLINE FLOAT4 GetStereoDebugTint(bool isLeftEye)
{
 FLOAT4 tint = FLOAT4(1.0, 1.0, 1.0, 1.0);

#if defined(STEREO_TOP_BOTTOM) || defined(STEREO_LEFT_RIGHT) || defined(STEREO_CUSTOM_UV)
 FLOAT4 leftEyeColor = FLOAT4(0.0, 1.0, 0.0, 1.0);  // green
 FLOAT4 rightEyeColor = FLOAT4(1.0, 0.0, 0.0, 1.0);  // red

 if (isLeftEye)
 {
  tint = leftEyeColor;
 }
 else
 {
  tint = rightEyeColor;
 }
#endif

#if defined(UNITY_UV_STARTS_AT_TOP)
 tint.b = 0.5;
#endif
/*#if defined(UNITY_SINGLE_PASS_STEREO) || defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_DECLARE_MULTIVIEW)
 tint.b = 1.0;
#endif*/

 return tint;
}
#endif

FLOAT2 ScaleZoomToFit(float targetWidth, float targetHeight, float sourceWidth, float sourceHeight)
{
#if defined(ALPHAPACK_TOP_BOTTOM)
 sourceHeight *= 0.5;
#elif defined(ALPHAPACK_LEFT_RIGHT)
 sourceWidth *= 0.5;
#endif
 float targetAspect = targetHeight / targetWidth;
 float sourceAspect = sourceHeight / sourceWidth;
 FLOAT2 scale = FLOAT2(1.0, sourceAspect / targetAspect);
 if (targetAspect < sourceAspect)
 {
  scale = FLOAT2(targetAspect / sourceAspect, 1.0);
 }
 return scale;
}

FLOAT4 OffsetAlphaPackingUV(FLOAT2 texelSize, FLOAT2 uv, bool flipVertical)
{
 FLOAT4 result = uv.xyxy;

 // We don't want bilinear interpolation to cause bleeding
 // when reading the pixels at the edge of the packed areas.
 // So we shift the UV's by a fraction of a pixel so the edges don't get sampled.

#if defined(ALPHAPACK_TOP_BOTTOM)
 float offset = texelSize.y * 1.5;
 result.y = lerp(0.0 + offset, 0.5 - offset, uv.y);
 result.w = result.y + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
  result.yw = result.wy;
 }
 else
 {
#if !defined(UNITY_UV_STARTS_AT_TOP)
  // For opengl we flip
  result.yw = result.wy;
#endif
 }

#elif defined(ALPHAPACK_LEFT_RIGHT)
 float offset = texelSize.x * 1.5;
 result.x = lerp(0.0 + offset, 0.5 - offset, uv.x);
 result.z = result.x + 0.5;

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#else

 if (flipVertical)
 {
  // Flip vertically (and offset to put back in 0..1 range)
  result.yw = 1.0 - result.yw;
 }

#endif

 return result;
}


// http://entropymine.com/imageworsener/srgbformula/
INLINE HALF3 GammaToLinear(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(2.2, 2.2, 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
#else
 return col * (col * (col * 0.305306011h + 0.682171111h) + 0.012522878h);
#endif
#else
// Accurate version
 if (col.r <= 0.04045)
  col.r = col.r / 12.92;
 else
  col.r = pow((col.r + 0.055) / 1.055, 2.4);

 if (col.g <= 0.04045)
  col.g = col.g / 12.92;
 else
  col.g = pow((col.g + 0.055) / 1.055, 2.4);

 if (col.b <= 0.04045)
  col.b = col.b / 12.92;
 else
  col.b = pow((col.b + 0.055) / 1.055, 2.4);
#endif
#endif
 return col;
}

INLINE HALF3 LinearToGamma(HALF3 col)
{
// Forced cheap version
#if defined(CHEAP_GAMMATOLINEAR)
#if defined (SHADERLAB_GLSL)
 return pow(col, vec3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2));
#else
 // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else

#if SHADER_TARGET < 30
// Cheaper approximation
#if defined (SHADERLAB_GLSL)
 return max(1.055 * pow(col, vec3(0.416666667, 0.416666667, 0.416666667)) - 0.055, 0.0);
#else
 return max(1.055h * pow(col, 0.416666667h) - 0.055h, 0.0h);
#endif
#else
// Accurate version
 if (col.r <= 0.0031308)
  col.r = col.r * 12.92;
 else
  col.r = 1.055 * pow(col.r, 0.4166667) - 0.055;

 if (col.g <= 0.0031308)
  col.g = col.g * 12.92;
 else
  col.g = 1.055 * pow(col.g, 0.4166667) - 0.055;

 if (col.b <= 0.0031308)
  col.b = col.b * 12.92;
 else
  col.b = 1.055 * pow(col.b, 0.4166667) - 0.055;
#endif
#endif
 return col;
}

// NOTE: This method is DEPRECATED as of 1.9.5.  Use ConvertYpCbCrToRGB() instead.
// Only keeping this here so any custom shaders people have made don't break.
// This method is broken and won't output accuratly (at least on iOS).
INLINE FLOAT3 Convert420YpCbCr8ToRGB(FLOAT3 ypcbcr)
{
#if 1
 // Full range [0...255]
 FLOAT3X3 m = FLOAT3X3(
  1.0,  0.0,      1.402,
  1.0, -0.34414, -0.71414,
  1.0,  1.77200,  0.0
 );
 FLOAT3 o = FLOAT3(0.0, -0.5, -0.5);
#else
 // Video range [16...235]
 FLOAT3X3 m = FLOAT3X3(
  1.1643,  0.0,      1.5958,
  1.1643, -0.39173, -0.81290,
  1.1643,  2.017,    0.0
 );
 FLOAT3 o = FLOAT3(-0.0625, -0.5, -0.5);
#endif

#if defined(SHADERLAB_GLSL)
 return m * (ypcbcr + o);
#else
 return mul(m, ypcbcr + o);
#endif
}

INLINE FLOAT3 ConvertYpCbCrToRGB(FLOAT3 YpCbCr, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)
 return FLOAT3X3(YpCbCrTransform) * (YpCbCr + YpCbCrTransform[3].xyz);
#else
 return mul((FLOAT3X3)YpCbCrTransform, YpCbCr + YpCbCrTransform[3].xyz);
#endif
}

INLINE HALF4 SampleRGBA(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else 
 HALF4 rgba = tex2D(tex, uv);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF4 SampleYpCbCr(sampler2D luma, sampler2D chroma, FLOAT2 uv, FLOAT4X4 YpCbCrTransform)
{
#if defined(SHADERLAB_GLSL)  // GLSL doesn't support tex2D, so just return for now
 return HALF4(1.0, 1.0, 0.0, 1.0);
#else
#if defined(SHADER_API_METAL) || defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).rg);
#else
 FLOAT3 YpCbCr = FLOAT3(tex2D(luma, uv).r, tex2D(chroma, uv).ra);
#endif
 HALF4 rgba = HALF4(ConvertYpCbCrToRGB(YpCbCr, YpCbCrTransform), 1.0);
#if defined(APPLY_GAMMA)
 rgba.rgb = GammaToLinear(rgba.rgb);
#endif
 return rgba;
#endif
}

INLINE HALF SamplePackedAlpha(sampler2D tex, FLOAT2 uv)
{
#if defined(SHADERLAB_GLSL) // GLSL doesn't support tex2D, so just return for now
 return 0.5;
#else
 HALF alpha;
#if defined(USE_YPCBCR)
 alpha = (tex2D(tex, uv).r - 0.0625) * (255.0 / 219.0);
#else
 HALF3 rgb = tex2D(tex, uv).rgb;
#if defined(APPLY_GAMMA)
 rgb = GammaToLinear(rgb);
#endif
 alpha = (rgb.r + rgb.g + rgb.b) / 3.0;
#endif
 return alpha;
#endif
}

#line 35

  
   out vec2 texVal;
   uniform vec4 _MainTex_ST;

   /// @fix: explicit TRANSFORM_TEX(); Unity's preprocessor chokes when attempting to use the TRANSFORM_TEX() macro in UnityCG.glslinc
   ///  (as of Unity 4.5.0f6; issue dates back to 2011 or earlier: http://forum.unity3d.com/threads/glsl-transform_tex-and-tiling.93756/)
   vec2 transformTex(vec4 texCoord, vec4 texST) 
   {
    return (texCoord.xy * texST.xy + texST.zw);
   }

   void main()
   {
    gl_Position = XFormObjectToClip(gl_Vertex);
    texVal = transformTex(gl_MultiTexCoord0, _MainTex_ST);
    //texVal.x = 1.0 - texVal.x;
    texVal.y = 1.0 - texVal.y;
            }
            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;


			in vec2 texVal;

#if defined(APPLY_GAMMA)
			vec3 GammaToLinear(vec3 col)
			{
				return col * (col * (col * 0.305306011 + 0.682171111) + 0.012522878);
			}
#endif			

			uniform samplerExternalOES _MainTex;

            void main()
            {          
				 
#if defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)
				vec4 col = texture(_MainTex, texVal.xy);
#else
				vec4 col = vec4(1.0, 1.0, 0.0, 1.0);
#endif

#if defined(APPLY_GAMMA)
				col.rgb = GammaToLinear(col.rgb);
#endif
				gl_FragColor = col;
			}
            
#endif"
}
}
}
}
Fallback "AVProVideo/Unlit/Opaque (texture+color+fog+stereo support)"
}