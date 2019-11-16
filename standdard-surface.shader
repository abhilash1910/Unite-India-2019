Shader "Standard-Lambert/Diffuse Texture" {
    Properties {

      _MainTex ("Texture", 2D) = "white" {}
      _Color("Color",Color)=(1,1,1,1)
    
    }
    //subshader
    SubShader {
      
      
      Tags { "RenderType" = "Opaque" }
      LOD 120
      //pass
    
      CGPROGRAM
      #pragma surface surf Lambert
      
      
      //struct
      struct Input {
      
          float2 uv_MainTex;
      
      
      };
      sampler2D _MainTex;
      float4 _Color;
      //function
      void surf (Input IN, inout SurfaceOutput o) {
          half4 color = tex2D (_MainTex, IN.uv_MainTex)*_Color;
          o.Albedo=color.rgb;
      }
      
      
      ENDCG
      
      
      
    } 
    Fallback "Diffuse"
  }