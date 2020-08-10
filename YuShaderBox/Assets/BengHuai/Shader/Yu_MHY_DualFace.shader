Shader "YU/MHY//Yu_MHY_DualFace"
{
    Properties
    {
		_Color("Main Color", Color) = (1,1,1,1)
		_EnvColor("Env Color", Color) = (1,1,1,1)
		_Scale("Scale Compared to Maya", Float) = 0.01
		_BloomFactor("Bloom Factor", Float) = 1
		_MainTex("Main Tex (RGB)", 2D) = "white" { }
		_LightMapTex("Light Map Tex (RGB)", 2D) = "gray" { }
		_LightSpecColor("Light Specular Color", Color) = (1,1,1,1)
		_LightArea("Light Area Threshold", Range(0, 1)) = 0.51
		_SecondShadow("Second Shadow Threshold", Range(0, 1)) = 0.51
		_FirstShadowMultColor("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
		_SecondShadowMultColor("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
		_Shininess("Specular Shininess", Range(0.1, 100)) = 10
		_SpecMulti("Specular Multiply Factor", Range(0, 1)) = 0.1
		//---脸背部颜色
		_BackFaceColor("Back Face Color", Color) = (1,1,1,1)

		_OutlineWidth("Outline Width", Range(0, 100)) = 0.2
		_OutlineColor("Outline Color", Color) = (0,0,0,1)
	     //----新增内容，貌似和描边相关----------------------
		_MaxOutlineZOffset("Max Outline Z Offset", Range(0, 100)) = 1
		_OutlineCamStart("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
		_FadeDistance("Fade Start Distance", Range(0.1, 10)) = 0.5
		_FadeOffset("Fade Start Offset", Range(0, 10)) = 1
		//---------------------------------------------------
		[Toggle(LOOKUP_COLOR)] _LookupColor("Lookup Color", Float) = 0
		[Toggle(LOOKUP_COLOR_BILINEAR)] _LookupColorBilinear("Lookup Color Bilinear", Float) = 0
		_factorTex("Factor Tex", 2D) = "white" { }
		_indexTex("Index Tex", 2D) = "white" { }
		_tableTex("Lookup Tex", 2D) = "white" { }
		[Toggle(SPECIAL_STATE)] _SpecialState("Special State", Float) = 0
		_SPTex("SP Tex", 2D) = "white" { }
		_SPNoiseTex("SP Noise Tex", 2D) = "white" { }
		_SPNoiseScaler("SP Noise Scaler", Range(0, 10)) = 1
		_SPIntensity("SP Intensity", Range(0, 1)) = 0.5
		_SPTransition("SP Transition", Range(0, 1)) = 0
		_SPTransitionColor("SP Transition Color", Color) = (1,1,1,1)
		_SPOpaqueness("SP Opaqueness", Range(0, 1)) = 1
		_SPOutlineColor("SP Outline Color", Color) = (1,1,1,1)
		_SPTransitionEmissionScaler("SP Transition Emission Scaler", Range(1, 100)) = 1
		_SPTransitionBloomFactor("SP Transition Bloom Factor", Float) = 1
		_SPCubeMap("SP CubeMap", Cube) = "white" { }
		_SPCubeMapColor("SP CubeMap Color", Color) = (1,1,1,0)
		_SPCubeMapOffset("SP CubeMap Offset", Vector) = (0,0,0,0)
		_SPCubeMapIntensity("SP CubeMap Intensity", Range(0, 1)) = 0
		_SPCubeMapNoiseIntensity("SP CubeMap Noise Intensity", Range(0, 5)) = 0
		_SPCubeMapBrightness("SP CubeMap Brightness", Float) = 1.26
		_SPOldColor("SP Old Color", Color) = (1,1,1,0)
		[Toggle(RIM_GLOW)] _RimGlow("Rim Glow", Float) = 0
		_RGColor("Rim Glow Color", Color) = (1,1,1,1)
		_RGShininess("Rim Glow Shininess", Float) = 1
		_RGScale("Rim Glow Scale", Float) = 1
		_RGBias("Rim Glow Bias", Float) = 0
		_RGRatio("Rim Glow Ratio", Range(0, 1)) = 0.5
		_RGBloomFactor("Rim Glow Bloom Factor", Float) = 1
		[Toggle(DISTORTION)] _Distortion("Distortion", Float) = 0
		_DTTex("Distortion Tex", 2D) = "gray" { }
		_DTIntensity("Distortion Intensity", Range(1, 9)) = 5
		_DTPlaySpeed("Distortion Play Speed", Float) = 0
		_DTNormalDisplacment("Distortion Normal Displacment", Float) = 0
		_DTUVScaleInX("Distortion UV Scale in X", Float) = 1
		_DTUVScaleInY("Distortion UV Scale in Y", Float) = 1
		_DTFresnel("Distortion Fresnel Params", Vector) = (1,1,0,0)
		_Opaqueness("Opaqueness", Range(0, 1)) = 1
		_VertexAlphaFactor("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
		_OffestFactor("OFfset Factor", Range(-100, 100)) = 0
		_OffestUnit("OFfset Unit", Range(-100, 100)) = 0
		[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha("UsingDitherAlpha", Float) = 0
		_DitherAlpha("Dither Alpha Value", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
