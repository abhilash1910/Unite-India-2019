Shader "Unite-2019/Use-Pass"{

//Use -Pass Demo for reducing code complexity
  Properties{

_MainTex ("Texture", 2D) = "white" {}
        _color("Color",color)=(1,1,1,1)
        _Transparent("Transparency",float)=0.0
  }

CGINCLUDE

 #include "UnityCG.cginc"

 struct appdata
         {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };


sampler2D _MainTex;
float4 _color;
float _Transparent;
ENDCG
SubShader{
Tags{"RenderType"="Opaque"}

   UsePass "Unite-2019/disintegrate-modified/Disintegrate-Mod"
//Subsequently use more passes



}



}