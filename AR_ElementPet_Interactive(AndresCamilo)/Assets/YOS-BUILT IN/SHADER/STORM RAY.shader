// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YOS/STORM"
{
	Properties
	{
		_Distorttext1("Distorttext1", 2D) = "white" {}
		_DistortText2("DistortText2", 2D) = "white" {}
		_Distortspeed("Distort  speed", Vector) = (1,0.05,0.5,0.05)
		_maintex("maintex", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _maintex;
		uniform float4 _maintex_ST;
		uniform sampler2D _DistortText2;
		uniform float4 _DistortText2_ST;
		uniform float4 _Distortspeed;
		uniform sampler2D _Distorttext1;
		uniform float4 _Distorttext1_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv0_maintex = i.uv_texcoord * _maintex_ST.xy + _maintex_ST.zw;
			float2 uv0_DistortText2 = i.uv_texcoord * _DistortText2_ST.xy + _DistortText2_ST.zw;
			float4 temp_cast_1 = (1.0).xxxx;
			float2 temp_cast_2 = (( _Time.y * 1.25 * _Distortspeed.z )).xx;
			float4 temp_cast_3 = (1.0).xxxx;
			float2 uv0_Distorttext1 = i.uv_texcoord * _Distorttext1_ST.xy + _Distorttext1_ST.zw;
			float4 temp_cast_4 = (1.0).xxxx;
			float2 temp_cast_5 = (( _Time.y * 1.4 * _Distortspeed.x )).xx;
			float4 temp_cast_6 = (1.0).xxxx;
			float4 tex2DNode43 = tex2D( _maintex, ( float4( uv0_maintex, 0.0 , 0.0 ) + ( ( ( ( tex2D( _DistortText2, ( uv0_DistortText2 + ( _Time.y * _Distortspeed.z ) ) ) * 2.0 ) - temp_cast_1 ) + ( ( tex2D( _DistortText2, ( ( uv0_DistortText2 - temp_cast_2 ) + float2( 0.3,0.7 ) ) ) * 2.0 ) - temp_cast_3 ) ) * _Distortspeed.w ) + ( ( ( ( tex2D( _Distorttext1, ( uv0_Distorttext1 + ( _Distortspeed.x * _Time.y ) ) ) * 2.0 ) - temp_cast_4 ) + ( ( tex2D( _Distorttext1, ( ( uv0_Distorttext1 - temp_cast_5 ) + float2( 0.4,0.6 ) ) ) * 2.0 ) - temp_cast_6 ) ) * _Distortspeed.y ) ).rg );
			float ifLocalVar53 = 0;
			UNITY_BRANCH 
			if( tex2DNode43.r > 0.05 )
				ifLocalVar53 = tex2DNode43.r;
			o.Emission = ( _Color0 * ifLocalVar53 * 2.0 ).rgb;
			o.Alpha = ifLocalVar53;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
252;111;999;908;-171.0139;565.0815;2.537438;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;9;-1071.12,38.36577;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;4;-1108.688,-473.1541;Float;False;Property;_Distortspeed;Distort  speed;3;0;Create;True;0;0;False;0;1,0.05,0.5,0.05;0.1,0.02,0.01,0.02;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-644.7421,-161.0643;Float;False;0;14;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-523.097,806.143;Float;False;0;25;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-335.5036,1447.757;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;1.25;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-408.9925,123.3939;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;1.4;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-0.5715473,1451.24;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;19;-169.8729,376.8937;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0.4,0.6;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;16;-167.1921,44.09388;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-353.5425,-621.2639;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;42;115.0372,1727.921;Float;False;Constant;_Vector1;Vector 1;1;0;Create;True;0;0;False;0;0.3,0.7;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-402.0865,1036.489;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-141.6428,-262.4644;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;14;-70.14265,-632.9642;Float;True;Property;_Distorttext1;Distorttext1;1;0;Create;True;0;0;False;0;2daa246fc13f9b147b367da3cd1aeca1;2daa246fc13f9b147b367da3cd1aeca1;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;348.9005,1599.606;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;25;-122.3284,666.3681;Float;True;Property;_DistortText2;DistortText2;2;0;Create;True;0;0;False;0;2daa246fc13f9b147b367da3cd1aeca1;2daa246fc13f9b147b367da3cd1aeca1;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-145.9706,1011.379;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;61.60828,307.9937;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;582.8577,1016.251;Float;False;Constant;_Float5;Float 5;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;212.8,-493.9999;Float;True;Property;_distort1;distort1;0;0;Create;True;0;0;False;0;2daa246fc13f9b147b367da3cd1aeca1;2daa246fc13f9b147b367da3cd1aeca1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;690.7455,1491.595;Float;False;Constant;_Float7;Float 7;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;456.9787,1252.668;Float;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;False;0;2daa246fc13f9b147b367da3cd1aeca1;2daa246fc13f9b147b367da3cd1aeca1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;204.6079,-41.70615;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;2daa246fc13f9b147b367da3cd1aeca1;2daa246fc13f9b147b367da3cd1aeca1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;401.7574,-253.3644;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;425.6077,302.1436;Float;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;349.0909,777.3249;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;2daa246fc13f9b147b367da3cd1aeca1;2daa246fc13f9b147b367da3cd1aeca1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;864.9453,1312.194;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;24;575.1077,382.7437;Float;False;Constant;_Float3;Float 3;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;551.2574,-172.7643;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;732.3577,1096.851;Float;False;Constant;_Float4;Float 4;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;840.2455,1572.194;Float;False;Constant;_Float6;Float 6;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;757.0575,836.8507;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;599.8075,122.7437;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;575.9572,-432.7643;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;37;1121.046,1115.786;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;1087.922,676.4404;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;1012.044,-105.8251;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;1024.818,266.9268;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;1686.984,1292.8;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;1677.552,645.1796;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;1647.537,373.8116;Float;True;0;43;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;1917.476,990.1572;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;2014.163,1358.51;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;2303.466,851.9052;Float;True;3;3;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;43;1751.58,119.464;Float;True;Property;_maintex;maintex;4;0;Create;True;0;0;False;0;06f003342a5cdef44a24424f77142563;f9254a96bc53bb54a96ed9c3e5f0d295;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;51;2055.266,-151.1734;Float;False;Property;_Color0;Color 0;5;1;[HDR];Create;True;0;0;False;0;1,0,0,0;191.749,14.0549,14.0549,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;2311.016,440.4684;Float;False;Constant;_Float8;Float 8;6;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;53;2097.836,326.4373;Float;True;True;5;0;FLOAT;0;False;1;FLOAT;0.05;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;2354.36,-35.32697;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2802.123,44.27671;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;YOS/STORM;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;9;0
WireConnection;40;2;4;3
WireConnection;18;0;9;0
WireConnection;18;2;4;1
WireConnection;39;0;27;0
WireConnection;39;1;40;0
WireConnection;16;0;5;0
WireConnection;16;1;18;0
WireConnection;8;0;4;1
WireConnection;8;1;9;0
WireConnection;28;0;9;0
WireConnection;28;1;4;3
WireConnection;6;0;5;0
WireConnection;6;1;8;0
WireConnection;41;0;39;0
WireConnection;41;1;42;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;20;0;16;0
WireConnection;20;1;19;0
WireConnection;1;0;14;0
WireConnection;1;1;6;0
WireConnection;34;0;25;0
WireConnection;34;1;41;0
WireConnection;15;0;14;0
WireConnection;15;1;20;0
WireConnection;26;0;25;0
WireConnection;26;1;29;0
WireConnection;38;0;34;0
WireConnection;38;1;36;0
WireConnection;33;0;26;0
WireConnection;33;1;31;0
WireConnection;21;0;15;0
WireConnection;21;1;23;0
WireConnection;10;0;1;0
WireConnection;10;1;11;0
WireConnection;37;0;38;0
WireConnection;37;1;35;0
WireConnection;32;0;33;0
WireConnection;32;1;30;0
WireConnection;12;0;10;0
WireConnection;12;1;13;0
WireConnection;22;0;21;0
WireConnection;22;1;24;0
WireConnection;47;0;32;0
WireConnection;47;1;37;0
WireConnection;45;0;12;0
WireConnection;45;1;22;0
WireConnection;46;0;45;0
WireConnection;46;1;4;2
WireConnection;48;0;47;0
WireConnection;48;1;4;4
WireConnection;49;0;44;0
WireConnection;49;1;48;0
WireConnection;49;2;46;0
WireConnection;43;1;49;0
WireConnection;53;0;43;1
WireConnection;53;2;43;1
WireConnection;50;0;51;0
WireConnection;50;1;53;0
WireConnection;50;2;52;0
WireConnection;0;2;50;0
WireConnection;0;9;53;0
ASEEND*/
//CHKSM=B901309FEC66BF68A0FE97E9F3841D64BF9A5814