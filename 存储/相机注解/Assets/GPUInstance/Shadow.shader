Shader "Unlit/YuCustomShadow"
{
    Properties
    {
        _MaxBias("最大偏移值",Range(0,0.01))=0.005
		_BaseBias("基础偏移值",Range(0,0.01)) = 0.001
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "LightMode" = "ForwardBase"}
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag          
			#pragma multi_compile_fwdbase
            #include "UnityCG.cginc"
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float3 normal :NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
				float4 worldpos : TEXCOORD1;
				float4 sdCoord : TEXCOORD2;
				float4 worldNormal : TEXCOORD3;
            };
			float _MaxBias;
			float _BaseBias;
			sampler2D _CustomShadowMap;
			float GetShadowBias(float3 lightDir, float3 normal, float maxBias, float baseBias)
			{
				float cos_val = saturate(dot(lightDir, normal));
				float sin_val = sqrt(1 - cos_val * cos_val); // sin(acos(L·N))
				float tan_val = sin_val / cos_val;    // tan(acos(L·N))

				float bias = baseBias + clamp(tan_val, 0, maxBias);

				return bias;
			}
            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
				o.worldpos = mul(unity_ObjectToWorld, v.vertex);
				o.sdCoord = mul(unity_WorldToShadow[0], o.worldpos);
				o.worldNormal.xyz = normalize(UnityObjectToWorldNormal(v.normal));
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				float3 lightDir = normalize(WorldSpaceLightDir(i.worldpos));
				float depTexture = 1 - tex2D(_CustomShadowMap, i.sdCoord.xy / i.sdCoord.w).r;
				float depth = i.sdCoord.z / i.sdCoord.w;
                #if UNITY_REVERSED_Z
				depth = 1 - depth; //(1, 0)-->(0, 1)
                #else
				depth = depth * 0.5 + 0.5; //(-1, 1)-->(0, 1)
                #endif
				float bais = GetShadowBias(lightDir, i.worldNormal, _MaxBias, _BaseBias);
				fixed realTimeShadow = (depTexture + bais) >= (depth) ? 1 : 0.2;
                return float4(realTimeShadow, realTimeShadow, realTimeShadow,1);
            }
            ENDCG
        }
    }	
}
