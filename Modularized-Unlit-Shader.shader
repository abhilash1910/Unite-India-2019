Shader "Unite-2019/Modular"{

Properties{
 _MainTex("Tex",2D)="white"{}
 _Color("Color",Color)=(0,0,0,0)


}



CGINCLUDE

#include "UnityCG.cginc"

struct appdata{

 float4 vertex : POSITION;
		float3 normal : NORMAL;
    float2 uv:TEXCOORD0;
};
uniform sampler2D _MainTex;
	uniform float4 _Color;
ENDCG



	SubShader{
		//First outline
		Pass{
			Tags{  "RenderType" = "Opaque" }
			CGPROGRAM

			struct v2f {
				float4 pos : SV_POSITION;
			  float2 uv:TEXCOORD0;
      };

			#pragma vertex vert
			#pragma fragment frag

			v2f vert(appdata v) {
				
				
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			half4 frag(v2f i) : COLOR{
				return _Color;
			}

			ENDCG
		}


  }



}




