﻿Shader "Unite-2019/disintegrate"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _color("Color",color)=(1,1,1,1)
        _Transparent("Transparency",float)=0.0
        
    }




    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent"}
        LOD 100
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
         
        Lighting Off
        //ColorMask Optimization
        ColorMask RGB


        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

sampler2D _MainTex;
float4 _color;
float _Transparent;
            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

          
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv)*_color ;
                
                        
                        _Transparent=_Transparent*(_Time.y*5000);
                        if(_Transparent<8)
                {
                        col.a=_Transparent;
                }
                
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
