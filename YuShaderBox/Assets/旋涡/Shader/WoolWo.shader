Shader "Yu/WoolWo"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex VSMain
			#pragma fragment PSMain
			#pragma target 3.0

			#define TWO_PI 6.283185
			#define PI 3.14159265359

			struct Ray
			{
			   float3 origin;
			   float3 direction;
			};

			struct LightColor
			{
				float3 diffuse;
				float3 specular;
			};

			struct Material
			{
				LightColor color;
				float shininess;
			};

			struct MapValue
			{
				float signedDistance;
				Material material;
			};

			struct Trace
			{
				float dist;
				float3 p;
				Ray ray;
				Material material;
			};

			struct PointLight
			{
				float3 position;
				LightColor color;
			};

			struct DirectionalLight
			{
				float3 direction;
				LightColor color;
			};

			PointLight  light1,light2,light3;
			DirectionalLight dirLight;
			Material blackMat, whiteMat, bluishMat, yellowMat, oscMat, tableMat, tableDarkMat;

			float3 rayPoint(Ray r,float t)
			{
				return r.origin + t * r.direction;
			}

			float smoothmin(float a, float b, float k)
			{
				float x = exp(-k * a);
				float y = exp(-k * b);
				return (a * x + b * y) / (x + y);
			}

			float smoothmax(float a, float b, float k)
			{
				return smoothmin(a,  b, -k);
			}

			MapValue intersectObjects(MapValue d1, MapValue d2)
			{
				float sd = smoothmax(d1.signedDistance,d2.signedDistance, 3.0);
				MapValue mv;
				mv.material = d1.material;
				mv.signedDistance = sd;
				return mv;
			}

			float smin(float a, float b, float k)
			{
				float h = clamp(0.5 + 0.5*(b - a) / k, 0.0, 1.0);
				return lerp(b, a, h) - k * h*(1.0 - h);
			}

			MapValue subtractObjects(MapValue d1, MapValue d2)
			{
				d1.signedDistance = -d1.signedDistance;
				return intersectObjects(d1, d2);
			}

			void setMaterials()
			{
				float t = _Time.g;
				float s = 0.4*(1.0 + sin(t));
				float3 specular = float3(0.3,0.3,0.3);
				blackMat.color.diffuse = float3(0.0,0.0,0.01);
				blackMat.color.specular = float3(0.1,0.1,0.1);
				blackMat.shininess = 35.0;
				whiteMat.color.diffuse = 0.75*float3(1.0,1.0,0.9);
				whiteMat.color.specular = 0.3*float3(1.0,1.0,0.9);
				whiteMat.shininess = 16.0;
			}

			MapValue cube(float3 p, float d , Material m)
			{
				MapValue mv;
				mv.material = m;
				mv.signedDistance = length(max(abs(p) - d,0.0));
				return mv;
			}

			MapValue xzPlane(float3 p ,float y, Material m)
			{
				MapValue mv;
				mv.material = m;
				mv.signedDistance = p.y - y;
				return mv;
			}

			MapValue plane(float3 p, float3 origin, float3 normal , Material m)
			{
				float3 a = p - origin;
				MapValue mv;
				mv.material = m;
				mv.signedDistance = dot(a,normal);
				return mv;
			}

			float spiralWave(float2 p, float ratio, float rate, float scale)
			{
				float r = length(p);
				float theta = atan2(p.x,p.y);
				float logspiral = log(r) / ratio + theta;
				return sin(rate*_Time.g + scale * logspiral);
			}

			MapValue vortex(float3 p ,float3 c, Material m)
			{
				MapValue mv;
				mv.material = m;
				float2 v = p.xz - c.xz;
				float h1 = 0.03* spiralWave(v,0.618,3.0,5.0);
				float theta = 2.45*_Time.g;
				float2 orbit = 0.2*float2(sin(theta),cos(theta));
				float h2 = 0.02*spiralWave(v + orbit,0.618,6.53,6.0);
				mv.signedDistance = length(v) - exp(p.y + c.y + h1 + h2);
				return mv;
			}

			MapValue sphere(float3 p, float3 center, float radius, Material m)
			{
				MapValue mv;
				mv.material = m;
				mv.signedDistance = distance(p, center) - radius;
				return mv;
			}

			MapValue addObjects(MapValue d1, MapValue d2)
			{
				if (d1.signedDistance < d2.signedDistance)
					return d1;
				else
					return d2;
			}

			MapValue map(float3 p)
			{
				float t = _Time.g;
				MapValue vtx = vortex(p,float3(0.0,0.3,0.0), whiteMat);
				MapValue pl = plane(p,float3(0.0,0.0,0.0),float3(0.0,1.0,0.0) ,whiteMat);
				MapValue obj = subtractObjects(vtx,pl);
				return obj;
			}

			float3 calculateNormal(float3 p)
			{
				float epsilon = 0.001;
				float3 normal = float3(map(p + float3(epsilon,0,0)).signedDistance - map(p - float3(epsilon,0,0)).signedDistance,
					map(p + float3(0,epsilon,0)).signedDistance - map(p - float3(0,epsilon,0)).signedDistance,
					map(p + float3(0,0,epsilon)).signedDistance - map(p - float3(0,0,epsilon)).signedDistance);
				return normalize(normal);
			}

			Trace traceRay(in Ray ray, float maxDistance)
			{
				float dist = 0.01;
				float presicion = 0.002;
				float3 p;
				MapValue mv;
				for (int i = 0; i < 64; i++)
				{
					p = rayPoint(ray,dist);
					mv = map(p);
					dist += 0.5*mv.signedDistance;
					if (mv.signedDistance < presicion || dist>maxDistance) break;
				}
				Trace t;
				t.dist = dist;
				t.p = p;
				t.ray = ray;
				t.material = mv.material;
				return t;
			}

			float castShadow(in Ray ray, float dist)
			{
				Trace trace = traceRay(ray,dist);
				float maxDist = min(1.0,dist);
				float result = trace.dist / maxDist;
				return clamp(result,0.0,1.0);
			}

			Ray cameraRay(float3 viewPoint, float3 lookAtCenter, float2 p , float d)
			{
				float3 v = normalize(lookAtCenter - viewPoint);
				float3 n1 = cross(v,float3(0.0,1.0,0.0));
				float3 n2 = cross(n1,v);
				float3 lookAtPoint = lookAtCenter + d * (p.y*n2 + p.x*n1);
				Ray ray;
				ray.origin = viewPoint;
				ray.direction = normalize(lookAtPoint - viewPoint);
				return ray;
			}

			float3 diffuseLighting(in Trace trace, float3 normal, float3 lightColor,float3 lightDir)
			{
				float lambertian = max(dot(lightDir,normal), 0.0);
				return  lambertian * trace.material.color.diffuse * lightColor;
			}

			float3 specularLighting(in Trace trace, float3 normal, float3 lightColor,float3 lightDir)
			{
				float3 viewDir = -trace.ray.direction;
				float3 halfDir = normalize(lightDir + viewDir);
				float specAngle = max(dot(halfDir, normal), 0.0);
				float specular = pow(specAngle, trace.material.shininess);
				return specular * trace.material.color.specular * lightColor;
			}

			float3 pointLighting(in Trace trace, float3 normal, PointLight light)
			{
				float3 lightDir = light.position - trace.p;
				float d = length(lightDir);
				lightDir = normalize(lightDir);
				float3 color = diffuseLighting(trace, normal, light.color.diffuse, lightDir);
				color += specularLighting(trace, normal, light.color.specular, lightDir);
				float  attenuation = 1.0 / (1.0 + 0.1 * d * d);
				Ray r;
				r.origin = trace.p;
				r.direction = lightDir;
				float shadow = castShadow(r,d);
				color *= attenuation * shadow;
				return  color;
			}

			float3 directionalLighting(Trace trace, float3 normal, DirectionalLight light)
			{
				float3 color = diffuseLighting(trace, normal, light.color.diffuse, light.direction);
				color += specularLighting(trace, normal, light.color.specular, light.direction);
				Ray ray;
				ray.origin = trace.p;
				ray.direction = light.direction;
				float shadow = castShadow(ray,3.0);
				color *= shadow;
				return  color;
			}

			void setLights()
			{
				float  time = _Time.g;
				float3 specular = float3(0.7,0.7,0.7);
				light1.position = float3(cos(1.3*time),1.0,sin(1.3*time));
				light1.color.diffuse = float3(0.7,0.7,0.7);
				light1.color.specular = specular;
				light2.position = float3(0.7*cos(1.6*time),1.1 + 0.35*sin(0.8*time),0.7*sin(1.6*time));
				light2.color.diffuse = float3(0.6,0.6,0.6);
				light2.color.specular = specular;
				light3.position = float3(1.5*cos(1.6*time),0.15 + 0.15*sin(2.9*time),1.5*sin(1.6*time));
				light3.color.diffuse = float3(0.6,0.6,0.6);
				light3.color.specular = specular;
				dirLight.direction = normalize(float3(0.0,1.0,0.0));
				dirLight.color.diffuse = float3(0.1,0.1,0.1);
				dirLight.color.specular = float3(0.5,0.5,0.5);
			}

			float3 lighting(in Trace trace, float3 normal)
			{
				float3 color = float3(0.01,0.01,0.1);
				color += pointLighting(trace, normal,light1);
				color += pointLighting(trace, normal,light2);
				color += pointLighting(trace, normal,light3);
				color += directionalLighting(trace, normal,dirLight);
				return color;
			}

			float3 render(float2 p)
			{
				float3 viewpoint = float3(-1.7,1.4,-1.9);
				float3 lookAt = float3(0.0,-0.1,0.0);
				Ray ray = cameraRay(viewpoint,lookAt,p,2.3);
				Trace trace = traceRay(ray,12.0);
				float3 normal = calculateNormal(trace.p);
				float3 color = lighting(trace,normal);
				return color;
			}

			void VSMain(inout float4 vertex:POSITION, inout float2 uv0 : TEXCOORD0)
			{
				vertex = UnityObjectToClipPos(vertex);
			}

			float4 PSMain(float4 vertex:POSITION, float2 uv0 : TEXCOORD0) : SV_TARGET
			{
				float2 p = float2(1.2*uv0.xy - 0.6);
				setLights();
				setMaterials();
				float3 colorLinear = render(p);
				float screenGamma = 2.2;
				float3 colorGammaCorrected = pow(colorLinear, float3(1.0 / screenGamma,1.0 / screenGamma,1.0 / screenGamma));
				return float4(colorGammaCorrected,1.0);
			}
			ENDCG
		}
	}
}
