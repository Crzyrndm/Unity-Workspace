// This file SHOULD NOT BE USED IN THE SOLUTION
// You need compiled shader source to use Material constructor properly, which is located in SpecularLayered.txt
// Use this file to preview the shader in the Unity Editor and create compiled shader code using the inspector there

Shader "KSP/Specular Layered"
{
	Properties
	{
		_MainTex("Diffuse (4x grayscale in RGBA)", 2D) = "white" {}
	_Emissive("Color mask (4x grayscale in RGBA)", 2D) = "white" {}

	_SpecColor("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess("Shininess", Range(0.03, 1)) = 0.078125

		_Opacity("_Opacity", Range(0,1)) = 1
		_RimFalloff("_RimFalloff", Range(0.01,5)) = 0.1
		_RimColor("_RimColor", Color) = (0,0,0,0)
	}

		SubShader
	{
		ZWrite On
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM

#pragma surface surf BlinnPhong
#pragma target 3.0

		half _Shininess;
	sampler2D _MainTex;
	sampler2D _Emissive;

	float _Opacity;
	float _RimFalloff;
	float4 _RimColor;

	struct Input
	{
		float2 uv_MainTex : TEXCOORD0;
		float2 uv2_Emissive : TEXCOORD1;
		float3 viewDir;
		float4 color : COLOR;
	};

	// Vertex colors
	// R(x) - partial fill color R
	// G(y) - partial fill color G
	// B(z) - partial fill color B
	// A(w) - fill factor
	// U    - layer factor
	// V    - masked fill/uniform fill factor

	void surf(Input IN, inout SurfaceOutput o)
	{
		float4 color = tex2D(_MainTex, IN.uv_MainTex);
		float4 mask = tex2D(_Emissive, IN.uv_MainTex);
		float3 normal = float3 (0, 0, 1);

		half rim = 1.0 - saturate(dot(normalize(IN.viewDir), normal));
		float3 emission = (_RimColor.rgb * pow(rim, _RimFalloff)) * _RimColor.a;

		float2 albedoGrayscaleAndMask =
			lerp
			(
				lerp
				(
					float2 (color.x, mask.x),
					float2 (color.y, mask.y),
					saturate(IN.uv2_Emissive.x * 3)
					),
				lerp
				(
					float2 (color.z, mask.z),
					float2 (color.w, mask.w),
					saturate(IN.uv2_Emissive.x * 3 - 2)
					),
				saturate(IN.uv2_Emissive.x * 3 - 1)
				);
		float3 composite =
			lerp
			(
				albedoGrayscaleAndMask.xxx,
				lerp
				(
					lerp
					(
						saturate(albedoGrayscaleAndMask.x + ((1 - albedoGrayscaleAndMask.y) * pow(albedoGrayscaleAndMask.x, 2))).xxx,
						IN.color.xyz,
						albedoGrayscaleAndMask.y
						),
					IN.color.xyz,
					IN.uv2_Emissive.y
					),
				saturate(IN.color.w)
				);

		o.Albedo = composite;
		o.Emission = emission;

		o.Gloss = (pow(1 - albedoGrayscaleAndMask.y + 0.4, 3) + 0.2) * albedoGrayscaleAndMask.y;
		// Gloss output is weird - it's a workaround to extracting a decent-looking specular map out of colormask and some constants, required for the wing to look right next to stock parts

		o.Specular = _Shininess;
		o.Normal = normal;
		o.Emission *= _Opacity;
		o.Alpha = _Opacity;
	}
	ENDCG
	}
		Fallback "Diffuse"
}