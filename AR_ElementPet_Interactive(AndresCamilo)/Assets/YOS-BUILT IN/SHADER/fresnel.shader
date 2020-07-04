// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YOS/FRESNEL"
{
	Properties
	{
		[HDR]_Color0("Color 0", Color) = (0,0.2251563,1,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_SHIELDRIM("SHIELD RIM", Range( 0 , 2.5)) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample1;
		uniform float _SHIELDRIM;
		uniform sampler2D _TextureSample0;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV1, _SHIELDRIM ) );
			float lerpResult7 = lerp( 0.0 , fresnelNode1 , fresnelNode1);
			float cos21 = cos( 0.2 * _Time.y );
			float sin21 = sin( 0.2 * _Time.y );
			float2 rotator21 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos21 , -sin21 , sin21 , cos21 )) + float2( 0.5,0.5 );
			float2 panner24 = ( 0.2 * _Time.y * float2( 0.5,0.5 ) + rotator21);
			float blendOpSrc17 = lerpResult7;
			float blendOpDest17 = ( tex2D( _TextureSample0, panner24 ).r * 0.2 );
			float2 appendResult19 = (float2((( blendOpSrc17 > 0.5 )? ( blendOpDest17 + 2.0 * blendOpSrc17 - 1.0 ) : ( blendOpDest17 + 2.0 * ( blendOpSrc17 - 0.5 ) ) ) , 0.0));
			o.Emission = ( _Color0 * tex2D( _TextureSample1, appendResult19 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
706;480;1906;887;387.9623;-18.60568;1.792618;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-882.6573,267.7871;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;21;-615.5508,423.8336;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;0.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-884.7173,41.0677;Float;False;Property;_SHIELDRIM;SHIELD RIM;2;0;Create;True;0;0;False;0;0;0.46;0;2.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;24;-620.657,635.7871;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;0.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;1;-415,-6.5;Float;True;Standard;TangentNormal;ViewDir;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-30.24089,421.4323;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;2c97a2e99b33ee04f96b4d4f2d7f03b1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;7;207.8079,177.3928;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;325.0784,459.1942;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;17;647.8829,372.7404;Float;True;LinearLight;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;973.4036,572.3957;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;18;710.983,98.44019;Float;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;None;c66e1c0c68135014f8fe69f7bea19a7c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;531,-287.5;Float;False;Property;_Color0;Color 0;0;1;[HDR];Create;True;0;0;False;0;0,0.2251563,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1035.343,-224.2129;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;10;1295.9,-239.4;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;YOS/FRESNEL;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;22;0
WireConnection;24;0;21;0
WireConnection;1;3;11;0
WireConnection;5;1;24;0
WireConnection;7;1;1;0
WireConnection;7;2;1;0
WireConnection;8;0;5;1
WireConnection;17;0;7;0
WireConnection;17;1;8;0
WireConnection;19;0;17;0
WireConnection;18;1;19;0
WireConnection;23;0;2;0
WireConnection;23;1;18;0
WireConnection;10;2;23;0
ASEEND*/
//CHKSM=46800B8295F5116DC5D634A88E9276BFF6B68173