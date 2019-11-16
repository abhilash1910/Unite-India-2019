Shader "Unite-2019/edge-detect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color",Color)=(1,1,1,1)
        _OutlineColor("outline-color",color)=(0,0,0,1)
        _OutlineWidth("outline-width",Range(0.0,0.1))=0.05

    }
CGINCLUDE
#include "UnityCG.cginc"
struct appdata{

float4 vertex:POSITION;
//float3 normal:NORMAL;
float2 uv:TEXCOORD0;

};


struct v2f{

    float4 position:POSITION;
        float2 uv:TEXCOORD0;

};

float _OutlineWidth;
float4 _OutlineColor;
sampler2D _MainTex;
float4 _Color;






ENDCG




    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" }
        
        
        LOD 100



        Pass
        {
            ZWrite Off
            Cull Back


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            // make fog work
           // #pragma multi_compile_fog

            //#include "UnityCG.cginc"

            v2f vert (appdata v)
            {appdata original =v;


            v.vertex.xyz+= _OutlineWidth*normalize(v.vertex.xyz);
                v2f o;
                
                o.position = UnityObjectToClipPos(v.vertex);
//v.vertex.xyz+= 0.02*normalize(v.vertex.xyz);
  //           o.position = UnityObjectToClipPos(v.vertex);
              //  o.uv = TRANSFORM_TEX(v.uv, _MainTex);
               // UNITY_TRANSFER_FOG(o,o.position);
                o.uv=v.uv;
                return o;
            }

            half4 frag (v2f i) : COLOR
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv)*_Color;
                // apply fog
               // UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            
          

            ENDCG





        }
    

Tags{ "RenderType" = "Opaque"}
	CGPROGRAM
		#pragma surface surf Standard
        #pragma target 2.0
		 
		struct Input {
			float2 uv_MainTex:TEXCOORD0;
		};
		 
		void surf (Input IN, inout SurfaceOutputStandard o) {
			//fixed4 c = _Color;
			o.Albedo = _Color.rgb;
			o.Alpha = 1;
		}
	ENDCG
	
}
	Fallback "Diffuse"
       
      


}
