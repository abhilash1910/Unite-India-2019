Shader "Unite-2019/Alpha-test"{

//Simple alpha test to cut out pixels have alpha less than 0.5

Properties{

_MainTex("Base(RGB)Transparency(A)",2D)="white" {}
_Cutoff ("Alpha cutoff", Range (0,1)) = 0.5


}
SubShader{

Pass{
   AlphaTest  Greater [_Cutoff]


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
        //float4 _Color;
        float _Cutoff;
 

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
         fixed4 color=tex2D(_MainTex,i.uv);
         color.a=abs(_Cutoff * sin(_Time.y));
            return color;
     }




        ENDCG
   

}

}

















}