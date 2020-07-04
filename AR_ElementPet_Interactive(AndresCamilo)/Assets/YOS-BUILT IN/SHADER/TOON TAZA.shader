// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YOS/TOONGR"
{
	Properties
	{
		_Distort("Distort", 2D) = "white" {}
		_SpeedAnimUVxDistort("Speed Anim UVx Distort", Float) = 0
		_Mask("Mask", 2D) = "white" {}
		_SpeddAnimUVxMask("Spedd Anim UVx Mask", Float) = 0
		_PowMask("Pow Mask", Range( 0 , 5)) = 0.2
		_MultiplyMask("Multiply Mask", Range( 0 , 1)) = 0
		_Destructor("Destructor", Range( 1 , 20)) = 1
		_alphaacero("alphaacero", Range( 0 , 1)) = 0
		_OpacidadTotal("OpacidadTotal", Range( 0 , 1.55)) = 0
		[HDR]_Color("Color", Color) = (1,0,0,0)
		[HDR]_ColorExterno("ColorExterno", Color) = (0,0,0,0)
		_DifColores("DifColores", Float) = 0.93
		_OpacidadCOlorinterno("OpacidadCOlorinterno", Range( 0 , 1)) = 0
		_ACA("ACA", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _ACA;
		uniform sampler2D _Distort;
		uniform float _SpeedAnimUVxDistort;
		uniform float4 _Distort_ST;
		uniform sampler2D _Mask;
		uniform float _SpeddAnimUVxMask;
		uniform float4 _Mask_ST;
		uniform float _PowMask;
		uniform float _MultiplyMask;
		uniform float _Destructor;
		uniform float _alphaacero;
		uniform float _OpacidadTotal;
		uniform float _DifColores;
		uniform float4 _Color;
		uniform float _OpacidadCOlorinterno;
		uniform float4 _ColorExterno;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float lerpResult91 = lerp( 1.25 , 2.5 , (0.0 + (sin( _Time.y ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz += ( ase_vertexNormal * lerpResult91 * ( (1.0 + (ase_vertex3Pos.z - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) / 2.0 ) * _ACA );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult52 = (float2(0.0 , _SpeedAnimUVxDistort));
			float2 uv0_Distort = i.uv_texcoord * _Distort_ST.xy + _Distort_ST.zw;
			float2 panner41 = ( 1.0 * _Time.y * appendResult52 + uv0_Distort);
			float2 appendResult104 = (float2(_SpeddAnimUVxMask , 0.0));
			float2 uv0_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float2 panner106 = ( 1.0 * _Time.y * appendResult104 + uv0_Mask);
			float clampResult67 = clamp( ( pow( tex2D( _Mask, panner106 ).r , _PowMask ) * _MultiplyMask ) , 0.0 , 1.0 );
			float temp_output_50_0 = ( (0.5 + (tex2D( _Distort, panner41 ).r - 0.0) * (1.0 - 0.5) / (1.0 - 0.0)) * clampResult67 );
			float temp_output_57_0 = ( ceil( ( temp_output_50_0 * _Destructor ) ) / _Destructor );
			float ifLocalVar68 = 0;
			if( temp_output_57_0 > _alphaacero )
				ifLocalVar68 = temp_output_57_0;
			float clampResult72 = clamp( ( ifLocalVar68 * _OpacidadTotal ) , 0.0 , 1.0 );
			float4 temp_output_18_0 = ( _Color * clampResult72 );
			float4 temp_output_78_0 = ( _ColorExterno * temp_output_18_0 );
			float4 ifLocalVar73 = 0;
			if( clampResult72 <= _DifColores )
				ifLocalVar73 = temp_output_78_0;
			else
				ifLocalVar73 = ( temp_output_18_0 * _OpacidadCOlorinterno );
			o.Emission = ifLocalVar73.rgb;
			float clampResult125 = clamp( ( clampResult72 * 5.0 ) , 0.0 , 1.0 );
			o.Alpha = clampResult125;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
730;117;999;902;-2402.845;392.5757;1.6;True;False
Node;AmplifyShaderEditor.CommentaryNode;107;-2149.979,209.0616;Float;False;2133.253;738.6898;Mask;10;103;104;106;62;47;64;48;63;67;105;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-2099.979,609.9121;Float;False;Property;_SpeddAnimUVxMask;Spedd Anim UVx Mask;3;0;Create;True;0;0;False;0;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;104;-1792.399,544.9993;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;105;-1838.634,259.0616;Float;False;0;47;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;102;-1966.229,-560.0384;Float;False;1620.333;588.9377;Distort;6;53;52;96;41;3;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1916.229,-159.1877;Float;False;Property;_SpeedAnimUVxDistort;Speed Anim UVx Distort;1;0;Create;True;0;0;False;0;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;106;-1552.238,317.1558;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;52;-1608.649,-224.1005;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1029.202,486.3724;Float;False;Property;_PowMask;Pow Mask;4;0;Create;True;0;0;False;0;0.2;0.21;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;47;-1020.042,262.778;Float;True;Property;_Mask;Mask;2;0;Create;True;0;0;False;0;None;396f38a210576e54e859be3bfc253e2d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;96;-1654.884,-510.0382;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;48;-651.6339,351.1721;Float;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-873.652,727.0352;Float;False;Property;_MultiplyMask;Multiply Mask;5;0;Create;True;0;0;False;0;0;0.61;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;41;-1368.489,-451.944;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-503.8535,694.7515;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-1088.173,-223.0145;Float;True;Property;_Distort;Distort;0;0;Create;True;0;0;False;0;b93a189203184e54b9b06d05da41fd5e;2a54f16904242654299a96730ded17c9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;98;700.554,302.7164;Float;False;803.7499;584.6621;Destructor-1;4;55;54;56;57;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;49;-639.897,-255.0222;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;67;-272.7266,594.2667;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;137.2909,351.7144;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;750.554,772.3785;Float;False;Property;_Destructor;Destructor;8;0;Create;True;0;0;False;0;1;5;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;803.4106,352.7164;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;56;1005.162,423.8294;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;100;1630.276,62.09277;Float;False;1260.061;729.7252;Ajustar alpha 0;5;69;71;68;70;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;69;1680.276,112.0928;Float;False;Property;_alphaacero;alphaacero;9;0;Create;True;0;0;False;0;0;0.207;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;57;1269.304,610.1962;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;2063.945,676.8181;Float;False;Property;_OpacidadTotal;OpacidadTotal;10;0;Create;True;0;0;False;0;0;1.55;0;1.55;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;68;2033.523,202.0869;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;95;2886.102,1112.57;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;2380.613,561.485;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;101;1946.103,-971.9804;Float;False;1621.759;764.824;Asignar Color;8;12;75;77;18;78;76;74;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;72;2634.336,363.0031;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;94;3092.56,1087.826;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;80;3736.581,1034.772;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;1996.103,-582.4725;Float;False;Property;_Color;Color;11;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0.9548501,0.08365965,3.54717,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;75;2595.856,-322.1564;Float;False;Property;_OpacidadCOlorinterno;OpacidadCOlorinterno;14;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;77;2330.097,-921.9804;Float;False;Property;_ColorExterno;ColorExterno;12;1;[HDR];Create;True;0;0;False;0;0,0,0,0;26.26415,26.26415,26.26415,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;90;3275.649,965.2022;Float;True;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;2399.131,-507.9474;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;88;3946.412,1201.165;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;2959.581,-921.868;Float;False;Property;_DifColores;DifColores;13;0;Create;True;0;0;False;0;0.93;0.71;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;2657.206,-748.6682;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;2905.268,-486.0056;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;91;3625.922,927.8396;Float;False;3;0;FLOAT;1.25;False;1;FLOAT;2.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;3339.287,531.4152;Float;False;Property;_ACA;ACA;15;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;81;3189.254,640.2583;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;123;-1443.959,1208.445;Float;False;1614.832;443.2371;Segunda mascara;7;115;116;122;117;120;108;119;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;87;4094.791,1100.599;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;3153.459,367.7497;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;117;-1004.411,1281.375;Float;True;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;-0.1;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;73;3288.862,-586.487;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;120;-763.9736,1504.577;Float;False;FLOAT2;4;0;FLOAT;-0.37;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;3708.112,572.4036;Float;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;444.1961,763.9249;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;119;-150.1271,1421.682;Float;True;Property;_Mask2;Mask2;6;0;Create;True;0;0;False;0;None;b3118546f5cf91f419ed1ef279bf585b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;108;-558.4675,1339.092;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;122;-1374.878,1258.445;Float;False;Property;_AjusteMask2;Ajuste Mask2;7;0;Create;True;0;0;False;0;0;-0.215;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;116;-1187.501,1404;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;115;-1393.959,1428.744;Float;False;1;0;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;125;3466.759,314.4497;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3867.565,-278.8514;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;YOS/TOONGR;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;1;False;-1;1;False;-1;0;False;-1;5;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;16;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;104;0;103;0
WireConnection;106;0;105;0
WireConnection;106;2;104;0
WireConnection;52;1;53;0
WireConnection;47;1;106;0
WireConnection;48;0;47;1
WireConnection;48;1;62;0
WireConnection;41;0;96;0
WireConnection;41;2;52;0
WireConnection;63;0;48;0
WireConnection;63;1;64;0
WireConnection;3;1;41;0
WireConnection;49;0;3;1
WireConnection;67;0;63;0
WireConnection;50;0;49;0
WireConnection;50;1;67;0
WireConnection;54;0;50;0
WireConnection;54;1;55;0
WireConnection;56;0;54;0
WireConnection;57;0;56;0
WireConnection;57;1;55;0
WireConnection;68;0;57;0
WireConnection;68;1;69;0
WireConnection;68;2;57;0
WireConnection;70;0;68;0
WireConnection;70;1;71;0
WireConnection;72;0;70;0
WireConnection;94;0;95;0
WireConnection;90;0;94;0
WireConnection;18;0;12;0
WireConnection;18;1;72;0
WireConnection;88;0;80;3
WireConnection;78;0;77;0
WireConnection;78;1;18;0
WireConnection;76;0;18;0
WireConnection;76;1;75;0
WireConnection;91;2;90;0
WireConnection;87;0;88;0
WireConnection;124;0;72;0
WireConnection;117;0;116;0
WireConnection;117;3;122;0
WireConnection;73;0;72;0
WireConnection;73;1;74;0
WireConnection;73;2;76;0
WireConnection;73;3;78;0
WireConnection;73;4;78;0
WireConnection;120;0;117;0
WireConnection;84;0;81;0
WireConnection;84;1;91;0
WireConnection;84;2;87;0
WireConnection;84;3;82;0
WireConnection;121;0;50;0
WireConnection;121;1;119;1
WireConnection;119;1;108;0
WireConnection;108;1;120;0
WireConnection;116;0;115;0
WireConnection;125;0;124;0
WireConnection;0;2;73;0
WireConnection;0;9;125;0
WireConnection;0;11;84;0
ASEEND*/
//CHKSM=6B8CAC927EBF34AE51BDE2D22916805693267603