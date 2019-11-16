//Depth writing to ZWrite 
Shader "Unite-2019/Show Depth"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
	}
//sunshader opaque
	SubShader
	{
		Tags
		{
			"RenderType"="Opaque"
		}

		ZWrite On

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float depth : DEPTH;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//normalizing the view within the clipping planes
				o.depth = -mul(UNITY_MATRIX_MV, v.vertex).z *_ProjectionParams.w;
				return o;
			}
			
			half4 _Color;

			fixed4 frag (v2f i) : SV_Target
			{
				float invert = 1 - i.depth;
				return fixed4(invert, invert, invert, 1) * _Color;
			}
			ENDCG
		}
	}
//Subshader transparent
	SubShader
	{
		Tags
		{
			"RenderType"="Transparent"
		}

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			half4 _Color;

			fixed4 frag (v2f i) : SV_Target
			{
				return _Color;
			}
			ENDCG
		}
	}
}
