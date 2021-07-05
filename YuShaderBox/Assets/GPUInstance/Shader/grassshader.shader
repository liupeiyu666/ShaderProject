Shader "myshaders/Instancegrass"
{
    Properties
    {
        _Colorone ("Color", Color) = (1, 1, 1, 1)//根基颜色
		_Wind("_Wind",2D)="white"{}//突变风采样纹理
		_MainTex ("_MainTex", 2D) = "white" {}
		_VerticalBillboarding("Vertical Restraints", Range(0, 20)) = 1
		_Cutoff("Alpha Cutoff",Range(0,1))=0.5
		_Radius("_Radius",Range(0.1,10))=1//人物干扰半径
		//_Pos("_Pos",float)=1
		_Windvector("_Windvector",Vector)=(1,0,0,0)//风的方向（世界空间）
		_TimeScale("_TimeScale",float)=1//时间频数
		_Mapwidth("_Mapwidth",float)=80//地图大小（用来控制突变风效果）
    }
    SubShader
    {
        Tags {  "Queue" = "ALphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" "DisableBatching" = "True" }
        Pass
        {
			Tags{ "LightMode" = "ForwardBase" }
			Cull Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile_fwdbase
            #pragma multi_compile_instancing
			#pragma instancing_options nolightprobe nolightmap
            #include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
			sampler2D _MainTex;
			sampler2D _Wind;
			float4 _MainTex_ST;
			fixed _VerticalBillboarding;
			fixed _Cutoff;
			fixed4 _Colorone;
			fixed _Radius;
			//float _Pos;
			float4 _Windvector;
			float _TimeScale;
			float _Mapwidth;
            struct appdata
            {
                float4 vertex : POSITION;
				float4 texcoord : TEXCOORD0;
				float3 normal :NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 worldpos : TEXCOORD1;
				//float3 worldnormal :TEXCOORD2;
				//SHADOW_COORDS(3)
                UNITY_VERTEX_INPUT_INSTANCE_ID 
            };
            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
				UNITY_DEFINE_INSTANCED_PROP(float4,_Stepon)
            UNITY_INSTANCING_BUFFER_END(Props)
            v2f vert(appdata v)
            {
				v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.uv=v.texcoord.xy;
				o.uv=TRANSFORM_TEX(v.texcoord.xy, _MainTex);
				//o.worldnormal =  UnityObjectToWorldNormal(v.normal);
				float3 center = float3(0, 0, 0);
				float3 viewer = mul(unity_WorldToObject,float4(_WorldSpaceCameraPos,1));
				//--摄像机
				float3 normalDir = viewer - center;
				//normalDir.y = normalDir.y * _VerticalBillboarding;
				//normalDir = normalize(normalDir);
				//float3 upDir = abs(normalDir.y) > 0.9999 ? float3(0, 0, 1) : float3(0, 1, 0);
				//float3 rightDir = normalize(cross(upDir, normalDir));				
				//upDir = float3(0,1,0);
				//----锁定Y为世界Y，根据法线方向重构法线和Right
				float3 upDir = float3(0, 1, 0);
				normalDir = normalize(normalDir);
				float3 rightDir = normalize(cross(upDir, normalDir));
				normalDir= normalize(cross(rightDir, upDir));

				//----------判断扰乱中心与自己的距离，符合半径内执行偏移
				float4 stepon=UNITY_ACCESS_INSTANCED_PROP(Props,_Stepon);
				float4 worldpos=mul(unity_ObjectToWorld,float4(center,1));
				float3 dis = distance(stepon,worldpos);
				float3 circle=1-saturate(dis/_Radius);
				if(circle.x>0){
				float3 sphereDisp=worldpos-stepon;
				sphereDisp*=circle;
				v.vertex.xz+=sphereDisp.xz;
				}
				//-----------重构新的坐标位置
				float3 centerOffs = v.vertex.xyz - center;
				float3 localPos = center + rightDir * centerOffs.x + upDir * centerOffs.y+ normalDir * centerOffs.z;
				//---根据贴图获取风力的系数，但是这样的话，一个植被的位置一旦确定，则基础风力就已经确定了
				//float windmutation =1-tex2Dlod(_Wind,float4(worldpos.x/_Mapwidth+_Time.x,worldpos.z/_Mapwidth,0,0)).b;
				float windmutation = 1 - tex2Dlod(_Wind, float4(worldpos.x / _Mapwidth, worldpos.z / _Mapwidth, 0, 0)).b;
				//windmutation = _VerticalBillboarding;
				float time=(_Time.y)*(_TimeScale);
				//---获取风力的方向
				//float4 localwindvector=normalize(mul(unity_WorldToObject,_Windvector));
				float4 localwindvector = (mul(unity_WorldToObject, _Windvector));
				//--计算偏移
				//---因为草的根部是不摆动的，风吹草不会左右摆，而是向左/右摆动，然后回到中间所以用cos修正

				//localPos= localPos+ _VerticalBillboarding*sin(time+windmutation*10)*cos(time*2/3+1+windmutation*10)*localwindvector.xyz*clamp(v.texcoord.y-0.5,0,1);
				localPos = localPos + normalize(localwindvector)*_VerticalBillboarding * sin(time + windmutation * 10)*cos(time * 2 / 3 + 1 + windmutation * 10)*clamp(v.texcoord.y-0.7 , 0, 1);
				o.pos = UnityObjectToClipPos(float4(localPos, 1));

				//o.worldpos = mul(unity_ObjectToWorld,float4(localPos,1));
				//TRANSFER_SHADOW(o);
				return o;
            }
            fixed4 frag(v2f i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i);
                fixed4 c = tex2D(_MainTex, i.uv);
				clip(c.a-_Cutoff);
				//---
				c = c * _Colorone;
				//c=lerp(UNITY_ACCESS_INSTANCED_PROP(Props,_Color), c*_Colorone,1-i.uv.y+0.5);
				//UNITY_LIGHT_ATTENUATION(atten, i, i.worldpos);
				//c.rgb*=lerp(0.5,1,atten);
				return c;
            }
            ENDCG
        }
    }
	//FallBack "Transparent/Cutout/VertexLit"
}