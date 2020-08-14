Shader "Yu/BrushShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "RenderQueue"="Transparent"}
        LOD 100
		ZTest Always
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		Offset -1,0
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
                float4 vertex : SV_POSITION;
				float4 localPos : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
				o.localPos = v.vertex;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				float4 col=float4(1,0,0,1);	
				float3 dis = i.localPos - float3(0.5, 0.5, 0);
				float distance = length(i.localPos.xyz);
				if (distance <0.495)
				{
					col.a = 0.1;
				}
				else
				{
					if (distance > 0.5)
					{
						col.a = 0;
					}
				}

				//col.rgb =float3(i.localPos.x+0.5, i.localPos.y, i.localPos.z) ;
                return col;
            }
            ENDCG
        }
    }
}
