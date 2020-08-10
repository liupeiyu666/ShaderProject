Shader "NPR/NPR_BengHuai3"
{
	Properties
	{
		[Header(Main Texture Setting)]
		[Space(5)]
		_MainTex("Texture", 2D) = "white" {}
		_Color("Tint Color", color) = (0.5, 0.5, 0.5, 1.0)
		[Space(30)]

		[Header(Outline Setting)]
		[Space(5)]
		_OutlineColor("Outline Color", color) = (0.0, 0.0, 0.0, 1.0)
		_OutlineSize("Outline Size", range(0.0, 1.0)) = 0.1
		_ZBias("Z Bias", range(-1.0, 1.0)) = 0.0
		[Space(30)]

		[Header(Bloom Setting)]
		[Space(5)]
		_BloomTex("Bloom Map", 2D) = "black" {}
		_UsingBloomMask("Use Bloom", int) = 1
		_BloomFactor("Bloom Factor", range(0.0, 2.0)) = 1.0
		_Emission("Emission", range(0.0, 2.0)) = 1.0
		_EmissionColor("Emission Color", color) = (1.0, 1.0, 1.0, 1.0)
		_EmissionBloomFactor("Emission Bloom Factor", range(0.0, 2.0)) = 1.0
		[Space(30)]

		[Header(Shadow Setting)]
		[Space(5)]
		_LightMap("LightMap", 2D) = "black" {}
		_LightArea("Light Area", range(0.0, 1.0)) = 1.0
		_SecondShadow("Second Shadow", range(0.0, 1.0)) = 0.5
		_FirstShadowMultColor("First Shadow Color", color) = (1.0, 1.0, 1.0, 1.0)
		_SecondShadowMultColor("Second Shadow Color", color) = (0.5, 0.5, 0.5, 0.5)
		[Space(30)]

		[Header(Specular Setting)]
		[Space(5)]
		_LightSpecColor("Specular Color", color) = (1.0, 1.0, 1.0, 1.0)
		_Shininess("Shininess", range(0.0, 1.0)) = 0.1
		_SpecMulti("Multiple Factor", range(0.1, 1.0)) = 1

	    _MinSpec("_MinSpec",range(0,1))=0
	}
		SubShader
		{
			Tags{
				"RenderType" = "Opaque"
				"Queue" = "Geometry"
			}

		//	UsePass "NPR/NPR_CelShading/OUTLINE"

			Pass
			{
				NAME "BENGHUAI3"

				Tags{ "LightMode" = "ForwardBase" }

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_fwdbase

				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "AutoLight.cginc"

				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				uniform float4 _Color;

				uniform sampler2D _BloomTex;
				uniform float4 _BloomTex_ST;
				uniform int _UsingBloomMask;
				uniform float _BloomFactor;
				uniform float3 _EmissionColor;
				uniform float _Emission;
				uniform float _EmissionBloomFactor;

				uniform sampler2D _LightMap;
				uniform float4 _LightMap_ST;

				uniform float _LightArea;
				uniform float _SecondShadow;
				uniform float3 _FirstShadowMultColor;
				uniform float3 _SecondShadowMultColor;

				uniform float3 _LightSpecColor;
				uniform float _Shininess;
				uniform float _SpecMulti;
				uniform float _MinSpec;
				struct v2f
				{
					float4 pos : POSITION0;
					float4 color : COLOR0;
					float4 texcoord : TEXCOORD0;
					float3 worldPos : TEXCOORD1;
					float3 worldNormal : TEXCOORD2;
					float lambert : TEXCOORD3;
					SHADOW_COORDS(6)
				};

				v2f vert(appdata_full i)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(i.vertex);
					//这里用到了顶点的颜色
					o.color = i.color;
					o.worldPos = mul(unity_ObjectToWorld, i.vertex);
					o.worldNormal = UnityObjectToWorldNormal(i.normal);
					//注意这里进行了变量传递就意味着，在片元处理的时候会进行差值
					float3 worldLightDir = UnityWorldSpaceLightDir(o.worldPos);
					//明暗计算
					float lambert = dot(o.worldNormal, worldLightDir);
					//统一提高一个亮度
					o.lambert = lambert * 0.5f + 0.5f;
					//设置贴图uv
					o.texcoord.xy = TRANSFORM_TEX(i.texcoord, _MainTex);
					//bloom贴图uv
					o.texcoord.zw = TRANSFORM_TEX(i.texcoord, _BloomTex);
					//计算自阴影
					TRANSFER_SHADOW(o);

					return o;
				}

				fixed4 frag(v2f i) : COLOR
				{
					fixed4 diffuseTexColor = tex2D(_MainTex, i.texcoord.xy);
				    //透明度小的剔除掉？
					if (diffuseTexColor.a < 0.01f)
						discard;
					//判断是否使用bloom
					fixed useBloom = (_UsingBloomMask == 0 ? 0.0f : 1.0f);
					if (useBloom != 0)
					{
						//将需要bloom的存储在r通道，（注意在贴图制作中，应该满足不透明名的a为1）
						//换句话说，bloom是不透明物体的bloom
						diffuseTexColor.a = tex2D(_BloomTex, i.texcoord.zw).r * diffuseTexColor.a;
					}

					//Compute Dither Alpha？
					//应用阴影
					UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);
					atten = 1;
					//Compute Diffuse Color —— Choose 
					//读取光照贴图
					fixed3 lightTexColor = tex2D(_LightMap, i.texcoord.xy).rgb;
					//计算两个阴影的颜色
					fixed3 secondShadowColor = diffuseTexColor.rgb * _SecondShadowMultColor.rgb;
					fixed3 firstShadowColor = diffuseTexColor.rgb * _FirstShadowMultColor.rgb;

					
					fixed w = lightTexColor.g * i.color.r;
					
					//return step(0.09f, w);
					//下面的公式可以看出当g或者顶点颜色为0时，t1的范围为[0, 0.5],
					float t1 = (w + i.lambert * atten) * 0.5f;
					//
					//进行二分色，二分色结果t1阴影为1，非阴影为0
					t1 = 1.0f - step(_SecondShadow, t1); //smoothstep(_SecondShadow, _SecondShadow+0.03, t1)
					//将w数值做拆分，这是为了把阴影部分彻底拉出来，达到遮罩的效果
					//小于0.09的，t2为1，反之为0
					fixed t2 = 1.0f - step(0.09f, w);

					fixed4 outColor;
					outColor.w = 1.0f;
					//计算颜色，这个不就都已经 包含了亮面和暗面的颜色了么？为什么还要继续做计算
					secondShadowColor = t1 * secondShadowColor + (1.0f - t1) * firstShadowColor;
					outColor.rgb = secondShadowColor.rgb;
					
					//return w;
					//return outColor;
					//纳尼?===这里计算了light，其实就是计算rim的区域，感觉这个方法
					//不如计算rim的方式更可控
					//计算tt，阴影部分为fixed2(-0.1f,-0.125f)，非阴影部分计算结果。极限情况，（1.1,1.125）
					// w为0表示阴影，1不是阴影，因为最终阴影会乘以tt.x，也就是1.2x-0.1,在[0-0.5]的时候，得到的t1在[-0.1,0.5]之间
					//在w为[0.5,1]区间，得到的t1为1.25x-0.125,取值范围为[0.5,1.125]之间，卧槽？？这是做了映射么？
					//好犀利的算法，将[0,1]的值映射到[-0.1,1.125]之间，映射曲线为对应的1.2x-0.1和1.25x-0.125
					
					fixed2 tt = w * fixed2(1.2f, 1.25f) + fixed2(-0.1f,-0.125f);
					//对阴影进行一次拆分t1为1阴影，为0非阴影，单纯的美术制作的方向的
					t1 = 1.0f - step(0.5f, w);
					//return t1;
					//[0,1]的值映射到[-0.1,1.125]，可是为什么要做这个映射？首先我们要知道这个w这个值为[0-1],
					//光照信息的范围也是[0,1],如果我们系统控制自定的阴影值的比重更大点，就可以将w进行一次范围放大，
					//对于我们需要有边缘光的地方暗处理，某些地方不需要边边缘光的亮处理。其实我们再进行二分色的判断是
					//有数值范围的比如认为小于0.3的都是暗面，但是我们通过控制是0.1还是0.2来实现控制边缘光的强度。
					t1 = t1 * tt.x + (1.0f - t1) * tt.y;
					//return t1;
					//将设置的阴影和光照信息结合
					t1 = (t1 + i.lambert * atten) * 0.5f;
					//return i.lambert * atten;
					//return t1;
					//经过此转换阴影部分为1，亮面为0
					t1 = 1.0f - step(_LightArea, t1);
					//t1 = step(_LightArea, t1);
					//return t1;
					//将暗面添加了firstShadowColor的颜色，此时的暗面为更阴暗的面，其他颜色为依然为之前计算的颜色
					//这里是在阴影处添加了另一个阴影颜色
					firstShadowColor = t1 * firstShadowColor + (1.0f - t1) *diffuseTexColor ;//secondShadowColor
					//firstShadowColor = t1 * firstShadowColor + (1.0f - t1) *secondShadowColor;//secondShadowColor
					outColor.rgb = firstShadowColor;
					//t2阴影部分为1，亮面为0，而这里亮面使用了
					fixed3 diffuseColor = t2 * secondShadowColor + (1.0f - t2) * firstShadowColor;
					
					outColor.rgb = diffuseColor.rgb;
				//	return outColor;
					//return float4(t2 * secondShadowColor,1);

					//Compute Specular Color —————— Blinn-Phong Lighting model
					fixed3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
					fixed3 worldHalfVec = normalize(worldViewDir + _WorldSpaceLightPos0.xyz);
					fixed3 worldNormal = normalize(i.worldNormal);

					//高光计算--
					fixed spec = pow(saturate(dot(worldNormal, worldHalfVec)), _Shininess);
					//计算高光遮罩--根据光照的数据进行高光计算。贴图中为1表示高光区域
					//我们注意到这里高光使用了spec做的差值进行的计算，假设贴图中有个区域的颜色为0.7，那么他应不应该认为是高光区域呢？
					//如果光照计算的值为0.2，则他不做高光区域。
					//也就是光照图的b通道确定了，高中的倾向性。[1-0],1表示高光可能0,
					spec = step(1.0f - lightTexColor.b, spec);
					//lightTexColor.r定义了高光的系数。
					fixed3 specularColor = _LightSpecColor * _SpecMulti *lightTexColor.r  * spec;





					//高光加漫反射同时设置Bloom值
					fixed4 fragColor0;
					fragColor0.rgb = specularColor + diffuseColor;
					fragColor0.rgb *= _Color.rgb;
					fragColor0.a = _BloomFactor * _Color.a;
					//return fragColor0;


					fixed4 fragColor1;
					//自发光--透明的地方发光弱
					fragColor1.rgb = diffuseTexColor.rgb * _Emission.x;
					fragColor1.rgb = fragColor1.rgb * _EmissionColor.rgb - fragColor0.rgb;
					fragColor1.a = _EmissionBloomFactor - _BloomFactor * _Color.a;
					//return fragColor1;
					//这个Bloom的计算值为:diffuseTexColor.a*_EmissionBloomFactor+(1-diffuseTexColor.a)* _BloomFactor * _Color.a
					fixed4 fragColor = diffuseTexColor.a * fragColor1 + fragColor0;
					return fragColor;
				}
				ENDCG
			}
		}
			//FallBack "Diffuse"
}