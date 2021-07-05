Shader "YU/MHY/Yu_MHY_Avatar"
{
    Properties
    {
		_Color("Main Color", Color) = (1,1,1,1)
		_EnvColor("Env Color", Color) = (1,1,1,1)
		_Scale("Scale Compared to Maya", Float) = 0.01

		[Header(Bloom Setting)]
		[Space(5)]
		_BloomTex("Bloom Map", 2D) = "black" {}
		_UsingBloomMask("Use Bloom", int) = 1
		_BloomFactor("Bloom Factor", range(0.0, 2.0)) = 1.0
		_Emission("Emission", range(0.0, 2.0)) = 1.0
		_EmissionColor("Emission Color", color) = (1.0, 1.0, 1.0, 1.0)
		_EmissionBloomFactor("Emission Bloom Factor", range(0.0, 2.0)) = 1.0

		
		_MainTex("Main Tex (RGB)", 2D) = "white" { }
		_LightMapTex("Light Map Tex (RGB)", 2D) = "gray" { }
		_LightSpecColor("Light Specular Color", Color) = (1,1,1,1)
		_LightArea("Light Area Threshold", Range(0, 1)) = 0.51
		_SecondShadow("Second Shadow Threshold", Range(0, 1)) = 0.51
		_FirstShadowMultColor("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
		_SecondShadowMultColor("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
		_Shininess("Specular Shininess", Range(0.1, 100)) = 10
		_SpecMulti("Specular Multiply Factor", Range(0, 1)) = 0.1
		_OutlineWidth("Outline Width", Range(0, 100)) = 0.2
		_OutlineColor("Outline Color", Color) = (0,0,0,1)
		_MaxOutlineZOffset("Max Outline Z Offset", Range(0, 100)) = 1
		_OutlineCamStart("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
		_FadeDistance("Fade Start Distance", Range(0.1, 10)) = 0.5
		_FadeOffset("Fade Start Offset", Range(0, 10)) = 1
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
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
#pragma exclude_renderers gles
            #pragma vertex vert
            #pragma fragment frag	
            #pragma multi_compile_fwdbase
			#pragma shader_feature RIM_GLOW      
			#pragma shader_feature SPECIAL_STATE
			//-----LUT以及双线性差值颜色查找，这个我们可以先不用关心
			#pragma shader_feature LOOKUP_COLOR
			#pragma shader_feature LOOKUP_COLOR_BILINEAR
            #include "UnityCG.cginc"

			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 color : COLOR0;//顶点颜色
				float2 uv:TEXCOORD0;
				float lambert : TEXCOORD1;
				float3 worldNormal:TEXCOORD2;
				float4 worldPos:TEXCOORD3;
				float4 screenPos:TEXCOORD4;
				//特殊状态下的uv信息,xy存储特殊状态贴图的uv，zw存储对应噪声图的uv
				float4 specialUV:TEXCOORD5;
				
			};

            sampler2D _MainTex;
            float4 _MainTex_ST;
			//特殊效果图
			sampler2D _SPTex;			
			float4 _SPTex_ST;
			sampler2D _SPNoiseTex;
			float4 _SPNoiseTex_ST;
			//是否使用Dither效果--可以用变体操作
			float _UsingDitherAlpha;
			//Dither阀值
			float _DitherAlpha;
            v2f vert (appdata_full v)
            {
                v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				//o.viewDir = WorldSpaceViewDir(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				//--屏幕空间坐标转换，为了Dither效果
				o.screenPos = ComputeScreenPos(o.pos);
				//--计算lambert系数--如果为了高效果可以放到片元处理
				float3 worldLightDir = UnityWorldSpaceLightDir(o.worldPos);
				//明暗计算
				float lambert = dot(o.worldNormal, worldLightDir);
				//统一提高一个亮度
				o.lambert = lambert * 0.5f + 0.5f;

				o.color = v.color;
				//#ifdef SPECIAL_STATE
				o.specialUV.xy = TRANSFORM_TEX(v.texcoord, _SPTex);
				//--特殊状态下的噪声图的uv根据局部空间的坐标信息确定
				float3 scaleVertex= (v.vertex * 0.5);
				float3x2 xUvRadio = {1,scaleVertex.x,0,1,scaleVertex.z,0.5 };
				float2 noiseUv = mul(scaleVertex, xUvRadio).xy;
				o.specialUV.zw= TRANSFORM_TEX(noiseUv, _SPNoiseTex);				
				//#endif
                return o;
            }
			uniform sampler2D _LightMapTex;
			uniform float4 _LightMapTex_ST;
			uniform sampler2D _BloomTex;
			uniform float4 _BloomTex_ST;
			uniform int _UsingBloomMask;
			uniform float _BloomFactor;
			uniform float3 _EmissionColor;
			uniform float _Emission;
			uniform float _EmissionBloomFactor;


			uniform float3 _FirstShadowMultColor;
			uniform float3 _SecondShadowMultColor;
			uniform float _LightArea;
			uniform float _SecondShadow;
			uniform float _Shininess;
			uniform float _SpecMulti;
			uniform float3 _LightSpecColor;



			uniform float _SPCubeMapNoiseIntensity;
			uniform float4 _SPCubeMapOffset;
			uniform samplerCUBE _SPCubeMap;
			uniform float4 _SPOldColor;
			uniform float4 _SPCubeMapColor;
			//uniform float4 _Color.xyz * _EnvColor
			uniform float _SPCubeMapBrightness;
			uniform float _SPCubeMapIntensity;
			uniform float _SPNoiseScaler;
			uniform float _SPTransition;
			uniform float _SPTransitionBloomFactor;
			uniform float4 _SPTransitionColor;
			uniform float _SPTransitionEmissionScaler;
			uniform float _SPIntensity;


			uniform float4 _Color;
			uniform float4 _EnvColor;

			//菲涅尔-边缘光计算 _RGScale  _RGShininess  _RGBias _RGRatio _RGColor
			uniform float _RGScale;
			uniform float _RGShininess;
			uniform float _RGBias;
			uniform float4 _RGColor;
			uniform float _RGRatio;

            fixed4 frag (v2f i) : SV_Target
            {
				float4 col;
				//--计算Dither效果
				float4x4 _RowAccess = { 1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1 };
			    float2 pos = (i.screenPos.xy/ i.screenPos.w)*_ScreenParams.xy;
			  //  clip(0.9 - _RowAccess[floor(fmod(pos.x, 4))][floor(fmod(pos.y, 4))]);
				 //-----------此处省略LUT方式的颜色计算，
				//------------------------------
                fixed4 baseTexColor = tex2D(_MainTex, i.uv);
				//判断是否使用bloom---这里采用了根据是否采用Bloom遮罩图，如果没用就是用a通道的
				//--这个没有必要做太多操作，也不用完全按照崩坏的来，个人觉得，bloom的调整可以根据亮暗面进行设置
				fixed useBloom = (_UsingBloomMask == 0 ? 0.0f : 1.0f);
				if (useBloom != 0)
				{
					//将需要bloom的存储在r通道，（注意在贴图制作中，应该满足不透明名的a为1）
					//换句话说，bloom是不透明物体的bloom
					baseTexColor.a *= tex2D(_BloomTex, i.uv).r;
				}
				//计算光照效果 
				//1.计算阴影衰减--这个可以后期添加进去，但是从源码中是没有看到设置的
				//UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);
				float atten = 1;//--临时处理重置为1，忽略阴影的影响

				//2.采样遮罩图--g通道确订明暗关系
				fixed3 lightTexColor = tex2D(_LightMapTex, i.uv.xy).rgb;
				//return lightTexColor.g;
				fixed3 secondShadowColor = baseTexColor.rgb * _SecondShadowMultColor.rgb;
				fixed3 firstShadowColor = baseTexColor.rgb * _FirstShadowMultColor.rgb;
				//2.1 通过lambert、阴影衰减和外部设定的明暗面阀值确定明暗面
				//-----通过顶点颜色和遮罩图的g通道的乘积来表示，此片元成为暗面的倾向
				fixed realMask = lightTexColor.g * i.color.r;
				float t1 = (realMask + i.lambert * atten) * 0.5f;
				//进行二分色，二分色结果t1阴影为1，非阴影为0
				//t1 = 1.0f - step(_SecondShadow, t1); //smoothstep(_SecondShadow, _SecondShadow+0.03, t1)				
				t1 = 1.0f - smoothstep(_SecondShadow-0.05,_SecondShadow, t1);
				//计算颜色，这个不就都已经 包含了亮面和暗面的颜色
				secondShadowColor = t1 * secondShadowColor + (1.0f - t1) * firstShadowColor;
				//return float4(secondShadowColor, 1);
				float4 outCo;				
				//对应的做了映射x=1.2x-0.1  y=1.25y-0.125
				fixed2 expandMask = realMask * fixed2(1.2f, 1.25f) + fixed2(-0.1f, -0.125f);
				//对阴影进行一次拆分t1为1阴影，为0非阴影，单纯的美术制作的方向的
				t1 = 1.0f - step(0.5f, realMask);
				t1 = t1 * expandMask.x + (1.0f - t1) * expandMask.y;
				//--上面是做了分段的解析t1=1.2x-0.1 {x=[0,0.5]=>[-0.1,0.5]}    t1=1.25x-0.125 {x=[0.5,1]=>[0.5,1.125]}				
				
				//将设置的阴影和光照信息结合,本次进行的
				t1 = (t1 + i.lambert * atten) * 0.5f;
				//经过此转换阴影部分为1，亮面为0
				//t1 = 1.0f - step(_LightArea, t1);//--这里处理会有锯齿，添加平滑处理
				t1 = 1.0f - smoothstep(_LightArea - 0.02,_LightArea, t1);
				//这里是在阴影处添加了另一个阴影颜色
				firstShadowColor = t1 * firstShadowColor + (1.0f - t1) *baseTexColor;
				//return float4(firstShadowColor, 1);
				//小于0.09的，t2为1，反之为0
				fixed t2 = 1.0f - step(0.09f, realMask);				
				//t2阴影部分为1，亮面为0，而这里亮面使用了
				fixed3 diffuseColor = t2 * secondShadowColor + (1.0f - t2) * firstShadowColor;

				

				//---高光区域计算
				fixed3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
				fixed3 worldHalfVec = normalize(worldViewDir + _WorldSpaceLightPos0.xyz);
				fixed3 worldNormal = normalize(i.worldNormal);

				//高光计算--
				fixed spec = pow(saturate(dot(worldNormal, worldHalfVec)), _Shininess);
				//计算高光遮罩--根据光照的数据进行高光计算。贴图中为1表示高光区域				
				spec = step(1.0f - lightTexColor.b, spec);
				//lightTexColor.r定义了高光的系数。
				fixed3 specularColor = _LightSpecColor * _SpecMulti *lightTexColor.r  * spec;
				float3 shadowEndColor = specularColor + diffuseColor;

				/*outCo.xyz = shadowEndColor.xyz;
				return outCo;*/
				
				//------特殊状态下

				float4 spBaseColor = tex2D(_SPTex, i.specialUV.xy);//uv
			//	float4 spBaseColor = tex2D(_SPTex, i.uv);
				float3 spNoiseBaseColor = tex2D(_SPNoiseTex, i.specialUV.zw).xyz;

				//return spBaseColor;
				//---u_xlat2--viewdir--（u_xlat2.xyz = (-worldPos.xyz) + _WorldSpaceCameraPos.xyz;）
				float3 cubeMapView = normalize(worldViewDir - _WorldSpaceCameraPos.xyz);
				cubeMapView = cubeMapView + spNoiseBaseColor.xyz*_SPCubeMapNoiseIntensity + _SPCubeMapOffset.xyz;
				//计算反射
				float3 cubeNormal= reflect(cubeMapView, i.worldNormal);				
				//采样CubeMap
				float3 cubeMapColor = texCUBE(_SPCubeMap, cubeNormal).xyz;
				//---特殊状态的颜色，采样的图混合颜色
				float3 spColor = spBaseColor.xzw * _SPOldColor.xyz;
				//---特殊状态的颜色混合
				cubeMapColor.xyz = cubeMapColor.xyz * _SPCubeMapColor.xyz;
				//---特殊状态下cubemap+spColor
				spColor.xyz = cubeMapColor.xyz * _SPCubeMapBrightness*_SPCubeMapIntensity+(1- _SPCubeMapIntensity)*spColor.xyz;
				
		
				//--噪声系数*流动系数
				float transitonRadio = _SPNoiseScaler * _SPTransition;
				
				//------_SPNoiseScaler*(_SPTransition*1.7-1.99*spNoiseBaseColor.x)+1
				float transitonColorRadio = transitonRadio * 1.7000000 +1- spNoiseBaseColor.x *1.99*_SPNoiseScaler;
				//return step(_SPNoiseScaler,spNoiseBaseColor.x) ;
				//---这个*10表示只留下了之前0-0.1的部分作为过渡了
				transitonColorRadio = clamp(transitonColorRadio*10,0.0, 1.0);
				//---特殊颜色和过度色的差值计算--这个差值计算解析一下
				//---因为噪声系数是不固定的为0-1，所以对于transitonRadio的有效值范围为[0-0.1],
				//-----此时spNoiseBaseColor.x为0的地方为spcolor
				float3 lerpTemp = lerp(spColor.xyz, _SPTransitionColor.xyz * _SPTransitionEmissionScaler, transitonColorRadio);
				
				//利用x,y做阀值计算，
				//----x:_SPNoiseScaler*(_SPTransition*1.7-1.99*spNoiseBaseColor.x)+1.99
				//----y:_SPNoiseScaler(_SPTransition*1.5-1.99*spNoiseBaseColor.x)+1.99
				
				float2 tempTransitonRadio = transitonRadio * float2(1.7, 1.6) - 1.99*spNoiseBaseColor.x*_SPNoiseScaler+1;
				//--非0即1，和噪声图的a通道做的比较
				tempTransitonRadio = max(0, step(0, tempTransitonRadio));
				//--对1.5为界限进行限定，注意这里的混色计算，第一次的计算时1.7，现在为1.5，就意味着会向下做偏移，比如之前大于0的部分，会变成小于0
				//--然后就会有0.2的一个偏差，第一次计算时transitonColorRadio为小于0时为spColor，这次是大于0为spColor。而中间那偏移的0.2则会为过度色
				//float3 spMixColor  = (transitonColorRadio != 0) ? spColor.xyz : lerpTemp;//tempTransitonRadio.y
				float3 spMixColor = (tempTransitonRadio.y != 0) ? spColor.xyz : lerpTemp;//tempTransitonRadio.y
				/*outCo.xyz = spMixColor;
				return outCo;*/
				//---bloom进行差值计算
				float lerpBloom = lerp(_SPTransitionBloomFactor, _BloomFactor, transitonColorRadio);

				//计算bloom数值
				//---  tempTransitonRadio,只有y为0，x不为0，才会使用到transitonRadio，否则都是_BloomFactor
				spec = (tempTransitonRadio.y != 0) ? _BloomFactor : lerpBloom;
				col.w = (tempTransitonRadio.x != 0) ? spec : _BloomFactor;
				//--计算颜色--tempTransitonRadio.x与第一次计算的系数相同，为1.7，而这里做的限定为x!=0
				spMixColor = (tempTransitonRadio.x != 0) ? spMixColor : spColor.xyz; //spColor.xyz
				

				//--与二分色计算出的阴影效果做叠加
				spMixColor.xyz= lerp(shadowEndColor, spMixColor, _SPIntensity*tempTransitonRadio.x);
				//---这里我们也看懂，_Color和_EnvColor感觉没有必要用两个了
				shadowEndColor.xyz = spMixColor.xyz * _Color.xyz * _EnvColor.xyz;


				/*outCo.xyz = shadowEndColor.xyz;
				return outCo;*/
				//---pow (clamp ((1.0 - dot(V_2, N_3)), 0.0, 1.0), _RGShininess);
				//----RimLight
				float colorRadio= _RGScale*pow(clamp((1.0 - dot(worldViewDir, worldNormal)), 0.0, 1.0), _RGShininess) + _RGBias;
				float Fresnel= clamp(colorRadio, 0.0, 1.0);
				col.xyz = lerp(shadowEndColor, colorRadio * _RGColor, Fresnel * _RGRatio);
                return col;
            }
            ENDCG
        }
    }
}
