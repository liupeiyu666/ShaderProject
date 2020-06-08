// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "ApcShader/YOcclusionDissolove"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	    _DissolveDisFactor("_DissolveDisFactor", Range(0, 1.5)) = 0.3
	    _DissolveThreshold("DissolveThreshold", Range(0,2)) = 0.87
		_ODDissolveMap("_ODDissolveMap", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
				float2 uv : TEXCOORD1;
				//x表示深度 
				float4 viewPos : TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			//目标点在的视空间的位置
			uniform float4 _TargetPos;
			uniform sampler2D _ODDissolveMap; 
			uniform float _DissolveDisFactor;
			uniform float _DissolveThreshold;
			v2f vert(appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				//遮挡溶解设置
				//计算屏幕坐标
				float4 screenPos = ComputeGrabScreenPos(o.pos);
				o.viewPos.x = mul(UNITY_MATRIX_MV, v.vertex).z;
				float4 targetScreenPos = ComputeGrabScreenPos(mul(UNITY_MATRIX_P, _TargetPos));
				o.viewPos.yz= (screenPos.xy / screenPos.w - targetScreenPos.xy / targetScreenPos.w);//
				//装换到屏幕空间
				
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				//return float4(i.temp.z,0,0,1);
				//1.进行裁剪计算--满足条件，深度比目标小，并且距离目标在合法范围内
				//只有深度小的时候才会溶解
				if (i.viewPos.x >= _TargetPos.z)
				{
					//屏幕空间的距离，这个距离作为一个系数，去做溶解的解析--取值范围[0,1.414]
					float distance = length(i.viewPos.yz);
				//	float distance = length(i.screenPos.xy / i.screenPos.w - i.targetScreenPos.xy / i.targetScreenPos.w);
					//采样Dissolve Map
					fixed4 dissolveValue = tex2D(_ODDissolveMap, i.uv);
					//溶解系数--限制在0-1之间，距离越近溶解越厉害
					float disolveFactor = max(0,(_DissolveDisFactor - distance)) / _DissolveDisFactor;
					
					//系数相乘
					float endValue = disolveFactor * _DissolveThreshold;
					//当溶解图的alpha通道小于指定系数时溶解生效
					if (dissolveValue.r<= endValue)
					{
						discard;
					}					
					//模拟边缘的灰烬，将原来的颜色，乘以灰度艺术
					float grayValue = endValue + 0.05;
					if (dissolveValue.r < grayValue)
					{
						fixed4 col = tex2D(_MainTex, i.uv);
						float grey = dot(col.rgb, fixed3(0.22, 0.707, 0.071));
						return half4(grey, grey, grey, col.a);
					}
				}
				
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
			
		    	return col;
		    }
		ENDCG
	}
	}
}
