Shader "Transparent/Unlit/Africa/transparent"{

//properties
Properties{

     _MainTex("Main Texture",2D)="white"{}
     _Color("Color",Color)=(1,1,1,1)
     _Transparent("Transparent",Range(0.0,0.5))=0.25



}


//Subshadder
SubShader{

  Tags {"Queue"="Transparent" "RenderType"="Transparent"}
  LOD 100

    ZWrite Off
    Blend SrcAlpha OneMinusSrcAlpha


  Pass{

      CGPROGRAM
    #pragma vertex vertexfunction
    #pragma fragment fragmentfunction
    #include "UnityCG.cginc"


     struct appdata{

         float4 vertex:POSITION;
         float2 uv:TEXCOORD0;
         float3 normal:NORMAL;


     };
        //initialise the variables
        sampler2D _MainTex;
        float4 _Color;
        float _Transparent;
 

     struct v2f{
         

         float4 vertex:SV_POSITION;
         float2 uv:TEXCOORD0;
     };

     v2f vertexfunction(appdata IN)
     {
          v2f OUT;

          OUT.vertex= UnityObjectToClipPos(IN.vertex);
          OUT.uv=IN.uv;



          return OUT;


     }



     fixed4 fragmentfunction(v2f i) :SV_Target
     {
         fixed4 color=tex2D(_MainTex,i.uv)* _Color;
         color.a=abs(_Transparent * sin(_Time.y));
            return color;
     }




        ENDCG
  }






}

  



















}