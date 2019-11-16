Shader "Unite-2019/Ripple"{

 Properties{

  _MainTex("Texture",2D)="white"{}
  _Scale("Scale",float)=1
  _Frequency("Frequency",float)=1
  _Speed("Speed",float)=1


 }

 SubShader{
     Tags { "RenderType"="Opaque"}
  LOD 100



    
   CGPROGRAM 
   
      #pragma surface surf Lambert vertex:vert
      sampler2D _MainTex;
      float4 _Scale;
      float _Speed;
      float _Frequency;
      
      
      //struct
      struct Input {
      
          float2 uv_MainTex;
          //float3 customValue;
      
      
      };

      void vert(inout appdata_full v)
      {
          half offset= v.vertex.x + v.vertex.z;
          half val = _Scale* sin(_Time.w * _Speed + offset*_Frequency);
          v.vertex.y+=val;

      }
      
      //function
      void surf (Input IN, inout SurfaceOutput o) {
          half4 color = tex2D (_MainTex, IN.uv_MainTex);
          o.Albedo=color.rgb;
          o.Alpha=color.a;
      }
      ENDCG
      
 }

Fallback "Diffuse"







 










}