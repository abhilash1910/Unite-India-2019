Shader "Unite-2019/Standard"
//custom standard surface shader to wrap texture over a 3d model and adding an additional color property 
// Lambert Diffuse Reflection
{
//standard properties for surface shader following Lambert cosine diffuse law
Properties{

    _MainTex("Texture",2D)="white"{}
    _Color("Color",Color)=(0,0,0,0)

}

//subshader pass
SubShader
{
//tags
Tags {"RenderType"="Opaque"}
//lod 
LOD 100

CGPROGRAM
//using Lambert diffusion shader(standard)
#pragma surface surf Lambert 
struct Input{
  float2 uv_Maintex;

};
//declaration of properties
sampler2D _MainTex;
float4 _Color; 

//implementation of the Lambert shader
void surf(Input IN,inout SurfaceOutput o)
{

   //less optimised
   fixed4 col= tex2D(_MainTex,IN.uv_Maintex)*_Color;
   o.Albedo= col.rgb;
   o.Alpha= 1;

}
ENDCG
}

Fallback "Diffuse"


}