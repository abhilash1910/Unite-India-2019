Shader "Unite-2019/template-modularized-Shader"{
//properties to be displayed in Unity editor for tweaking
Properties{

  _MainTexture("Texture",2D)="white"{}
  _Color("Color",Color)=(0,0,0,0)
  _Transparency("Transparent",Range(0.0,1.0))=0.5
  //more properties to be added
    
}



CGINCLUDE

#include "UnityCG.cginc"

struct appdata{

 float4 position : POSITION;
		float3 normal : NORMAL;
    float2 uv:TEXCOORD0;
};
uniform sampler2D _MainTexture;
	uniform float4 _Color;
   uniform  float _Transparency;
    




ENDCG

//declares the subshader which has the vertex and fragment shaders
Subshader{

   //tags
   Tags {"RenderType"="Opaque"}
   //LOD
   LOD 100
   //other tag properties Zwrite,Cull,etc
     //pass 
   Pass{
    

    //CG PROGRAM

     CGPROGRAM
   #pragma vertex vertexfunction
    #pragma fragment fragmentfunction

    
//preprocessor structure for passing the attributes to the fragment shader
    struct v2f{

     float4 position:SV_POSITION;
     float2 uv:TEXCOORD0;
    };

    
    v2f vertexfunction(appdata IN)
    {
         v2f OUT;
//UNITY_MATRIX_MVP
            OUT.position = UnityObjectToClipPos(IN.position);
            OUT.uv=IN.uv;

        return OUT;
    }

    //here comes the beautiful part
    //fragment shader
    fixed4 fragmentfunction(v2f i):SV_Target{

       float4 color=tex2D(_MainTexture,i.uv)*_Color;
       color.a= _Transparency;
       return color;

    }








    ENDCG


   }





}



}