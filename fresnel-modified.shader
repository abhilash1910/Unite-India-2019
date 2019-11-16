Shader "Unite-2019/Fresnel-Shader"{


Properties
{

  _MainTex("Texture",2D)="white"{}
  _Color("Color",Color)=(0,0,0,0)
  _FresnelBias("Fresnel Bias",Range(0.0,1.0))=0.0
  _FresnelColor("Fresnel Color",Color)=(0,0,0,0)
  _FresnelScale("Fresnel Scale",float)=1
  _FresnelPower("Fresnel Power",float)=1


}


SubShader{


Tags{ "RenderType"="Opaque" "Queue"="Geometry" "IgnoreProjector"="True"}

LOD 100

Cull Back
Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			#include "UnityCG.cginc"

			struct appdata_t
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
				half3 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				half2 uv : TEXCOORD0;
				float fresnel : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _Color;
			fixed4 _FresnelColor;
			fixed _FresnelBias;
			fixed _FresnelScale;
			fixed _FresnelPower;

      v2f vert(appdata_t v)
      {
        v2f o;
        o.pos = UnityObjectToClipPos(v.pos);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
  float3 i= normalize(ObjSpaceViewDir(v.pos));
  o.fresnel= _FresnelBias + _FresnelScale*(pow(1+dot(i,v.normal),_FresnelPower));
return o;
      }

      fixed4 frag(v2f i):SV_TARGET{

        fixed4 c = tex2D(_MainTex, i.uv) * _Color;
        return lerp(c,_FresnelColor, 1 - i.fresnel);

      }
ENDCG
    }



}
}