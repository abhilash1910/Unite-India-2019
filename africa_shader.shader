Shader "Unite-2019/shader"{


//properties
Properties{

   _MainTexture("Hello this is my main texture",2D)="white"{}
   _Color("Color",Color)=(1,1,1,1)




}

//subshaders
//platform specific shaders
Subshader{

//passes-drawcalls
  Pass
  {
      //header inclusions
    CGPROGRAM
    #pragma vertex vertexfunction
    #pragma fragment fragmentfunction

    #include "UnityCG.cginc"
    
//appdata structure
    struct appdata{

       float4 position:POSITION;
    float2 uv:TEXCOORD0;
     float3 normal:NORMAL;
    };

//preprocessor structure for passing the attributes to the fragment shader
    struct v2f{

     float4 position:SV_POSITION;
     float2 uv:TEXCOORD0;




    };

    //variables
    sampler2D _MainTexture;
    float4 _Color;


    //preprocess our vertex attributes to send to fragment shader

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
       return color;



    }













    ENDCG
    




  }
    







}


















}