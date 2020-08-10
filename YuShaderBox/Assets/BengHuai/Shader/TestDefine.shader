Shader "Test/TestDefine"
{
    Properties
    {
        _MainTex ("Texture", Cube) = "white" {}
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
		    
#define HHHH 0

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
				float4 worldNormal:TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
			   float lee = 0.2;
			   float3 ddd = i.vertex.xyz;
			//   float3 reflectEye = reflect(ddd, i.worldNormal);
			   float mm= pow(clamp((1.0 - dot(i.vertex.xyz, i.worldNormal)), 0.0, 1.0), lee);
			   return mm;
			   float3 reflectEye = lerp(ddd, i.worldNormal, lee);
			  // float4 maskTex = tex2D(_SpEmCubeTEX,i.uv * _SpEmCubeTEX_ST.xy + _SpEmCubeTEX_ST.zw);
              
                return float4(reflectEye.xyz,0);
            }
            ENDCG
        }
    }
}
