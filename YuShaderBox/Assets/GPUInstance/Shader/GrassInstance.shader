Shader "YU/GPUInstancing"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_WindTex("Wind Texture",2D) = "while"{}
		_Color("Texture Color",Color) = (1,1,1,1)
		_VerticalBillboarding("Vertical Restraints",Range(0,1)) = 1
		_WindVector("Wind Vector",Vector) = (1,0,0,0)
		_TimeScale("Time Scale",float) = 1
		_CutOff("Cut Off",Range(0,0.8)) = 0.2
	}
		SubShader
		{
			Tags {"IgnoreProjector" = "True" "RenderType" = "TransparentCutout" "DisableBatching" = "True"}
			LOD 100
			Cull Off
			Pass
			{
				Tags{ "LightMode" = "ForwardBase" }
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fwdbase
			//第一步，必须要使用这个编译指示符宣告使用GPU多例化技术
			#pragma multi_compile_instancing

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				//第二步，如果要访问片元着色器中的多例化属性变量，需要使用此宏
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _WindTex;

			fixed4 _Color;
			float _VerticalBillboarding;
			float4 _MapMessage;
			float4 _WindVector;
			float _TimeScale;
			float _CutOff;

			//第三步，宣告多例化属性变量语句
			//UNITY_INSTANCING_CBUFFER_START(Props)
			//UNITY_DEFINE_INSTANCED_PROP(float4,_Color)
			//UNITY_INSTANCING_CBUFFER_END(Props)
			//我这里用不上，就是给每个着色器一个不同的属性（例如颜色），
			//可以代码赋值也可以Inspectors窗口赋值	

			v2f vert(appdata v)
			{
				v2f o;
				//第四步，如果要访问片元着色器中的多例化属性变量，需要使用此宏
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v,o);

				float3 center = float3(0,0,0);
				float4 worldPos = mul(unity_ObjectToWorld,float4(center,1));
				float3 viewDir = mul(unity_WorldToObject,float4(_WorldSpaceCameraPos,1));
				float3 normalDir = viewDir - center;
				normalDir.y = normalDir.y*_VerticalBillboarding;
				normalDir = normalize(normalDir);
				float3 upDir = abs(normalDir.y) > 0.999 ? float3(0,0,1) : float3(0,1,0);
				float3 rightDir = normalize(cross(normalDir,upDir));
				float3 centerOffs = v.vertex.xyz - center;
				float3 localPos = center + rightDir * centerOffs.x + upDir * centerOffs.y + normalDir * centerOffs.z;

				float2 map = _MapMessage.zw - _MapMessage.xy;

				float wind = 1 - tex2Dlod(_WindTex,float4(worldPos.x / map.x + _Time.x,worldPos.z / map.y,0,0)).b;
				float time = _Time.y*_TimeScale;
				float4 localWindVector = normalize(mul(unity_WorldToObject,_WindVector));
				localPos += sin(time + wind * 10)*cos(time * 2 / 3 + 1 + wind * 10)*localWindVector.xyz*
					clamp(v.uv.y - 0.5,0,1);

				o.vertex = UnityObjectToClipPos(float4(localPos,1));
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				//第五步，如果要访问片元着色器中的多例化属性变量，需要使用此宏
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 col = tex2D(_MainTex, i.uv);
				clip(col.a - _CutOff);
				fixed4 finalColor = col * _Color;
				return finalColor;
			}
			ENDCG
		}
		}
}

