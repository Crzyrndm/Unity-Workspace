// Compiled shader for all platforms, uncompressed size: 529.0KB

// Skipping shader variants that would not be included into build of current scene.

Shader "KSP/Specular Layered" {
	Properties{
		_MainTex("Diffuse (4x grayscale in RGBA)", 2D) = "white" { }
	_Emissive("Color mask (4x grayscale in RGBA)", 2D) = "white" { }
	_SpecColor("Specular Color", Color) = (0.5,0.5,0.5,1)
		_Shininess("Shininess", Range(0.03,1)) = 0.078125
		_Opacity("_Opacity", Range(0,1)) = 1
		_RimFalloff("_RimFalloff", Range(0.01,5)) = 0.1
		_RimColor("_RimColor", Color) = (0,0,0,0)
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }


		// Stats for Vertex shader:
		//       d3d11 : 56 avg math (45..68)
		//        d3d9 : 66 avg math (48..84)
		//        gles : 59 avg math (56..61), 2 avg texture (2..3)
		//       metal : 48 avg math (33..64)
		//      opengl : 56 avg math (56..57), 2 avg texture (2..3)
		// Stats for Fragment shader:
		//       d3d11 : 55 avg math (54..56), 2 avg texture (2..3)
		//        d3d9 : 68 avg math (68..69), 2 avg texture (2..3)
		//       metal : 56 avg math (56..57), 2 avg texture (2..3)
		Pass{
		Name "FORWARD"
		Tags{ "LIGHTMODE" = "ForwardBase" "SHADOWSUPPORT" = "true" "RenderType" = "Opaque" }
		GpuProgramID 4947
		Program "vp" {
		SubProgram "opengl " {
			// Stats: 56 math, 2 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLSL#version 120

#ifdef VERTEX
				uniform vec4 unity_SHAr;
			uniform vec4 unity_SHAg;
			uniform vec4 unity_SHAb;
			uniform vec4 unity_SHBr;
			uniform vec4 unity_SHBg;
			uniform vec4 unity_SHBb;
			uniform vec4 unity_SHC;

			uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_TEXCOORD7;
			void main()
			{
				vec4 tmpvar_1;
				vec4 tmpvar_2;
				tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_1.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec3 tmpvar_3;
				tmpvar_3 = (_Object2World * gl_Vertex).xyz;
				vec4 v_4;
				v_4.x = _World2Object[0].x;
				v_4.y = _World2Object[1].x;
				v_4.z = _World2Object[2].x;
				v_4.w = _World2Object[3].x;
				vec4 v_5;
				v_5.x = _World2Object[0].y;
				v_5.y = _World2Object[1].y;
				v_5.z = _World2Object[2].y;
				v_5.w = _World2Object[3].y;
				vec4 v_6;
				v_6.x = _World2Object[0].z;
				v_6.y = _World2Object[1].z;
				v_6.z = _World2Object[2].z;
				v_6.w = _World2Object[3].z;
				vec3 tmpvar_7;
				tmpvar_7 = normalize(((
					(v_4.xyz * gl_Normal.x)
					+
					(v_5.xyz * gl_Normal.y)
					) + (v_6.xyz * gl_Normal.z)));
				mat3 tmpvar_8;
				tmpvar_8[0] = _Object2World[0].xyz;
				tmpvar_8[1] = _Object2World[1].xyz;
				tmpvar_8[2] = _Object2World[2].xyz;
				vec3 tmpvar_9;
				tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
				vec3 tmpvar_10;
				tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec4 tmpvar_11;
				tmpvar_11.x = tmpvar_9.x;
				tmpvar_11.y = tmpvar_10.x;
				tmpvar_11.z = tmpvar_7.x;
				tmpvar_11.w = tmpvar_3.x;
				vec4 tmpvar_12;
				tmpvar_12.x = tmpvar_9.y;
				tmpvar_12.y = tmpvar_10.y;
				tmpvar_12.z = tmpvar_7.y;
				tmpvar_12.w = tmpvar_3.y;
				vec4 tmpvar_13;
				tmpvar_13.x = tmpvar_9.z;
				tmpvar_13.y = tmpvar_10.z;
				tmpvar_13.z = tmpvar_7.z;
				tmpvar_13.w = tmpvar_3.z;
				vec4 tmpvar_14;
				tmpvar_14.w = 1.0;
				tmpvar_14.xyz = tmpvar_7;
				vec3 x2_15;
				vec3 x1_16;
				x1_16.x = dot(unity_SHAr, tmpvar_14);
				x1_16.y = dot(unity_SHAg, tmpvar_14);
				x1_16.z = dot(unity_SHAb, tmpvar_14);
				vec4 tmpvar_17;
				tmpvar_17 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
				x2_15.x = dot(unity_SHBr, tmpvar_17);
				x2_15.y = dot(unity_SHBg, tmpvar_17);
				x2_15.z = dot(unity_SHBb, tmpvar_17);
				gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
				xlv_TEXCOORD0 = tmpvar_1;
				xlv_TEXCOORD1 = tmpvar_11;
				xlv_TEXCOORD2 = tmpvar_12;
				xlv_TEXCOORD3 = tmpvar_13;
				xlv_COLOR0 = gl_Color;
				xlv_TEXCOORD4 = ((x2_15 + (unity_SHC.xyz *
					((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))
					)) + x1_16);
				xlv_TEXCOORD7 = tmpvar_2;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform float _Opacity;
			uniform float _RimFalloff;
			uniform vec4 _RimColor;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec3 tmpvar_3;
				tmpvar_3.x = xlv_TEXCOORD1.w;
				tmpvar_3.y = xlv_TEXCOORD2.w;
				tmpvar_3.z = xlv_TEXCOORD3.w;
				vec3 tmpvar_4;
				tmpvar_4 = normalize((normalize(
					(_WorldSpaceCameraPos - tmpvar_3)
					) + _WorldSpaceLightPos0.xyz));
				vec4 tmpvar_5;
				tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_6;
				tmpvar_6 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_5.x;
				tmpvar_7.y = tmpvar_6.x;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_5.y;
				tmpvar_8.y = tmpvar_6.y;
				vec2 tmpvar_9;
				tmpvar_9.x = tmpvar_5.z;
				tmpvar_9.y = tmpvar_6.z;
				vec2 tmpvar_10;
				tmpvar_10.x = tmpvar_5.w;
				tmpvar_10.y = tmpvar_6.w;
				vec2 tmpvar_11;
				float tmpvar_12;
				tmpvar_12 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_11 = mix(mix(tmpvar_7, tmpvar_8, vec2(clamp(tmpvar_12, 0.0, 1.0))), mix(tmpvar_9, tmpvar_10, vec2(clamp(
					(tmpvar_12 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_12 - 1.0), 0.0, 1.0)));
				vec3 tmpvar_13;
				tmpvar_13 = mix(tmpvar_11.xxx, mix(mix(vec3(
					clamp((tmpvar_11.x + ((1.0 - tmpvar_11.y) * (tmpvar_11.x * tmpvar_11.x))), 0.0, 1.0)
					), xlv_COLOR0.xyz, tmpvar_11.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0)));
				c_2.w = 0.0;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				vec4 c_14;
				vec3 tmpvar_15;
				tmpvar_15 = normalize(worldN_1);
				c_14.xyz = (_LightColor0.xyz * ((tmpvar_13 *
					max(0.0, dot(tmpvar_15, _WorldSpaceLightPos0.xyz))
					) + (
						pow(max(0.0, dot(tmpvar_15, tmpvar_4)), (_Shininess * 128.0))
						*
						((pow((
							(1.0 - tmpvar_11.y)
							+ 0.4), 3.0) + 0.2) * tmpvar_11.y)
						)));
				c_14.w = 1.0;
				c_2 = (c_2 + c_14);
				c_2.xyz = (c_2.xyz + ((
					(_RimColor.xyz * pow((1.0 - clamp(
						normalize((((xlv_TEXCOORD1.xyz * tmpvar_4.x) + (xlv_TEXCOORD2.xyz * tmpvar_4.y)) + (xlv_TEXCOORD3.xyz * tmpvar_4.z)))
						.z, 0.0, 1.0)), _RimFalloff))
					* _RimColor.w) * _Opacity));
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 48 math
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 4[_Object2World] 3
				Matrix 7[_World2Object] 3
				Matrix 0[glstate_matrix_mvp]
				Vector 19[_Emissive_ST]
				Vector 18[_MainTex_ST]
				Vector 12[unity_SHAb]
				Vector 11[unity_SHAg]
				Vector 10[unity_SHAr]
				Vector 15[unity_SHBb]
				Vector 14[unity_SHBg]
				Vector 13[unity_SHBr]
				Vector 16[unity_SHC]
				Vector 17[unity_WorldTransformParams]
				"vs_3_0
				def c20, 1, 0, 0, 0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2
				dcl_texcoord2 o3
				dcl_texcoord3 o4
				dcl_color o5
				dcl_texcoord4 o6.xyz
				dcl_texcoord7 o7
				dp4 o0.x, c0, v0
				dp4 o0.y, c1, v0
				dp4 o0.z, c2, v0
				dp4 o0.w, c3, v0
				mad o1.xy, v3, c18, c18.zwzw
				mad o1.zw, v4.xyxy, c19.xyxy, c19
				dp4 o2.w, c4, v0
				dp4 o3.w, c5, v0
				dp4 o4.w, c6, v0
				mul r0.xyz, c8, v2.y
				mad r0.xyz, c7, v2.x, r0
				mad r0.xyz, c9, v2.z, r0
				nrm r1.xyz, r0
				mul r0.x, r1.y, r1.y
				mad r0.x, r1.x, r1.x, -r0.x
				mul r2, r1.yzzx, r1.xyzz
				dp4 r3.x, c13, r2
				dp4 r3.y, c14, r2
				dp4 r3.z, c15, r2
				mad r0.xyz, c16, r0.x, r3
				mov r1.w, c20.x
				dp4 r2.x, c10, r1
				dp4 r2.y, c11, r1
				dp4 r2.z, c12, r1
				add o6.xyz, r0, r2
				dp3 r0.z, c4, v1
				dp3 r0.x, c5, v1
				dp3 r0.y, c6, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r2.xyz, r0, r1.zxyw
				mad r2.xyz, r1.yzxw, r0.yzxw, -r2
				mul r0.z, c17.w, v1.w
				mul r2.xyz, r0.z, r2
				mov o2.y, r2.x
				mov o2.z, r1.x
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r2.y
				mov o4.y, r2.z
				mov o3.z, r1.y
				mov o4.z, r1.z
				mov o5, v5
				mov o7, c20.y

				"
		}
		SubProgram "d3d11 " {
			// Stats: 45 math
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 208
				Vector 176[_MainTex_ST]
				Vector 192[_Emissive_ST]
				ConstBuffer "UnityLighting" 720
				Vector 608[unity_SHAr]
				Vector 624[unity_SHAg]
				Vector 640[unity_SHAb]
				Vector 656[unity_SHBr]
				Vector 672[unity_SHBg]
				Vector 688[unity_SHBb]
				Vector 704[unity_SHC]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityLighting" 1
				BindCB  "UnityPerDraw" 2
				"vs_4_0
				root12:aaadaaaa
				eefiecedpmokhcacjpnblfafjemblcbnbomohjohabaaaaaaamakaaaaadaaaaaa
				cmaaaaaaceabaaaabaacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaapaaaaaannaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaa
				ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
				feeffiedepepfceeaaedepemepfcaaklfdeieefcpeahaaaaeaaaabaapnabaaaa
				fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
				fjaaaaaeegiocaaaacaaaaaabgaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
				pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
				fpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaahaaaaaaghaaaaaepccabaaa
				aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
				gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
				afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaac
				aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
				abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
				aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
				acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
				egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
				dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
				aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
				aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaaihcaabaaaaaaaaaaa
				fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
				egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
				hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
				aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
				aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaaaaaaaaa
				diaaaaaibcaabaaaaaaaaaaadkbabaaaabaaaaaadkiacaaaacaaaaaabfaaaaaa
				diaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaa
				dcaaaaakhcaabaaaabaaaaaajgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaa
				egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaacaaaaaaaoaaaaaa
				kgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
				abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
				diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
				bcaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
				ccaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
				ecaabaaaacaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
				bcaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
				ccaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
				ecaabaaaadaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
				hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaibcaabaaa
				adaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
				adaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
				adaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
				acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
				egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
				aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
				diaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaacgajbaaaacaaaaaadcaaaaak
				hcaabaaaadaaaaaajgaebaaaacaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaa
				adaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaa
				dgaaaaafcccabaaaacaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaacaaaaaa
				ckaabaaaabaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
				bccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaa
				abaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaaaaaaaaadgaaaaaficcabaaa
				aeaaaaaackaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaadaaaaaa
				dgaaaaafcccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaaadaaaaaa
				bkaabaaaacaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaf
				pccabaaaafaaaaaaegbobaaaahaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
				acaaaaaabkaabaaaacaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaacaaaaaa
				akaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaa
				jgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
				abaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
				abaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
				abaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
				abaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
				acaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaa
				cgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaa
				chaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaa
				ciaaaaaaegaobaaaacaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaa
				egacbaaaabaaaaaadgaaaaaipccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
				aaaaaaaaaaaaaaaadoaaaaab"
		}
		SubProgram "gles " {
			// Stats: 56 math, 2 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform mediump vec4 unity_SHAr;
			uniform mediump vec4 unity_SHAg;
			uniform mediump vec4 unity_SHAb;
			uniform mediump vec4 unity_SHBr;
			uniform mediump vec4 unity_SHBg;
			uniform mediump vec4 unity_SHBb;
			uniform mediump vec4 unity_SHC;
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying highp vec4 xlv_TEXCOORD7;
			void main()
			{
				highp vec3 shlight_1;
				lowp float tangentSign_2;
				lowp vec3 worldTangent_3;
				lowp vec3 worldNormal_4;
				highp vec4 tmpvar_5;
				lowp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec3 tmpvar_8;
				tmpvar_8 = (_Object2World * _glesVertex).xyz;
				highp vec4 v_9;
				v_9.x = _World2Object[0].x;
				v_9.y = _World2Object[1].x;
				v_9.z = _World2Object[2].x;
				v_9.w = _World2Object[3].x;
				highp vec4 v_10;
				v_10.x = _World2Object[0].y;
				v_10.y = _World2Object[1].y;
				v_10.z = _World2Object[2].y;
				v_10.w = _World2Object[3].y;
				highp vec4 v_11;
				v_11.x = _World2Object[0].z;
				v_11.y = _World2Object[1].z;
				v_11.z = _World2Object[2].z;
				v_11.w = _World2Object[3].z;
				highp vec3 tmpvar_12;
				tmpvar_12 = normalize(((
					(v_9.xyz * _glesNormal.x)
					+
					(v_10.xyz * _glesNormal.y)
					) + (v_11.xyz * _glesNormal.z)));
				worldNormal_4 = tmpvar_12;
				highp mat3 tmpvar_13;
				tmpvar_13[0] = _Object2World[0].xyz;
				tmpvar_13[1] = _Object2World[1].xyz;
				tmpvar_13[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_14;
				tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
				worldTangent_3 = tmpvar_14;
				highp float tmpvar_15;
				tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_2 = tmpvar_15;
				lowp vec3 tmpvar_16;
				tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				highp vec4 tmpvar_17;
				tmpvar_17.x = worldTangent_3.x;
				tmpvar_17.y = tmpvar_16.x;
				tmpvar_17.z = worldNormal_4.x;
				tmpvar_17.w = tmpvar_8.x;
				highp vec4 tmpvar_18;
				tmpvar_18.x = worldTangent_3.y;
				tmpvar_18.y = tmpvar_16.y;
				tmpvar_18.z = worldNormal_4.y;
				tmpvar_18.w = tmpvar_8.y;
				highp vec4 tmpvar_19;
				tmpvar_19.x = worldTangent_3.z;
				tmpvar_19.y = tmpvar_16.z;
				tmpvar_19.z = worldNormal_4.z;
				tmpvar_19.w = tmpvar_8.z;
				lowp vec4 tmpvar_20;
				tmpvar_20.w = 1.0;
				tmpvar_20.xyz = worldNormal_4;
				mediump vec3 tmpvar_21;
				mediump vec4 normal_22;
				normal_22 = tmpvar_20;
				mediump vec3 x2_23;
				mediump vec3 x1_24;
				x1_24.x = dot(unity_SHAr, normal_22);
				x1_24.y = dot(unity_SHAg, normal_22);
				x1_24.z = dot(unity_SHAb, normal_22);
				mediump vec4 tmpvar_25;
				tmpvar_25 = (normal_22.xyzz * normal_22.yzzx);
				x2_23.x = dot(unity_SHBr, tmpvar_25);
				x2_23.y = dot(unity_SHBg, tmpvar_25);
				x2_23.z = dot(unity_SHBb, tmpvar_25);
				tmpvar_21 = ((x2_23 + (unity_SHC.xyz *
					((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					)) + x1_24);
				shlight_1 = tmpvar_21;
				tmpvar_6 = shlight_1;
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_5;
				xlv_TEXCOORD1 = tmpvar_17;
				xlv_TEXCOORD2 = tmpvar_18;
				xlv_TEXCOORD3 = tmpvar_19;
				xlv_COLOR0 = _glesColor;
				xlv_TEXCOORD4 = tmpvar_6;
				xlv_TEXCOORD7 = tmpvar_7;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform lowp vec4 _LightColor0;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform highp float _Opacity;
			uniform highp float _RimFalloff;
			uniform highp vec4 _RimColor;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 viewDir_3;
				lowp vec3 worldViewDir_4;
				lowp vec3 lightDir_5;
				highp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				highp vec3 tmpvar_8;
				tmpvar_8.x = xlv_TEXCOORD1.w;
				tmpvar_8.y = xlv_TEXCOORD2.w;
				tmpvar_8.z = xlv_TEXCOORD3.w;
				mediump vec3 tmpvar_9;
				tmpvar_9 = _WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = tmpvar_10;
				lowp vec3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				highp vec3 tmpvar_12;
				tmpvar_12 = (((xlv_TEXCOORD1.xyz * tmpvar_11.x) + (xlv_TEXCOORD2.xyz * tmpvar_11.y)) + (xlv_TEXCOORD3.xyz * tmpvar_11.z));
				viewDir_3 = tmpvar_12;
				tmpvar_6 = viewDir_3;
				tmpvar_7 = xlv_COLOR0;
				lowp vec3 tmpvar_13;
				lowp vec3 tmpvar_14;
				lowp float tmpvar_15;
				highp vec4 mask_16;
				highp vec4 color_17;
				lowp vec4 tmpvar_18;
				tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_17 = tmpvar_18;
				lowp vec4 tmpvar_19;
				tmpvar_19 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_16 = tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				mediump float tmpvar_21;
				tmpvar_21 = (1.0 - tmpvar_20);
				highp vec3 tmpvar_22;
				tmpvar_22 = ((_RimColor.xyz * pow(tmpvar_21, _RimFalloff)) * _RimColor.w);
				highp vec2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				highp vec2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				highp vec2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				highp vec2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				highp vec2 tmpvar_27;
				highp float tmpvar_28;
				tmpvar_28 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, vec2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, vec2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(vec3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = tmpvar_29;
				tmpvar_14 = tmpvar_22;
				highp float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = ((tmpvar_30 + 0.2) * tmpvar_27.y);
				tmpvar_14 = (tmpvar_14 * _Opacity);
				c_2.w = 0.0;
				highp float tmpvar_31;
				tmpvar_31 = xlv_TEXCOORD1.z;
				worldN_1.x = tmpvar_31;
				highp float tmpvar_32;
				tmpvar_32 = xlv_TEXCOORD2.z;
				worldN_1.y = tmpvar_32;
				highp float tmpvar_33;
				tmpvar_33 = xlv_TEXCOORD3.z;
				worldN_1.z = tmpvar_33;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				lowp vec4 c_34;
				lowp float spec_35;
				lowp vec3 tmpvar_36;
				tmpvar_36 = normalize(worldN_1);
				lowp float tmpvar_37;
				tmpvar_37 = max(0.0, dot(tmpvar_36, tmpvar_11));
				mediump float tmpvar_38;
				tmpvar_38 = (pow(tmpvar_37, (_Shininess * 128.0)) * tmpvar_15);
				spec_35 = tmpvar_38;
				c_34.xyz = (_LightColor0.xyz * ((tmpvar_13 *
					max(0.0, dot(tmpvar_36, lightDir_5))
					) + spec_35));
				c_34.w = 1.0;
				c_2 = (c_2 + c_34);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out highp vec4 vs_TEXCOORD1;
			out highp vec4 vs_TEXCOORD2;
			out highp vec4 vs_TEXCOORD3;
			out lowp vec4 vs_COLOR0;
			out lowp vec3 vs_TEXCOORD4;
			out highp vec4 vs_TEXCOORD7;
			highp vec4 t0;
			mediump vec4 t16_0;
			highp vec3 t1;
			highp vec4 t2;
			highp vec3 t3;
			lowp vec3 t10_4;
			mediump vec3 t16_5;
			mediump vec3 t16_6;
			highp float t21;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_TEXCOORD1.w = t0.x;
				t0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t21 = dot(t1.xyz, t1.xyz);
				t21 = inversesqrt(t21);
				t1.xyz = vec3(t21) * t1.xyz;
				t2.x = in_NORMAL0.x * _World2Object[0].x;
				t2.y = in_NORMAL0.x * _World2Object[1].x;
				t2.z = in_NORMAL0.x * _World2Object[2].x;
				t3.x = in_NORMAL0.y * _World2Object[0].y;
				t3.y = in_NORMAL0.y * _World2Object[1].y;
				t3.z = in_NORMAL0.y * _World2Object[2].y;
				t2.xyz = t2.xyz + t3.xyz;
				t3.x = in_NORMAL0.z * _World2Object[0].z;
				t3.y = in_NORMAL0.z * _World2Object[1].z;
				t3.z = in_NORMAL0.z * _World2Object[2].z;
				t2.xyz = t2.xyz + t3.xyz;
				t21 = dot(t2.xyz, t2.xyz);
				t21 = inversesqrt(t21);
				t2.xyz = vec3(t21) * t2.xyz;
				t10_4.xyz = t1.xyz * t2.zxy;
				t10_4.xyz = t2.yzx * t1.yzx + (-t10_4.xyz);
				t10_4.xyz = t0.xxx * t10_4.xyz;
				vs_TEXCOORD1.y = t10_4.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD1.z = t2.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.w = t0.y;
				vs_TEXCOORD3.w = t0.z;
				vs_TEXCOORD2.y = t10_4.y;
				vs_TEXCOORD3.y = t10_4.z;
				vs_TEXCOORD2.z = t2.y;
				vs_TEXCOORD3.z = t2.z;
				vs_COLOR0 = in_COLOR0;
				t16_5.x = t2.y * t2.y;
				t16_5.x = t2.x * t2.x + (-t16_5.x);
				t16_0 = t2.yzzx * t2.xyzz;
				t16_6.x = dot(unity_SHBr, t16_0);
				t16_6.y = dot(unity_SHBg, t16_0);
				t16_6.z = dot(unity_SHBb, t16_0);
				t16_5.xyz = unity_SHC.xyz * t16_5.xxx + t16_6.xyz;
				t2.w = 1.0;
				t16_6.x = dot(unity_SHAr, t2);
				t16_6.y = dot(unity_SHAg, t2);
				t16_6.z = dot(unity_SHAb, t2);
				t16_5.xyz = t16_5.xyz + t16_6.xyz;
				vs_TEXCOORD4.xyz = t16_5.xyz;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			in highp vec4 vs_TEXCOORD0;
			in highp vec4 vs_TEXCOORD1;
			in highp vec4 vs_TEXCOORD2;
			in highp vec4 vs_TEXCOORD3;
			in lowp vec4 vs_COLOR0;
			in lowp vec3 vs_TEXCOORD4;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec3 t0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec4 t10_4;
			lowp vec3 t10_5;
			mediump float t16_6;
			highp vec3 t7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_26;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t10_4.x = dot(t2.xyz, t2.xyz);
				t10_4.x = inversesqrt(t10_4.x);
				t10_4.xyz = t2.xyz * t10_4.xxx;
				t10_4.w = dot(t10_4.xyz, _WorldSpaceLightPos0.xyz);
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.x = vs_TEXCOORD1.w;
				t1.y = vs_TEXCOORD2.w;
				t1.z = vs_TEXCOORD3.w;
				t1.xyz = (-t1.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t10_5.xyz = t1.xyz * vec3(t22) + _WorldSpaceLightPos0.xyz;
				t10_26 = dot(t10_5.xyz, t10_5.xyz);
				t10_26 = inversesqrt(t10_26);
				t10_5.xyz = vec3(t10_26) * t10_5.xyz;
				t10_4.x = dot(t10_4.xyz, t10_5.xyz);
				t10_4.xw = max(t10_4.xw, vec2(0.0, 0.0));
				t16_6 = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6 = t16_6 * t16_13;
				t16_6 = exp2(t16_6);
				t16_6 = t0.x * t16_6;
				t10_4.xyz = t7.xyz * t10_4.www + vec3(t16_6);
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				t10_4.xyz = t7.xyz * vs_TEXCOORD4.xyz + t10_4.xyz;
				t0.xyz = t10_5.yyy * vs_TEXCOORD2.xyz;
				t0.xyz = vs_TEXCOORD1.xyz * t10_5.xxx + t0.xyz;
				t0.xyz = vs_TEXCOORD3.xyz * t10_5.zzz + t0.xyz;
				t0.x = dot(t0.xyz, t0.xyz);
				t0.x = inversesqrt(t0.x);
				t0.x = t0.x * t0.z;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t0.x = (-t0.x) + 1.0;
				t0.x = log2(t0.x);
				t0.x = t0.x * _RimFalloff;
				t0.x = exp2(t0.x);
				t0.xyz = t0.xxx * _RimColor.xyz;
				t0.xyz = t0.xyz * _RimColor.www;
				SV_Target0.xyz = t0.xyz * vec3(_Opacity) + t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 33 math
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 304
				Matrix 64[glstate_matrix_mvp]
				Matrix 128[_Object2World]
				Matrix 192[_World2Object]
				VectorHalf 0[unity_SHAr] 4
				VectorHalf 8[unity_SHAg] 4
				VectorHalf 16[unity_SHAb] 4
				VectorHalf 24[unity_SHBr] 4
				VectorHalf 32[unity_SHBg] 4
				VectorHalf 40[unity_SHBb] 4
				VectorHalf 48[unity_SHC] 4
				Vector 256[unity_WorldTransformParams]
				Vector 272[_MainTex_ST]
				Vector 288[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				float4 xlv_TEXCOORD1;
				float4 xlv_TEXCOORD2;
				float4 xlv_TEXCOORD3;
				half4 xlv_COLOR0;
				half3 xlv_TEXCOORD4;
				float4 xlv_TEXCOORD7;
			};
			struct xlatMtlShaderUniform {
				half4 unity_SHAr;
				half4 unity_SHAg;
				half4 unity_SHAb;
				half4 unity_SHBr;
				half4 unity_SHBg;
				half4 unity_SHBb;
				half4 unity_SHC;
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				float3 shlight_2;
				half tangentSign_3;
				half3 worldTangent_4;
				half3 worldNormal_5;
				float4 tmpvar_6;
				half3 tmpvar_7;
				float4 tmpvar_8;
				tmpvar_6.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_6.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float3 tmpvar_9;
				tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				float4 v_10;
				v_10.x = _mtl_u._World2Object[0].x;
				v_10.y = _mtl_u._World2Object[1].x;
				v_10.z = _mtl_u._World2Object[2].x;
				v_10.w = _mtl_u._World2Object[3].x;
				float4 v_11;
				v_11.x = _mtl_u._World2Object[0].y;
				v_11.y = _mtl_u._World2Object[1].y;
				v_11.z = _mtl_u._World2Object[2].y;
				v_11.w = _mtl_u._World2Object[3].y;
				float4 v_12;
				v_12.x = _mtl_u._World2Object[0].z;
				v_12.y = _mtl_u._World2Object[1].z;
				v_12.z = _mtl_u._World2Object[2].z;
				v_12.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_13;
				tmpvar_13 = normalize(((
					(v_10.xyz * _mtl_i._glesNormal.x)
					+
					(v_11.xyz * _mtl_i._glesNormal.y)
					) + (v_12.xyz * _mtl_i._glesNormal.z)));
				worldNormal_5 = half3(tmpvar_13);
				float3x3 tmpvar_14;
				tmpvar_14[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_14[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_14[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_15;
				tmpvar_15 = normalize((tmpvar_14 * _mtl_i._glesTANGENT.xyz));
				worldTangent_4 = half3(tmpvar_15);
				float tmpvar_16;
				tmpvar_16 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_3 = half(tmpvar_16);
				half3 tmpvar_17;
				tmpvar_17 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
				float4 tmpvar_18;
				tmpvar_18.x = float(worldTangent_4.x);
				tmpvar_18.y = float(tmpvar_17.x);
				tmpvar_18.z = float(worldNormal_5.x);
				tmpvar_18.w = tmpvar_9.x;
				float4 tmpvar_19;
				tmpvar_19.x = float(worldTangent_4.y);
				tmpvar_19.y = float(tmpvar_17.y);
				tmpvar_19.z = float(worldNormal_5.y);
				tmpvar_19.w = tmpvar_9.y;
				float4 tmpvar_20;
				tmpvar_20.x = float(worldTangent_4.z);
				tmpvar_20.y = float(tmpvar_17.z);
				tmpvar_20.z = float(worldNormal_5.z);
				tmpvar_20.w = tmpvar_9.z;
				half4 tmpvar_21;
				tmpvar_21.w = half(1.0);
				tmpvar_21.xyz = worldNormal_5;
				half3 tmpvar_22;
				half4 normal_23;
				normal_23 = tmpvar_21;
				half3 x2_24;
				half3 x1_25;
				x1_25.x = dot(_mtl_u.unity_SHAr, normal_23);
				x1_25.y = dot(_mtl_u.unity_SHAg, normal_23);
				x1_25.z = dot(_mtl_u.unity_SHAb, normal_23);
				half4 tmpvar_26;
				tmpvar_26 = (normal_23.xyzz * normal_23.yzzx);
				x2_24.x = dot(_mtl_u.unity_SHBr, tmpvar_26);
				x2_24.y = dot(_mtl_u.unity_SHBg, tmpvar_26);
				x2_24.z = dot(_mtl_u.unity_SHBb, tmpvar_26);
				tmpvar_22 = ((x2_24 + (_mtl_u.unity_SHC.xyz *
					((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
					)) + x1_25);
				shlight_2 = float3(tmpvar_22);
				tmpvar_7 = half3(shlight_2);
				_mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				_mtl_o.xlv_TEXCOORD0 = tmpvar_6;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_18;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_19;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_20;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				_mtl_o.xlv_TEXCOORD4 = tmpvar_7;
				_mtl_o.xlv_TEXCOORD7 = tmpvar_8;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec4 vs_TEXCOORD1;
			out vec4 vs_TEXCOORD2;
			out vec4 vs_TEXCOORD3;
			out vec4 vs_COLOR0;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_TEXCOORD7;
			vec4 t0;
			vec4 t1;
			vec4 t2;
			vec3 t3;
			float t12;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_TEXCOORD1.w = t0.x;
				t0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t12 = dot(t1.xyz, t1.xyz);
				t12 = inversesqrt(t12);
				t1.xyz = vec3(t12) * t1.xyz;
				t2.x = in_NORMAL0.x * _World2Object[0].x;
				t2.y = in_NORMAL0.x * _World2Object[1].x;
				t2.z = in_NORMAL0.x * _World2Object[2].x;
				t3.x = in_NORMAL0.y * _World2Object[0].y;
				t3.y = in_NORMAL0.y * _World2Object[1].y;
				t3.z = in_NORMAL0.y * _World2Object[2].y;
				t2.xyz = t2.xyz + t3.xyz;
				t3.x = in_NORMAL0.z * _World2Object[0].z;
				t3.y = in_NORMAL0.z * _World2Object[1].z;
				t3.z = in_NORMAL0.z * _World2Object[2].z;
				t2.xyz = t2.xyz + t3.xyz;
				t12 = dot(t2.xyz, t2.xyz);
				t12 = inversesqrt(t12);
				t2.xyz = vec3(t12) * t2.xyz;
				t3.xyz = t1.xyz * t2.zxy;
				t3.xyz = t2.yzx * t1.yzx + (-t3.xyz);
				t3.xyz = t0.xxx * t3.xyz;
				vs_TEXCOORD1.y = t3.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD1.z = t2.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.w = t0.y;
				vs_TEXCOORD3.w = t0.z;
				vs_TEXCOORD2.y = t3.y;
				vs_TEXCOORD3.y = t3.z;
				vs_TEXCOORD2.z = t2.y;
				vs_TEXCOORD3.z = t2.z;
				vs_COLOR0 = in_COLOR0;
				t0.x = t2.y * t2.y;
				t0.x = t2.x * t2.x + (-t0.x);
				t1 = t2.yzzx * t2.xyzz;
				t3.x = dot(unity_SHBr, t1);
				t3.y = dot(unity_SHBg, t1);
				t3.z = dot(unity_SHBb, t1);
				t0.xyz = unity_SHC.xyz * t0.xxx + t3.xyz;
				t2.w = 1.0;
				t1.x = dot(unity_SHAr, t2);
				t1.y = dot(unity_SHAg, t2);
				t1.z = dot(unity_SHAb, t2);
				vs_TEXCOORD4.xyz = t0.xyz + t1.xyz;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			in  vec4 vs_TEXCOORD0;
			in  vec4 vs_TEXCOORD1;
			in  vec4 vs_TEXCOORD2;
			in  vec4 vs_TEXCOORD3;
			in  vec4 vs_COLOR0;
			in  vec3 vs_TEXCOORD4;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			vec4 t2;
			vec3 t3;
			lowp vec4 t10_3;
			vec3 t4;
			float t5;
			vec3 t6;
			vec2 t8;
			float t12;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t1.x = dot(t2.xyz, t2.xyz);
				t1.x = inversesqrt(t1.x);
				t1.xzw = t1.xxx * t2.xyz;
				t2.x = dot(t1.xzw, _WorldSpaceLightPos0.xyz);
				t2.x = max(t2.x, 0.0);
				t6.x = t1.y * t1.y;
				t5 = t1.y * t6.x + 0.200000003;
				t0.x = t0.x * t5;
				t3.x = vs_TEXCOORD1.w;
				t3.y = vs_TEXCOORD2.w;
				t3.z = vs_TEXCOORD3.w;
				t6.xyz = (-t3.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = t6.xyz * vec3(t5) + _WorldSpaceLightPos0.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = vec3(t5) * t6.xyz;
				t1.x = dot(t1.xzw, t6.xyz);
				t1.x = max(t1.x, 0.0);
				t1.x = log2(t1.x);
				t5 = _Shininess * 128.0;
				t1.x = t1.x * t5;
				t1.x = exp2(t1.x);
				t0.x = t0.x * t1.x;
				t1.xyz = t4.xyz * t2.xxx + t0.xxx;
				t1.xyz = t1.xyz * _LightColor0.xyz;
				t0.xyz = t4.xyz * vs_TEXCOORD4.xyz + t1.xyz;
				t1.xyz = t6.yyy * vs_TEXCOORD2.xyz;
				t1.xyz = vs_TEXCOORD1.xyz * t6.xxx + t1.xyz;
				t1.xyz = vs_TEXCOORD3.xyz * t6.zzz + t1.xyz;
				t12 = dot(t1.xyz, t1.xyz);
				t12 = inversesqrt(t12);
				t12 = t12 * t1.z;
				t12 = clamp(t12, 0.0, 1.0);
				t12 = (-t12) + 1.0;
				t12 = log2(t12);
				t12 = t12 * _RimFalloff;
				t12 = exp2(t12);
				t1.xyz = vec3(t12) * _RimColor.xyz;
				t1.xyz = t1.xyz * _RimColor.www;
				SV_Target0.xyz = t1.xyz * vec3(vec3(_Opacity, _Opacity, _Opacity)) + t0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "opengl " {
			// Stats: 57 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLSL#version 120

#ifdef VERTEX
				uniform vec4 _ProjectionParams;
			uniform vec4 unity_SHAr;
			uniform vec4 unity_SHAg;
			uniform vec4 unity_SHAb;
			uniform vec4 unity_SHBr;
			uniform vec4 unity_SHBg;
			uniform vec4 unity_SHBb;
			uniform vec4 unity_SHC;

			uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_TEXCOORD5;
			varying vec4 xlv_TEXCOORD7;
			void main()
			{
				vec4 tmpvar_1;
				vec4 tmpvar_2;
				vec4 tmpvar_3;
				tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
				tmpvar_2.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_2.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec3 tmpvar_4;
				tmpvar_4 = (_Object2World * gl_Vertex).xyz;
				vec4 v_5;
				v_5.x = _World2Object[0].x;
				v_5.y = _World2Object[1].x;
				v_5.z = _World2Object[2].x;
				v_5.w = _World2Object[3].x;
				vec4 v_6;
				v_6.x = _World2Object[0].y;
				v_6.y = _World2Object[1].y;
				v_6.z = _World2Object[2].y;
				v_6.w = _World2Object[3].y;
				vec4 v_7;
				v_7.x = _World2Object[0].z;
				v_7.y = _World2Object[1].z;
				v_7.z = _World2Object[2].z;
				v_7.w = _World2Object[3].z;
				vec3 tmpvar_8;
				tmpvar_8 = normalize(((
					(v_5.xyz * gl_Normal.x)
					+
					(v_6.xyz * gl_Normal.y)
					) + (v_7.xyz * gl_Normal.z)));
				mat3 tmpvar_9;
				tmpvar_9[0] = _Object2World[0].xyz;
				tmpvar_9[1] = _Object2World[1].xyz;
				tmpvar_9[2] = _Object2World[2].xyz;
				vec3 tmpvar_10;
				tmpvar_10 = normalize((tmpvar_9 * TANGENT.xyz));
				vec3 tmpvar_11;
				tmpvar_11 = (((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec4 tmpvar_12;
				tmpvar_12.x = tmpvar_10.x;
				tmpvar_12.y = tmpvar_11.x;
				tmpvar_12.z = tmpvar_8.x;
				tmpvar_12.w = tmpvar_4.x;
				vec4 tmpvar_13;
				tmpvar_13.x = tmpvar_10.y;
				tmpvar_13.y = tmpvar_11.y;
				tmpvar_13.z = tmpvar_8.y;
				tmpvar_13.w = tmpvar_4.y;
				vec4 tmpvar_14;
				tmpvar_14.x = tmpvar_10.z;
				tmpvar_14.y = tmpvar_11.z;
				tmpvar_14.z = tmpvar_8.z;
				tmpvar_14.w = tmpvar_4.z;
				vec4 tmpvar_15;
				tmpvar_15.w = 1.0;
				tmpvar_15.xyz = tmpvar_8;
				vec3 x2_16;
				vec3 x1_17;
				x1_17.x = dot(unity_SHAr, tmpvar_15);
				x1_17.y = dot(unity_SHAg, tmpvar_15);
				x1_17.z = dot(unity_SHAb, tmpvar_15);
				vec4 tmpvar_18;
				tmpvar_18 = (tmpvar_8.xyzz * tmpvar_8.yzzx);
				x2_16.x = dot(unity_SHBr, tmpvar_18);
				x2_16.y = dot(unity_SHBg, tmpvar_18);
				x2_16.z = dot(unity_SHBb, tmpvar_18);
				vec4 o_19;
				vec4 tmpvar_20;
				tmpvar_20 = (tmpvar_1 * 0.5);
				vec2 tmpvar_21;
				tmpvar_21.x = tmpvar_20.x;
				tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
				o_19.xy = (tmpvar_21 + tmpvar_20.w);
				o_19.zw = tmpvar_1.zw;
				gl_Position = tmpvar_1;
				xlv_TEXCOORD0 = tmpvar_2;
				xlv_TEXCOORD1 = tmpvar_12;
				xlv_TEXCOORD2 = tmpvar_13;
				xlv_TEXCOORD3 = tmpvar_14;
				xlv_COLOR0 = gl_Color;
				xlv_TEXCOORD4 = ((x2_16 + (unity_SHC.xyz *
					((tmpvar_8.x * tmpvar_8.x) - (tmpvar_8.y * tmpvar_8.y))
					)) + x1_17);
				xlv_TEXCOORD5 = o_19;
				xlv_TEXCOORD7 = tmpvar_3;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform sampler2D _ShadowMapTexture;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform float _Opacity;
			uniform float _RimFalloff;
			uniform vec4 _RimColor;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_TEXCOORD5;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec3 tmpvar_3;
				tmpvar_3.x = xlv_TEXCOORD1.w;
				tmpvar_3.y = xlv_TEXCOORD2.w;
				tmpvar_3.z = xlv_TEXCOORD3.w;
				vec3 tmpvar_4;
				tmpvar_4 = normalize((normalize(
					(_WorldSpaceCameraPos - tmpvar_3)
					) + _WorldSpaceLightPos0.xyz));
				vec4 tmpvar_5;
				tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_6;
				tmpvar_6 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_5.x;
				tmpvar_7.y = tmpvar_6.x;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_5.y;
				tmpvar_8.y = tmpvar_6.y;
				vec2 tmpvar_9;
				tmpvar_9.x = tmpvar_5.z;
				tmpvar_9.y = tmpvar_6.z;
				vec2 tmpvar_10;
				tmpvar_10.x = tmpvar_5.w;
				tmpvar_10.y = tmpvar_6.w;
				vec2 tmpvar_11;
				float tmpvar_12;
				tmpvar_12 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_11 = mix(mix(tmpvar_7, tmpvar_8, vec2(clamp(tmpvar_12, 0.0, 1.0))), mix(tmpvar_9, tmpvar_10, vec2(clamp(
					(tmpvar_12 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_12 - 1.0), 0.0, 1.0)));
				vec3 tmpvar_13;
				tmpvar_13 = mix(tmpvar_11.xxx, mix(mix(vec3(
					clamp((tmpvar_11.x + ((1.0 - tmpvar_11.y) * (tmpvar_11.x * tmpvar_11.x))), 0.0, 1.0)
					), xlv_COLOR0.xyz, tmpvar_11.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0)));
				c_2.w = 0.0;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				vec4 c_14;
				vec3 tmpvar_15;
				tmpvar_15 = normalize(worldN_1);
				c_14.xyz = ((_LightColor0.xyz * (
					(tmpvar_13 * max(0.0, dot(tmpvar_15, _WorldSpaceLightPos0.xyz)))
					+
					(pow(max(0.0, dot(tmpvar_15, tmpvar_4)), (_Shininess * 128.0)) * ((pow(
						((1.0 - tmpvar_11.y) + 0.4)
						, 3.0) + 0.2) * tmpvar_11.y))
					)) * texture2DProj(_ShadowMapTexture, xlv_TEXCOORD5).x);
				c_14.w = 1.0;
				c_2 = (c_2 + c_14);
				c_2.xyz = (c_2.xyz + ((
					(_RimColor.xyz * pow((1.0 - clamp(
						normalize((((xlv_TEXCOORD1.xyz * tmpvar_4.x) + (xlv_TEXCOORD2.xyz * tmpvar_4.y)) + (xlv_TEXCOORD3.xyz * tmpvar_4.z)))
						.z, 0.0, 1.0)), _RimFalloff))
					* _RimColor.w) * _Opacity));
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 54 math
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 4[_Object2World] 3
				Matrix 7[_World2Object] 3
				Matrix 0[glstate_matrix_mvp]
				Vector 21[_Emissive_ST]
				Vector 20[_MainTex_ST]
				Vector 10[_ProjectionParams]
				Vector 11[_ScreenParams]
				Vector 14[unity_SHAb]
				Vector 13[unity_SHAg]
				Vector 12[unity_SHAr]
				Vector 17[unity_SHBb]
				Vector 16[unity_SHBg]
				Vector 15[unity_SHBr]
				Vector 18[unity_SHC]
				Vector 19[unity_WorldTransformParams]
				"vs_3_0
				def c22, 1, 0.5, 0, 0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2
				dcl_texcoord2 o3
				dcl_texcoord3 o4
				dcl_color o5
				dcl_texcoord4 o6.xyz
				dcl_texcoord5 o7
				dcl_texcoord7 o8
				mad o1.xy, v3, c20, c20.zwzw
				mad o1.zw, v4.xyxy, c21.xyxy, c21
				dp4 o2.w, c4, v0
				dp4 o3.w, c5, v0
				dp4 o4.w, c6, v0
				mul r0.xyz, c8, v2.y
				mad r0.xyz, c7, v2.x, r0
				mad r0.xyz, c9, v2.z, r0
				nrm r1.xyz, r0
				mul r0.x, r1.y, r1.y
				mad r0.x, r1.x, r1.x, -r0.x
				mul r2, r1.yzzx, r1.xyzz
				dp4 r3.x, c15, r2
				dp4 r3.y, c16, r2
				dp4 r3.z, c17, r2
				mad r0.xyz, c18, r0.x, r3
				mov r1.w, c22.x
				dp4 r2.x, c12, r1
				dp4 r2.y, c13, r1
				dp4 r2.z, c14, r1
				add o6.xyz, r0, r2
				dp4 r0.y, c1, v0
				mul r1.w, r0.y, c10.x
				mul r2.w, r1.w, c22.y
				dp4 r0.x, c0, v0
				dp4 r0.w, c3, v0
				mul r2.xz, r0.xyww, c22.y
				mad o7.xy, r2.z, c11.zwzw, r2.xwzw
				dp4 r0.z, c2, v0
				mov o0, r0
				mov o7.zw, r0
				dp3 r0.z, c4, v1
				dp3 r0.x, c5, v1
				dp3 r0.y, c6, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r2.xyz, r0, r1.zxyw
				mad r2.xyz, r1.yzxw, r0.yzxw, -r2
				mul r0.z, c19.w, v1.w
				mul r2.xyz, r0.z, r2
				mov o2.y, r2.x
				mov o2.z, r1.x
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r2.y
				mov o4.y, r2.z
				mov o3.z, r1.y
				mov o4.z, r1.z
				mov o5, v5
				mov o8, c22.z

				"
		}
		SubProgram "d3d11 " {
			// Stats: 48 math
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 208
				Vector 176[_MainTex_ST]
				Vector 192[_Emissive_ST]
				ConstBuffer "UnityPerCamera" 144
				Vector 80[_ProjectionParams]
				ConstBuffer "UnityLighting" 720
				Vector 608[unity_SHAr]
				Vector 624[unity_SHAg]
				Vector 640[unity_SHAb]
				Vector 656[unity_SHBr]
				Vector 672[unity_SHBg]
				Vector 688[unity_SHBb]
				Vector 704[unity_SHC]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				BindCB  "UnityPerDraw" 3
				"vs_4_0
				root12:aaaeaaaa
				eefiecedajjhickfgdlnhemldeoemkhjppagonalabaaaaaammakaaaaadaaaaaa
				cmaaaaaaceabaaaaciacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaomaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaomaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaapaaaaaapfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				apaaaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaaomaaaaaa
				afaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
				adaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
				aaedepemepfcaaklfdeieefcjmaiaaaaeaaaabaachacaaaafjaaaaaeegiocaaa
				aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
				acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabgaaaaaafpaaaaadpcbabaaa
				aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
				dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaahaaaaaa
				ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
				pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
				gfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaa
				ahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
				aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
				aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
				dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
				egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
				pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
				aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
				alaaaaaaogikcaaaaaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
				aeaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaai
				hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
				hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
				abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
				aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
				apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaacaaaaaa
				akaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaadkbabaaaabaaaaaadkiacaaa
				adaaaaaabfaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaabaaaaaajgiecaaa
				adaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaajgiecaaaadaaaaaaamaaaaaa
				agbabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaajgiecaaa
				adaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaa
				abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaa
				dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
				acaaaaaadiaaaaaibcaabaaaadaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
				baaaaaaadiaaaaaiccaabaaaadaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
				bbaaaaaadiaaaaaiecaabaaaadaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
				bcaaaaaadiaaaaaibcaabaaaaeaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
				baaaaaaadiaaaaaiccaabaaaaeaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
				bbaaaaaadiaaaaaiecaabaaaaeaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
				bcaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaa
				diaaaaaibcaabaaaaeaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaa
				diaaaaaiccaabaaaaeaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaa
				diaaaaaiecaabaaaaeaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaa
				aaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaah
				icaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
				abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaa
				egacbaaaadaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaacaaaaaacgajbaaa
				adaaaaaadcaaaaakhcaabaaaaeaaaaaajgaebaaaadaaaaaajgaebaaaacaaaaaa
				egacbaiaebaaaaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaaagaabaaaabaaaaaa
				egacbaaaaeaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaaeaaaaaadgaaaaaf
				bccabaaaacaaaaaackaabaaaacaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaa
				adaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaacaaaaaadgaaaaafbccabaaa
				aeaaaaaabkaabaaaacaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaabaaaaaa
				dgaaaaaficcabaaaaeaaaaaackaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaa
				bkaabaaaaeaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaaeaaaaaadgaaaaaf
				eccabaaaadaaaaaabkaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaa
				adaaaaaadgaaaaafpccabaaaafaaaaaaegbobaaaahaaaaaadiaaaaahbcaabaaa
				abaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakbcaabaaaabaaaaaa
				akaabaaaadaaaaaaakaabaaaadaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
				pcaabaaaacaaaaaajgacbaaaadaaaaaaegakbaaaadaaaaaabbaaaaaibcaabaaa
				aeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
				aeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
				aeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
				abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaaeaaaaaa
				dgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
				egiocaaaacaaaaaacgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaacaaaaaa
				egiocaaaacaaaaaachaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaacaaaaaa
				egiocaaaacaaaaaaciaaaaaaegaobaaaadaaaaaaaaaaaaahhccabaaaagaaaaaa
				egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
				aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
				aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
				ahaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
				mgaabaaaabaaaaaadgaaaaaipccabaaaaiaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
				aaaaaaaaaaaaaaaadoaaaaab"
		}
		SubProgram "gles " {
			// Stats: 61 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform mediump vec4 unity_SHAr;
			uniform mediump vec4 unity_SHAg;
			uniform mediump vec4 unity_SHAb;
			uniform mediump vec4 unity_SHBr;
			uniform mediump vec4 unity_SHBg;
			uniform mediump vec4 unity_SHBb;
			uniform mediump vec4 unity_SHC;
			uniform highp mat4 unity_World2Shadow[4];
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			varying highp vec4 xlv_TEXCOORD7;
			void main()
			{
				highp vec3 shlight_1;
				lowp float tangentSign_2;
				lowp vec3 worldTangent_3;
				lowp vec3 worldNormal_4;
				highp vec4 tmpvar_5;
				lowp vec3 tmpvar_6;
				mediump vec4 tmpvar_7;
				highp vec4 tmpvar_8;
				tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec3 tmpvar_9;
				highp vec4 tmpvar_10;
				tmpvar_10 = (_Object2World * _glesVertex);
				tmpvar_9 = tmpvar_10.xyz;
				highp vec4 v_11;
				v_11.x = _World2Object[0].x;
				v_11.y = _World2Object[1].x;
				v_11.z = _World2Object[2].x;
				v_11.w = _World2Object[3].x;
				highp vec4 v_12;
				v_12.x = _World2Object[0].y;
				v_12.y = _World2Object[1].y;
				v_12.z = _World2Object[2].y;
				v_12.w = _World2Object[3].y;
				highp vec4 v_13;
				v_13.x = _World2Object[0].z;
				v_13.y = _World2Object[1].z;
				v_13.z = _World2Object[2].z;
				v_13.w = _World2Object[3].z;
				highp vec3 tmpvar_14;
				tmpvar_14 = normalize(((
					(v_11.xyz * _glesNormal.x)
					+
					(v_12.xyz * _glesNormal.y)
					) + (v_13.xyz * _glesNormal.z)));
				worldNormal_4 = tmpvar_14;
				highp mat3 tmpvar_15;
				tmpvar_15[0] = _Object2World[0].xyz;
				tmpvar_15[1] = _Object2World[1].xyz;
				tmpvar_15[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_16;
				tmpvar_16 = normalize((tmpvar_15 * _glesTANGENT.xyz));
				worldTangent_3 = tmpvar_16;
				highp float tmpvar_17;
				tmpvar_17 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_2 = tmpvar_17;
				lowp vec3 tmpvar_18;
				tmpvar_18 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				highp vec4 tmpvar_19;
				tmpvar_19.x = worldTangent_3.x;
				tmpvar_19.y = tmpvar_18.x;
				tmpvar_19.z = worldNormal_4.x;
				tmpvar_19.w = tmpvar_9.x;
				highp vec4 tmpvar_20;
				tmpvar_20.x = worldTangent_3.y;
				tmpvar_20.y = tmpvar_18.y;
				tmpvar_20.z = worldNormal_4.y;
				tmpvar_20.w = tmpvar_9.y;
				highp vec4 tmpvar_21;
				tmpvar_21.x = worldTangent_3.z;
				tmpvar_21.y = tmpvar_18.z;
				tmpvar_21.z = worldNormal_4.z;
				tmpvar_21.w = tmpvar_9.z;
				lowp vec4 tmpvar_22;
				tmpvar_22.w = 1.0;
				tmpvar_22.xyz = worldNormal_4;
				mediump vec3 tmpvar_23;
				mediump vec4 normal_24;
				normal_24 = tmpvar_22;
				mediump vec3 x2_25;
				mediump vec3 x1_26;
				x1_26.x = dot(unity_SHAr, normal_24);
				x1_26.y = dot(unity_SHAg, normal_24);
				x1_26.z = dot(unity_SHAb, normal_24);
				mediump vec4 tmpvar_27;
				tmpvar_27 = (normal_24.xyzz * normal_24.yzzx);
				x2_25.x = dot(unity_SHBr, tmpvar_27);
				x2_25.y = dot(unity_SHBg, tmpvar_27);
				x2_25.z = dot(unity_SHBb, tmpvar_27);
				tmpvar_23 = ((x2_25 + (unity_SHC.xyz *
					((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					)) + x1_26);
				shlight_1 = tmpvar_23;
				tmpvar_6 = shlight_1;
				tmpvar_7 = (unity_World2Shadow[0] * tmpvar_10);
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_5;
				xlv_TEXCOORD1 = tmpvar_19;
				xlv_TEXCOORD2 = tmpvar_20;
				xlv_TEXCOORD3 = tmpvar_21;
				xlv_COLOR0 = _glesColor;
				xlv_TEXCOORD4 = tmpvar_6;
				xlv_TEXCOORD5 = tmpvar_7;
				xlv_TEXCOORD7 = tmpvar_8;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform mediump vec4 _LightShadowData;
			uniform lowp vec4 _LightColor0;
			uniform highp sampler2D _ShadowMapTexture;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform highp float _Opacity;
			uniform highp float _RimFalloff;
			uniform highp vec4 _RimColor;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 viewDir_3;
				lowp vec3 worldViewDir_4;
				lowp vec3 lightDir_5;
				highp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				highp vec3 tmpvar_8;
				tmpvar_8.x = xlv_TEXCOORD1.w;
				tmpvar_8.y = xlv_TEXCOORD2.w;
				tmpvar_8.z = xlv_TEXCOORD3.w;
				mediump vec3 tmpvar_9;
				tmpvar_9 = _WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = tmpvar_10;
				lowp vec3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				highp vec3 tmpvar_12;
				tmpvar_12 = (((xlv_TEXCOORD1.xyz * tmpvar_11.x) + (xlv_TEXCOORD2.xyz * tmpvar_11.y)) + (xlv_TEXCOORD3.xyz * tmpvar_11.z));
				viewDir_3 = tmpvar_12;
				tmpvar_6 = viewDir_3;
				tmpvar_7 = xlv_COLOR0;
				lowp vec3 tmpvar_13;
				lowp vec3 tmpvar_14;
				lowp float tmpvar_15;
				highp vec4 mask_16;
				highp vec4 color_17;
				lowp vec4 tmpvar_18;
				tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_17 = tmpvar_18;
				lowp vec4 tmpvar_19;
				tmpvar_19 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_16 = tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				mediump float tmpvar_21;
				tmpvar_21 = (1.0 - tmpvar_20);
				highp vec3 tmpvar_22;
				tmpvar_22 = ((_RimColor.xyz * pow(tmpvar_21, _RimFalloff)) * _RimColor.w);
				highp vec2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				highp vec2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				highp vec2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				highp vec2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				highp vec2 tmpvar_27;
				highp float tmpvar_28;
				tmpvar_28 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, vec2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, vec2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(vec3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = tmpvar_29;
				tmpvar_14 = tmpvar_22;
				highp float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = ((tmpvar_30 + 0.2) * tmpvar_27.y);
				tmpvar_14 = (tmpvar_14 * _Opacity);
				lowp float tmpvar_31;
				highp float tmpvar_32;
				tmpvar_32 = max(float((texture2DProj(_ShadowMapTexture, xlv_TEXCOORD5).x >
					(xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
					)), _LightShadowData.x);
				tmpvar_31 = tmpvar_32;
				c_2.w = 0.0;
				highp float tmpvar_33;
				tmpvar_33 = xlv_TEXCOORD1.z;
				worldN_1.x = tmpvar_33;
				highp float tmpvar_34;
				tmpvar_34 = xlv_TEXCOORD2.z;
				worldN_1.y = tmpvar_34;
				highp float tmpvar_35;
				tmpvar_35 = xlv_TEXCOORD3.z;
				worldN_1.z = tmpvar_35;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				lowp vec4 c_36;
				lowp float spec_37;
				lowp vec3 tmpvar_38;
				tmpvar_38 = normalize(worldN_1);
				lowp float tmpvar_39;
				tmpvar_39 = max(0.0, dot(tmpvar_38, tmpvar_11));
				mediump float tmpvar_40;
				tmpvar_40 = (pow(tmpvar_39, (_Shininess * 128.0)) * tmpvar_15);
				spec_37 = tmpvar_40;
				c_36.xyz = ((_LightColor0.xyz * (
					(tmpvar_13 * max(0.0, dot(tmpvar_38, lightDir_5)))
					+ spec_37)) * tmpvar_31);
				c_36.w = 1.0;
				c_2 = (c_2 + c_36);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec4 vs_TEXCOORD1;
			out vec4 vs_TEXCOORD2;
			out vec4 vs_TEXCOORD3;
			out vec4 vs_COLOR0;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_TEXCOORD5;
			out vec4 vs_TEXCOORD7;
			vec4 t0;
			vec4 t1;
			vec4 t2;
			vec4 t3;
			vec3 t4;
			float t16;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				gl_Position = t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t1.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t1.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t1.xyz;
				t1.xyz = _Object2World[3].xyz * in_POSITION0.www + t1.xyz;
				vs_TEXCOORD1.w = t1.x;
				t1.x = in_TANGENT0.w * unity_WorldTransformParams.w;
				t2.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t2.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t2.xyz;
				t2.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t2.xyz;
				t16 = dot(t2.xyz, t2.xyz);
				t16 = inversesqrt(t16);
				t2.xyz = vec3(t16) * t2.xyz;
				t3.x = in_NORMAL0.x * _World2Object[0].x;
				t3.y = in_NORMAL0.x * _World2Object[1].x;
				t3.z = in_NORMAL0.x * _World2Object[2].x;
				t4.x = in_NORMAL0.y * _World2Object[0].y;
				t4.y = in_NORMAL0.y * _World2Object[1].y;
				t4.z = in_NORMAL0.y * _World2Object[2].y;
				t3.xyz = t3.xyz + t4.xyz;
				t4.x = in_NORMAL0.z * _World2Object[0].z;
				t4.y = in_NORMAL0.z * _World2Object[1].z;
				t4.z = in_NORMAL0.z * _World2Object[2].z;
				t3.xyz = t3.xyz + t4.xyz;
				t16 = dot(t3.xyz, t3.xyz);
				t16 = inversesqrt(t16);
				t3.xyz = vec3(t16) * t3.xyz;
				t4.xyz = t2.xyz * t3.zxy;
				t4.xyz = t3.yzx * t2.yzx + (-t4.xyz);
				t4.xyz = t1.xxx * t4.xyz;
				vs_TEXCOORD1.y = t4.x;
				vs_TEXCOORD1.x = t2.z;
				vs_TEXCOORD1.z = t3.x;
				vs_TEXCOORD2.x = t2.x;
				vs_TEXCOORD3.x = t2.y;
				vs_TEXCOORD2.w = t1.y;
				vs_TEXCOORD3.w = t1.z;
				vs_TEXCOORD2.y = t4.y;
				vs_TEXCOORD3.y = t4.z;
				vs_TEXCOORD2.z = t3.y;
				vs_TEXCOORD3.z = t3.z;
				vs_COLOR0 = in_COLOR0;
				t1.x = t3.y * t3.y;
				t1.x = t3.x * t3.x + (-t1.x);
				t2 = t3.yzzx * t3.xyzz;
				t4.x = dot(unity_SHBr, t2);
				t4.y = dot(unity_SHBg, t2);
				t4.z = dot(unity_SHBb, t2);
				t1.xyz = unity_SHC.xyz * t1.xxx + t4.xyz;
				t3.w = 1.0;
				t2.x = dot(unity_SHAr, t3);
				t2.y = dot(unity_SHAg, t3);
				t2.z = dot(unity_SHAb, t3);
				vs_TEXCOORD4.xyz = t1.xyz + t2.xyz;
				t0.y = t0.y * _ProjectionParams.x;
				t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
				vs_TEXCOORD5.zw = t0.zw;
				vs_TEXCOORD5.xy = t1.zz + t1.xw;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			uniform  sampler2D _ShadowMapTexture;
			in  vec4 vs_TEXCOORD0;
			in  vec4 vs_TEXCOORD1;
			in  vec4 vs_TEXCOORD2;
			in  vec4 vs_TEXCOORD3;
			in  vec4 vs_COLOR0;
			in  vec3 vs_TEXCOORD4;
			in  vec4 vs_TEXCOORD5;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			vec4 t2;
			vec3 t3;
			lowp vec4 t10_3;
			vec3 t4;
			float t5;
			vec3 t6;
			vec2 t8;
			float t12;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t1.x = dot(t2.xyz, t2.xyz);
				t1.x = inversesqrt(t1.x);
				t1.xzw = t1.xxx * t2.xyz;
				t2.x = dot(t1.xzw, _WorldSpaceLightPos0.xyz);
				t2.x = max(t2.x, 0.0);
				t6.x = t1.y * t1.y;
				t5 = t1.y * t6.x + 0.200000003;
				t0.x = t0.x * t5;
				t3.x = vs_TEXCOORD1.w;
				t3.y = vs_TEXCOORD2.w;
				t3.z = vs_TEXCOORD3.w;
				t6.xyz = (-t3.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = t6.xyz * vec3(t5) + _WorldSpaceLightPos0.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = vec3(t5) * t6.xyz;
				t1.x = dot(t1.xzw, t6.xyz);
				t1.x = max(t1.x, 0.0);
				t1.x = log2(t1.x);
				t5 = _Shininess * 128.0;
				t1.x = t1.x * t5;
				t1.x = exp2(t1.x);
				t0.x = t0.x * t1.x;
				t1.xyz = t4.xyz * t2.xxx + t0.xxx;
				t1.xyz = t1.xyz * _LightColor0.xyz;
				t3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
				t10_3 = texture(_ShadowMapTexture, t3.xy);
				t1.xyz = t1.xyz * t10_3.xxx;
				t0.xyz = t4.xyz * vs_TEXCOORD4.xyz + t1.xyz;
				t1.xyz = t6.yyy * vs_TEXCOORD2.xyz;
				t1.xyz = vs_TEXCOORD1.xyz * t6.xxx + t1.xyz;
				t1.xyz = vs_TEXCOORD3.xyz * t6.zzz + t1.xyz;
				t12 = dot(t1.xyz, t1.xyz);
				t12 = inversesqrt(t12);
				t12 = t12 * t1.z;
				t12 = clamp(t12, 0.0, 1.0);
				t12 = (-t12) + 1.0;
				t12 = log2(t12);
				t12 = t12 * _RimFalloff;
				t12 = exp2(t12);
				t1.xyz = vec3(t12) * _RimColor.xyz;
				t1.xyz = t1.xyz * _RimColor.www;
				SV_Target0.xyz = t1.xyz * vec3(vec3(_Opacity, _Opacity, _Opacity)) + t0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "opengl " {
			// Stats: 56 math, 2 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GLSL#version 120

#ifdef VERTEX
				uniform vec4 unity_4LightPosX0;
			uniform vec4 unity_4LightPosY0;
			uniform vec4 unity_4LightPosZ0;
			uniform vec4 unity_4LightAtten0;
			uniform vec4 unity_LightColor[8];
			uniform vec4 unity_SHAr;
			uniform vec4 unity_SHAg;
			uniform vec4 unity_SHAb;
			uniform vec4 unity_SHBr;
			uniform vec4 unity_SHBg;
			uniform vec4 unity_SHBb;
			uniform vec4 unity_SHC;

			uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_TEXCOORD7;
			void main()
			{
				vec4 tmpvar_1;
				vec4 tmpvar_2;
				tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_1.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec3 tmpvar_3;
				tmpvar_3 = (_Object2World * gl_Vertex).xyz;
				vec4 v_4;
				v_4.x = _World2Object[0].x;
				v_4.y = _World2Object[1].x;
				v_4.z = _World2Object[2].x;
				v_4.w = _World2Object[3].x;
				vec4 v_5;
				v_5.x = _World2Object[0].y;
				v_5.y = _World2Object[1].y;
				v_5.z = _World2Object[2].y;
				v_5.w = _World2Object[3].y;
				vec4 v_6;
				v_6.x = _World2Object[0].z;
				v_6.y = _World2Object[1].z;
				v_6.z = _World2Object[2].z;
				v_6.w = _World2Object[3].z;
				vec3 tmpvar_7;
				tmpvar_7 = normalize(((
					(v_4.xyz * gl_Normal.x)
					+
					(v_5.xyz * gl_Normal.y)
					) + (v_6.xyz * gl_Normal.z)));
				mat3 tmpvar_8;
				tmpvar_8[0] = _Object2World[0].xyz;
				tmpvar_8[1] = _Object2World[1].xyz;
				tmpvar_8[2] = _Object2World[2].xyz;
				vec3 tmpvar_9;
				tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
				vec3 tmpvar_10;
				tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec4 tmpvar_11;
				tmpvar_11.x = tmpvar_9.x;
				tmpvar_11.y = tmpvar_10.x;
				tmpvar_11.z = tmpvar_7.x;
				tmpvar_11.w = tmpvar_3.x;
				vec4 tmpvar_12;
				tmpvar_12.x = tmpvar_9.y;
				tmpvar_12.y = tmpvar_10.y;
				tmpvar_12.z = tmpvar_7.y;
				tmpvar_12.w = tmpvar_3.y;
				vec4 tmpvar_13;
				tmpvar_13.x = tmpvar_9.z;
				tmpvar_13.y = tmpvar_10.z;
				tmpvar_13.z = tmpvar_7.z;
				tmpvar_13.w = tmpvar_3.z;
				vec4 tmpvar_14;
				tmpvar_14.w = 1.0;
				tmpvar_14.xyz = tmpvar_7;
				vec3 x2_15;
				vec3 x1_16;
				x1_16.x = dot(unity_SHAr, tmpvar_14);
				x1_16.y = dot(unity_SHAg, tmpvar_14);
				x1_16.z = dot(unity_SHAb, tmpvar_14);
				vec4 tmpvar_17;
				tmpvar_17 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
				x2_15.x = dot(unity_SHBr, tmpvar_17);
				x2_15.y = dot(unity_SHBg, tmpvar_17);
				x2_15.z = dot(unity_SHBb, tmpvar_17);
				vec3 col_18;
				vec4 ndotl_19;
				vec4 lengthSq_20;
				vec4 tmpvar_21;
				tmpvar_21 = (unity_4LightPosX0 - tmpvar_3.x);
				vec4 tmpvar_22;
				tmpvar_22 = (unity_4LightPosY0 - tmpvar_3.y);
				vec4 tmpvar_23;
				tmpvar_23 = (unity_4LightPosZ0 - tmpvar_3.z);
				lengthSq_20 = (tmpvar_21 * tmpvar_21);
				lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
				lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
				ndotl_19 = (tmpvar_21 * tmpvar_7.x);
				ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_7.y));
				ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_7.z));
				vec4 tmpvar_24;
				tmpvar_24 = max(vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(lengthSq_20)));
				ndotl_19 = tmpvar_24;
				vec4 tmpvar_25;
				tmpvar_25 = (tmpvar_24 * (1.0 / ((1.0 +
					(lengthSq_20 * unity_4LightAtten0)
					))));
				col_18 = (unity_LightColor[0].xyz * tmpvar_25.x);
				col_18 = (col_18 + (unity_LightColor[1].xyz * tmpvar_25.y));
				col_18 = (col_18 + (unity_LightColor[2].xyz * tmpvar_25.z));
				col_18 = (col_18 + (unity_LightColor[3].xyz * tmpvar_25.w));
				gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
				xlv_TEXCOORD0 = tmpvar_1;
				xlv_TEXCOORD1 = tmpvar_11;
				xlv_TEXCOORD2 = tmpvar_12;
				xlv_TEXCOORD3 = tmpvar_13;
				xlv_COLOR0 = gl_Color;
				xlv_TEXCOORD4 = (((x2_15 +
					(unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y)))
					) + x1_16) + col_18);
				xlv_TEXCOORD7 = tmpvar_2;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform float _Opacity;
			uniform float _RimFalloff;
			uniform vec4 _RimColor;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec3 tmpvar_3;
				tmpvar_3.x = xlv_TEXCOORD1.w;
				tmpvar_3.y = xlv_TEXCOORD2.w;
				tmpvar_3.z = xlv_TEXCOORD3.w;
				vec3 tmpvar_4;
				tmpvar_4 = normalize((normalize(
					(_WorldSpaceCameraPos - tmpvar_3)
					) + _WorldSpaceLightPos0.xyz));
				vec4 tmpvar_5;
				tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_6;
				tmpvar_6 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_5.x;
				tmpvar_7.y = tmpvar_6.x;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_5.y;
				tmpvar_8.y = tmpvar_6.y;
				vec2 tmpvar_9;
				tmpvar_9.x = tmpvar_5.z;
				tmpvar_9.y = tmpvar_6.z;
				vec2 tmpvar_10;
				tmpvar_10.x = tmpvar_5.w;
				tmpvar_10.y = tmpvar_6.w;
				vec2 tmpvar_11;
				float tmpvar_12;
				tmpvar_12 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_11 = mix(mix(tmpvar_7, tmpvar_8, vec2(clamp(tmpvar_12, 0.0, 1.0))), mix(tmpvar_9, tmpvar_10, vec2(clamp(
					(tmpvar_12 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_12 - 1.0), 0.0, 1.0)));
				vec3 tmpvar_13;
				tmpvar_13 = mix(tmpvar_11.xxx, mix(mix(vec3(
					clamp((tmpvar_11.x + ((1.0 - tmpvar_11.y) * (tmpvar_11.x * tmpvar_11.x))), 0.0, 1.0)
					), xlv_COLOR0.xyz, tmpvar_11.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0)));
				c_2.w = 0.0;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				vec4 c_14;
				vec3 tmpvar_15;
				tmpvar_15 = normalize(worldN_1);
				c_14.xyz = (_LightColor0.xyz * ((tmpvar_13 *
					max(0.0, dot(tmpvar_15, _WorldSpaceLightPos0.xyz))
					) + (
						pow(max(0.0, dot(tmpvar_15, tmpvar_4)), (_Shininess * 128.0))
						*
						((pow((
							(1.0 - tmpvar_11.y)
							+ 0.4), 3.0) + 0.2) * tmpvar_11.y)
						)));
				c_14.w = 1.0;
				c_2 = (c_2 + c_14);
				c_2.xyz = (c_2.xyz + ((
					(_RimColor.xyz * pow((1.0 - clamp(
						normalize((((xlv_TEXCOORD1.xyz * tmpvar_4.x) + (xlv_TEXCOORD2.xyz * tmpvar_4.y)) + (xlv_TEXCOORD3.xyz * tmpvar_4.z)))
						.z, 0.0, 1.0)), _RimFalloff))
					* _RimColor.w) * _Opacity));
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 78 math
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 8[_Object2World] 3
				Matrix 11[_World2Object] 3
				Matrix 4[glstate_matrix_mvp]
				Vector 27[_Emissive_ST]
				Vector 26[_MainTex_ST]
				Vector 17[unity_4LightAtten0]
				Vector 14[unity_4LightPosX0]
				Vector 15[unity_4LightPosY0]
				Vector 16[unity_4LightPosZ0]
				Vector 0[unity_LightColor0]
				Vector 1[unity_LightColor1]
				Vector 2[unity_LightColor2]
				Vector 3[unity_LightColor3]
				Vector 20[unity_SHAb]
				Vector 19[unity_SHAg]
				Vector 18[unity_SHAr]
				Vector 23[unity_SHBb]
				Vector 22[unity_SHBg]
				Vector 21[unity_SHBr]
				Vector 24[unity_SHC]
				Vector 25[unity_WorldTransformParams]
				"vs_3_0
				def c28, 1, 0, 0, 0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2
				dcl_texcoord2 o3
				dcl_texcoord3 o4
				dcl_color o5
				dcl_texcoord4 o6.xyz
				dcl_texcoord7 o7
				dp4 o0.x, c4, v0
				dp4 o0.y, c5, v0
				dp4 o0.z, c6, v0
				dp4 o0.w, c7, v0
				mad o1.xy, v3, c26, c26.zwzw
				mad o1.zw, v4.xyxy, c27.xyxy, c27
				dp4 r0.x, c9, v0
				add r1, -r0.x, c15
				mov o3.w, r0.x
				mul r0, r1, r1
				dp4 r2.x, c8, v0
				add r3, -r2.x, c14
				mov o2.w, r2.x
				mad r0, r3, r3, r0
				dp4 r2.x, c10, v0
				add r4, -r2.x, c16
				mov o4.w, r2.x
				mad r0, r4, r4, r0
				rsq r2.x, r0.x
				rsq r2.y, r0.y
				rsq r2.z, r0.z
				rsq r2.w, r0.w
				mov r5.x, c28.x
				mad r0, r0, c17, r5.x
				mul r5.xyz, c12, v2.y
				mad r5.xyz, c11, v2.x, r5
				mad r5.xyz, c13, v2.z, r5
				nrm r6.xyz, r5
				mul r1, r1, r6.y
				mad r1, r3, r6.x, r1
				mad r1, r4, r6.z, r1
				mul r1, r2, r1
				max r1, r1, c28.y
				rcp r2.x, r0.x
				rcp r2.y, r0.y
				rcp r2.z, r0.z
				rcp r2.w, r0.w
				mul r0, r1, r2
				mul r1.xyz, r0.y, c1
				mad r1.xyz, c0, r0.x, r1
				mad r0.xyz, c2, r0.z, r1
				mad r0.xyz, c3, r0.w, r0
				mul r0.w, r6.y, r6.y
				mad r0.w, r6.x, r6.x, -r0.w
				mul r1, r6.yzzx, r6.xyzz
				dp4 r2.x, c21, r1
				dp4 r2.y, c22, r1
				dp4 r2.z, c23, r1
				mad r1.xyz, c24, r0.w, r2
				mov r6.w, c28.x
				dp4 r2.x, c18, r6
				dp4 r2.y, c19, r6
				dp4 r2.z, c20, r6
				add r1.xyz, r1, r2
				add o6.xyz, r0, r1
				dp3 r0.z, c8, v1
				dp3 r0.x, c9, v1
				dp3 r0.y, c10, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r1.xyz, r0, r6.zxyw
				mad r1.xyz, r6.yzxw, r0.yzxw, -r1
				mul r0.z, c25.w, v1.w
				mul r1.xyz, r0.z, r1
				mov o2.y, r1.x
				mov o2.z, r6.x
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r1.y
				mov o4.y, r1.z
				mov o3.z, r6.y
				mov o4.z, r6.z
				mov o5, v5
				mov o7, c28.y

				"
		}
		SubProgram "d3d11 " {
			// Stats: 65 math
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 208
				Vector 176[_MainTex_ST]
				Vector 192[_Emissive_ST]
				ConstBuffer "UnityLighting" 720
				Vector 32[unity_4LightPosX0]
				Vector 48[unity_4LightPosY0]
				Vector 64[unity_4LightPosZ0]
				Vector 80[unity_4LightAtten0]
				Vector 96[unity_LightColor0]
				Vector 112[unity_LightColor1]
				Vector 128[unity_LightColor2]
				Vector 144[unity_LightColor3]
				Vector 160[unity_LightColor4]
				Vector 176[unity_LightColor5]
				Vector 192[unity_LightColor6]
				Vector 208[unity_LightColor7]
				Vector 608[unity_SHAr]
				Vector 624[unity_SHAg]
				Vector 640[unity_SHAb]
				Vector 656[unity_SHBr]
				Vector 672[unity_SHBg]
				Vector 688[unity_SHBb]
				Vector 704[unity_SHC]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityLighting" 1
				BindCB  "UnityPerDraw" 2
				"vs_4_0
				root12:aaadaaaa
				eefiecedjmjgdijcnjdjgehdilphleaghlagkcjcabaaaaaameamaaaaadaaaaaa
				cmaaaaaaceabaaaabaacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaapaaaaaannaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaaneaaaaaa
				ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
				feeffiedepepfceeaaedepemepfcaaklfdeieefckmakaaaaeaaaabaaklacaaaa
				fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
				fjaaaaaeegiocaaaacaaaaaabgaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
				pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
				fpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaahaaaaaaghaaaaaepccabaaa
				aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
				gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaa
				afaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagiaaaaac
				agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
				abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
				aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
				acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
				egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
				dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
				aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
				aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaaihcaabaaaaaaaaaaa
				fgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
				jgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaak
				hcaabaaaaaaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
				aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
				eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
				pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafbccabaaaacaaaaaackaabaaa
				aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaabaaaaaadkiacaaaacaaaaaa
				bfaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
				baaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
				bbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
				bcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
				baaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
				bbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
				bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
				diaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaa
				diaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaa
				diaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaa
				aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
				icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
				abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
				egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaacgajbaaa
				abaaaaaadcaaaaakhcaabaaaacaaaaaajgaebaaaabaaaaaajgaebaaaaaaaaaaa
				egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
				egacbaaaacaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
				eccabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
				aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
				acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
				adaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaa
				dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
				egacbaaaadaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaadaaaaaadgaaaaaf
				bccabaaaadaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaa
				aaaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaa
				aeaaaaaackaabaaaacaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaabaaaaaa
				dgaaaaaficcabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaficcabaaaaeaaaaaa
				ckaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaaabaaaaaadgaaaaaf
				pccabaaaafaaaaaaegbobaaaahaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaa
				abaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaabaaaaaa
				akaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
				jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
				abaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
				abaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
				abaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
				abaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaa
				abaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaa
				cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaa
				chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaa
				ciaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
				egacbaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaadaaaaaa
				egiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaa
				egaobaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
				acaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaa
				abaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaa
				egiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
				agaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
				adaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaa
				egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
				acaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaaeeaaaaaf
				pcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaa
				acaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
				aaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
				aaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
				egaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
				aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
				acaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
				egiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaa
				agaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
				egiccaaaabaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
				hcaabaaaabaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaa
				abaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
				dgaaaaaipccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
				doaaaaab"
		}
		SubProgram "gles " {
			// Stats: 56 math, 2 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp vec4 unity_4LightPosX0;
			uniform highp vec4 unity_4LightPosY0;
			uniform highp vec4 unity_4LightPosZ0;
			uniform mediump vec4 unity_4LightAtten0;
			uniform mediump vec4 unity_LightColor[8];
			uniform mediump vec4 unity_SHAr;
			uniform mediump vec4 unity_SHAg;
			uniform mediump vec4 unity_SHAb;
			uniform mediump vec4 unity_SHBr;
			uniform mediump vec4 unity_SHBg;
			uniform mediump vec4 unity_SHBb;
			uniform mediump vec4 unity_SHC;
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying highp vec4 xlv_TEXCOORD7;
			void main()
			{
				highp vec3 shlight_1;
				lowp float tangentSign_2;
				lowp vec3 worldTangent_3;
				lowp vec3 worldNormal_4;
				highp vec4 tmpvar_5;
				lowp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec3 tmpvar_8;
				tmpvar_8 = (_Object2World * _glesVertex).xyz;
				highp vec4 v_9;
				v_9.x = _World2Object[0].x;
				v_9.y = _World2Object[1].x;
				v_9.z = _World2Object[2].x;
				v_9.w = _World2Object[3].x;
				highp vec4 v_10;
				v_10.x = _World2Object[0].y;
				v_10.y = _World2Object[1].y;
				v_10.z = _World2Object[2].y;
				v_10.w = _World2Object[3].y;
				highp vec4 v_11;
				v_11.x = _World2Object[0].z;
				v_11.y = _World2Object[1].z;
				v_11.z = _World2Object[2].z;
				v_11.w = _World2Object[3].z;
				highp vec3 tmpvar_12;
				tmpvar_12 = normalize(((
					(v_9.xyz * _glesNormal.x)
					+
					(v_10.xyz * _glesNormal.y)
					) + (v_11.xyz * _glesNormal.z)));
				worldNormal_4 = tmpvar_12;
				highp mat3 tmpvar_13;
				tmpvar_13[0] = _Object2World[0].xyz;
				tmpvar_13[1] = _Object2World[1].xyz;
				tmpvar_13[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_14;
				tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
				worldTangent_3 = tmpvar_14;
				highp float tmpvar_15;
				tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_2 = tmpvar_15;
				lowp vec3 tmpvar_16;
				tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				highp vec4 tmpvar_17;
				tmpvar_17.x = worldTangent_3.x;
				tmpvar_17.y = tmpvar_16.x;
				tmpvar_17.z = worldNormal_4.x;
				tmpvar_17.w = tmpvar_8.x;
				highp vec4 tmpvar_18;
				tmpvar_18.x = worldTangent_3.y;
				tmpvar_18.y = tmpvar_16.y;
				tmpvar_18.z = worldNormal_4.y;
				tmpvar_18.w = tmpvar_8.y;
				highp vec4 tmpvar_19;
				tmpvar_19.x = worldTangent_3.z;
				tmpvar_19.y = tmpvar_16.z;
				tmpvar_19.z = worldNormal_4.z;
				tmpvar_19.w = tmpvar_8.z;
				lowp vec4 tmpvar_20;
				tmpvar_20.w = 1.0;
				tmpvar_20.xyz = worldNormal_4;
				mediump vec3 tmpvar_21;
				mediump vec4 normal_22;
				normal_22 = tmpvar_20;
				mediump vec3 x2_23;
				mediump vec3 x1_24;
				x1_24.x = dot(unity_SHAr, normal_22);
				x1_24.y = dot(unity_SHAg, normal_22);
				x1_24.z = dot(unity_SHAb, normal_22);
				mediump vec4 tmpvar_25;
				tmpvar_25 = (normal_22.xyzz * normal_22.yzzx);
				x2_23.x = dot(unity_SHBr, tmpvar_25);
				x2_23.y = dot(unity_SHBg, tmpvar_25);
				x2_23.z = dot(unity_SHBb, tmpvar_25);
				tmpvar_21 = ((x2_23 + (unity_SHC.xyz *
					((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					)) + x1_24);
				shlight_1 = tmpvar_21;
				tmpvar_6 = shlight_1;
				highp vec3 lightColor0_26;
				lightColor0_26 = unity_LightColor[0].xyz;
				highp vec3 lightColor1_27;
				lightColor1_27 = unity_LightColor[1].xyz;
				highp vec3 lightColor2_28;
				lightColor2_28 = unity_LightColor[2].xyz;
				highp vec3 lightColor3_29;
				lightColor3_29 = unity_LightColor[3].xyz;
				highp vec4 lightAttenSq_30;
				lightAttenSq_30 = unity_4LightAtten0;
				highp vec3 normal_31;
				normal_31 = worldNormal_4;
				highp vec3 col_32;
				highp vec4 ndotl_33;
				highp vec4 lengthSq_34;
				highp vec4 tmpvar_35;
				tmpvar_35 = (unity_4LightPosX0 - tmpvar_8.x);
				highp vec4 tmpvar_36;
				tmpvar_36 = (unity_4LightPosY0 - tmpvar_8.y);
				highp vec4 tmpvar_37;
				tmpvar_37 = (unity_4LightPosZ0 - tmpvar_8.z);
				lengthSq_34 = (tmpvar_35 * tmpvar_35);
				lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
				lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
				ndotl_33 = (tmpvar_35 * normal_31.x);
				ndotl_33 = (ndotl_33 + (tmpvar_36 * normal_31.y));
				ndotl_33 = (ndotl_33 + (tmpvar_37 * normal_31.z));
				highp vec4 tmpvar_38;
				tmpvar_38 = max(vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(lengthSq_34)));
				ndotl_33 = tmpvar_38;
				highp vec4 tmpvar_39;
				tmpvar_39 = (tmpvar_38 * (1.0 / ((1.0 +
					(lengthSq_34 * lightAttenSq_30)
					))));
				col_32 = (lightColor0_26 * tmpvar_39.x);
				col_32 = (col_32 + (lightColor1_27 * tmpvar_39.y));
				col_32 = (col_32 + (lightColor2_28 * tmpvar_39.z));
				col_32 = (col_32 + (lightColor3_29 * tmpvar_39.w));
				tmpvar_6 = (tmpvar_6 + col_32);
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_5;
				xlv_TEXCOORD1 = tmpvar_17;
				xlv_TEXCOORD2 = tmpvar_18;
				xlv_TEXCOORD3 = tmpvar_19;
				xlv_COLOR0 = _glesColor;
				xlv_TEXCOORD4 = tmpvar_6;
				xlv_TEXCOORD7 = tmpvar_7;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform lowp vec4 _LightColor0;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform highp float _Opacity;
			uniform highp float _RimFalloff;
			uniform highp vec4 _RimColor;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 viewDir_3;
				lowp vec3 worldViewDir_4;
				lowp vec3 lightDir_5;
				highp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				highp vec3 tmpvar_8;
				tmpvar_8.x = xlv_TEXCOORD1.w;
				tmpvar_8.y = xlv_TEXCOORD2.w;
				tmpvar_8.z = xlv_TEXCOORD3.w;
				mediump vec3 tmpvar_9;
				tmpvar_9 = _WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = tmpvar_10;
				lowp vec3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				highp vec3 tmpvar_12;
				tmpvar_12 = (((xlv_TEXCOORD1.xyz * tmpvar_11.x) + (xlv_TEXCOORD2.xyz * tmpvar_11.y)) + (xlv_TEXCOORD3.xyz * tmpvar_11.z));
				viewDir_3 = tmpvar_12;
				tmpvar_6 = viewDir_3;
				tmpvar_7 = xlv_COLOR0;
				lowp vec3 tmpvar_13;
				lowp vec3 tmpvar_14;
				lowp float tmpvar_15;
				highp vec4 mask_16;
				highp vec4 color_17;
				lowp vec4 tmpvar_18;
				tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_17 = tmpvar_18;
				lowp vec4 tmpvar_19;
				tmpvar_19 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_16 = tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				mediump float tmpvar_21;
				tmpvar_21 = (1.0 - tmpvar_20);
				highp vec3 tmpvar_22;
				tmpvar_22 = ((_RimColor.xyz * pow(tmpvar_21, _RimFalloff)) * _RimColor.w);
				highp vec2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				highp vec2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				highp vec2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				highp vec2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				highp vec2 tmpvar_27;
				highp float tmpvar_28;
				tmpvar_28 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, vec2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, vec2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(vec3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = tmpvar_29;
				tmpvar_14 = tmpvar_22;
				highp float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = ((tmpvar_30 + 0.2) * tmpvar_27.y);
				tmpvar_14 = (tmpvar_14 * _Opacity);
				c_2.w = 0.0;
				highp float tmpvar_31;
				tmpvar_31 = xlv_TEXCOORD1.z;
				worldN_1.x = tmpvar_31;
				highp float tmpvar_32;
				tmpvar_32 = xlv_TEXCOORD2.z;
				worldN_1.y = tmpvar_32;
				highp float tmpvar_33;
				tmpvar_33 = xlv_TEXCOORD3.z;
				worldN_1.z = tmpvar_33;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				lowp vec4 c_34;
				lowp float spec_35;
				lowp vec3 tmpvar_36;
				tmpvar_36 = normalize(worldN_1);
				lowp float tmpvar_37;
				tmpvar_37 = max(0.0, dot(tmpvar_36, tmpvar_11));
				mediump float tmpvar_38;
				tmpvar_38 = (pow(tmpvar_37, (_Shininess * 128.0)) * tmpvar_15);
				spec_35 = tmpvar_38;
				c_34.xyz = (_LightColor0.xyz * ((tmpvar_13 *
					max(0.0, dot(tmpvar_36, lightDir_5))
					) + spec_35));
				c_34.w = 1.0;
				c_2 = (c_2 + c_34);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out highp vec4 vs_TEXCOORD1;
			out highp vec4 vs_TEXCOORD2;
			out highp vec4 vs_TEXCOORD3;
			out lowp vec4 vs_COLOR0;
			out lowp vec3 vs_TEXCOORD4;
			out highp vec4 vs_TEXCOORD7;
			highp vec4 t0;
			mediump vec4 t16_0;
			highp vec4 t1;
			highp vec4 t2;
			highp vec4 t3;
			lowp vec3 t10_3;
			mediump vec3 t16_4;
			highp vec4 t5;
			mediump vec3 t16_5;
			highp float t18;
			highp float t19;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t0.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t0.xyz;
				t18 = dot(t0.xyz, t0.xyz);
				t18 = inversesqrt(t18);
				t0.xyz = vec3(t18) * t0.xyz;
				vs_TEXCOORD1.x = t0.z;
				t18 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t1.x = in_NORMAL0.x * _World2Object[0].x;
				t1.y = in_NORMAL0.x * _World2Object[1].x;
				t1.z = in_NORMAL0.x * _World2Object[2].x;
				t2.x = in_NORMAL0.y * _World2Object[0].y;
				t2.y = in_NORMAL0.y * _World2Object[1].y;
				t2.z = in_NORMAL0.y * _World2Object[2].y;
				t1.xyz = t1.xyz + t2.xyz;
				t2.x = in_NORMAL0.z * _World2Object[0].z;
				t2.y = in_NORMAL0.z * _World2Object[1].z;
				t2.z = in_NORMAL0.z * _World2Object[2].z;
				t1.xyz = t1.xyz + t2.xyz;
				t19 = dot(t1.xyz, t1.xyz);
				t19 = inversesqrt(t19);
				t1.xyz = vec3(t19) * t1.xyz;
				t10_3.xyz = t0.xyz * t1.zxy;
				t10_3.xyz = t1.yzx * t0.yzx + (-t10_3.xyz);
				t10_3.xyz = vec3(t18) * t10_3.xyz;
				vs_TEXCOORD1.y = t10_3.x;
				vs_TEXCOORD1.z = t1.x;
				t2.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t2.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t2.xyz;
				t2.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t2.xyz;
				t2.xyz = _Object2World[3].xyz * in_POSITION0.www + t2.xyz;
				vs_TEXCOORD1.w = t2.x;
				vs_TEXCOORD2.x = t0.x;
				vs_TEXCOORD3.x = t0.y;
				vs_TEXCOORD2.y = t10_3.y;
				vs_TEXCOORD3.y = t10_3.z;
				vs_TEXCOORD2.z = t1.y;
				vs_TEXCOORD2.w = t2.y;
				vs_TEXCOORD3.w = t2.z;
				vs_TEXCOORD3.z = t1.z;
				vs_COLOR0 = in_COLOR0;
				t16_4.x = t1.y * t1.y;
				t16_4.x = t1.x * t1.x + (-t16_4.x);
				t16_0 = t1.yzzx * t1.xyzz;
				t16_5.x = dot(unity_SHBr, t16_0);
				t16_5.y = dot(unity_SHBg, t16_0);
				t16_5.z = dot(unity_SHBb, t16_0);
				t16_4.xyz = unity_SHC.xyz * t16_4.xxx + t16_5.xyz;
				t1.w = 1.0;
				t16_5.x = dot(unity_SHAr, t1);
				t16_5.y = dot(unity_SHAg, t1);
				t16_5.z = dot(unity_SHAb, t1);
				t16_4.xyz = t16_4.xyz + t16_5.xyz;
				t0 = (-t2.yyyy) + unity_4LightPosY0;
				t3 = t1.yyyy * t0;
				t0 = t0 * t0;
				t5 = (-t2.xxxx) + unity_4LightPosX0;
				t2 = (-t2.zzzz) + unity_4LightPosZ0;
				t3 = t5 * t1.xxxx + t3;
				t1 = t2 * t1.zzzz + t3;
				t0 = t5 * t5 + t0;
				t0 = t2 * t2 + t0;
				t2 = inversesqrt(t0);
				t0 = t0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
				t0 = vec4(1.0, 1.0, 1.0, 1.0) / t0;
				t1 = t1 * t2;
				t1 = max(t1, vec4(0.0, 0.0, 0.0, 0.0));
				t0 = t0 * t1;
				t1.xyz = t0.yyy * unity_LightColor[1].xyz;
				t1.xyz = unity_LightColor[0].xyz * t0.xxx + t1.xyz;
				t1.xyz = unity_LightColor[2].xyz * t0.zzz + t1.xyz;
				t1.xyz = unity_LightColor[3].xyz * t0.www + t1.xyz;
				t1.xyz = t1.xyz + t16_4.xyz;
				vs_TEXCOORD4.xyz = t1.xyz;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			in highp vec4 vs_TEXCOORD0;
			in highp vec4 vs_TEXCOORD1;
			in highp vec4 vs_TEXCOORD2;
			in highp vec4 vs_TEXCOORD3;
			in lowp vec4 vs_COLOR0;
			in lowp vec3 vs_TEXCOORD4;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec3 t0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec4 t10_4;
			lowp vec3 t10_5;
			mediump float t16_6;
			highp vec3 t7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_26;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t10_4.x = dot(t2.xyz, t2.xyz);
				t10_4.x = inversesqrt(t10_4.x);
				t10_4.xyz = t2.xyz * t10_4.xxx;
				t10_4.w = dot(t10_4.xyz, _WorldSpaceLightPos0.xyz);
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.x = vs_TEXCOORD1.w;
				t1.y = vs_TEXCOORD2.w;
				t1.z = vs_TEXCOORD3.w;
				t1.xyz = (-t1.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t10_5.xyz = t1.xyz * vec3(t22) + _WorldSpaceLightPos0.xyz;
				t10_26 = dot(t10_5.xyz, t10_5.xyz);
				t10_26 = inversesqrt(t10_26);
				t10_5.xyz = vec3(t10_26) * t10_5.xyz;
				t10_4.x = dot(t10_4.xyz, t10_5.xyz);
				t10_4.xw = max(t10_4.xw, vec2(0.0, 0.0));
				t16_6 = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6 = t16_6 * t16_13;
				t16_6 = exp2(t16_6);
				t16_6 = t0.x * t16_6;
				t10_4.xyz = t7.xyz * t10_4.www + vec3(t16_6);
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				t10_4.xyz = t7.xyz * vs_TEXCOORD4.xyz + t10_4.xyz;
				t0.xyz = t10_5.yyy * vs_TEXCOORD2.xyz;
				t0.xyz = vs_TEXCOORD1.xyz * t10_5.xxx + t0.xyz;
				t0.xyz = vs_TEXCOORD3.xyz * t10_5.zzz + t0.xyz;
				t0.x = dot(t0.xyz, t0.xyz);
				t0.x = inversesqrt(t0.x);
				t0.x = t0.x * t0.z;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t0.x = (-t0.x) + 1.0;
				t0.x = log2(t0.x);
				t0.x = t0.x * _RimFalloff;
				t0.x = exp2(t0.x);
				t0.xyz = t0.xxx * _RimColor.xyz;
				t0.xyz = t0.xyz * _RimColor.www;
				SV_Target0.xyz = t0.xyz * vec3(_Opacity) + t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 61 math
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 416
				Matrix 176[glstate_matrix_mvp]
				Matrix 240[_Object2World]
				Matrix 304[_World2Object]
				Vector 0[unity_4LightPosX0]
				Vector 16[unity_4LightPosY0]
				Vector 32[unity_4LightPosZ0]
				VectorHalf 48[unity_4LightAtten0] 4
				VectorHalf 56[unity_LightColor0] 4
				VectorHalf 64[unity_LightColor1] 4
				VectorHalf 72[unity_LightColor2] 4
				VectorHalf 80[unity_LightColor3] 4
				VectorHalf 88[unity_LightColor4] 4
				VectorHalf 96[unity_LightColor5] 4
				VectorHalf 104[unity_LightColor6] 4
				VectorHalf 112[unity_LightColor7] 4
				VectorHalf 120[unity_SHAr] 4
				VectorHalf 128[unity_SHAg] 4
				VectorHalf 136[unity_SHAb] 4
				VectorHalf 144[unity_SHBr] 4
				VectorHalf 152[unity_SHBg] 4
				VectorHalf 160[unity_SHBb] 4
				VectorHalf 168[unity_SHC] 4
				Vector 368[unity_WorldTransformParams]
				Vector 384[_MainTex_ST]
				Vector 400[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				float4 xlv_TEXCOORD1;
				float4 xlv_TEXCOORD2;
				float4 xlv_TEXCOORD3;
				half4 xlv_COLOR0;
				half3 xlv_TEXCOORD4;
				float4 xlv_TEXCOORD7;
			};
			struct xlatMtlShaderUniform {
				float4 unity_4LightPosX0;
				float4 unity_4LightPosY0;
				float4 unity_4LightPosZ0;
				half4 unity_4LightAtten0;
				half4 unity_LightColor[8];
				half4 unity_SHAr;
				half4 unity_SHAg;
				half4 unity_SHAb;
				half4 unity_SHBr;
				half4 unity_SHBg;
				half4 unity_SHBb;
				half4 unity_SHC;
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				float3 shlight_2;
				half tangentSign_3;
				half3 worldTangent_4;
				half3 worldNormal_5;
				float4 tmpvar_6;
				half3 tmpvar_7;
				float4 tmpvar_8;
				tmpvar_6.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_6.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float3 tmpvar_9;
				tmpvar_9 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				float4 v_10;
				v_10.x = _mtl_u._World2Object[0].x;
				v_10.y = _mtl_u._World2Object[1].x;
				v_10.z = _mtl_u._World2Object[2].x;
				v_10.w = _mtl_u._World2Object[3].x;
				float4 v_11;
				v_11.x = _mtl_u._World2Object[0].y;
				v_11.y = _mtl_u._World2Object[1].y;
				v_11.z = _mtl_u._World2Object[2].y;
				v_11.w = _mtl_u._World2Object[3].y;
				float4 v_12;
				v_12.x = _mtl_u._World2Object[0].z;
				v_12.y = _mtl_u._World2Object[1].z;
				v_12.z = _mtl_u._World2Object[2].z;
				v_12.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_13;
				tmpvar_13 = normalize(((
					(v_10.xyz * _mtl_i._glesNormal.x)
					+
					(v_11.xyz * _mtl_i._glesNormal.y)
					) + (v_12.xyz * _mtl_i._glesNormal.z)));
				worldNormal_5 = half3(tmpvar_13);
				float3x3 tmpvar_14;
				tmpvar_14[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_14[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_14[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_15;
				tmpvar_15 = normalize((tmpvar_14 * _mtl_i._glesTANGENT.xyz));
				worldTangent_4 = half3(tmpvar_15);
				float tmpvar_16;
				tmpvar_16 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_3 = half(tmpvar_16);
				half3 tmpvar_17;
				tmpvar_17 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
				float4 tmpvar_18;
				tmpvar_18.x = float(worldTangent_4.x);
				tmpvar_18.y = float(tmpvar_17.x);
				tmpvar_18.z = float(worldNormal_5.x);
				tmpvar_18.w = tmpvar_9.x;
				float4 tmpvar_19;
				tmpvar_19.x = float(worldTangent_4.y);
				tmpvar_19.y = float(tmpvar_17.y);
				tmpvar_19.z = float(worldNormal_5.y);
				tmpvar_19.w = tmpvar_9.y;
				float4 tmpvar_20;
				tmpvar_20.x = float(worldTangent_4.z);
				tmpvar_20.y = float(tmpvar_17.z);
				tmpvar_20.z = float(worldNormal_5.z);
				tmpvar_20.w = tmpvar_9.z;
				half4 tmpvar_21;
				tmpvar_21.w = half(1.0);
				tmpvar_21.xyz = worldNormal_5;
				half3 tmpvar_22;
				half4 normal_23;
				normal_23 = tmpvar_21;
				half3 x2_24;
				half3 x1_25;
				x1_25.x = dot(_mtl_u.unity_SHAr, normal_23);
				x1_25.y = dot(_mtl_u.unity_SHAg, normal_23);
				x1_25.z = dot(_mtl_u.unity_SHAb, normal_23);
				half4 tmpvar_26;
				tmpvar_26 = (normal_23.xyzz * normal_23.yzzx);
				x2_24.x = dot(_mtl_u.unity_SHBr, tmpvar_26);
				x2_24.y = dot(_mtl_u.unity_SHBg, tmpvar_26);
				x2_24.z = dot(_mtl_u.unity_SHBb, tmpvar_26);
				tmpvar_22 = ((x2_24 + (_mtl_u.unity_SHC.xyz *
					((normal_23.x * normal_23.x) - (normal_23.y * normal_23.y))
					)) + x1_25);
				shlight_2 = float3(tmpvar_22);
				tmpvar_7 = half3(shlight_2);
				float3 lightColor0_27;
				lightColor0_27 = float3(_mtl_u.unity_LightColor[0].xyz);
				float3 lightColor1_28;
				lightColor1_28 = float3(_mtl_u.unity_LightColor[1].xyz);
				float3 lightColor2_29;
				lightColor2_29 = float3(_mtl_u.unity_LightColor[2].xyz);
				float3 lightColor3_30;
				lightColor3_30 = float3(_mtl_u.unity_LightColor[3].xyz);
				float4 lightAttenSq_31;
				lightAttenSq_31 = float4(_mtl_u.unity_4LightAtten0);
				float3 normal_32;
				normal_32 = float3(worldNormal_5);
				float3 col_33;
				float4 ndotl_34;
				float4 lengthSq_35;
				float4 tmpvar_36;
				tmpvar_36 = (_mtl_u.unity_4LightPosX0 - tmpvar_9.x);
				float4 tmpvar_37;
				tmpvar_37 = (_mtl_u.unity_4LightPosY0 - tmpvar_9.y);
				float4 tmpvar_38;
				tmpvar_38 = (_mtl_u.unity_4LightPosZ0 - tmpvar_9.z);
				lengthSq_35 = (tmpvar_36 * tmpvar_36);
				lengthSq_35 = (lengthSq_35 + (tmpvar_37 * tmpvar_37));
				lengthSq_35 = (lengthSq_35 + (tmpvar_38 * tmpvar_38));
				ndotl_34 = (tmpvar_36 * normal_32.x);
				ndotl_34 = (ndotl_34 + (tmpvar_37 * normal_32.y));
				ndotl_34 = (ndotl_34 + (tmpvar_38 * normal_32.z));
				float4 tmpvar_39;
				tmpvar_39 = max(float4(0.0, 0.0, 0.0, 0.0), (ndotl_34 * rsqrt(lengthSq_35)));
				ndotl_34 = tmpvar_39;
				float4 tmpvar_40;
				tmpvar_40 = (tmpvar_39 * (1.0 / ((1.0 +
					(lengthSq_35 * lightAttenSq_31)
					))));
				col_33 = (lightColor0_27 * tmpvar_40.x);
				col_33 = (col_33 + (lightColor1_28 * tmpvar_40.y));
				col_33 = (col_33 + (lightColor2_29 * tmpvar_40.z));
				col_33 = (col_33 + (lightColor3_30 * tmpvar_40.w));
				tmpvar_7 = half3(((float3)tmpvar_7 + col_33));
				_mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				_mtl_o.xlv_TEXCOORD0 = tmpvar_6;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_18;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_19;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_20;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				_mtl_o.xlv_TEXCOORD4 = tmpvar_7;
				_mtl_o.xlv_TEXCOORD7 = tmpvar_8;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec4 vs_TEXCOORD1;
			out vec4 vs_TEXCOORD2;
			out vec4 vs_TEXCOORD3;
			out vec4 vs_COLOR0;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_TEXCOORD7;
			vec4 t0;
			vec4 t1;
			vec4 t2;
			vec4 t3;
			vec4 t4;
			vec4 t5;
			float t18;
			float t19;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t0.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t0.xyz;
				t18 = dot(t0.xyz, t0.xyz);
				t18 = inversesqrt(t18);
				t0.xyz = vec3(t18) * t0.xyz;
				vs_TEXCOORD1.x = t0.z;
				t18 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t1.x = in_NORMAL0.x * _World2Object[0].x;
				t1.y = in_NORMAL0.x * _World2Object[1].x;
				t1.z = in_NORMAL0.x * _World2Object[2].x;
				t2.x = in_NORMAL0.y * _World2Object[0].y;
				t2.y = in_NORMAL0.y * _World2Object[1].y;
				t2.z = in_NORMAL0.y * _World2Object[2].y;
				t1.xyz = t1.xyz + t2.xyz;
				t2.x = in_NORMAL0.z * _World2Object[0].z;
				t2.y = in_NORMAL0.z * _World2Object[1].z;
				t2.z = in_NORMAL0.z * _World2Object[2].z;
				t1.xyz = t1.xyz + t2.xyz;
				t19 = dot(t1.xyz, t1.xyz);
				t19 = inversesqrt(t19);
				t1.xyz = vec3(t19) * t1.xyz;
				t2.xyz = t0.xyz * t1.zxy;
				t2.xyz = t1.yzx * t0.yzx + (-t2.xyz);
				t2.xyz = vec3(t18) * t2.xyz;
				vs_TEXCOORD1.y = t2.x;
				vs_TEXCOORD1.z = t1.x;
				t3.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t3.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t3.xyz;
				t3.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t3.xyz;
				t3.xyz = _Object2World[3].xyz * in_POSITION0.www + t3.xyz;
				vs_TEXCOORD1.w = t3.x;
				vs_TEXCOORD2.x = t0.x;
				vs_TEXCOORD3.x = t0.y;
				vs_TEXCOORD2.y = t2.y;
				vs_TEXCOORD3.y = t2.z;
				vs_TEXCOORD2.z = t1.y;
				vs_TEXCOORD2.w = t3.y;
				vs_TEXCOORD3.w = t3.z;
				vs_TEXCOORD3.z = t1.z;
				vs_COLOR0 = in_COLOR0;
				t0.x = t1.y * t1.y;
				t0.x = t1.x * t1.x + (-t0.x);
				t2 = t1.yzzx * t1.xyzz;
				t4.x = dot(unity_SHBr, t2);
				t4.y = dot(unity_SHBg, t2);
				t4.z = dot(unity_SHBb, t2);
				t0.xyz = unity_SHC.xyz * t0.xxx + t4.xyz;
				t1.w = 1.0;
				t2.x = dot(unity_SHAr, t1);
				t2.y = dot(unity_SHAg, t1);
				t2.z = dot(unity_SHAb, t1);
				t0.xyz = t0.xyz + t2.xyz;
				t2 = (-t3.yyyy) + unity_4LightPosY0;
				t4 = t1.yyyy * t2;
				t2 = t2 * t2;
				t5 = (-t3.xxxx) + unity_4LightPosX0;
				t3 = (-t3.zzzz) + unity_4LightPosZ0;
				t4 = t5 * t1.xxxx + t4;
				t1 = t3 * t1.zzzz + t4;
				t2 = t5 * t5 + t2;
				t2 = t3 * t3 + t2;
				t3 = inversesqrt(t2);
				t2 = t2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
				t2 = vec4(1.0, 1.0, 1.0, 1.0) / t2;
				t1 = t1 * t3;
				t1 = max(t1, vec4(0.0, 0.0, 0.0, 0.0));
				t1 = t2 * t1;
				t2.xyz = t1.yyy * unity_LightColor[1].xyz;
				t2.xyz = unity_LightColor[0].xyz * t1.xxx + t2.xyz;
				t1.xyz = unity_LightColor[2].xyz * t1.zzz + t2.xyz;
				t1.xyz = unity_LightColor[3].xyz * t1.www + t1.xyz;
				vs_TEXCOORD4.xyz = t0.xyz + t1.xyz;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			in  vec4 vs_TEXCOORD0;
			in  vec4 vs_TEXCOORD1;
			in  vec4 vs_TEXCOORD2;
			in  vec4 vs_TEXCOORD3;
			in  vec4 vs_COLOR0;
			in  vec3 vs_TEXCOORD4;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			vec4 t2;
			vec3 t3;
			lowp vec4 t10_3;
			vec3 t4;
			float t5;
			vec3 t6;
			vec2 t8;
			float t12;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t1.x = dot(t2.xyz, t2.xyz);
				t1.x = inversesqrt(t1.x);
				t1.xzw = t1.xxx * t2.xyz;
				t2.x = dot(t1.xzw, _WorldSpaceLightPos0.xyz);
				t2.x = max(t2.x, 0.0);
				t6.x = t1.y * t1.y;
				t5 = t1.y * t6.x + 0.200000003;
				t0.x = t0.x * t5;
				t3.x = vs_TEXCOORD1.w;
				t3.y = vs_TEXCOORD2.w;
				t3.z = vs_TEXCOORD3.w;
				t6.xyz = (-t3.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = t6.xyz * vec3(t5) + _WorldSpaceLightPos0.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = vec3(t5) * t6.xyz;
				t1.x = dot(t1.xzw, t6.xyz);
				t1.x = max(t1.x, 0.0);
				t1.x = log2(t1.x);
				t5 = _Shininess * 128.0;
				t1.x = t1.x * t5;
				t1.x = exp2(t1.x);
				t0.x = t0.x * t1.x;
				t1.xyz = t4.xyz * t2.xxx + t0.xxx;
				t1.xyz = t1.xyz * _LightColor0.xyz;
				t0.xyz = t4.xyz * vs_TEXCOORD4.xyz + t1.xyz;
				t1.xyz = t6.yyy * vs_TEXCOORD2.xyz;
				t1.xyz = vs_TEXCOORD1.xyz * t6.xxx + t1.xyz;
				t1.xyz = vs_TEXCOORD3.xyz * t6.zzz + t1.xyz;
				t12 = dot(t1.xyz, t1.xyz);
				t12 = inversesqrt(t12);
				t12 = t12 * t1.z;
				t12 = clamp(t12, 0.0, 1.0);
				t12 = (-t12) + 1.0;
				t12 = log2(t12);
				t12 = t12 * _RimFalloff;
				t12 = exp2(t12);
				t1.xyz = vec3(t12) * _RimColor.xyz;
				t1.xyz = t1.xyz * _RimColor.www;
				SV_Target0.xyz = t1.xyz * vec3(vec3(_Opacity, _Opacity, _Opacity)) + t0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "opengl " {
			// Stats: 57 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GLSL#version 120

#ifdef VERTEX
				uniform vec4 _ProjectionParams;
			uniform vec4 unity_4LightPosX0;
			uniform vec4 unity_4LightPosY0;
			uniform vec4 unity_4LightPosZ0;
			uniform vec4 unity_4LightAtten0;
			uniform vec4 unity_LightColor[8];
			uniform vec4 unity_SHAr;
			uniform vec4 unity_SHAg;
			uniform vec4 unity_SHAb;
			uniform vec4 unity_SHBr;
			uniform vec4 unity_SHBg;
			uniform vec4 unity_SHBb;
			uniform vec4 unity_SHC;

			uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_TEXCOORD5;
			varying vec4 xlv_TEXCOORD7;
			void main()
			{
				vec4 tmpvar_1;
				vec4 tmpvar_2;
				vec4 tmpvar_3;
				tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
				tmpvar_2.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_2.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec3 tmpvar_4;
				tmpvar_4 = (_Object2World * gl_Vertex).xyz;
				vec4 v_5;
				v_5.x = _World2Object[0].x;
				v_5.y = _World2Object[1].x;
				v_5.z = _World2Object[2].x;
				v_5.w = _World2Object[3].x;
				vec4 v_6;
				v_6.x = _World2Object[0].y;
				v_6.y = _World2Object[1].y;
				v_6.z = _World2Object[2].y;
				v_6.w = _World2Object[3].y;
				vec4 v_7;
				v_7.x = _World2Object[0].z;
				v_7.y = _World2Object[1].z;
				v_7.z = _World2Object[2].z;
				v_7.w = _World2Object[3].z;
				vec3 tmpvar_8;
				tmpvar_8 = normalize(((
					(v_5.xyz * gl_Normal.x)
					+
					(v_6.xyz * gl_Normal.y)
					) + (v_7.xyz * gl_Normal.z)));
				mat3 tmpvar_9;
				tmpvar_9[0] = _Object2World[0].xyz;
				tmpvar_9[1] = _Object2World[1].xyz;
				tmpvar_9[2] = _Object2World[2].xyz;
				vec3 tmpvar_10;
				tmpvar_10 = normalize((tmpvar_9 * TANGENT.xyz));
				vec3 tmpvar_11;
				tmpvar_11 = (((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec4 tmpvar_12;
				tmpvar_12.x = tmpvar_10.x;
				tmpvar_12.y = tmpvar_11.x;
				tmpvar_12.z = tmpvar_8.x;
				tmpvar_12.w = tmpvar_4.x;
				vec4 tmpvar_13;
				tmpvar_13.x = tmpvar_10.y;
				tmpvar_13.y = tmpvar_11.y;
				tmpvar_13.z = tmpvar_8.y;
				tmpvar_13.w = tmpvar_4.y;
				vec4 tmpvar_14;
				tmpvar_14.x = tmpvar_10.z;
				tmpvar_14.y = tmpvar_11.z;
				tmpvar_14.z = tmpvar_8.z;
				tmpvar_14.w = tmpvar_4.z;
				vec4 tmpvar_15;
				tmpvar_15.w = 1.0;
				tmpvar_15.xyz = tmpvar_8;
				vec3 x2_16;
				vec3 x1_17;
				x1_17.x = dot(unity_SHAr, tmpvar_15);
				x1_17.y = dot(unity_SHAg, tmpvar_15);
				x1_17.z = dot(unity_SHAb, tmpvar_15);
				vec4 tmpvar_18;
				tmpvar_18 = (tmpvar_8.xyzz * tmpvar_8.yzzx);
				x2_16.x = dot(unity_SHBr, tmpvar_18);
				x2_16.y = dot(unity_SHBg, tmpvar_18);
				x2_16.z = dot(unity_SHBb, tmpvar_18);
				vec3 col_19;
				vec4 ndotl_20;
				vec4 lengthSq_21;
				vec4 tmpvar_22;
				tmpvar_22 = (unity_4LightPosX0 - tmpvar_4.x);
				vec4 tmpvar_23;
				tmpvar_23 = (unity_4LightPosY0 - tmpvar_4.y);
				vec4 tmpvar_24;
				tmpvar_24 = (unity_4LightPosZ0 - tmpvar_4.z);
				lengthSq_21 = (tmpvar_22 * tmpvar_22);
				lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
				lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
				ndotl_20 = (tmpvar_22 * tmpvar_8.x);
				ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_8.y));
				ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_8.z));
				vec4 tmpvar_25;
				tmpvar_25 = max(vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(lengthSq_21)));
				ndotl_20 = tmpvar_25;
				vec4 tmpvar_26;
				tmpvar_26 = (tmpvar_25 * (1.0 / ((1.0 +
					(lengthSq_21 * unity_4LightAtten0)
					))));
				col_19 = (unity_LightColor[0].xyz * tmpvar_26.x);
				col_19 = (col_19 + (unity_LightColor[1].xyz * tmpvar_26.y));
				col_19 = (col_19 + (unity_LightColor[2].xyz * tmpvar_26.z));
				col_19 = (col_19 + (unity_LightColor[3].xyz * tmpvar_26.w));
				vec4 o_27;
				vec4 tmpvar_28;
				tmpvar_28 = (tmpvar_1 * 0.5);
				vec2 tmpvar_29;
				tmpvar_29.x = tmpvar_28.x;
				tmpvar_29.y = (tmpvar_28.y * _ProjectionParams.x);
				o_27.xy = (tmpvar_29 + tmpvar_28.w);
				o_27.zw = tmpvar_1.zw;
				gl_Position = tmpvar_1;
				xlv_TEXCOORD0 = tmpvar_2;
				xlv_TEXCOORD1 = tmpvar_12;
				xlv_TEXCOORD2 = tmpvar_13;
				xlv_TEXCOORD3 = tmpvar_14;
				xlv_COLOR0 = gl_Color;
				xlv_TEXCOORD4 = (((x2_16 +
					(unity_SHC.xyz * ((tmpvar_8.x * tmpvar_8.x) - (tmpvar_8.y * tmpvar_8.y)))
					) + x1_17) + col_19);
				xlv_TEXCOORD5 = o_27;
				xlv_TEXCOORD7 = tmpvar_3;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform sampler2D _ShadowMapTexture;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform float _Opacity;
			uniform float _RimFalloff;
			uniform vec4 _RimColor;
			varying vec4 xlv_TEXCOORD0;
			varying vec4 xlv_TEXCOORD1;
			varying vec4 xlv_TEXCOORD2;
			varying vec4 xlv_TEXCOORD3;
			varying vec4 xlv_COLOR0;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_TEXCOORD5;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec3 tmpvar_3;
				tmpvar_3.x = xlv_TEXCOORD1.w;
				tmpvar_3.y = xlv_TEXCOORD2.w;
				tmpvar_3.z = xlv_TEXCOORD3.w;
				vec3 tmpvar_4;
				tmpvar_4 = normalize((normalize(
					(_WorldSpaceCameraPos - tmpvar_3)
					) + _WorldSpaceLightPos0.xyz));
				vec4 tmpvar_5;
				tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_6;
				tmpvar_6 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_5.x;
				tmpvar_7.y = tmpvar_6.x;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_5.y;
				tmpvar_8.y = tmpvar_6.y;
				vec2 tmpvar_9;
				tmpvar_9.x = tmpvar_5.z;
				tmpvar_9.y = tmpvar_6.z;
				vec2 tmpvar_10;
				tmpvar_10.x = tmpvar_5.w;
				tmpvar_10.y = tmpvar_6.w;
				vec2 tmpvar_11;
				float tmpvar_12;
				tmpvar_12 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_11 = mix(mix(tmpvar_7, tmpvar_8, vec2(clamp(tmpvar_12, 0.0, 1.0))), mix(tmpvar_9, tmpvar_10, vec2(clamp(
					(tmpvar_12 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_12 - 1.0), 0.0, 1.0)));
				vec3 tmpvar_13;
				tmpvar_13 = mix(tmpvar_11.xxx, mix(mix(vec3(
					clamp((tmpvar_11.x + ((1.0 - tmpvar_11.y) * (tmpvar_11.x * tmpvar_11.x))), 0.0, 1.0)
					), xlv_COLOR0.xyz, tmpvar_11.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0)));
				c_2.w = 0.0;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				vec4 c_14;
				vec3 tmpvar_15;
				tmpvar_15 = normalize(worldN_1);
				c_14.xyz = ((_LightColor0.xyz * (
					(tmpvar_13 * max(0.0, dot(tmpvar_15, _WorldSpaceLightPos0.xyz)))
					+
					(pow(max(0.0, dot(tmpvar_15, tmpvar_4)), (_Shininess * 128.0)) * ((pow(
						((1.0 - tmpvar_11.y) + 0.4)
						, 3.0) + 0.2) * tmpvar_11.y))
					)) * texture2DProj(_ShadowMapTexture, xlv_TEXCOORD5).x);
				c_14.w = 1.0;
				c_2 = (c_2 + c_14);
				c_2.xyz = (c_2.xyz + ((
					(_RimColor.xyz * pow((1.0 - clamp(
						normalize((((xlv_TEXCOORD1.xyz * tmpvar_4.x) + (xlv_TEXCOORD2.xyz * tmpvar_4.y)) + (xlv_TEXCOORD3.xyz * tmpvar_4.z)))
						.z, 0.0, 1.0)), _RimFalloff))
					* _RimColor.w) * _Opacity));
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 84 math
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 8[_Object2World] 3
				Matrix 11[_World2Object] 3
				Matrix 4[glstate_matrix_mvp]
				Vector 29[_Emissive_ST]
				Vector 28[_MainTex_ST]
				Vector 14[_ProjectionParams]
				Vector 15[_ScreenParams]
				Vector 19[unity_4LightAtten0]
				Vector 16[unity_4LightPosX0]
				Vector 17[unity_4LightPosY0]
				Vector 18[unity_4LightPosZ0]
				Vector 0[unity_LightColor0]
				Vector 1[unity_LightColor1]
				Vector 2[unity_LightColor2]
				Vector 3[unity_LightColor3]
				Vector 22[unity_SHAb]
				Vector 21[unity_SHAg]
				Vector 20[unity_SHAr]
				Vector 25[unity_SHBb]
				Vector 24[unity_SHBg]
				Vector 23[unity_SHBr]
				Vector 26[unity_SHC]
				Vector 27[unity_WorldTransformParams]
				"vs_3_0
				def c30, 1, 0, 0.5, 0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2
				dcl_texcoord2 o3
				dcl_texcoord3 o4
				dcl_color o5
				dcl_texcoord4 o6.xyz
				dcl_texcoord5 o7
				dcl_texcoord7 o8
				mad o1.xy, v3, c28, c28.zwzw
				mad o1.zw, v4.xyxy, c29.xyxy, c29
				dp4 r0.x, c9, v0
				add r1, -r0.x, c17
				mov o3.w, r0.x
				mul r0, r1, r1
				dp4 r2.x, c8, v0
				add r3, -r2.x, c16
				mov o2.w, r2.x
				mad r0, r3, r3, r0
				dp4 r2.x, c10, v0
				add r4, -r2.x, c18
				mov o4.w, r2.x
				mad r0, r4, r4, r0
				rsq r2.x, r0.x
				rsq r2.y, r0.y
				rsq r2.z, r0.z
				rsq r2.w, r0.w
				mov r5.x, c30.x
				mad r0, r0, c19, r5.x
				mul r5.xyz, c12, v2.y
				mad r5.xyz, c11, v2.x, r5
				mad r5.xyz, c13, v2.z, r5
				nrm r6.xyz, r5
				mul r1, r1, r6.y
				mad r1, r3, r6.x, r1
				mad r1, r4, r6.z, r1
				mul r1, r2, r1
				max r1, r1, c30.y
				rcp r2.x, r0.x
				rcp r2.y, r0.y
				rcp r2.z, r0.z
				rcp r2.w, r0.w
				mul r0, r1, r2
				mul r1.xyz, r0.y, c1
				mad r1.xyz, c0, r0.x, r1
				mad r0.xyz, c2, r0.z, r1
				mad r0.xyz, c3, r0.w, r0
				mul r0.w, r6.y, r6.y
				mad r0.w, r6.x, r6.x, -r0.w
				mul r1, r6.yzzx, r6.xyzz
				dp4 r2.x, c23, r1
				dp4 r2.y, c24, r1
				dp4 r2.z, c25, r1
				mad r1.xyz, c26, r0.w, r2
				mov r6.w, c30.x
				dp4 r2.x, c20, r6
				dp4 r2.y, c21, r6
				dp4 r2.z, c22, r6
				add r1.xyz, r1, r2
				add o6.xyz, r0, r1
				dp4 r0.y, c5, v0
				mul r1.x, r0.y, c14.x
				mul r1.w, r1.x, c30.z
				dp4 r0.x, c4, v0
				dp4 r0.w, c7, v0
				mul r1.xz, r0.xyww, c30.z
				mad o7.xy, r1.z, c15.zwzw, r1.xwzw
				dp4 r0.z, c6, v0
				mov o0, r0
				mov o7.zw, r0
				dp3 r0.z, c8, v1
				dp3 r0.x, c9, v1
				dp3 r0.y, c10, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r1.xyz, r0, r6.zxyw
				mad r1.xyz, r6.yzxw, r0.yzxw, -r1
				mul r0.z, c27.w, v1.w
				mul r1.xyz, r0.z, r1
				mov o2.y, r1.x
				mov o2.z, r6.x
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r1.y
				mov o4.y, r1.z
				mov o3.z, r6.y
				mov o4.z, r6.z
				mov o5, v5
				mov o8, c30.y

				"
		}
		SubProgram "d3d11 " {
			// Stats: 68 math
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 208
				Vector 176[_MainTex_ST]
				Vector 192[_Emissive_ST]
				ConstBuffer "UnityPerCamera" 144
				Vector 80[_ProjectionParams]
				ConstBuffer "UnityLighting" 720
				Vector 32[unity_4LightPosX0]
				Vector 48[unity_4LightPosY0]
				Vector 64[unity_4LightPosZ0]
				Vector 80[unity_4LightAtten0]
				Vector 96[unity_LightColor0]
				Vector 112[unity_LightColor1]
				Vector 128[unity_LightColor2]
				Vector 144[unity_LightColor3]
				Vector 160[unity_LightColor4]
				Vector 176[unity_LightColor5]
				Vector 192[unity_LightColor6]
				Vector 208[unity_LightColor7]
				Vector 608[unity_SHAr]
				Vector 624[unity_SHAg]
				Vector 640[unity_SHAb]
				Vector 656[unity_SHBr]
				Vector 672[unity_SHBg]
				Vector 688[unity_SHBb]
				Vector 704[unity_SHC]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				BindCB  "UnityPerDraw" 3
				"vs_4_0
				root12:aaaeaaaa
				eefiecedjgdlggnjkecejefgijfcoijgfnmokcikabaaaaaaieanaaaaadaaaaaa
				cmaaaaaaceabaaaaciacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaomaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaomaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaapaaaaaapfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				apaaaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaaahaiaaaaomaaaaaa
				afaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
				adaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
				aaedepemepfcaaklfdeieefcfealaaaaeaaaabaanfacaaaafjaaaaaeegiocaaa
				aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
				acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabgaaaaaafpaaaaadpcbabaaa
				aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
				dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaafpaaaaadpcbabaaaahaaaaaa
				ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
				pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
				gfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaa
				ahaaaaaagfaaaaadpccabaaaaiaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaa
				aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
				aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
				dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
				egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
				pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
				aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
				alaaaaaaogikcaaaaaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
				aeaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaai
				hcaabaaaabaaaaaafgbfbaaaabaaaaaajgiecaaaadaaaaaaanaaaaaadcaaaaak
				hcaabaaaabaaaaaajgiecaaaadaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaa
				abaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaadaaaaaaaoaaaaaakgbkbaaa
				abaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
				egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
				hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafbccabaaa
				acaaaaaackaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkbabaaaabaaaaaa
				dkiacaaaadaaaaaabfaaaaaadiaaaaaibcaabaaaacaaaaaaakbabaaaacaaaaaa
				akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaaakbabaaaacaaaaaa
				akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaaakbabaaaacaaaaaa
				akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaadaaaaaabkbabaaaacaaaaaa
				bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaabkbabaaaacaaaaaa
				bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaabkbabaaaacaaaaaa
				bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
				egacbaaaadaaaaaadiaaaaaibcaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
				adaaaaaabaaaaaaadiaaaaaiccaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
				adaaaaaabbaaaaaadiaaaaaiecaabaaaadaaaaaackbabaaaacaaaaaackiacaaa
				adaaaaaabcaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
				adaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
				eeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
				pgapbaaaacaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
				abaaaaaacgajbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgaebaaaacaaaaaa
				jgaebaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
				pgapbaaaabaaaaaaegacbaaaadaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaa
				adaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaa
				aeaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
				aeaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaeaaaaaa
				dcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
				egacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaapaaaaaa
				pgbpbaaaaaaaaaaaegacbaaaaeaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaa
				aeaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
				aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaadaaaaaa
				dgaaaaafcccabaaaaeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaaadaaaaaa
				bkaabaaaacaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaaeaaaaaadgaaaaaf
				iccabaaaaeaaaaaackaabaaaaeaaaaaadgaaaaafeccabaaaaeaaaaaackaabaaa
				acaaaaaadgaaaaafpccabaaaafaaaaaaegbobaaaahaaaaaadiaaaaahbcaabaaa
				abaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakbcaabaaaabaaaaaa
				akaabaaaacaaaaaaakaabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
				pcaabaaaadaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaaibcaabaaa
				afaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
				afaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
				afaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaa
				abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaafaaaaaa
				dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
				egiocaaaacaaaaaacgaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
				egiocaaaacaaaaaachaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
				egiocaaaacaaaaaaciaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
				egacbaaaabaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaia
				ebaaaaaaaeaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaa
				fgafbaaaacaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
				adaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaa
				aeaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaakgakbaia
				ebaaaaaaaeaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaa
				egaobaaaagaaaaaaagaabaaaacaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
				acaaaaaaegaobaaaaeaaaaaakgakbaaaacaaaaaaegaobaaaafaaaaaadcaaaaaj
				pcaabaaaadaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaadaaaaaa
				dcaaaaajpcaabaaaadaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
				adaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaa
				adaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
				aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadp
				aaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaa
				egaobaaaacaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaa
				acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
				acaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaadaaaaaa
				fgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaa
				egiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaaegacbaaaadaaaaaadcaaaaak
				hcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaaegacbaaa
				adaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
				acaaaaaaegacbaaaacaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaabaaaaaa
				egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
				abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
				aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaa
				aaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
				dgaaaaaipccabaaaaiaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
				doaaaaab"
		}
		SubProgram "gles " {
			// Stats: 61 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp vec4 unity_4LightPosX0;
			uniform highp vec4 unity_4LightPosY0;
			uniform highp vec4 unity_4LightPosZ0;
			uniform mediump vec4 unity_4LightAtten0;
			uniform mediump vec4 unity_LightColor[8];
			uniform mediump vec4 unity_SHAr;
			uniform mediump vec4 unity_SHAg;
			uniform mediump vec4 unity_SHAb;
			uniform mediump vec4 unity_SHBr;
			uniform mediump vec4 unity_SHBg;
			uniform mediump vec4 unity_SHBb;
			uniform mediump vec4 unity_SHC;
			uniform highp mat4 unity_World2Shadow[4];
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			varying highp vec4 xlv_TEXCOORD7;
			void main()
			{
				highp vec3 shlight_1;
				lowp float tangentSign_2;
				lowp vec3 worldTangent_3;
				lowp vec3 worldNormal_4;
				highp vec4 tmpvar_5;
				lowp vec3 tmpvar_6;
				mediump vec4 tmpvar_7;
				highp vec4 tmpvar_8;
				tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec3 tmpvar_9;
				highp vec4 tmpvar_10;
				tmpvar_10 = (_Object2World * _glesVertex);
				tmpvar_9 = tmpvar_10.xyz;
				highp vec4 v_11;
				v_11.x = _World2Object[0].x;
				v_11.y = _World2Object[1].x;
				v_11.z = _World2Object[2].x;
				v_11.w = _World2Object[3].x;
				highp vec4 v_12;
				v_12.x = _World2Object[0].y;
				v_12.y = _World2Object[1].y;
				v_12.z = _World2Object[2].y;
				v_12.w = _World2Object[3].y;
				highp vec4 v_13;
				v_13.x = _World2Object[0].z;
				v_13.y = _World2Object[1].z;
				v_13.z = _World2Object[2].z;
				v_13.w = _World2Object[3].z;
				highp vec3 tmpvar_14;
				tmpvar_14 = normalize(((
					(v_11.xyz * _glesNormal.x)
					+
					(v_12.xyz * _glesNormal.y)
					) + (v_13.xyz * _glesNormal.z)));
				worldNormal_4 = tmpvar_14;
				highp mat3 tmpvar_15;
				tmpvar_15[0] = _Object2World[0].xyz;
				tmpvar_15[1] = _Object2World[1].xyz;
				tmpvar_15[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_16;
				tmpvar_16 = normalize((tmpvar_15 * _glesTANGENT.xyz));
				worldTangent_3 = tmpvar_16;
				highp float tmpvar_17;
				tmpvar_17 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_2 = tmpvar_17;
				lowp vec3 tmpvar_18;
				tmpvar_18 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				highp vec4 tmpvar_19;
				tmpvar_19.x = worldTangent_3.x;
				tmpvar_19.y = tmpvar_18.x;
				tmpvar_19.z = worldNormal_4.x;
				tmpvar_19.w = tmpvar_9.x;
				highp vec4 tmpvar_20;
				tmpvar_20.x = worldTangent_3.y;
				tmpvar_20.y = tmpvar_18.y;
				tmpvar_20.z = worldNormal_4.y;
				tmpvar_20.w = tmpvar_9.y;
				highp vec4 tmpvar_21;
				tmpvar_21.x = worldTangent_3.z;
				tmpvar_21.y = tmpvar_18.z;
				tmpvar_21.z = worldNormal_4.z;
				tmpvar_21.w = tmpvar_9.z;
				lowp vec4 tmpvar_22;
				tmpvar_22.w = 1.0;
				tmpvar_22.xyz = worldNormal_4;
				mediump vec3 tmpvar_23;
				mediump vec4 normal_24;
				normal_24 = tmpvar_22;
				mediump vec3 x2_25;
				mediump vec3 x1_26;
				x1_26.x = dot(unity_SHAr, normal_24);
				x1_26.y = dot(unity_SHAg, normal_24);
				x1_26.z = dot(unity_SHAb, normal_24);
				mediump vec4 tmpvar_27;
				tmpvar_27 = (normal_24.xyzz * normal_24.yzzx);
				x2_25.x = dot(unity_SHBr, tmpvar_27);
				x2_25.y = dot(unity_SHBg, tmpvar_27);
				x2_25.z = dot(unity_SHBb, tmpvar_27);
				tmpvar_23 = ((x2_25 + (unity_SHC.xyz *
					((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					)) + x1_26);
				shlight_1 = tmpvar_23;
				tmpvar_6 = shlight_1;
				highp vec3 lightColor0_28;
				lightColor0_28 = unity_LightColor[0].xyz;
				highp vec3 lightColor1_29;
				lightColor1_29 = unity_LightColor[1].xyz;
				highp vec3 lightColor2_30;
				lightColor2_30 = unity_LightColor[2].xyz;
				highp vec3 lightColor3_31;
				lightColor3_31 = unity_LightColor[3].xyz;
				highp vec4 lightAttenSq_32;
				lightAttenSq_32 = unity_4LightAtten0;
				highp vec3 normal_33;
				normal_33 = worldNormal_4;
				highp vec3 col_34;
				highp vec4 ndotl_35;
				highp vec4 lengthSq_36;
				highp vec4 tmpvar_37;
				tmpvar_37 = (unity_4LightPosX0 - tmpvar_10.x);
				highp vec4 tmpvar_38;
				tmpvar_38 = (unity_4LightPosY0 - tmpvar_10.y);
				highp vec4 tmpvar_39;
				tmpvar_39 = (unity_4LightPosZ0 - tmpvar_10.z);
				lengthSq_36 = (tmpvar_37 * tmpvar_37);
				lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
				lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
				ndotl_35 = (tmpvar_37 * normal_33.x);
				ndotl_35 = (ndotl_35 + (tmpvar_38 * normal_33.y));
				ndotl_35 = (ndotl_35 + (tmpvar_39 * normal_33.z));
				highp vec4 tmpvar_40;
				tmpvar_40 = max(vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(lengthSq_36)));
				ndotl_35 = tmpvar_40;
				highp vec4 tmpvar_41;
				tmpvar_41 = (tmpvar_40 * (1.0 / ((1.0 +
					(lengthSq_36 * lightAttenSq_32)
					))));
				col_34 = (lightColor0_28 * tmpvar_41.x);
				col_34 = (col_34 + (lightColor1_29 * tmpvar_41.y));
				col_34 = (col_34 + (lightColor2_30 * tmpvar_41.z));
				col_34 = (col_34 + (lightColor3_31 * tmpvar_41.w));
				tmpvar_6 = (tmpvar_6 + col_34);
				tmpvar_7 = (unity_World2Shadow[0] * tmpvar_10);
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_5;
				xlv_TEXCOORD1 = tmpvar_19;
				xlv_TEXCOORD2 = tmpvar_20;
				xlv_TEXCOORD3 = tmpvar_21;
				xlv_COLOR0 = _glesColor;
				xlv_TEXCOORD4 = tmpvar_6;
				xlv_TEXCOORD5 = tmpvar_7;
				xlv_TEXCOORD7 = tmpvar_8;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform mediump vec4 _LightShadowData;
			uniform lowp vec4 _LightColor0;
			uniform highp sampler2D _ShadowMapTexture;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform highp float _Opacity;
			uniform highp float _RimFalloff;
			uniform highp vec4 _RimColor;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 viewDir_3;
				lowp vec3 worldViewDir_4;
				lowp vec3 lightDir_5;
				highp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				highp vec3 tmpvar_8;
				tmpvar_8.x = xlv_TEXCOORD1.w;
				tmpvar_8.y = xlv_TEXCOORD2.w;
				tmpvar_8.z = xlv_TEXCOORD3.w;
				mediump vec3 tmpvar_9;
				tmpvar_9 = _WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = tmpvar_10;
				lowp vec3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				highp vec3 tmpvar_12;
				tmpvar_12 = (((xlv_TEXCOORD1.xyz * tmpvar_11.x) + (xlv_TEXCOORD2.xyz * tmpvar_11.y)) + (xlv_TEXCOORD3.xyz * tmpvar_11.z));
				viewDir_3 = tmpvar_12;
				tmpvar_6 = viewDir_3;
				tmpvar_7 = xlv_COLOR0;
				lowp vec3 tmpvar_13;
				lowp vec3 tmpvar_14;
				lowp float tmpvar_15;
				highp vec4 mask_16;
				highp vec4 color_17;
				lowp vec4 tmpvar_18;
				tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_17 = tmpvar_18;
				lowp vec4 tmpvar_19;
				tmpvar_19 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_16 = tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				mediump float tmpvar_21;
				tmpvar_21 = (1.0 - tmpvar_20);
				highp vec3 tmpvar_22;
				tmpvar_22 = ((_RimColor.xyz * pow(tmpvar_21, _RimFalloff)) * _RimColor.w);
				highp vec2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				highp vec2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				highp vec2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				highp vec2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				highp vec2 tmpvar_27;
				highp float tmpvar_28;
				tmpvar_28 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, vec2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, vec2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(vec3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = tmpvar_29;
				tmpvar_14 = tmpvar_22;
				highp float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = ((tmpvar_30 + 0.2) * tmpvar_27.y);
				tmpvar_14 = (tmpvar_14 * _Opacity);
				lowp float tmpvar_31;
				highp float tmpvar_32;
				tmpvar_32 = max(float((texture2DProj(_ShadowMapTexture, xlv_TEXCOORD5).x >
					(xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
					)), _LightShadowData.x);
				tmpvar_31 = tmpvar_32;
				c_2.w = 0.0;
				highp float tmpvar_33;
				tmpvar_33 = xlv_TEXCOORD1.z;
				worldN_1.x = tmpvar_33;
				highp float tmpvar_34;
				tmpvar_34 = xlv_TEXCOORD2.z;
				worldN_1.y = tmpvar_34;
				highp float tmpvar_35;
				tmpvar_35 = xlv_TEXCOORD3.z;
				worldN_1.z = tmpvar_35;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				lowp vec4 c_36;
				lowp float spec_37;
				lowp vec3 tmpvar_38;
				tmpvar_38 = normalize(worldN_1);
				lowp float tmpvar_39;
				tmpvar_39 = max(0.0, dot(tmpvar_38, tmpvar_11));
				mediump float tmpvar_40;
				tmpvar_40 = (pow(tmpvar_39, (_Shininess * 128.0)) * tmpvar_15);
				spec_37 = tmpvar_40;
				c_36.xyz = ((_LightColor0.xyz * (
					(tmpvar_13 * max(0.0, dot(tmpvar_38, lightDir_5)))
					+ spec_37)) * tmpvar_31);
				c_36.w = 1.0;
				c_2 = (c_2 + c_36);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec4 vs_TEXCOORD1;
			out vec4 vs_TEXCOORD2;
			out vec4 vs_TEXCOORD3;
			out vec4 vs_COLOR0;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_TEXCOORD5;
			out vec4 vs_TEXCOORD7;
			vec4 t0;
			vec4 t1;
			vec4 t2;
			vec4 t3;
			vec4 t4;
			vec4 t5;
			vec4 t6;
			float t22;
			float t23;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				gl_Position = t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t1.xyz = vec3(t22) * t1.xyz;
				vs_TEXCOORD1.x = t1.z;
				t22 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t2.x = in_NORMAL0.x * _World2Object[0].x;
				t2.y = in_NORMAL0.x * _World2Object[1].x;
				t2.z = in_NORMAL0.x * _World2Object[2].x;
				t3.x = in_NORMAL0.y * _World2Object[0].y;
				t3.y = in_NORMAL0.y * _World2Object[1].y;
				t3.z = in_NORMAL0.y * _World2Object[2].y;
				t2.xyz = t2.xyz + t3.xyz;
				t3.x = in_NORMAL0.z * _World2Object[0].z;
				t3.y = in_NORMAL0.z * _World2Object[1].z;
				t3.z = in_NORMAL0.z * _World2Object[2].z;
				t2.xyz = t2.xyz + t3.xyz;
				t23 = dot(t2.xyz, t2.xyz);
				t23 = inversesqrt(t23);
				t2.xyz = vec3(t23) * t2.xyz;
				t3.xyz = t1.xyz * t2.zxy;
				t3.xyz = t2.yzx * t1.yzx + (-t3.xyz);
				t3.xyz = vec3(t22) * t3.xyz;
				vs_TEXCOORD1.y = t3.x;
				vs_TEXCOORD1.z = t2.x;
				t4.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t4.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t4.xyz;
				t4.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t4.xyz;
				t4.xyz = _Object2World[3].xyz * in_POSITION0.www + t4.xyz;
				vs_TEXCOORD1.w = t4.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t3.y;
				vs_TEXCOORD3.y = t3.z;
				vs_TEXCOORD2.z = t2.y;
				vs_TEXCOORD2.w = t4.y;
				vs_TEXCOORD3.w = t4.z;
				vs_TEXCOORD3.z = t2.z;
				vs_COLOR0 = in_COLOR0;
				t1.x = t2.y * t2.y;
				t1.x = t2.x * t2.x + (-t1.x);
				t3 = t2.yzzx * t2.xyzz;
				t5.x = dot(unity_SHBr, t3);
				t5.y = dot(unity_SHBg, t3);
				t5.z = dot(unity_SHBb, t3);
				t1.xyz = unity_SHC.xyz * t1.xxx + t5.xyz;
				t2.w = 1.0;
				t3.x = dot(unity_SHAr, t2);
				t3.y = dot(unity_SHAg, t2);
				t3.z = dot(unity_SHAb, t2);
				t1.xyz = t1.xyz + t3.xyz;
				t3 = (-t4.yyyy) + unity_4LightPosY0;
				t5 = t2.yyyy * t3;
				t3 = t3 * t3;
				t6 = (-t4.xxxx) + unity_4LightPosX0;
				t4 = (-t4.zzzz) + unity_4LightPosZ0;
				t5 = t6 * t2.xxxx + t5;
				t2 = t4 * t2.zzzz + t5;
				t3 = t6 * t6 + t3;
				t3 = t4 * t4 + t3;
				t4 = inversesqrt(t3);
				t3 = t3 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
				t3 = vec4(1.0, 1.0, 1.0, 1.0) / t3;
				t2 = t2 * t4;
				t2 = max(t2, vec4(0.0, 0.0, 0.0, 0.0));
				t2 = t3 * t2;
				t3.xyz = t2.yyy * unity_LightColor[1].xyz;
				t3.xyz = unity_LightColor[0].xyz * t2.xxx + t3.xyz;
				t2.xyz = unity_LightColor[2].xyz * t2.zzz + t3.xyz;
				t2.xyz = unity_LightColor[3].xyz * t2.www + t2.xyz;
				vs_TEXCOORD4.xyz = t1.xyz + t2.xyz;
				t0.y = t0.y * _ProjectionParams.x;
				t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
				vs_TEXCOORD5.zw = t0.zw;
				vs_TEXCOORD5.xy = t1.zz + t1.xw;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			uniform  sampler2D _ShadowMapTexture;
			in  vec4 vs_TEXCOORD0;
			in  vec4 vs_TEXCOORD1;
			in  vec4 vs_TEXCOORD2;
			in  vec4 vs_TEXCOORD3;
			in  vec4 vs_COLOR0;
			in  vec3 vs_TEXCOORD4;
			in  vec4 vs_TEXCOORD5;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			vec4 t2;
			vec3 t3;
			lowp vec4 t10_3;
			vec3 t4;
			float t5;
			vec3 t6;
			vec2 t8;
			float t12;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t1.x = dot(t2.xyz, t2.xyz);
				t1.x = inversesqrt(t1.x);
				t1.xzw = t1.xxx * t2.xyz;
				t2.x = dot(t1.xzw, _WorldSpaceLightPos0.xyz);
				t2.x = max(t2.x, 0.0);
				t6.x = t1.y * t1.y;
				t5 = t1.y * t6.x + 0.200000003;
				t0.x = t0.x * t5;
				t3.x = vs_TEXCOORD1.w;
				t3.y = vs_TEXCOORD2.w;
				t3.z = vs_TEXCOORD3.w;
				t6.xyz = (-t3.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = t6.xyz * vec3(t5) + _WorldSpaceLightPos0.xyz;
				t5 = dot(t6.xyz, t6.xyz);
				t5 = inversesqrt(t5);
				t6.xyz = vec3(t5) * t6.xyz;
				t1.x = dot(t1.xzw, t6.xyz);
				t1.x = max(t1.x, 0.0);
				t1.x = log2(t1.x);
				t5 = _Shininess * 128.0;
				t1.x = t1.x * t5;
				t1.x = exp2(t1.x);
				t0.x = t0.x * t1.x;
				t1.xyz = t4.xyz * t2.xxx + t0.xxx;
				t1.xyz = t1.xyz * _LightColor0.xyz;
				t3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
				t10_3 = texture(_ShadowMapTexture, t3.xy);
				t1.xyz = t1.xyz * t10_3.xxx;
				t0.xyz = t4.xyz * vs_TEXCOORD4.xyz + t1.xyz;
				t1.xyz = t6.yyy * vs_TEXCOORD2.xyz;
				t1.xyz = vs_TEXCOORD1.xyz * t6.xxx + t1.xyz;
				t1.xyz = vs_TEXCOORD3.xyz * t6.zzz + t1.xyz;
				t12 = dot(t1.xyz, t1.xyz);
				t12 = inversesqrt(t12);
				t12 = t12 * t1.z;
				t12 = clamp(t12, 0.0, 1.0);
				t12 = (-t12) + 1.0;
				t12 = log2(t12);
				t12 = t12 * _RimFalloff;
				t12 = exp2(t12);
				t1.xyz = vec3(t12) * _RimColor.xyz;
				t1.xyz = t1.xyz * _RimColor.www;
				SV_Target0.xyz = t1.xyz * vec3(vec3(_Opacity, _Opacity, _Opacity)) + t0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "gles " {
			// Stats: 60 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES
				#version 100

#ifdef VERTEX
				#extension GL_EXT_shadow_samplers : enable
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform mediump vec4 unity_SHAr;
			uniform mediump vec4 unity_SHAg;
			uniform mediump vec4 unity_SHAb;
			uniform mediump vec4 unity_SHBr;
			uniform mediump vec4 unity_SHBg;
			uniform mediump vec4 unity_SHBb;
			uniform mediump vec4 unity_SHC;
			uniform highp mat4 unity_World2Shadow[4];
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			varying highp vec4 xlv_TEXCOORD7;
			void main()
			{
				highp vec3 shlight_1;
				lowp float tangentSign_2;
				lowp vec3 worldTangent_3;
				lowp vec3 worldNormal_4;
				highp vec4 tmpvar_5;
				lowp vec3 tmpvar_6;
				mediump vec4 tmpvar_7;
				highp vec4 tmpvar_8;
				tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec3 tmpvar_9;
				highp vec4 tmpvar_10;
				tmpvar_10 = (_Object2World * _glesVertex);
				tmpvar_9 = tmpvar_10.xyz;
				highp vec4 v_11;
				v_11.x = _World2Object[0].x;
				v_11.y = _World2Object[1].x;
				v_11.z = _World2Object[2].x;
				v_11.w = _World2Object[3].x;
				highp vec4 v_12;
				v_12.x = _World2Object[0].y;
				v_12.y = _World2Object[1].y;
				v_12.z = _World2Object[2].y;
				v_12.w = _World2Object[3].y;
				highp vec4 v_13;
				v_13.x = _World2Object[0].z;
				v_13.y = _World2Object[1].z;
				v_13.z = _World2Object[2].z;
				v_13.w = _World2Object[3].z;
				highp vec3 tmpvar_14;
				tmpvar_14 = normalize(((
					(v_11.xyz * _glesNormal.x)
					+
					(v_12.xyz * _glesNormal.y)
					) + (v_13.xyz * _glesNormal.z)));
				worldNormal_4 = tmpvar_14;
				highp mat3 tmpvar_15;
				tmpvar_15[0] = _Object2World[0].xyz;
				tmpvar_15[1] = _Object2World[1].xyz;
				tmpvar_15[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_16;
				tmpvar_16 = normalize((tmpvar_15 * _glesTANGENT.xyz));
				worldTangent_3 = tmpvar_16;
				highp float tmpvar_17;
				tmpvar_17 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_2 = tmpvar_17;
				lowp vec3 tmpvar_18;
				tmpvar_18 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				highp vec4 tmpvar_19;
				tmpvar_19.x = worldTangent_3.x;
				tmpvar_19.y = tmpvar_18.x;
				tmpvar_19.z = worldNormal_4.x;
				tmpvar_19.w = tmpvar_9.x;
				highp vec4 tmpvar_20;
				tmpvar_20.x = worldTangent_3.y;
				tmpvar_20.y = tmpvar_18.y;
				tmpvar_20.z = worldNormal_4.y;
				tmpvar_20.w = tmpvar_9.y;
				highp vec4 tmpvar_21;
				tmpvar_21.x = worldTangent_3.z;
				tmpvar_21.y = tmpvar_18.z;
				tmpvar_21.z = worldNormal_4.z;
				tmpvar_21.w = tmpvar_9.z;
				lowp vec4 tmpvar_22;
				tmpvar_22.w = 1.0;
				tmpvar_22.xyz = worldNormal_4;
				mediump vec3 tmpvar_23;
				mediump vec4 normal_24;
				normal_24 = tmpvar_22;
				mediump vec3 x2_25;
				mediump vec3 x1_26;
				x1_26.x = dot(unity_SHAr, normal_24);
				x1_26.y = dot(unity_SHAg, normal_24);
				x1_26.z = dot(unity_SHAb, normal_24);
				mediump vec4 tmpvar_27;
				tmpvar_27 = (normal_24.xyzz * normal_24.yzzx);
				x2_25.x = dot(unity_SHBr, tmpvar_27);
				x2_25.y = dot(unity_SHBg, tmpvar_27);
				x2_25.z = dot(unity_SHBb, tmpvar_27);
				tmpvar_23 = ((x2_25 + (unity_SHC.xyz *
					((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					)) + x1_26);
				shlight_1 = tmpvar_23;
				tmpvar_6 = shlight_1;
				tmpvar_7 = (unity_World2Shadow[0] * tmpvar_10);
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_5;
				xlv_TEXCOORD1 = tmpvar_19;
				xlv_TEXCOORD2 = tmpvar_20;
				xlv_TEXCOORD3 = tmpvar_21;
				xlv_COLOR0 = _glesColor;
				xlv_TEXCOORD4 = tmpvar_6;
				xlv_TEXCOORD5 = tmpvar_7;
				xlv_TEXCOORD7 = tmpvar_8;
			}


#endif
#ifdef FRAGMENT
			#extension GL_EXT_shadow_samplers : enable
				uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform mediump vec4 _LightShadowData;
			uniform lowp vec4 _LightColor0;
			uniform lowp sampler2DShadow _ShadowMapTexture;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform highp float _Opacity;
			uniform highp float _RimFalloff;
			uniform highp vec4 _RimColor;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 viewDir_3;
				lowp vec3 worldViewDir_4;
				lowp vec3 lightDir_5;
				highp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				highp vec3 tmpvar_8;
				tmpvar_8.x = xlv_TEXCOORD1.w;
				tmpvar_8.y = xlv_TEXCOORD2.w;
				tmpvar_8.z = xlv_TEXCOORD3.w;
				mediump vec3 tmpvar_9;
				tmpvar_9 = _WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = tmpvar_10;
				lowp vec3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				highp vec3 tmpvar_12;
				tmpvar_12 = (((xlv_TEXCOORD1.xyz * tmpvar_11.x) + (xlv_TEXCOORD2.xyz * tmpvar_11.y)) + (xlv_TEXCOORD3.xyz * tmpvar_11.z));
				viewDir_3 = tmpvar_12;
				tmpvar_6 = viewDir_3;
				tmpvar_7 = xlv_COLOR0;
				lowp vec3 tmpvar_13;
				lowp vec3 tmpvar_14;
				lowp float tmpvar_15;
				highp vec4 mask_16;
				highp vec4 color_17;
				lowp vec4 tmpvar_18;
				tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_17 = tmpvar_18;
				lowp vec4 tmpvar_19;
				tmpvar_19 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_16 = tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				mediump float tmpvar_21;
				tmpvar_21 = (1.0 - tmpvar_20);
				highp vec3 tmpvar_22;
				tmpvar_22 = ((_RimColor.xyz * pow(tmpvar_21, _RimFalloff)) * _RimColor.w);
				highp vec2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				highp vec2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				highp vec2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				highp vec2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				highp vec2 tmpvar_27;
				highp float tmpvar_28;
				tmpvar_28 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, vec2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, vec2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(vec3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = tmpvar_29;
				tmpvar_14 = tmpvar_22;
				highp float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = ((tmpvar_30 + 0.2) * tmpvar_27.y);
				tmpvar_14 = (tmpvar_14 * _Opacity);
				lowp float shadow_31;
				shadow_31 = (_LightShadowData.x + (shadow2DEXT(_ShadowMapTexture, xlv_TEXCOORD5.xyz) * (1.0 - _LightShadowData.x)));
				c_2.w = 0.0;
				highp float tmpvar_32;
				tmpvar_32 = xlv_TEXCOORD1.z;
				worldN_1.x = tmpvar_32;
				highp float tmpvar_33;
				tmpvar_33 = xlv_TEXCOORD2.z;
				worldN_1.y = tmpvar_33;
				highp float tmpvar_34;
				tmpvar_34 = xlv_TEXCOORD3.z;
				worldN_1.z = tmpvar_34;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				lowp vec4 c_35;
				lowp float spec_36;
				lowp vec3 tmpvar_37;
				tmpvar_37 = normalize(worldN_1);
				lowp float tmpvar_38;
				tmpvar_38 = max(0.0, dot(tmpvar_37, tmpvar_11));
				mediump float tmpvar_39;
				tmpvar_39 = (pow(tmpvar_38, (_Shininess * 128.0)) * tmpvar_15);
				spec_36 = tmpvar_39;
				c_35.xyz = ((_LightColor0.xyz * (
					(tmpvar_13 * max(0.0, dot(tmpvar_37, lightDir_5)))
					+ spec_36)) * shadow_31);
				c_35.w = 1.0;
				c_2 = (c_2 + c_35);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out highp vec4 vs_TEXCOORD1;
			out highp vec4 vs_TEXCOORD2;
			out highp vec4 vs_TEXCOORD3;
			out lowp vec4 vs_COLOR0;
			out lowp vec3 vs_TEXCOORD4;
			out mediump vec4 vs_TEXCOORD5;
			out highp vec4 vs_TEXCOORD7;
			highp vec4 t0;
			mediump vec4 t16_0;
			highp vec4 t1;
			highp vec4 t2;
			highp vec3 t3;
			lowp vec3 t10_4;
			mediump vec3 t16_5;
			mediump vec3 t16_6;
			highp float t21;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_TEXCOORD1.w = t0.x;
				t0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t21 = dot(t1.xyz, t1.xyz);
				t21 = inversesqrt(t21);
				t1.xyz = vec3(t21) * t1.xyz;
				t2.x = in_NORMAL0.x * _World2Object[0].x;
				t2.y = in_NORMAL0.x * _World2Object[1].x;
				t2.z = in_NORMAL0.x * _World2Object[2].x;
				t3.x = in_NORMAL0.y * _World2Object[0].y;
				t3.y = in_NORMAL0.y * _World2Object[1].y;
				t3.z = in_NORMAL0.y * _World2Object[2].y;
				t2.xyz = t2.xyz + t3.xyz;
				t3.x = in_NORMAL0.z * _World2Object[0].z;
				t3.y = in_NORMAL0.z * _World2Object[1].z;
				t3.z = in_NORMAL0.z * _World2Object[2].z;
				t2.xyz = t2.xyz + t3.xyz;
				t21 = dot(t2.xyz, t2.xyz);
				t21 = inversesqrt(t21);
				t2.xyz = vec3(t21) * t2.xyz;
				t10_4.xyz = t1.xyz * t2.zxy;
				t10_4.xyz = t2.yzx * t1.yzx + (-t10_4.xyz);
				t10_4.xyz = t0.xxx * t10_4.xyz;
				vs_TEXCOORD1.y = t10_4.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD1.z = t2.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.w = t0.y;
				vs_TEXCOORD3.w = t0.z;
				vs_TEXCOORD2.y = t10_4.y;
				vs_TEXCOORD3.y = t10_4.z;
				vs_TEXCOORD2.z = t2.y;
				vs_TEXCOORD3.z = t2.z;
				vs_COLOR0 = in_COLOR0;
				t16_5.x = t2.y * t2.y;
				t16_5.x = t2.x * t2.x + (-t16_5.x);
				t16_0 = t2.yzzx * t2.xyzz;
				t16_6.x = dot(unity_SHBr, t16_0);
				t16_6.y = dot(unity_SHBg, t16_0);
				t16_6.z = dot(unity_SHBb, t16_0);
				t16_5.xyz = unity_SHC.xyz * t16_5.xxx + t16_6.xyz;
				t2.w = 1.0;
				t16_6.x = dot(unity_SHAr, t2);
				t16_6.y = dot(unity_SHAg, t2);
				t16_6.z = dot(unity_SHAb, t2);
				t16_5.xyz = t16_5.xyz + t16_6.xyz;
				vs_TEXCOORD4.xyz = t16_5.xyz;
				t0 = in_POSITION0.yyyy * _Object2World[1];
				t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
				t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
				t0 = _Object2World[3] * in_POSITION0.wwww + t0;
				t1 = t0.yyyy * unity_World2Shadow[0][1];
				t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
				t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
				t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
				vs_TEXCOORD5 = t0;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
			uniform lowp sampler2D _ShadowMapTexture;
			in highp vec4 vs_TEXCOORD0;
			in highp vec4 vs_TEXCOORD1;
			in highp vec4 vs_TEXCOORD2;
			in highp vec4 vs_TEXCOORD3;
			in lowp vec4 vs_COLOR0;
			in lowp vec3 vs_TEXCOORD4;
			in mediump vec4 vs_TEXCOORD5;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec3 t0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec4 t10_4;
			lowp vec3 t10_5;
			mediump float t16_6;
			highp vec3 t7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_26;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t10_4.x = dot(t2.xyz, t2.xyz);
				t10_4.x = inversesqrt(t10_4.x);
				t10_4.xyz = t2.xyz * t10_4.xxx;
				t10_4.w = dot(t10_4.xyz, _WorldSpaceLightPos0.xyz);
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.x = vs_TEXCOORD1.w;
				t1.y = vs_TEXCOORD2.w;
				t1.z = vs_TEXCOORD3.w;
				t1.xyz = (-t1.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t10_5.xyz = t1.xyz * vec3(t22) + _WorldSpaceLightPos0.xyz;
				t10_26 = dot(t10_5.xyz, t10_5.xyz);
				t10_26 = inversesqrt(t10_26);
				t10_5.xyz = vec3(t10_26) * t10_5.xyz;
				t10_4.x = dot(t10_4.xyz, t10_5.xyz);
				t10_4.xw = max(t10_4.xw, vec2(0.0, 0.0));
				t16_6 = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6 = t16_6 * t16_13;
				t16_6 = exp2(t16_6);
				t16_6 = t0.x * t16_6;
				t10_4.xyz = t7.xyz * t10_4.www + vec3(t16_6);
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
				t16_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
				t16_13 = (-_LightShadowData.x) + 1.0;
				t16_6 = t16_6 * t16_13 + _LightShadowData.x;
				t10_4.xyz = t10_4.xyz * vec3(t16_6);
				t10_4.xyz = t7.xyz * vs_TEXCOORD4.xyz + t10_4.xyz;
				t0.xyz = t10_5.yyy * vs_TEXCOORD2.xyz;
				t0.xyz = vs_TEXCOORD1.xyz * t10_5.xxx + t0.xyz;
				t0.xyz = vs_TEXCOORD3.xyz * t10_5.zzz + t0.xyz;
				t0.x = dot(t0.xyz, t0.xyz);
				t0.x = inversesqrt(t0.x);
				t0.x = t0.x * t0.z;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t0.x = (-t0.x) + 1.0;
				t0.x = log2(t0.x);
				t0.x = t0.x * _RimFalloff;
				t0.x = exp2(t0.x);
				t0.xyz = t0.xxx * _RimColor.xyz;
				t0.xyz = t0.xyz * _RimColor.www;
				SV_Target0.xyz = t0.xyz * vec3(_Opacity) + t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 36 math
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 320
				Matrix 80[glstate_matrix_mvp]
				Matrix 144[_Object2World]
				Matrix 208[_World2Object]
				Vector 0[_ProjectionParams]
				VectorHalf 16[unity_SHAr] 4
				VectorHalf 24[unity_SHAg] 4
				VectorHalf 32[unity_SHAb] 4
				VectorHalf 40[unity_SHBr] 4
				VectorHalf 48[unity_SHBg] 4
				VectorHalf 56[unity_SHBb] 4
				VectorHalf 64[unity_SHC] 4
				Vector 272[unity_WorldTransformParams]
				Vector 288[_MainTex_ST]
				Vector 304[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				float4 xlv_TEXCOORD1;
				float4 xlv_TEXCOORD2;
				float4 xlv_TEXCOORD3;
				half4 xlv_COLOR0;
				half3 xlv_TEXCOORD4;
				half4 xlv_TEXCOORD5;
				float4 xlv_TEXCOORD7;
			};
			struct xlatMtlShaderUniform {
				float4 _ProjectionParams;
				half4 unity_SHAr;
				half4 unity_SHAg;
				half4 unity_SHAb;
				half4 unity_SHBr;
				half4 unity_SHBg;
				half4 unity_SHBb;
				half4 unity_SHC;
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				float3 shlight_2;
				half tangentSign_3;
				half3 worldTangent_4;
				half3 worldNormal_5;
				float4 tmpvar_6;
				float4 tmpvar_7;
				half3 tmpvar_8;
				half4 tmpvar_9;
				float4 tmpvar_10;
				tmpvar_6 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				tmpvar_7.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_7.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float3 tmpvar_11;
				tmpvar_11 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				float4 v_12;
				v_12.x = _mtl_u._World2Object[0].x;
				v_12.y = _mtl_u._World2Object[1].x;
				v_12.z = _mtl_u._World2Object[2].x;
				v_12.w = _mtl_u._World2Object[3].x;
				float4 v_13;
				v_13.x = _mtl_u._World2Object[0].y;
				v_13.y = _mtl_u._World2Object[1].y;
				v_13.z = _mtl_u._World2Object[2].y;
				v_13.w = _mtl_u._World2Object[3].y;
				float4 v_14;
				v_14.x = _mtl_u._World2Object[0].z;
				v_14.y = _mtl_u._World2Object[1].z;
				v_14.z = _mtl_u._World2Object[2].z;
				v_14.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_15;
				tmpvar_15 = normalize(((
					(v_12.xyz * _mtl_i._glesNormal.x)
					+
					(v_13.xyz * _mtl_i._glesNormal.y)
					) + (v_14.xyz * _mtl_i._glesNormal.z)));
				worldNormal_5 = half3(tmpvar_15);
				float3x3 tmpvar_16;
				tmpvar_16[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_16[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_16[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_17;
				tmpvar_17 = normalize((tmpvar_16 * _mtl_i._glesTANGENT.xyz));
				worldTangent_4 = half3(tmpvar_17);
				float tmpvar_18;
				tmpvar_18 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_3 = half(tmpvar_18);
				half3 tmpvar_19;
				tmpvar_19 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
				float4 tmpvar_20;
				tmpvar_20.x = float(worldTangent_4.x);
				tmpvar_20.y = float(tmpvar_19.x);
				tmpvar_20.z = float(worldNormal_5.x);
				tmpvar_20.w = tmpvar_11.x;
				float4 tmpvar_21;
				tmpvar_21.x = float(worldTangent_4.y);
				tmpvar_21.y = float(tmpvar_19.y);
				tmpvar_21.z = float(worldNormal_5.y);
				tmpvar_21.w = tmpvar_11.y;
				float4 tmpvar_22;
				tmpvar_22.x = float(worldTangent_4.z);
				tmpvar_22.y = float(tmpvar_19.z);
				tmpvar_22.z = float(worldNormal_5.z);
				tmpvar_22.w = tmpvar_11.z;
				half4 tmpvar_23;
				tmpvar_23.w = half(1.0);
				tmpvar_23.xyz = worldNormal_5;
				half3 tmpvar_24;
				half4 normal_25;
				normal_25 = tmpvar_23;
				half3 x2_26;
				half3 x1_27;
				x1_27.x = dot(_mtl_u.unity_SHAr, normal_25);
				x1_27.y = dot(_mtl_u.unity_SHAg, normal_25);
				x1_27.z = dot(_mtl_u.unity_SHAb, normal_25);
				half4 tmpvar_28;
				tmpvar_28 = (normal_25.xyzz * normal_25.yzzx);
				x2_26.x = dot(_mtl_u.unity_SHBr, tmpvar_28);
				x2_26.y = dot(_mtl_u.unity_SHBg, tmpvar_28);
				x2_26.z = dot(_mtl_u.unity_SHBb, tmpvar_28);
				tmpvar_24 = ((x2_26 + (_mtl_u.unity_SHC.xyz *
					((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					)) + x1_27);
				shlight_2 = float3(tmpvar_24);
				tmpvar_8 = half3(shlight_2);
				float4 o_29;
				float4 tmpvar_30;
				tmpvar_30 = (tmpvar_6 * 0.5);
				float2 tmpvar_31;
				tmpvar_31.x = tmpvar_30.x;
				tmpvar_31.y = (tmpvar_30.y * _mtl_u._ProjectionParams.x);
				o_29.xy = (tmpvar_31 + tmpvar_30.w);
				o_29.zw = tmpvar_6.zw;
				tmpvar_9 = half4(o_29);
				_mtl_o.gl_Position = tmpvar_6;
				_mtl_o.xlv_TEXCOORD0 = tmpvar_7;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_20;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_21;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_22;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				_mtl_o.xlv_TEXCOORD4 = tmpvar_8;
				_mtl_o.xlv_TEXCOORD5 = tmpvar_9;
				_mtl_o.xlv_TEXCOORD7 = tmpvar_10;
				return _mtl_o;
			}

			"
		}
		SubProgram "gles " {
			// Stats: 60 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GLES
				#version 100

#ifdef VERTEX
				#extension GL_EXT_shadow_samplers : enable
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp vec4 unity_4LightPosX0;
			uniform highp vec4 unity_4LightPosY0;
			uniform highp vec4 unity_4LightPosZ0;
			uniform mediump vec4 unity_4LightAtten0;
			uniform mediump vec4 unity_LightColor[8];
			uniform mediump vec4 unity_SHAr;
			uniform mediump vec4 unity_SHAg;
			uniform mediump vec4 unity_SHAb;
			uniform mediump vec4 unity_SHBr;
			uniform mediump vec4 unity_SHBg;
			uniform mediump vec4 unity_SHBb;
			uniform mediump vec4 unity_SHC;
			uniform highp mat4 unity_World2Shadow[4];
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			varying highp vec4 xlv_TEXCOORD7;
			void main()
			{
				highp vec3 shlight_1;
				lowp float tangentSign_2;
				lowp vec3 worldTangent_3;
				lowp vec3 worldNormal_4;
				highp vec4 tmpvar_5;
				lowp vec3 tmpvar_6;
				mediump vec4 tmpvar_7;
				highp vec4 tmpvar_8;
				tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_5.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec3 tmpvar_9;
				highp vec4 tmpvar_10;
				tmpvar_10 = (_Object2World * _glesVertex);
				tmpvar_9 = tmpvar_10.xyz;
				highp vec4 v_11;
				v_11.x = _World2Object[0].x;
				v_11.y = _World2Object[1].x;
				v_11.z = _World2Object[2].x;
				v_11.w = _World2Object[3].x;
				highp vec4 v_12;
				v_12.x = _World2Object[0].y;
				v_12.y = _World2Object[1].y;
				v_12.z = _World2Object[2].y;
				v_12.w = _World2Object[3].y;
				highp vec4 v_13;
				v_13.x = _World2Object[0].z;
				v_13.y = _World2Object[1].z;
				v_13.z = _World2Object[2].z;
				v_13.w = _World2Object[3].z;
				highp vec3 tmpvar_14;
				tmpvar_14 = normalize(((
					(v_11.xyz * _glesNormal.x)
					+
					(v_12.xyz * _glesNormal.y)
					) + (v_13.xyz * _glesNormal.z)));
				worldNormal_4 = tmpvar_14;
				highp mat3 tmpvar_15;
				tmpvar_15[0] = _Object2World[0].xyz;
				tmpvar_15[1] = _Object2World[1].xyz;
				tmpvar_15[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_16;
				tmpvar_16 = normalize((tmpvar_15 * _glesTANGENT.xyz));
				worldTangent_3 = tmpvar_16;
				highp float tmpvar_17;
				tmpvar_17 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_2 = tmpvar_17;
				lowp vec3 tmpvar_18;
				tmpvar_18 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				highp vec4 tmpvar_19;
				tmpvar_19.x = worldTangent_3.x;
				tmpvar_19.y = tmpvar_18.x;
				tmpvar_19.z = worldNormal_4.x;
				tmpvar_19.w = tmpvar_9.x;
				highp vec4 tmpvar_20;
				tmpvar_20.x = worldTangent_3.y;
				tmpvar_20.y = tmpvar_18.y;
				tmpvar_20.z = worldNormal_4.y;
				tmpvar_20.w = tmpvar_9.y;
				highp vec4 tmpvar_21;
				tmpvar_21.x = worldTangent_3.z;
				tmpvar_21.y = tmpvar_18.z;
				tmpvar_21.z = worldNormal_4.z;
				tmpvar_21.w = tmpvar_9.z;
				lowp vec4 tmpvar_22;
				tmpvar_22.w = 1.0;
				tmpvar_22.xyz = worldNormal_4;
				mediump vec3 tmpvar_23;
				mediump vec4 normal_24;
				normal_24 = tmpvar_22;
				mediump vec3 x2_25;
				mediump vec3 x1_26;
				x1_26.x = dot(unity_SHAr, normal_24);
				x1_26.y = dot(unity_SHAg, normal_24);
				x1_26.z = dot(unity_SHAb, normal_24);
				mediump vec4 tmpvar_27;
				tmpvar_27 = (normal_24.xyzz * normal_24.yzzx);
				x2_25.x = dot(unity_SHBr, tmpvar_27);
				x2_25.y = dot(unity_SHBg, tmpvar_27);
				x2_25.z = dot(unity_SHBb, tmpvar_27);
				tmpvar_23 = ((x2_25 + (unity_SHC.xyz *
					((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					)) + x1_26);
				shlight_1 = tmpvar_23;
				tmpvar_6 = shlight_1;
				highp vec3 lightColor0_28;
				lightColor0_28 = unity_LightColor[0].xyz;
				highp vec3 lightColor1_29;
				lightColor1_29 = unity_LightColor[1].xyz;
				highp vec3 lightColor2_30;
				lightColor2_30 = unity_LightColor[2].xyz;
				highp vec3 lightColor3_31;
				lightColor3_31 = unity_LightColor[3].xyz;
				highp vec4 lightAttenSq_32;
				lightAttenSq_32 = unity_4LightAtten0;
				highp vec3 normal_33;
				normal_33 = worldNormal_4;
				highp vec3 col_34;
				highp vec4 ndotl_35;
				highp vec4 lengthSq_36;
				highp vec4 tmpvar_37;
				tmpvar_37 = (unity_4LightPosX0 - tmpvar_10.x);
				highp vec4 tmpvar_38;
				tmpvar_38 = (unity_4LightPosY0 - tmpvar_10.y);
				highp vec4 tmpvar_39;
				tmpvar_39 = (unity_4LightPosZ0 - tmpvar_10.z);
				lengthSq_36 = (tmpvar_37 * tmpvar_37);
				lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
				lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
				ndotl_35 = (tmpvar_37 * normal_33.x);
				ndotl_35 = (ndotl_35 + (tmpvar_38 * normal_33.y));
				ndotl_35 = (ndotl_35 + (tmpvar_39 * normal_33.z));
				highp vec4 tmpvar_40;
				tmpvar_40 = max(vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(lengthSq_36)));
				ndotl_35 = tmpvar_40;
				highp vec4 tmpvar_41;
				tmpvar_41 = (tmpvar_40 * (1.0 / ((1.0 +
					(lengthSq_36 * lightAttenSq_32)
					))));
				col_34 = (lightColor0_28 * tmpvar_41.x);
				col_34 = (col_34 + (lightColor1_29 * tmpvar_41.y));
				col_34 = (col_34 + (lightColor2_30 * tmpvar_41.z));
				col_34 = (col_34 + (lightColor3_31 * tmpvar_41.w));
				tmpvar_6 = (tmpvar_6 + col_34);
				tmpvar_7 = (unity_World2Shadow[0] * tmpvar_10);
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_5;
				xlv_TEXCOORD1 = tmpvar_19;
				xlv_TEXCOORD2 = tmpvar_20;
				xlv_TEXCOORD3 = tmpvar_21;
				xlv_COLOR0 = _glesColor;
				xlv_TEXCOORD4 = tmpvar_6;
				xlv_TEXCOORD5 = tmpvar_7;
				xlv_TEXCOORD7 = tmpvar_8;
			}


#endif
#ifdef FRAGMENT
			#extension GL_EXT_shadow_samplers : enable
				uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform mediump vec4 _LightShadowData;
			uniform lowp vec4 _LightColor0;
			uniform lowp sampler2DShadow _ShadowMapTexture;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			uniform highp float _Opacity;
			uniform highp float _RimFalloff;
			uniform highp vec4 _RimColor;
			varying highp vec4 xlv_TEXCOORD0;
			varying highp vec4 xlv_TEXCOORD1;
			varying highp vec4 xlv_TEXCOORD2;
			varying highp vec4 xlv_TEXCOORD3;
			varying lowp vec4 xlv_COLOR0;
			varying lowp vec3 xlv_TEXCOORD4;
			varying mediump vec4 xlv_TEXCOORD5;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 viewDir_3;
				lowp vec3 worldViewDir_4;
				lowp vec3 lightDir_5;
				highp vec3 tmpvar_6;
				highp vec4 tmpvar_7;
				highp vec3 tmpvar_8;
				tmpvar_8.x = xlv_TEXCOORD1.w;
				tmpvar_8.y = xlv_TEXCOORD2.w;
				tmpvar_8.z = xlv_TEXCOORD3.w;
				mediump vec3 tmpvar_9;
				tmpvar_9 = _WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = tmpvar_10;
				lowp vec3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				highp vec3 tmpvar_12;
				tmpvar_12 = (((xlv_TEXCOORD1.xyz * tmpvar_11.x) + (xlv_TEXCOORD2.xyz * tmpvar_11.y)) + (xlv_TEXCOORD3.xyz * tmpvar_11.z));
				viewDir_3 = tmpvar_12;
				tmpvar_6 = viewDir_3;
				tmpvar_7 = xlv_COLOR0;
				lowp vec3 tmpvar_13;
				lowp vec3 tmpvar_14;
				lowp float tmpvar_15;
				highp vec4 mask_16;
				highp vec4 color_17;
				lowp vec4 tmpvar_18;
				tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_17 = tmpvar_18;
				lowp vec4 tmpvar_19;
				tmpvar_19 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_16 = tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				mediump float tmpvar_21;
				tmpvar_21 = (1.0 - tmpvar_20);
				highp vec3 tmpvar_22;
				tmpvar_22 = ((_RimColor.xyz * pow(tmpvar_21, _RimFalloff)) * _RimColor.w);
				highp vec2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				highp vec2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				highp vec2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				highp vec2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				highp vec2 tmpvar_27;
				highp float tmpvar_28;
				tmpvar_28 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, vec2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, vec2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(vec3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = tmpvar_29;
				tmpvar_14 = tmpvar_22;
				highp float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = ((tmpvar_30 + 0.2) * tmpvar_27.y);
				tmpvar_14 = (tmpvar_14 * _Opacity);
				lowp float shadow_31;
				shadow_31 = (_LightShadowData.x + (shadow2DEXT(_ShadowMapTexture, xlv_TEXCOORD5.xyz) * (1.0 - _LightShadowData.x)));
				c_2.w = 0.0;
				highp float tmpvar_32;
				tmpvar_32 = xlv_TEXCOORD1.z;
				worldN_1.x = tmpvar_32;
				highp float tmpvar_33;
				tmpvar_33 = xlv_TEXCOORD2.z;
				worldN_1.y = tmpvar_33;
				highp float tmpvar_34;
				tmpvar_34 = xlv_TEXCOORD3.z;
				worldN_1.z = tmpvar_34;
				c_2.xyz = (tmpvar_13 * xlv_TEXCOORD4);
				lowp vec4 c_35;
				lowp float spec_36;
				lowp vec3 tmpvar_37;
				tmpvar_37 = normalize(worldN_1);
				lowp float tmpvar_38;
				tmpvar_38 = max(0.0, dot(tmpvar_37, tmpvar_11));
				mediump float tmpvar_39;
				tmpvar_39 = (pow(tmpvar_38, (_Shininess * 128.0)) * tmpvar_15);
				spec_36 = tmpvar_39;
				c_35.xyz = ((_LightColor0.xyz * (
					(tmpvar_13 * max(0.0, dot(tmpvar_37, lightDir_5)))
					+ spec_36)) * shadow_31);
				c_35.w = 1.0;
				c_2 = (c_2 + c_35);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out highp vec4 vs_TEXCOORD1;
			out highp vec4 vs_TEXCOORD2;
			out highp vec4 vs_TEXCOORD3;
			out lowp vec4 vs_COLOR0;
			out lowp vec3 vs_TEXCOORD4;
			out mediump vec4 vs_TEXCOORD5;
			out highp vec4 vs_TEXCOORD7;
			highp vec4 t0;
			mediump vec4 t16_0;
			highp vec4 t1;
			highp vec4 t2;
			highp vec4 t3;
			lowp vec3 t10_3;
			mediump vec3 t16_4;
			highp vec4 t5;
			mediump vec3 t16_5;
			highp float t18;
			highp float t19;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t0.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t0.xyz;
				t18 = dot(t0.xyz, t0.xyz);
				t18 = inversesqrt(t18);
				t0.xyz = vec3(t18) * t0.xyz;
				vs_TEXCOORD1.x = t0.z;
				t18 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t1.x = in_NORMAL0.x * _World2Object[0].x;
				t1.y = in_NORMAL0.x * _World2Object[1].x;
				t1.z = in_NORMAL0.x * _World2Object[2].x;
				t2.x = in_NORMAL0.y * _World2Object[0].y;
				t2.y = in_NORMAL0.y * _World2Object[1].y;
				t2.z = in_NORMAL0.y * _World2Object[2].y;
				t1.xyz = t1.xyz + t2.xyz;
				t2.x = in_NORMAL0.z * _World2Object[0].z;
				t2.y = in_NORMAL0.z * _World2Object[1].z;
				t2.z = in_NORMAL0.z * _World2Object[2].z;
				t1.xyz = t1.xyz + t2.xyz;
				t19 = dot(t1.xyz, t1.xyz);
				t19 = inversesqrt(t19);
				t1.xyz = vec3(t19) * t1.xyz;
				t10_3.xyz = t0.xyz * t1.zxy;
				t10_3.xyz = t1.yzx * t0.yzx + (-t10_3.xyz);
				t10_3.xyz = vec3(t18) * t10_3.xyz;
				vs_TEXCOORD1.y = t10_3.x;
				vs_TEXCOORD1.z = t1.x;
				t2.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t2.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t2.xyz;
				t2.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t2.xyz;
				t2.xyz = _Object2World[3].xyz * in_POSITION0.www + t2.xyz;
				vs_TEXCOORD1.w = t2.x;
				vs_TEXCOORD2.x = t0.x;
				vs_TEXCOORD3.x = t0.y;
				vs_TEXCOORD2.y = t10_3.y;
				vs_TEXCOORD3.y = t10_3.z;
				vs_TEXCOORD2.z = t1.y;
				vs_TEXCOORD2.w = t2.y;
				vs_TEXCOORD3.w = t2.z;
				vs_TEXCOORD3.z = t1.z;
				vs_COLOR0 = in_COLOR0;
				t16_4.x = t1.y * t1.y;
				t16_4.x = t1.x * t1.x + (-t16_4.x);
				t16_0 = t1.yzzx * t1.xyzz;
				t16_5.x = dot(unity_SHBr, t16_0);
				t16_5.y = dot(unity_SHBg, t16_0);
				t16_5.z = dot(unity_SHBb, t16_0);
				t16_4.xyz = unity_SHC.xyz * t16_4.xxx + t16_5.xyz;
				t1.w = 1.0;
				t16_5.x = dot(unity_SHAr, t1);
				t16_5.y = dot(unity_SHAg, t1);
				t16_5.z = dot(unity_SHAb, t1);
				t16_4.xyz = t16_4.xyz + t16_5.xyz;
				t0 = (-t2.yyyy) + unity_4LightPosY0;
				t3 = t1.yyyy * t0;
				t0 = t0 * t0;
				t5 = (-t2.xxxx) + unity_4LightPosX0;
				t2 = (-t2.zzzz) + unity_4LightPosZ0;
				t3 = t5 * t1.xxxx + t3;
				t1 = t2 * t1.zzzz + t3;
				t0 = t5 * t5 + t0;
				t0 = t2 * t2 + t0;
				t2 = inversesqrt(t0);
				t0 = t0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
				t0 = vec4(1.0, 1.0, 1.0, 1.0) / t0;
				t1 = t1 * t2;
				t1 = max(t1, vec4(0.0, 0.0, 0.0, 0.0));
				t0 = t0 * t1;
				t1.xyz = t0.yyy * unity_LightColor[1].xyz;
				t1.xyz = unity_LightColor[0].xyz * t0.xxx + t1.xyz;
				t1.xyz = unity_LightColor[2].xyz * t0.zzz + t1.xyz;
				t1.xyz = unity_LightColor[3].xyz * t0.www + t1.xyz;
				t1.xyz = t1.xyz + t16_4.xyz;
				vs_TEXCOORD4.xyz = t1.xyz;
				t0 = in_POSITION0.yyyy * _Object2World[1];
				t0 = _Object2World[0] * in_POSITION0.xxxx + t0;
				t0 = _Object2World[2] * in_POSITION0.zzzz + t0;
				t0 = _Object2World[3] * in_POSITION0.wwww + t0;
				t1 = t0.yyyy * unity_World2Shadow[0][1];
				t1 = unity_World2Shadow[0][0] * t0.xxxx + t1;
				t1 = unity_World2Shadow[0][2] * t0.zzzz + t1;
				t0 = unity_World2Shadow[0][3] * t0.wwww + t1;
				vs_TEXCOORD5 = t0;
				vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
			uniform lowp sampler2D _ShadowMapTexture;
			in highp vec4 vs_TEXCOORD0;
			in highp vec4 vs_TEXCOORD1;
			in highp vec4 vs_TEXCOORD2;
			in highp vec4 vs_TEXCOORD3;
			in lowp vec4 vs_COLOR0;
			in lowp vec3 vs_TEXCOORD4;
			in mediump vec4 vs_TEXCOORD5;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec3 t0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec4 t10_4;
			lowp vec3 t10_5;
			mediump float t16_6;
			highp vec3 t7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_26;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t10_4.x = dot(t2.xyz, t2.xyz);
				t10_4.x = inversesqrt(t10_4.x);
				t10_4.xyz = t2.xyz * t10_4.xxx;
				t10_4.w = dot(t10_4.xyz, _WorldSpaceLightPos0.xyz);
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.x = vs_TEXCOORD1.w;
				t1.y = vs_TEXCOORD2.w;
				t1.z = vs_TEXCOORD3.w;
				t1.xyz = (-t1.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t10_5.xyz = t1.xyz * vec3(t22) + _WorldSpaceLightPos0.xyz;
				t10_26 = dot(t10_5.xyz, t10_5.xyz);
				t10_26 = inversesqrt(t10_26);
				t10_5.xyz = vec3(t10_26) * t10_5.xyz;
				t10_4.x = dot(t10_4.xyz, t10_5.xyz);
				t10_4.xw = max(t10_4.xw, vec2(0.0, 0.0));
				t16_6 = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6 = t16_6 * t16_13;
				t16_6 = exp2(t16_6);
				t16_6 = t0.x * t16_6;
				t10_4.xyz = t7.xyz * t10_4.www + vec3(t16_6);
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
				t16_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
				t16_13 = (-_LightShadowData.x) + 1.0;
				t16_6 = t16_6 * t16_13 + _LightShadowData.x;
				t10_4.xyz = t10_4.xyz * vec3(t16_6);
				t10_4.xyz = t7.xyz * vs_TEXCOORD4.xyz + t10_4.xyz;
				t0.xyz = t10_5.yyy * vs_TEXCOORD2.xyz;
				t0.xyz = vs_TEXCOORD1.xyz * t10_5.xxx + t0.xyz;
				t0.xyz = vs_TEXCOORD3.xyz * t10_5.zzz + t0.xyz;
				t0.x = dot(t0.xyz, t0.xyz);
				t0.x = inversesqrt(t0.x);
				t0.x = t0.x * t0.z;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t0.x = (-t0.x) + 1.0;
				t0.x = log2(t0.x);
				t0.x = t0.x * _RimFalloff;
				t0.x = exp2(t0.x);
				t0.xyz = t0.xxx * _RimColor.xyz;
				t0.xyz = t0.xyz * _RimColor.www;
				SV_Target0.xyz = t0.xyz * vec3(_Opacity) + t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 64 math
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 432
				Matrix 192[glstate_matrix_mvp]
				Matrix 256[_Object2World]
				Matrix 320[_World2Object]
				Vector 0[_ProjectionParams]
				Vector 16[unity_4LightPosX0]
				Vector 32[unity_4LightPosY0]
				Vector 48[unity_4LightPosZ0]
				VectorHalf 64[unity_4LightAtten0] 4
				VectorHalf 72[unity_LightColor0] 4
				VectorHalf 80[unity_LightColor1] 4
				VectorHalf 88[unity_LightColor2] 4
				VectorHalf 96[unity_LightColor3] 4
				VectorHalf 104[unity_LightColor4] 4
				VectorHalf 112[unity_LightColor5] 4
				VectorHalf 120[unity_LightColor6] 4
				VectorHalf 128[unity_LightColor7] 4
				VectorHalf 136[unity_SHAr] 4
				VectorHalf 144[unity_SHAg] 4
				VectorHalf 152[unity_SHAb] 4
				VectorHalf 160[unity_SHBr] 4
				VectorHalf 168[unity_SHBg] 4
				VectorHalf 176[unity_SHBb] 4
				VectorHalf 184[unity_SHC] 4
				Vector 384[unity_WorldTransformParams]
				Vector 400[_MainTex_ST]
				Vector 416[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				float4 xlv_TEXCOORD1;
				float4 xlv_TEXCOORD2;
				float4 xlv_TEXCOORD3;
				half4 xlv_COLOR0;
				half3 xlv_TEXCOORD4;
				half4 xlv_TEXCOORD5;
				float4 xlv_TEXCOORD7;
			};
			struct xlatMtlShaderUniform {
				float4 _ProjectionParams;
				float4 unity_4LightPosX0;
				float4 unity_4LightPosY0;
				float4 unity_4LightPosZ0;
				half4 unity_4LightAtten0;
				half4 unity_LightColor[8];
				half4 unity_SHAr;
				half4 unity_SHAg;
				half4 unity_SHAb;
				half4 unity_SHBr;
				half4 unity_SHBg;
				half4 unity_SHBb;
				half4 unity_SHC;
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				float3 shlight_2;
				half tangentSign_3;
				half3 worldTangent_4;
				half3 worldNormal_5;
				float4 tmpvar_6;
				float4 tmpvar_7;
				half3 tmpvar_8;
				half4 tmpvar_9;
				float4 tmpvar_10;
				tmpvar_6 = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				tmpvar_7.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_7.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float3 tmpvar_11;
				tmpvar_11 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				float4 v_12;
				v_12.x = _mtl_u._World2Object[0].x;
				v_12.y = _mtl_u._World2Object[1].x;
				v_12.z = _mtl_u._World2Object[2].x;
				v_12.w = _mtl_u._World2Object[3].x;
				float4 v_13;
				v_13.x = _mtl_u._World2Object[0].y;
				v_13.y = _mtl_u._World2Object[1].y;
				v_13.z = _mtl_u._World2Object[2].y;
				v_13.w = _mtl_u._World2Object[3].y;
				float4 v_14;
				v_14.x = _mtl_u._World2Object[0].z;
				v_14.y = _mtl_u._World2Object[1].z;
				v_14.z = _mtl_u._World2Object[2].z;
				v_14.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_15;
				tmpvar_15 = normalize(((
					(v_12.xyz * _mtl_i._glesNormal.x)
					+
					(v_13.xyz * _mtl_i._glesNormal.y)
					) + (v_14.xyz * _mtl_i._glesNormal.z)));
				worldNormal_5 = half3(tmpvar_15);
				float3x3 tmpvar_16;
				tmpvar_16[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_16[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_16[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_17;
				tmpvar_17 = normalize((tmpvar_16 * _mtl_i._glesTANGENT.xyz));
				worldTangent_4 = half3(tmpvar_17);
				float tmpvar_18;
				tmpvar_18 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_3 = half(tmpvar_18);
				half3 tmpvar_19;
				tmpvar_19 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
				float4 tmpvar_20;
				tmpvar_20.x = float(worldTangent_4.x);
				tmpvar_20.y = float(tmpvar_19.x);
				tmpvar_20.z = float(worldNormal_5.x);
				tmpvar_20.w = tmpvar_11.x;
				float4 tmpvar_21;
				tmpvar_21.x = float(worldTangent_4.y);
				tmpvar_21.y = float(tmpvar_19.y);
				tmpvar_21.z = float(worldNormal_5.y);
				tmpvar_21.w = tmpvar_11.y;
				float4 tmpvar_22;
				tmpvar_22.x = float(worldTangent_4.z);
				tmpvar_22.y = float(tmpvar_19.z);
				tmpvar_22.z = float(worldNormal_5.z);
				tmpvar_22.w = tmpvar_11.z;
				half4 tmpvar_23;
				tmpvar_23.w = half(1.0);
				tmpvar_23.xyz = worldNormal_5;
				half3 tmpvar_24;
				half4 normal_25;
				normal_25 = tmpvar_23;
				half3 x2_26;
				half3 x1_27;
				x1_27.x = dot(_mtl_u.unity_SHAr, normal_25);
				x1_27.y = dot(_mtl_u.unity_SHAg, normal_25);
				x1_27.z = dot(_mtl_u.unity_SHAb, normal_25);
				half4 tmpvar_28;
				tmpvar_28 = (normal_25.xyzz * normal_25.yzzx);
				x2_26.x = dot(_mtl_u.unity_SHBr, tmpvar_28);
				x2_26.y = dot(_mtl_u.unity_SHBg, tmpvar_28);
				x2_26.z = dot(_mtl_u.unity_SHBb, tmpvar_28);
				tmpvar_24 = ((x2_26 + (_mtl_u.unity_SHC.xyz *
					((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					)) + x1_27);
				shlight_2 = float3(tmpvar_24);
				tmpvar_8 = half3(shlight_2);
				float3 lightColor0_29;
				lightColor0_29 = float3(_mtl_u.unity_LightColor[0].xyz);
				float3 lightColor1_30;
				lightColor1_30 = float3(_mtl_u.unity_LightColor[1].xyz);
				float3 lightColor2_31;
				lightColor2_31 = float3(_mtl_u.unity_LightColor[2].xyz);
				float3 lightColor3_32;
				lightColor3_32 = float3(_mtl_u.unity_LightColor[3].xyz);
				float4 lightAttenSq_33;
				lightAttenSq_33 = float4(_mtl_u.unity_4LightAtten0);
				float3 normal_34;
				normal_34 = float3(worldNormal_5);
				float3 col_35;
				float4 ndotl_36;
				float4 lengthSq_37;
				float4 tmpvar_38;
				tmpvar_38 = (_mtl_u.unity_4LightPosX0 - tmpvar_11.x);
				float4 tmpvar_39;
				tmpvar_39 = (_mtl_u.unity_4LightPosY0 - tmpvar_11.y);
				float4 tmpvar_40;
				tmpvar_40 = (_mtl_u.unity_4LightPosZ0 - tmpvar_11.z);
				lengthSq_37 = (tmpvar_38 * tmpvar_38);
				lengthSq_37 = (lengthSq_37 + (tmpvar_39 * tmpvar_39));
				lengthSq_37 = (lengthSq_37 + (tmpvar_40 * tmpvar_40));
				ndotl_36 = (tmpvar_38 * normal_34.x);
				ndotl_36 = (ndotl_36 + (tmpvar_39 * normal_34.y));
				ndotl_36 = (ndotl_36 + (tmpvar_40 * normal_34.z));
				float4 tmpvar_41;
				tmpvar_41 = max(float4(0.0, 0.0, 0.0, 0.0), (ndotl_36 * rsqrt(lengthSq_37)));
				ndotl_36 = tmpvar_41;
				float4 tmpvar_42;
				tmpvar_42 = (tmpvar_41 * (1.0 / ((1.0 +
					(lengthSq_37 * lightAttenSq_33)
					))));
				col_35 = (lightColor0_29 * tmpvar_42.x);
				col_35 = (col_35 + (lightColor1_30 * tmpvar_42.y));
				col_35 = (col_35 + (lightColor2_31 * tmpvar_42.z));
				col_35 = (col_35 + (lightColor3_32 * tmpvar_42.w));
				tmpvar_8 = half3(((float3)tmpvar_8 + col_35));
				float4 o_43;
				float4 tmpvar_44;
				tmpvar_44 = (tmpvar_6 * 0.5);
				float2 tmpvar_45;
				tmpvar_45.x = tmpvar_44.x;
				tmpvar_45.y = (tmpvar_44.y * _mtl_u._ProjectionParams.x);
				o_43.xy = (tmpvar_45 + tmpvar_44.w);
				o_43.zw = tmpvar_6.zw;
				tmpvar_9 = half4(o_43);
				_mtl_o.gl_Position = tmpvar_6;
				_mtl_o.xlv_TEXCOORD0 = tmpvar_7;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_20;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_21;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_22;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				_mtl_o.xlv_TEXCOORD4 = tmpvar_8;
				_mtl_o.xlv_TEXCOORD5 = tmpvar_9;
				_mtl_o.xlv_TEXCOORD7 = tmpvar_10;
				return _mtl_o;
			}

			"
		}
	}
	Program "fp" {
		SubProgram "opengl " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLSL"
		}
		SubProgram "d3d9 " {
			// Stats: 68 math, 2 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Vector 2[_LightColor0]
				Float 4[_Opacity]
				Vector 6[_RimColor]
				Float 5[_RimFalloff]
				Float 3[_Shininess]
				Vector 0[_WorldSpaceCameraPos]
				Vector 1[_WorldSpaceLightPos0]
				SetTexture 0[_MainTex] 2D 0
				SetTexture 1[_Emissive] 2D 1
				"ps_3_0
				def c7, 1, 3, -2, -1
				def c8, 1, 1.39999998, 0.200000003, 0
				def c9, 128, 0, 0, 0
				dcl_texcoord v0
				dcl_texcoord1 v1
				dcl_texcoord2 v2
				dcl_texcoord3 v3
				dcl_color v4
				dcl_texcoord4_pp v5.xyz
				dcl_2d s0
				dcl_2d s1
				mul r0.x, c7.y, v0.z
				mov_sat r0.x, r0.x
				texld r1, v0, s0
				mov r2.xz, r1
				texld r3, v0, s1
				mov r2.yw, r3.xxzz
				mov r1.xz, r3.yyww
				lrp r3.xy, r0.x, r1, r2.yxzw
				mad_sat r0.xy, v0.z, c7.y, c7.zwzw
				lrp r3.zw, r0.x, r1, r2.xywz
				lrp r1.xy, r0.y, r3.zwzw, r3
				mul r0.x, r1.y, r1.y
				add r0.yz, -r1.x, c8.xxyw
				mad_sat r0.x, r0.y, r0.x, r1.y
				lrp r2.xyz, r1.x, v4, r0.x
				add r0.xyw, -r2.xyzz, v4.xyzz
				mad r0.xyw, v0.w, r0, r2.xyzz
				mov_sat r1.z, v4.w
				lrp_pp r2.xyz, r1.z, r0.xyww, r1.y
				mov r3.x, v1.z
				mov r3.y, v2.z
				mov r3.z, v3.z
				nrm_pp r4.xyz, r3
				dp3_pp r0.x, r4, c1
				max_pp r1.y, r0.x, c8.w
				mul r0.x, r0.z, r0.z
				mad r0.x, r0.z, r0.x, c8.z
				mul_pp r0.x, r1.x, r0.x
				mov r3.x, v1.w
				mov r3.y, v2.w
				mov r3.z, v3.w
				add r0.yzw, -r3.xxyz, c0.xxyz
				dp3 r1.x, r0.yzww, r0.yzww
				rsq r1.x, r1.x
				mad_pp r0.yzw, r0, r1.x, c1.xxyz
				nrm_pp r3.xyz, r0.yzww
				dp3_pp r0.y, r4, r3
				max_pp r1.x, r0.y, c8.w
				mov r4.x, c3.x
				mul_pp r0.y, r4.x, c9.x
				pow_pp r2.w, r1.x, r0.y
				mul_pp r0.x, r0.x, r2.w
				mad_pp r0.xyz, r2, r1.y, r0.x
				mul_pp r0.xyz, r0, c2
				mad_pp r0.xyz, r2, v5, r0
				mul r1.xyz, r3.y, v2
				mad r1.xyz, v1, r3.x, r1
				mad_pp r1.xyz, v3, r3.z, r1
				dp3 r0.w, r1, r1
				rsq r0.w, r0.w
				mul_sat r0.w, r0.w, r1.z
				add_pp r0.w, -r0.w, c7.x
				pow r1.x, r0.w, c5.x
				mul r1.xyz, r1.x, c6
				mul_pp r1.xyz, r1, c6.w
				mad_pp oC0.xyz, r1, c4.x, r0
				mov_pp oC0.w, c7.x

				"
		}
		SubProgram "d3d11 " {
			// Stats: 54 math, 2 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				SetTexture 0[_MainTex] 2D 0
				SetTexture 1[_Emissive] 2D 1
				ConstBuffer "$Globals" 208
				Vector 96[_LightColor0]
				Float 144[_Shininess]
				Float 148[_Opacity]
				Float 152[_RimFalloff]
				Vector 160[_RimColor]
				ConstBuffer "UnityPerCamera" 144
				Vector 64[_WorldSpaceCameraPos] 3
				ConstBuffer "UnityLighting" 720
				Vector 0[_WorldSpaceLightPos0]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				"ps_4_0
				root12:acadacaa
				eefiecedhpckppfpfgclncioefmdcpbbjgeodaocabaaaaaaoeajaaaaadaaaaaa
				cmaaaaaabiabaaaaemabaaaaejfdeheooeaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
				adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaannaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfa
				epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
				abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
				fdfgfpfegbhcghgfheaaklklfdeieefcjaaiaaaaeaaaaaaaceacaaaafjaaaaae
				egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
				egiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
				abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
				ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
				pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
				gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
				diaaaaahbcaabaaaaaaaaaaackbabaaaabaaaaaaabeaaaaaaaaaeaeadgcaaaaf
				bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
				abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafkcaabaaaacaaaaaa
				fganbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
				abaaaaaaaagabaaaabaaaaaadgaaaaaffcaabaaaacaaaaaafgahbaaaadaaaaaa
				dgaaaaafkcaabaaaabaaaaaaagaibaaaadaaaaaaaaaaaaaipcaabaaaacaaaaaa
				bgalbaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajdcaabaaaaaaaaaaa
				agaabaaaaaaaaaaaegaabaaaacaaaaaabgafbaaaabaaaaaadccaaaapmcaabaaa
				aaaaaaaakgbkbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaaeaea
				aceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaialpdcaaaaajdcaabaaaabaaaaaa
				kgakbaaaaaaaaaaaogakbaaaacaaaaaalgapbaaaabaaaaaaaaaaaaaidcaabaaa
				abaaaaaaegaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
				aaaaaaaapgapbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaadiaaaaah
				ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaldcaabaaa
				abaaaaaaagaabaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpddddlddpaaaaaaaa
				aaaaaaaadccaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaa
				bkaabaaaaaaaaaaaaaaaaaaincaabaaaabaaaaaakgakbaiaebaaaaaaaaaaaaaa
				agbjbaaaafaaaaaadcaaaaajncaabaaaabaaaaaaagaabaaaaaaaaaaaagaobaaa
				abaaaaaakgakbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaigadbaiaebaaaaaa
				abaaaaaaegbcbaaaafaaaaaadcaaaaajncaabaaaabaaaaaapgbpbaaaabaaaaaa
				agajbaaaacaaaaaaagaobaaaabaaaaaaaaaaaaaincaabaaaabaaaaaafgafbaia
				ebaaaaaaaaaaaaaaagaobaaaabaaaaaadgcaaaafecaabaaaaaaaaaaadkbabaaa
				afaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaaaaaaaaaagaobaaaabaaaaaa
				fgafbaaaaaaaaaaadgaaaaafbcaabaaaacaaaaaackbabaaaacaaaaaadgaaaaaf
				ccaabaaaacaaaaaackbabaaaadaaaaaadgaaaaafecaabaaaacaaaaaackbabaaa
				aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
				eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahncaabaaaabaaaaaa
				agaabaaaabaaaaaaagajbaaaacaaaaaabaaaaaaibcaabaaaacaaaaaaigadbaaa
				abaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
				acaaaaaaabeaaaaaaaaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaabaaaaaa
				bkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
				acaaaaaaabeaaaaamnmmemdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
				bkaabaaaabaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaacaaaaaadgaaaaaf
				ccaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaa
				aeaaaaaaaaaaaaajocaabaaaacaaaaaaagajbaiaebaaaaaaadaaaaaaagijcaaa
				abaaaaaaaeaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaacaaaaaajgahbaaa
				acaaaaaaeeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakocaabaaa
				acaaaaaafgaobaaaacaaaaaafgafbaaaabaaaaaaagijcaaaacaaaaaaaaaaaaaa
				baaaaaahccaabaaaabaaaaaajgahbaaaacaaaaaajgahbaaaacaaaaaaeeaaaaaf
				ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaacaaaaaafgafbaaa
				abaaaaaafgaobaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaigadbaaaabaaaaaa
				jgahbaaaacaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
				aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaa
				abaaaaaaakiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
				abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
				akaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
				abaaaaaadcaaaaajhcaabaaaabaaaaaajgahbaaaaaaaaaaaagaabaaaacaaaaaa
				agaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
				aaaaaaaaagaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegbcbaaa
				agaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaacaaaaaa
				egbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaafgafbaaa
				acaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
				pgapbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
				abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
				dicaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaaaaaaaaai
				icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpcpaaaaaf
				icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
				aaaaaaaackiacaaaaaaaaaaaajaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
				aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
				akaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaa
				akaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaa
				ajaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
				doaaaaab"
		}
		SubProgram "gles " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES3"
		}
		SubProgram "metal " {
			// Stats: 56 math, 2 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				SetTexture 0[_MainTex] 2D 0
				SetTexture 1[_Emissive] 2D 1
				ConstBuffer "$Globals" 64
				Vector 0[_WorldSpaceCameraPos] 3
				VectorHalf 16[_WorldSpaceLightPos0] 4
				VectorHalf 24[_LightColor0] 4
				ScalarHalf 32[_Shininess]
				Float 36[_Opacity]
				Float 40[_RimFalloff]
				Vector 48[_RimColor]
				"metal_fs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 xlv_TEXCOORD0;
				float4 xlv_TEXCOORD1;
				float4 xlv_TEXCOORD2;
				float4 xlv_TEXCOORD3;
				half4 xlv_COLOR0;
				half3 xlv_TEXCOORD4;
			};
			struct xlatMtlShaderOutput {
				half4 _glesFragData_0[[color(0)]];
			};
			struct xlatMtlShaderUniform {
				float3 _WorldSpaceCameraPos;
				half4 _WorldSpaceLightPos0;
				half4 _LightColor0;
				half _Shininess;
				float _Opacity;
				float _RimFalloff;
				float4 _RimColor;
			};
			fragment xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]]
				,   texture2d<half> _MainTex[[texture(0)]], sampler _mtlsmp__MainTex[[sampler(0)]]
				,   texture2d<half> _Emissive[[texture(1)]], sampler _mtlsmp__Emissive[[sampler(1)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half3 worldN_1;
				half4 c_2;
				half3 viewDir_3;
				half3 worldViewDir_4;
				half3 lightDir_5;
				float3 tmpvar_6;
				float4 tmpvar_7;
				float3 tmpvar_8;
				tmpvar_8.x = _mtl_i.xlv_TEXCOORD1.w;
				tmpvar_8.y = _mtl_i.xlv_TEXCOORD2.w;
				tmpvar_8.z = _mtl_i.xlv_TEXCOORD3.w;
				half3 tmpvar_9;
				tmpvar_9 = _mtl_u._WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				float3 tmpvar_10;
				tmpvar_10 = normalize((_mtl_u._WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = half3(tmpvar_10);
				half3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				float3 tmpvar_12;
				tmpvar_12 = (((_mtl_i.xlv_TEXCOORD1.xyz * (float)tmpvar_11.x) + (_mtl_i.xlv_TEXCOORD2.xyz * (float)tmpvar_11.y)) + (_mtl_i.xlv_TEXCOORD3.xyz * (float)tmpvar_11.z));
				viewDir_3 = half3(tmpvar_12);
				tmpvar_6 = float3(viewDir_3);
				tmpvar_7 = float4(_mtl_i.xlv_COLOR0);
				half3 tmpvar_13;
				half3 tmpvar_14;
				half tmpvar_15;
				float4 mask_16;
				float4 color_17;
				half4 tmpvar_18;
				tmpvar_18 = _MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				color_17 = float4(tmpvar_18);
				half4 tmpvar_19;
				tmpvar_19 = _Emissive.sample(_mtlsmp__Emissive, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				mask_16 = float4(tmpvar_19);
				float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				half tmpvar_21;
				tmpvar_21 = half((1.0 - tmpvar_20));
				float3 tmpvar_22;
				tmpvar_22 = ((_mtl_u._RimColor.xyz * pow((float)tmpvar_21, _mtl_u._RimFalloff)) * _mtl_u._RimColor.w);
				float2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				float2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				float2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				float2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				float2 tmpvar_27;
				float tmpvar_28;
				tmpvar_28 = (_mtl_i.xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, float2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, float2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), float2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				float3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(float3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, _mtl_i.xlv_TEXCOORD0.www), float3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = half3(tmpvar_29);
				tmpvar_14 = half3(tmpvar_22);
				float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = half(((tmpvar_30 + 0.2) * tmpvar_27.y));
				tmpvar_14 = half3(((float3)tmpvar_14 * _mtl_u._Opacity));
				c_2.w = half(0.0);
				float tmpvar_31;
				tmpvar_31 = _mtl_i.xlv_TEXCOORD1.z;
				worldN_1.x = half(tmpvar_31);
				float tmpvar_32;
				tmpvar_32 = _mtl_i.xlv_TEXCOORD2.z;
				worldN_1.y = half(tmpvar_32);
				float tmpvar_33;
				tmpvar_33 = _mtl_i.xlv_TEXCOORD3.z;
				worldN_1.z = half(tmpvar_33);
				c_2.xyz = (tmpvar_13 * _mtl_i.xlv_TEXCOORD4);
				half4 c_34;
				half spec_35;
				half3 tmpvar_36;
				tmpvar_36 = normalize(worldN_1);
				half tmpvar_37;
				tmpvar_37 = max((half)0.0, dot(tmpvar_36, tmpvar_11));
				half tmpvar_38;
				tmpvar_38 = (pow(tmpvar_37, (_mtl_u._Shininess * (half)128.0)) * tmpvar_15);
				spec_35 = tmpvar_38;
				c_34.xyz = (_mtl_u._LightColor0.xyz * ((tmpvar_13 *
					max((half)0.0, dot(tmpvar_36, lightDir_5))
					) + spec_35));
				c_34.w = half(1.0);
				c_2 = (c_2 + c_34);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = half(1.0);
				_mtl_o._glesFragData_0 = c_2;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GL3x"
		}
		SubProgram "opengl " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLSL"
		}
		SubProgram "d3d9 " {
			// Stats: 69 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				Vector 2[_LightColor0]
				Float 4[_Opacity]
				Vector 6[_RimColor]
				Float 5[_RimFalloff]
				Float 3[_Shininess]
				Vector 0[_WorldSpaceCameraPos]
				Vector 1[_WorldSpaceLightPos0]
				SetTexture 0[_ShadowMapTexture] 2D 0
				SetTexture 1[_MainTex] 2D 1
				SetTexture 2[_Emissive] 2D 2
				"ps_3_0
				def c7, 1, 3, -2, -1
				def c8, 1, 1.39999998, 0.200000003, 0
				def c9, 128, 0, 0, 0
				dcl_texcoord v0
				dcl_texcoord1 v1
				dcl_texcoord2 v2
				dcl_texcoord3 v3
				dcl_color v4
				dcl_texcoord4_pp v5.xyz
				dcl_texcoord5 v6
				dcl_2d s0
				dcl_2d s1
				dcl_2d s2
				mul r0.x, c7.y, v0.z
				mov_sat r0.x, r0.x
				texld r1, v0, s1
				mov r2.xz, r1
				texld r3, v0, s2
				mov r2.yw, r3.xxzz
				mov r1.xz, r3.yyww
				lrp r3.xy, r0.x, r1, r2.yxzw
				mad_sat r0.xy, v0.z, c7.y, c7.zwzw
				lrp r3.zw, r0.x, r1, r2.xywz
				lrp r1.xy, r0.y, r3.zwzw, r3
				mul r0.x, r1.y, r1.y
				add r0.yz, -r1.x, c8.xxyw
				mad_sat r0.x, r0.y, r0.x, r1.y
				lrp r2.xyz, r1.x, v4, r0.x
				add r0.xyw, -r2.xyzz, v4.xyzz
				mad r0.xyw, v0.w, r0, r2.xyzz
				mov_sat r1.z, v4.w
				lrp_pp r2.xyz, r1.z, r0.xyww, r1.y
				mov r3.x, v1.z
				mov r3.y, v2.z
				mov r3.z, v3.z
				nrm_pp r4.xyz, r3
				dp3_pp r0.x, r4, c1
				max_pp r1.y, r0.x, c8.w
				mul r0.x, r0.z, r0.z
				mad r0.x, r0.z, r0.x, c8.z
				mul_pp r0.x, r1.x, r0.x
				mov r3.x, v1.w
				mov r3.y, v2.w
				mov r3.z, v3.w
				add r0.yzw, -r3.xxyz, c0.xxyz
				dp3 r1.x, r0.yzww, r0.yzww
				rsq r1.x, r1.x
				mad_pp r0.yzw, r0, r1.x, c1.xxyz
				nrm_pp r3.xyz, r0.yzww
				dp3_pp r0.y, r4, r3
				max_pp r1.x, r0.y, c8.w
				mov r4.x, c3.x
				mul_pp r0.y, r4.x, c9.x
				pow_pp r2.w, r1.x, r0.y
				mul_pp r0.x, r0.x, r2.w
				mad_pp r0.xyz, r2, r1.y, r0.x
				mul_pp r0.xyz, r0, c2
				texldp_pp r1, v6, s0
				mul_pp r0.xyz, r0, r1.x
				mad_pp r0.xyz, r2, v5, r0
				mul r1.xyz, r3.y, v2
				mad r1.xyz, v1, r3.x, r1
				mad_pp r1.xyz, v3, r3.z, r1
				dp3 r0.w, r1, r1
				rsq r0.w, r0.w
				mul_sat r0.w, r0.w, r1.z
				add_pp r0.w, -r0.w, c7.x
				pow r1.x, r0.w, c5.x
				mul r1.xyz, r1.x, c6
				mul_pp r1.xyz, r1, c6.w
				mad_pp oC0.xyz, r1, c4.x, r0
				mov_pp oC0.w, c7.x

				"
		}
		SubProgram "d3d11 " {
			// Stats: 56 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				SetTexture 0[_MainTex] 2D 1
				SetTexture 1[_Emissive] 2D 2
				SetTexture 2[_ShadowMapTexture] 2D 0
				ConstBuffer "$Globals" 208
				Vector 96[_LightColor0]
				Float 144[_Shininess]
				Float 148[_Opacity]
				Float 152[_RimFalloff]
				Vector 160[_RimColor]
				ConstBuffer "UnityPerCamera" 144
				Vector 64[_WorldSpaceCameraPos] 3
				ConstBuffer "UnityLighting" 720
				Vector 0[_WorldSpaceLightPos0]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				"ps_4_0
				root12:adadadaa
				eefiecedhcnlfkjakjamejhdfbmggfajijohigecabaaaaaaiaakaaaaadaaaaaa
				cmaaaaaadaabaaaageabaaaaejfdeheopmaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
				aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				apapaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaomaaaaaa
				adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaapfaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapapaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaaomaaaaaa
				ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
				feeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
				caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
				heaaklklfdeieefcbeajaaaaeaaaaaaaefacaaaafjaaaaaeegiocaaaaaaaaaaa
				alaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
				abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
				aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
				abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
				abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
				pcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
				gcbaaaadlcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
				diaaaaahbcaabaaaaaaaaaaackbabaaaabaaaaaaabeaaaaaaaaaeaeadgcaaaaf
				bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
				abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadgaaaaafkcaabaaaacaaaaaa
				fganbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
				abaaaaaaaagabaaaacaaaaaadgaaaaaffcaabaaaacaaaaaafgahbaaaadaaaaaa
				dgaaaaafkcaabaaaabaaaaaaagaibaaaadaaaaaaaaaaaaaipcaabaaaacaaaaaa
				bgalbaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajdcaabaaaaaaaaaaa
				agaabaaaaaaaaaaaegaabaaaacaaaaaabgafbaaaabaaaaaadccaaaapmcaabaaa
				aaaaaaaakgbkbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaaeaea
				aceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaialpdcaaaaajdcaabaaaabaaaaaa
				kgakbaaaaaaaaaaaogakbaaaacaaaaaalgapbaaaabaaaaaaaaaaaaaidcaabaaa
				abaaaaaaegaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
				aaaaaaaapgapbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaadiaaaaah
				ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaldcaabaaa
				abaaaaaaagaabaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpddddlddpaaaaaaaa
				aaaaaaaadccaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaa
				bkaabaaaaaaaaaaaaaaaaaaincaabaaaabaaaaaakgakbaiaebaaaaaaaaaaaaaa
				agbjbaaaafaaaaaadcaaaaajncaabaaaabaaaaaaagaabaaaaaaaaaaaagaobaaa
				abaaaaaakgakbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaigadbaiaebaaaaaa
				abaaaaaaegbcbaaaafaaaaaadcaaaaajncaabaaaabaaaaaapgbpbaaaabaaaaaa
				agajbaaaacaaaaaaagaobaaaabaaaaaaaaaaaaaincaabaaaabaaaaaafgafbaia
				ebaaaaaaaaaaaaaaagaobaaaabaaaaaadgcaaaafecaabaaaaaaaaaaadkbabaaa
				afaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaaaaaaaaaagaobaaaabaaaaaa
				fgafbaaaaaaaaaaadgaaaaafbcaabaaaacaaaaaackbabaaaacaaaaaadgaaaaaf
				ccaabaaaacaaaaaackbabaaaadaaaaaadgaaaaafecaabaaaacaaaaaackbabaaa
				aeaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
				eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahncaabaaaabaaaaaa
				agaabaaaabaaaaaaagajbaaaacaaaaaabaaaaaaibcaabaaaacaaaaaaigadbaaa
				abaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaa
				acaaaaaaabeaaaaaaaaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaabaaaaaa
				bkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
				acaaaaaaabeaaaaamnmmemdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
				bkaabaaaabaaaaaadgaaaaafbcaabaaaadaaaaaadkbabaaaacaaaaaadgaaaaaf
				ccaabaaaadaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaadaaaaaadkbabaaa
				aeaaaaaaaaaaaaajocaabaaaacaaaaaaagajbaiaebaaaaaaadaaaaaaagijcaaa
				abaaaaaaaeaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaacaaaaaajgahbaaa
				acaaaaaaeeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakocaabaaa
				acaaaaaafgaobaaaacaaaaaafgafbaaaabaaaaaaagijcaaaacaaaaaaaaaaaaaa
				baaaaaahccaabaaaabaaaaaajgahbaaaacaaaaaajgahbaaaacaaaaaaeeaaaaaf
				ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaacaaaaaafgafbaaa
				abaaaaaafgaobaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaigadbaaaabaaaaaa
				jgahbaaaacaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
				aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaa
				abaaaaaaakiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
				abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
				akaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
				abaaaaaadcaaaaajhcaabaaaabaaaaaajgahbaaaaaaaaaaaagaabaaaacaaaaaa
				agaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
				aaaaaaaaagaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaahaaaaaapgbpbaaa
				ahaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaa
				aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaa
				adaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegbcbaaaagaaaaaa
				egacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaacaaaaaaegbcbaaa
				adaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaafgafbaaaacaaaaaa
				egacbaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaapgapbaaa
				acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
				egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadicaaaah
				icaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaaaaaaaaaiicaabaaa
				aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpcpaaaaaficaabaaa
				aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
				ckiacaaaaaaaaaaaajaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
				diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaakaaaaaa
				diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
				dcaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaa
				egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
				"
		}
		SubProgram "gles " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GL3x"
		}
		SubProgram "gles " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				"!!GLES3"
		}
		SubProgram "metal " {
			// Stats: 57 math, 3 textures
			Keywords{ "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
				SetTexture 0[_ShadowMapTexture] 2D 0
				SetTexture 1[_MainTex] 2D 1
				SetTexture 2[_Emissive] 2D 2
				ConstBuffer "$Globals" 64
				Vector 0[_WorldSpaceCameraPos] 3
				VectorHalf 16[_WorldSpaceLightPos0] 4
				VectorHalf 24[_LightColor0] 4
				ScalarHalf 32[_Shininess]
				Float 36[_Opacity]
				Float 40[_RimFalloff]
				Vector 48[_RimColor]
				"metal_fs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 xlv_TEXCOORD0;
				float4 xlv_TEXCOORD1;
				float4 xlv_TEXCOORD2;
				float4 xlv_TEXCOORD3;
				half4 xlv_COLOR0;
				half3 xlv_TEXCOORD4;
				half4 xlv_TEXCOORD5;
			};
			struct xlatMtlShaderOutput {
				half4 _glesFragData_0[[color(0)]];
			};
			struct xlatMtlShaderUniform {
				float3 _WorldSpaceCameraPos;
				half4 _WorldSpaceLightPos0;
				half4 _LightColor0;
				half _Shininess;
				float _Opacity;
				float _RimFalloff;
				float4 _RimColor;
			};
			fragment xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]]
				,   texture2d<half> _ShadowMapTexture[[texture(0)]], sampler _mtlsmp__ShadowMapTexture[[sampler(0)]]
				,   texture2d<half> _MainTex[[texture(1)]], sampler _mtlsmp__MainTex[[sampler(1)]]
				,   texture2d<half> _Emissive[[texture(2)]], sampler _mtlsmp__Emissive[[sampler(2)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half3 worldN_1;
				half4 c_2;
				half3 viewDir_3;
				half3 worldViewDir_4;
				half3 lightDir_5;
				float3 tmpvar_6;
				float4 tmpvar_7;
				float3 tmpvar_8;
				tmpvar_8.x = _mtl_i.xlv_TEXCOORD1.w;
				tmpvar_8.y = _mtl_i.xlv_TEXCOORD2.w;
				tmpvar_8.z = _mtl_i.xlv_TEXCOORD3.w;
				half3 tmpvar_9;
				tmpvar_9 = _mtl_u._WorldSpaceLightPos0.xyz;
				lightDir_5 = tmpvar_9;
				float3 tmpvar_10;
				tmpvar_10 = normalize((_mtl_u._WorldSpaceCameraPos - tmpvar_8));
				worldViewDir_4 = half3(tmpvar_10);
				half3 tmpvar_11;
				tmpvar_11 = normalize((worldViewDir_4 + lightDir_5));
				worldViewDir_4 = tmpvar_11;
				float3 tmpvar_12;
				tmpvar_12 = (((_mtl_i.xlv_TEXCOORD1.xyz * (float)tmpvar_11.x) + (_mtl_i.xlv_TEXCOORD2.xyz * (float)tmpvar_11.y)) + (_mtl_i.xlv_TEXCOORD3.xyz * (float)tmpvar_11.z));
				viewDir_3 = half3(tmpvar_12);
				tmpvar_6 = float3(viewDir_3);
				tmpvar_7 = float4(_mtl_i.xlv_COLOR0);
				half3 tmpvar_13;
				half3 tmpvar_14;
				half tmpvar_15;
				float4 mask_16;
				float4 color_17;
				half4 tmpvar_18;
				tmpvar_18 = _MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				color_17 = float4(tmpvar_18);
				half4 tmpvar_19;
				tmpvar_19 = _Emissive.sample(_mtlsmp__Emissive, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				mask_16 = float4(tmpvar_19);
				float tmpvar_20;
				tmpvar_20 = clamp(normalize(tmpvar_6).z, 0.0, 1.0);
				half tmpvar_21;
				tmpvar_21 = half((1.0 - tmpvar_20));
				float3 tmpvar_22;
				tmpvar_22 = ((_mtl_u._RimColor.xyz * pow((float)tmpvar_21, _mtl_u._RimFalloff)) * _mtl_u._RimColor.w);
				float2 tmpvar_23;
				tmpvar_23.x = color_17.x;
				tmpvar_23.y = mask_16.x;
				float2 tmpvar_24;
				tmpvar_24.x = color_17.y;
				tmpvar_24.y = mask_16.y;
				float2 tmpvar_25;
				tmpvar_25.x = color_17.z;
				tmpvar_25.y = mask_16.z;
				float2 tmpvar_26;
				tmpvar_26.x = color_17.w;
				tmpvar_26.y = mask_16.w;
				float2 tmpvar_27;
				float tmpvar_28;
				tmpvar_28 = (_mtl_i.xlv_TEXCOORD0.z * 3.0);
				tmpvar_27 = mix(mix(tmpvar_23, tmpvar_24, float2(clamp(tmpvar_28, 0.0, 1.0))), mix(tmpvar_25, tmpvar_26, float2(clamp(
					(tmpvar_28 - 2.0)
					, 0.0, 1.0))), float2(clamp((tmpvar_28 - 1.0), 0.0, 1.0)));
				float3 tmpvar_29;
				tmpvar_29 = mix(tmpvar_27.xxx, mix(mix(float3(
					clamp((tmpvar_27.x + ((1.0 - tmpvar_27.y) * (tmpvar_27.x * tmpvar_27.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_27.yyy), tmpvar_7.xyz, _mtl_i.xlv_TEXCOORD0.www), float3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_13 = half3(tmpvar_29);
				tmpvar_14 = half3(tmpvar_22);
				float tmpvar_30;
				tmpvar_30 = pow(((1.0 - tmpvar_27.y) + 0.4), 3.0);
				tmpvar_15 = half(((tmpvar_30 + 0.2) * tmpvar_27.y));
				tmpvar_14 = half3(((float3)tmpvar_14 * _mtl_u._Opacity));
				c_2.w = half(0.0);
				float tmpvar_31;
				tmpvar_31 = _mtl_i.xlv_TEXCOORD1.z;
				worldN_1.x = half(tmpvar_31);
				float tmpvar_32;
				tmpvar_32 = _mtl_i.xlv_TEXCOORD2.z;
				worldN_1.y = half(tmpvar_32);
				float tmpvar_33;
				tmpvar_33 = _mtl_i.xlv_TEXCOORD3.z;
				worldN_1.z = half(tmpvar_33);
				c_2.xyz = (tmpvar_13 * _mtl_i.xlv_TEXCOORD4);
				half4 c_34;
				half spec_35;
				half3 tmpvar_36;
				tmpvar_36 = normalize(worldN_1);
				half tmpvar_37;
				tmpvar_37 = max((half)0.0, dot(tmpvar_36, tmpvar_11));
				half tmpvar_38;
				tmpvar_38 = (pow(tmpvar_37, (_mtl_u._Shininess * (half)128.0)) * tmpvar_15);
				spec_35 = tmpvar_38;
				c_34.xyz = ((_mtl_u._LightColor0.xyz * (
					(tmpvar_13 * max((half)0.0, dot(tmpvar_36, lightDir_5)))
					+ spec_35)) * _ShadowMapTexture.sample(_mtlsmp__ShadowMapTexture, ((float2)(_mtl_i.xlv_TEXCOORD5).xy / (float)(_mtl_i.xlv_TEXCOORD5).w)).x);
				c_34.w = half(1.0);
				c_2 = (c_2 + c_34);
				c_2.xyz = (c_2.xyz + tmpvar_14);
				c_2.w = half(1.0);
				_mtl_o._glesFragData_0 = c_2;
				return _mtl_o;
			}

			"
		}
	}
	}


		// Stats for Vertex shader:
		//       d3d11 : 34 math
		//        d3d9 : 35 math
		//        gles : 45 avg math (40..52), 3 avg texture (2..4)
		//       metal : 19 math
		//      opengl : 45 avg math (40..52), 3 avg texture (2..4)
		// Stats for Fragment shader:
		//       d3d11 : 47 avg math (39..55), 3 avg texture (2..4)
		//        d3d9 : 59 avg math (51..66), 3 avg texture (2..4)
		//       metal : 45 avg math (40..52), 3 avg texture (2..4)
		Pass{
		Name "FORWARD"
		Tags{ "LIGHTMODE" = "ForwardAdd" "RenderType" = "Opaque" }
		ZWrite Off
		Blend One One
		GpuProgramID 75109
		Program "vp" {
		SubProgram "opengl " {
			// Stats: 46 math, 3 textures
			Keywords{ "POINT" }
				"!!GLSL#version 120

#ifdef VERTEX

				uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec4 tmpvar_1;
				tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_1.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec4 v_2;
				v_2.x = _World2Object[0].x;
				v_2.y = _World2Object[1].x;
				v_2.z = _World2Object[2].x;
				v_2.w = _World2Object[3].x;
				vec4 v_3;
				v_3.x = _World2Object[0].y;
				v_3.y = _World2Object[1].y;
				v_3.z = _World2Object[2].y;
				v_3.w = _World2Object[3].y;
				vec4 v_4;
				v_4.x = _World2Object[0].z;
				v_4.y = _World2Object[1].z;
				v_4.z = _World2Object[2].z;
				v_4.w = _World2Object[3].z;
				vec3 tmpvar_5;
				tmpvar_5 = normalize(((
					(v_2.xyz * gl_Normal.x)
					+
					(v_3.xyz * gl_Normal.y)
					) + (v_4.xyz * gl_Normal.z)));
				mat3 tmpvar_6;
				tmpvar_6[0] = _Object2World[0].xyz;
				tmpvar_6[1] = _Object2World[1].xyz;
				tmpvar_6[2] = _Object2World[2].xyz;
				vec3 tmpvar_7;
				tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
				vec3 tmpvar_8;
				tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec3 tmpvar_9;
				tmpvar_9.x = tmpvar_7.x;
				tmpvar_9.y = tmpvar_8.x;
				tmpvar_9.z = tmpvar_5.x;
				vec3 tmpvar_10;
				tmpvar_10.x = tmpvar_7.y;
				tmpvar_10.y = tmpvar_8.y;
				tmpvar_10.z = tmpvar_5.y;
				vec3 tmpvar_11;
				tmpvar_11.x = tmpvar_7.z;
				tmpvar_11.y = tmpvar_8.z;
				tmpvar_11.z = tmpvar_5.z;
				gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
				xlv_TEXCOORD0 = tmpvar_1;
				xlv_TEXCOORD1 = tmpvar_9;
				xlv_TEXCOORD2 = tmpvar_10;
				xlv_TEXCOORD3 = tmpvar_11;
				xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
				xlv_COLOR0 = gl_Color;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform sampler2D _LightTexture0;
			uniform mat4 _LightMatrix0;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec3 tmpvar_3;
				tmpvar_3 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
				vec4 tmpvar_4;
				tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_5;
				tmpvar_5 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_6;
				tmpvar_6.x = tmpvar_4.x;
				tmpvar_6.y = tmpvar_5.x;
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_4.y;
				tmpvar_7.y = tmpvar_5.y;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_4.z;
				tmpvar_8.y = tmpvar_5.z;
				vec2 tmpvar_9;
				tmpvar_9.x = tmpvar_4.w;
				tmpvar_9.y = tmpvar_5.w;
				vec2 tmpvar_10;
				float tmpvar_11;
				tmpvar_11 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_10 = mix(mix(tmpvar_6, tmpvar_7, vec2(clamp(tmpvar_11, 0.0, 1.0))), mix(tmpvar_8, tmpvar_9, vec2(clamp(
					(tmpvar_11 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_11 - 1.0), 0.0, 1.0)));
				vec4 tmpvar_12;
				tmpvar_12.w = 1.0;
				tmpvar_12.xyz = xlv_TEXCOORD4;
				vec3 tmpvar_13;
				tmpvar_13 = (_LightMatrix0 * tmpvar_12).xyz;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				vec4 c_14;
				vec3 tmpvar_15;
				tmpvar_15 = normalize(worldN_1);
				c_14.xyz = ((_LightColor0.xyz * (
					(mix(tmpvar_10.xxx, mix(mix(vec3(
						clamp((tmpvar_10.x + ((1.0 - tmpvar_10.y) * (tmpvar_10.x * tmpvar_10.x))), 0.0, 1.0)
						), xlv_COLOR0.xyz, tmpvar_10.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0))) * max(0.0, dot(tmpvar_15, tmpvar_3)))
					+
					(pow(max(0.0, dot(tmpvar_15,
						normalize((normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)) + tmpvar_3))
						)), (_Shininess * 128.0)) * ((pow(
							((1.0 - tmpvar_10.y) + 0.4)
							, 3.0) + 0.2) * tmpvar_10.y))
					)) * texture2D (_LightTexture0, vec2(dot(tmpvar_13, tmpvar_13))).w);
				c_14.w = 1.0;
				c_2.xyz = c_14.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 35 math
			Keywords{ "POINT" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 4[_Object2World] 3
				Matrix 7[_World2Object] 3
				Matrix 0[glstate_matrix_mvp]
				Vector 12[_Emissive_ST]
				Vector 11[_MainTex_ST]
				Vector 10[unity_WorldTransformParams]
				"vs_3_0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2.xyz
				dcl_texcoord2 o3.xyz
				dcl_texcoord3 o4.xyz
				dcl_texcoord4 o5.xyz
				dcl_color o6
				dp4 o0.x, c0, v0
				dp4 o0.y, c1, v0
				dp4 o0.z, c2, v0
				dp4 o0.w, c3, v0
				mad o1.xy, v3, c11, c11.zwzw
				mad o1.zw, v4.xyxy, c12.xyxy, c12
				dp4 o5.x, c4, v0
				dp4 o5.y, c5, v0
				dp4 o5.z, c6, v0
				dp3 r0.z, c4, v1
				dp3 r0.x, c5, v1
				dp3 r0.y, c6, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r1.xyz, c8.zxyw, v2.y
				mad r1.xyz, c7.zxyw, v2.x, r1
				mad r1.xyz, c9.zxyw, v2.z, r1
				dp3 r0.w, r1, r1
				rsq r0.w, r0.w
				mul r1.xyz, r0.w, r1
				mul r2.xyz, r0, r1
				mad r2.xyz, r1.zxyw, r0.yzxw, -r2
				mul r0.z, c10.w, v1.w
				mul r2.xyz, r0.z, r2
				mov o2.y, r2.x
				mov o2.z, r1.y
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r2.y
				mov o4.y, r2.z
				mov o3.z, r1.z
				mov o4.z, r1.x
				mov o6, v5

				"
		}
		SubProgram "d3d11 " {
			// Stats: 34 math
			Keywords{ "POINT" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 272
				Vector 240[_MainTex_ST]
				Vector 256[_Emissive_ST]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityPerDraw" 1
				"vs_4_0
				root12:aaacaaaa
				eefiecedhaomgnoeigpocikojcffdbiamlplojojabaaaaaaaeaiaaaaadaaaaaa
				cmaaaaaaceabaaaapiabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				ahaiaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
				epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcaeagaaaa
				eaaaabaaibabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
				abaaaaaabgaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
				fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
				aeaaaaaafpaaaaadpcbabaaaahaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
				gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
				adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
				pccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
				aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
				abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
				aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
				dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
				egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
				aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadcaaaaalmccabaaaabaaaaaa
				agbebaaaaeaaaaaaagiecaaaaaaaaaaabaaaaaaakgiocaaaaaaaaaaabaaaaaaa
				diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
				diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
				aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
				ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
				ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
				bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
				hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
				aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
				dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
				aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
				abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
				abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
				dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
				egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
				egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
				aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaa
				aaaaaaaadkbabaaaabaaaaaadkiacaaaabaaaaaabfaaaaaadiaaaaahhcaabaaa
				acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaafcccabaaaacaaaaaa
				akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
				eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
				aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
				aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
				dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
				fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
				egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
				hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
				aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
				aaaaaaaaegacbaaaaaaaaaaadgaaaaafpccabaaaagaaaaaaegbobaaaahaaaaaa
				doaaaaab"
		}
		SubProgram "gles " {
			// Stats: 46 math, 3 textures
			Keywords{ "POINT" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp float tangentSign_1;
				lowp vec3 worldTangent_2;
				lowp vec3 worldNormal_3;
				highp vec4 tmpvar_4;
				tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec4 v_5;
				v_5.x = _World2Object[0].x;
				v_5.y = _World2Object[1].x;
				v_5.z = _World2Object[2].x;
				v_5.w = _World2Object[3].x;
				highp vec4 v_6;
				v_6.x = _World2Object[0].y;
				v_6.y = _World2Object[1].y;
				v_6.z = _World2Object[2].y;
				v_6.w = _World2Object[3].y;
				highp vec4 v_7;
				v_7.x = _World2Object[0].z;
				v_7.y = _World2Object[1].z;
				v_7.z = _World2Object[2].z;
				v_7.w = _World2Object[3].z;
				highp vec3 tmpvar_8;
				tmpvar_8 = normalize(((
					(v_5.xyz * _glesNormal.x)
					+
					(v_6.xyz * _glesNormal.y)
					) + (v_7.xyz * _glesNormal.z)));
				worldNormal_3 = tmpvar_8;
				highp mat3 tmpvar_9;
				tmpvar_9[0] = _Object2World[0].xyz;
				tmpvar_9[1] = _Object2World[1].xyz;
				tmpvar_9[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
				worldTangent_2 = tmpvar_10;
				highp float tmpvar_11;
				tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_1 = tmpvar_11;
				lowp vec3 tmpvar_12;
				tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
				lowp vec3 tmpvar_13;
				tmpvar_13.x = worldTangent_2.x;
				tmpvar_13.y = tmpvar_12.x;
				tmpvar_13.z = worldNormal_3.x;
				lowp vec3 tmpvar_14;
				tmpvar_14.x = worldTangent_2.y;
				tmpvar_14.y = tmpvar_12.y;
				tmpvar_14.z = worldNormal_3.y;
				lowp vec3 tmpvar_15;
				tmpvar_15.x = worldTangent_2.z;
				tmpvar_15.y = tmpvar_12.z;
				tmpvar_15.z = worldNormal_3.z;
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_4;
				xlv_TEXCOORD1 = tmpvar_13;
				xlv_TEXCOORD2 = tmpvar_14;
				xlv_TEXCOORD3 = tmpvar_15;
				xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
				xlv_COLOR0 = _glesColor;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform highp vec4 _WorldSpaceLightPos0;
			uniform lowp vec4 _LightColor0;
			uniform sampler2D _LightTexture0;
			uniform mediump mat4 _LightMatrix0;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 worldViewDir_3;
				lowp vec3 lightDir_4;
				highp vec4 tmpvar_5;
				highp vec3 tmpvar_6;
				tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
				lightDir_4 = tmpvar_6;
				highp vec3 tmpvar_7;
				tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
				worldViewDir_3 = tmpvar_7;
				lowp vec3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = xlv_COLOR0;
				lowp vec3 tmpvar_9;
				lowp float tmpvar_10;
				highp vec4 mask_11;
				highp vec4 color_12;
				lowp vec4 tmpvar_13;
				tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_12 = tmpvar_13;
				lowp vec4 tmpvar_14;
				tmpvar_14 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_11 = tmpvar_14;
				highp vec2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				highp vec2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				highp vec2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				highp vec2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				highp vec2 tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, vec2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, vec2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(vec3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = tmpvar_21;
				highp float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = ((tmpvar_22 + 0.2) * tmpvar_19.y);
				highp vec4 tmpvar_23;
				tmpvar_23.w = 1.0;
				tmpvar_23.xyz = xlv_TEXCOORD4;
				highp vec3 tmpvar_24;
				tmpvar_24 = (_LightMatrix0 * tmpvar_23).xyz;
				highp float tmpvar_25;
				tmpvar_25 = dot(tmpvar_24, tmpvar_24);
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				lowp vec4 c_26;
				lowp float spec_27;
				lowp vec3 tmpvar_28;
				tmpvar_28 = normalize(worldN_1);
				lowp float tmpvar_29;
				tmpvar_29 = max(0.0, dot(tmpvar_28, tmpvar_8));
				mediump float tmpvar_30;
				tmpvar_30 = (pow(tmpvar_29, (_Shininess * 128.0)) * tmpvar_10);
				spec_27 = tmpvar_30;
				c_26.xyz = ((_LightColor0.xyz * (
					(tmpvar_9 * max(0.0, dot(tmpvar_28, lightDir_4)))
					+ spec_27)) * texture2D (_LightTexture0, vec2(tmpvar_25)).w);
				c_26.w = 1.0;
				c_2.xyz = c_26.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "POINT" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out lowp vec3 vs_TEXCOORD1;
			out lowp vec3 vs_TEXCOORD2;
			out lowp vec3 vs_TEXCOORD3;
			out highp vec3 vs_TEXCOORD4;
			out lowp vec4 vs_COLOR0;
			highp vec4 t0;
			highp vec3 t1;
			lowp vec3 t10_2;
			highp float t3;
			highp float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t10_2.xyz = t0.xyz * t1.xyz;
				t10_2.xyz = t0.zxy * t1.yzx + (-t10_2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t10_2.xyz = vec3(t3) * t10_2.xyz;
				vs_TEXCOORD1.y = t10_2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t10_2.y;
				vs_TEXCOORD3.y = t10_2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			uniform lowp sampler2D _LightTexture0;
			in highp vec4 vs_TEXCOORD0;
			in lowp vec3 vs_TEXCOORD1;
			in lowp vec3 vs_TEXCOORD2;
			in lowp vec3 vs_TEXCOORD3;
			in highp vec3 vs_TEXCOORD4;
			in lowp vec4 vs_COLOR0;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec2 t0;
			mediump float t16_0;
			lowp float t10_0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec3 t10_4;
			lowp vec3 t10_5;
			mediump vec3 t16_6;
			highp vec3 t7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_25;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t1.xyz = vec3(t22) * t1.xyz;
				t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t2.xyz, t2.xyz);
				t22 = inversesqrt(t22);
				t10_4.xyz = t2.xyz * vec3(t22) + t1.xyz;
				t10_25 = dot(t10_4.xyz, t10_4.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_4.xyz = vec3(t10_25) * t10_4.xyz;
				t10_5.x = vs_TEXCOORD1.z;
				t10_5.y = vs_TEXCOORD2.z;
				t10_5.z = vs_TEXCOORD3.z;
				t10_25 = dot(t10_5.xyz, t10_5.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_5.xyz = vec3(t10_25) * t10_5.xyz;
				t10_4.x = dot(t10_5.xyz, t10_4.xyz);
				t10_4.y = dot(t10_5.xyz, t1.xyz);
				t10_4.xy = max(t10_4.xy, vec2(0.0, 0.0));
				t16_6.x = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6.x = t16_6.x * t16_13;
				t16_6.x = exp2(t16_6.x);
				t16_6.x = t0.x * t16_6.x;
				t10_4.xyz = t7.xyz * t10_4.yyy + t16_6.xxx;
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				t16_6.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
				t16_6.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t16_6.xyz;
				t16_6.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t16_6.xyz;
				t16_6.xyz = t16_6.xyz + _LightMatrix0[3].xyz;
				t16_0 = dot(t16_6.xyz, t16_6.xyz);
				t10_0 = texture(_LightTexture0, vec2(t16_0)).w;
				SV_Target0.xyz = vec3(t10_0) * t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 19 math
			Keywords{ "POINT" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 240
				Matrix 0[glstate_matrix_mvp]
				Matrix 64[_Object2World]
				Matrix 128[_World2Object]
				Vector 192[unity_WorldTransformParams]
				Vector 208[_MainTex_ST]
				Vector 224[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderUniform {
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				half tangentSign_2;
				half3 worldTangent_3;
				half3 worldNormal_4;
				float4 tmpvar_5;
				tmpvar_5.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_5.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float4 v_6;
				v_6.x = _mtl_u._World2Object[0].x;
				v_6.y = _mtl_u._World2Object[1].x;
				v_6.z = _mtl_u._World2Object[2].x;
				v_6.w = _mtl_u._World2Object[3].x;
				float4 v_7;
				v_7.x = _mtl_u._World2Object[0].y;
				v_7.y = _mtl_u._World2Object[1].y;
				v_7.z = _mtl_u._World2Object[2].y;
				v_7.w = _mtl_u._World2Object[3].y;
				float4 v_8;
				v_8.x = _mtl_u._World2Object[0].z;
				v_8.y = _mtl_u._World2Object[1].z;
				v_8.z = _mtl_u._World2Object[2].z;
				v_8.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_9;
				tmpvar_9 = normalize(((
					(v_6.xyz * _mtl_i._glesNormal.x)
					+
					(v_7.xyz * _mtl_i._glesNormal.y)
					) + (v_8.xyz * _mtl_i._glesNormal.z)));
				worldNormal_4 = half3(tmpvar_9);
				float3x3 tmpvar_10;
				tmpvar_10[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_10[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_10[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_11;
				tmpvar_11 = normalize((tmpvar_10 * _mtl_i._glesTANGENT.xyz));
				worldTangent_3 = half3(tmpvar_11);
				float tmpvar_12;
				tmpvar_12 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_2 = half(tmpvar_12);
				half3 tmpvar_13;
				tmpvar_13 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				half3 tmpvar_14;
				tmpvar_14.x = worldTangent_3.x;
				tmpvar_14.y = tmpvar_13.x;
				tmpvar_14.z = worldNormal_4.x;
				half3 tmpvar_15;
				tmpvar_15.x = worldTangent_3.y;
				tmpvar_15.y = tmpvar_13.y;
				tmpvar_15.z = worldNormal_4.y;
				half3 tmpvar_16;
				tmpvar_16.x = worldTangent_3.z;
				tmpvar_16.y = tmpvar_13.z;
				tmpvar_16.z = worldNormal_4.z;
				_mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				_mtl_o.xlv_TEXCOORD0 = tmpvar_5;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_14;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_15;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_16;
				_mtl_o.xlv_TEXCOORD4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "POINT" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec3 vs_TEXCOORD1;
			out vec3 vs_TEXCOORD2;
			out vec3 vs_TEXCOORD3;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_COLOR0;
			vec4 t0;
			vec3 t1;
			vec3 t2;
			float t3;
			float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t2.xyz = t0.xyz * t1.xyz;
				t2.xyz = t0.zxy * t1.yzx + (-t2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t2.xyz = vec3(t3) * t2.xyz;
				vs_TEXCOORD1.y = t2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t2.y;
				vs_TEXCOORD3.y = t2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			uniform  sampler2D _LightTexture0;
			in  vec4 vs_TEXCOORD0;
			in  vec3 vs_TEXCOORD1;
			in  vec3 vs_TEXCOORD2;
			in  vec3 vs_TEXCOORD3;
			in  vec3 vs_TEXCOORD4;
			in  vec4 vs_COLOR0;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			lowp vec4 t10_1;
			vec4 t2;
			vec3 t3;
			lowp vec4 t10_3;
			vec3 t4;
			float t5;
			vec2 t8;
			float t9;
			float t12;
			float t13;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
				t13 = dot(t1.xyz, t1.xyz);
				t13 = inversesqrt(t13);
				t1.xyz = vec3(t13) * t1.xyz;
				t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = t2.xyz * vec3(t13) + t1.xyz;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = vec3(t13) * t2.xyz;
				t3.x = vs_TEXCOORD1.z;
				t3.y = vs_TEXCOORD2.z;
				t3.z = vs_TEXCOORD3.z;
				t13 = dot(t3.xyz, t3.xyz);
				t13 = inversesqrt(t13);
				t3.xyz = vec3(t13) * t3.xyz;
				t1.w = dot(t3.xyz, t2.xyz);
				t1.x = dot(t3.xyz, t1.xyz);
				t1.xy = max(t1.xw, vec2(0.0, 0.0));
				t5 = log2(t1.y);
				t9 = _Shininess * 128.0;
				t5 = t5 * t9;
				t5 = exp2(t5);
				t0.x = t0.x * t5;
				t0.xyz = t4.xyz * t1.xxx + t0.xxx;
				t0.xyz = t0.xyz * _LightColor0.xyz;
				t1.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
				t1.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t1.xyz;
				t1.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t1.xyz;
				t1.xyz = t1.xyz + _LightMatrix0[3].xyz;
				t12 = dot(t1.xyz, t1.xyz);
				t10_1 = texture(_LightTexture0, vec2(t12));
				SV_Target0.xyz = t0.xyz * t10_1.www;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "opengl " {
			// Stats: 40 math, 2 textures
			Keywords{ "DIRECTIONAL" }
				"!!GLSL#version 120

#ifdef VERTEX

				uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec4 tmpvar_1;
				tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_1.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec4 v_2;
				v_2.x = _World2Object[0].x;
				v_2.y = _World2Object[1].x;
				v_2.z = _World2Object[2].x;
				v_2.w = _World2Object[3].x;
				vec4 v_3;
				v_3.x = _World2Object[0].y;
				v_3.y = _World2Object[1].y;
				v_3.z = _World2Object[2].y;
				v_3.w = _World2Object[3].y;
				vec4 v_4;
				v_4.x = _World2Object[0].z;
				v_4.y = _World2Object[1].z;
				v_4.z = _World2Object[2].z;
				v_4.w = _World2Object[3].z;
				vec3 tmpvar_5;
				tmpvar_5 = normalize(((
					(v_2.xyz * gl_Normal.x)
					+
					(v_3.xyz * gl_Normal.y)
					) + (v_4.xyz * gl_Normal.z)));
				mat3 tmpvar_6;
				tmpvar_6[0] = _Object2World[0].xyz;
				tmpvar_6[1] = _Object2World[1].xyz;
				tmpvar_6[2] = _Object2World[2].xyz;
				vec3 tmpvar_7;
				tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
				vec3 tmpvar_8;
				tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec3 tmpvar_9;
				tmpvar_9.x = tmpvar_7.x;
				tmpvar_9.y = tmpvar_8.x;
				tmpvar_9.z = tmpvar_5.x;
				vec3 tmpvar_10;
				tmpvar_10.x = tmpvar_7.y;
				tmpvar_10.y = tmpvar_8.y;
				tmpvar_10.z = tmpvar_5.y;
				vec3 tmpvar_11;
				tmpvar_11.x = tmpvar_7.z;
				tmpvar_11.y = tmpvar_8.z;
				tmpvar_11.z = tmpvar_5.z;
				gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
				xlv_TEXCOORD0 = tmpvar_1;
				xlv_TEXCOORD1 = tmpvar_9;
				xlv_TEXCOORD2 = tmpvar_10;
				xlv_TEXCOORD3 = tmpvar_11;
				xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
				xlv_COLOR0 = gl_Color;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec4 tmpvar_3;
				tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_4;
				tmpvar_4 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_5;
				tmpvar_5.x = tmpvar_3.x;
				tmpvar_5.y = tmpvar_4.x;
				vec2 tmpvar_6;
				tmpvar_6.x = tmpvar_3.y;
				tmpvar_6.y = tmpvar_4.y;
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_3.z;
				tmpvar_7.y = tmpvar_4.z;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_3.w;
				tmpvar_8.y = tmpvar_4.w;
				vec2 tmpvar_9;
				float tmpvar_10;
				tmpvar_10 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_9 = mix(mix(tmpvar_5, tmpvar_6, vec2(clamp(tmpvar_10, 0.0, 1.0))), mix(tmpvar_7, tmpvar_8, vec2(clamp(
					(tmpvar_10 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_10 - 1.0), 0.0, 1.0)));
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				vec4 c_11;
				vec3 tmpvar_12;
				tmpvar_12 = normalize(worldN_1);
				c_11.xyz = (_LightColor0.xyz * ((
					mix(tmpvar_9.xxx, mix(mix(vec3(clamp(
						(tmpvar_9.x + ((1.0 - tmpvar_9.y) * (tmpvar_9.x * tmpvar_9.x)))
						, 0.0, 1.0)), xlv_COLOR0.xyz, tmpvar_9.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0)))
					*
					max(0.0, dot(tmpvar_12, _WorldSpaceLightPos0.xyz))
					) + (
						pow(max(0.0, dot(tmpvar_12, normalize(
							(normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)) + _WorldSpaceLightPos0.xyz)
							))), (_Shininess * 128.0))
						*
						((pow((
							(1.0 - tmpvar_9.y)
							+ 0.4), 3.0) + 0.2) * tmpvar_9.y)
						)));
				c_11.w = 1.0;
				c_2.xyz = c_11.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 35 math
			Keywords{ "DIRECTIONAL" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 4[_Object2World] 3
				Matrix 7[_World2Object] 3
				Matrix 0[glstate_matrix_mvp]
				Vector 12[_Emissive_ST]
				Vector 11[_MainTex_ST]
				Vector 10[unity_WorldTransformParams]
				"vs_3_0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2.xyz
				dcl_texcoord2 o3.xyz
				dcl_texcoord3 o4.xyz
				dcl_texcoord4 o5.xyz
				dcl_color o6
				dp4 o0.x, c0, v0
				dp4 o0.y, c1, v0
				dp4 o0.z, c2, v0
				dp4 o0.w, c3, v0
				mad o1.xy, v3, c11, c11.zwzw
				mad o1.zw, v4.xyxy, c12.xyxy, c12
				dp4 o5.x, c4, v0
				dp4 o5.y, c5, v0
				dp4 o5.z, c6, v0
				dp3 r0.z, c4, v1
				dp3 r0.x, c5, v1
				dp3 r0.y, c6, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r1.xyz, c8.zxyw, v2.y
				mad r1.xyz, c7.zxyw, v2.x, r1
				mad r1.xyz, c9.zxyw, v2.z, r1
				dp3 r0.w, r1, r1
				rsq r0.w, r0.w
				mul r1.xyz, r0.w, r1
				mul r2.xyz, r0, r1
				mad r2.xyz, r1.zxyw, r0.yzxw, -r2
				mul r0.z, c10.w, v1.w
				mul r2.xyz, r0.z, r2
				mov o2.y, r2.x
				mov o2.z, r1.y
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r2.y
				mov o4.y, r2.z
				mov o3.z, r1.z
				mov o4.z, r1.x
				mov o6, v5

				"
		}
		SubProgram "d3d11 " {
			// Stats: 34 math
			Keywords{ "DIRECTIONAL" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 208
				Vector 176[_MainTex_ST]
				Vector 192[_Emissive_ST]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityPerDraw" 1
				"vs_4_0
				root12:aaacaaaa
				eefiecednjiahabaadnlcpbmgoieijojopdjlplcabaaaaaaaeaiaaaaadaaaaaa
				cmaaaaaaceabaaaapiabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				ahaiaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
				epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcaeagaaaa
				eaaaabaaibabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
				abaaaaaabgaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
				fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
				aeaaaaaafpaaaaadpcbabaaaahaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
				gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
				adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
				pccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
				aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
				abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
				aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
				dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
				egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
				aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaa
				agbebaaaaeaaaaaaagiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaa
				diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
				diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
				aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
				ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
				ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
				bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
				hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
				aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
				dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
				aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
				abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
				abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
				dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
				egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
				egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
				aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaa
				aaaaaaaadkbabaaaabaaaaaadkiacaaaabaaaaaabfaaaaaadiaaaaahhcaabaaa
				acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaafcccabaaaacaaaaaa
				akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
				eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
				aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
				aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
				dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
				fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
				egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
				hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
				aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
				aaaaaaaaegacbaaaaaaaaaaadgaaaaafpccabaaaagaaaaaaegbobaaaahaaaaaa
				doaaaaab"
		}
		SubProgram "gles " {
			// Stats: 40 math, 2 textures
			Keywords{ "DIRECTIONAL" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp float tangentSign_1;
				lowp vec3 worldTangent_2;
				lowp vec3 worldNormal_3;
				highp vec4 tmpvar_4;
				tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec4 v_5;
				v_5.x = _World2Object[0].x;
				v_5.y = _World2Object[1].x;
				v_5.z = _World2Object[2].x;
				v_5.w = _World2Object[3].x;
				highp vec4 v_6;
				v_6.x = _World2Object[0].y;
				v_6.y = _World2Object[1].y;
				v_6.z = _World2Object[2].y;
				v_6.w = _World2Object[3].y;
				highp vec4 v_7;
				v_7.x = _World2Object[0].z;
				v_7.y = _World2Object[1].z;
				v_7.z = _World2Object[2].z;
				v_7.w = _World2Object[3].z;
				highp vec3 tmpvar_8;
				tmpvar_8 = normalize(((
					(v_5.xyz * _glesNormal.x)
					+
					(v_6.xyz * _glesNormal.y)
					) + (v_7.xyz * _glesNormal.z)));
				worldNormal_3 = tmpvar_8;
				highp mat3 tmpvar_9;
				tmpvar_9[0] = _Object2World[0].xyz;
				tmpvar_9[1] = _Object2World[1].xyz;
				tmpvar_9[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
				worldTangent_2 = tmpvar_10;
				highp float tmpvar_11;
				tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_1 = tmpvar_11;
				lowp vec3 tmpvar_12;
				tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
				lowp vec3 tmpvar_13;
				tmpvar_13.x = worldTangent_2.x;
				tmpvar_13.y = tmpvar_12.x;
				tmpvar_13.z = worldNormal_3.x;
				lowp vec3 tmpvar_14;
				tmpvar_14.x = worldTangent_2.y;
				tmpvar_14.y = tmpvar_12.y;
				tmpvar_14.z = worldNormal_3.y;
				lowp vec3 tmpvar_15;
				tmpvar_15.x = worldTangent_2.z;
				tmpvar_15.y = tmpvar_12.z;
				tmpvar_15.z = worldNormal_3.z;
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_4;
				xlv_TEXCOORD1 = tmpvar_13;
				xlv_TEXCOORD2 = tmpvar_14;
				xlv_TEXCOORD3 = tmpvar_15;
				xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
				xlv_COLOR0 = _glesColor;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform lowp vec4 _LightColor0;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 worldViewDir_3;
				lowp vec3 lightDir_4;
				highp vec4 tmpvar_5;
				mediump vec3 tmpvar_6;
				tmpvar_6 = _WorldSpaceLightPos0.xyz;
				lightDir_4 = tmpvar_6;
				highp vec3 tmpvar_7;
				tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
				worldViewDir_3 = tmpvar_7;
				lowp vec3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = xlv_COLOR0;
				lowp vec3 tmpvar_9;
				lowp float tmpvar_10;
				highp vec4 mask_11;
				highp vec4 color_12;
				lowp vec4 tmpvar_13;
				tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_12 = tmpvar_13;
				lowp vec4 tmpvar_14;
				tmpvar_14 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_11 = tmpvar_14;
				highp vec2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				highp vec2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				highp vec2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				highp vec2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				highp vec2 tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, vec2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, vec2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(vec3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = tmpvar_21;
				highp float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = ((tmpvar_22 + 0.2) * tmpvar_19.y);
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				lowp vec4 c_23;
				lowp float spec_24;
				lowp vec3 tmpvar_25;
				tmpvar_25 = normalize(worldN_1);
				lowp float tmpvar_26;
				tmpvar_26 = max(0.0, dot(tmpvar_25, tmpvar_8));
				mediump float tmpvar_27;
				tmpvar_27 = (pow(tmpvar_26, (_Shininess * 128.0)) * tmpvar_10);
				spec_24 = tmpvar_27;
				c_23.xyz = (_LightColor0.xyz * ((tmpvar_9 *
					max(0.0, dot(tmpvar_25, lightDir_4))
					) + spec_24));
				c_23.w = 1.0;
				c_2.xyz = c_23.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out lowp vec3 vs_TEXCOORD1;
			out lowp vec3 vs_TEXCOORD2;
			out lowp vec3 vs_TEXCOORD3;
			out highp vec3 vs_TEXCOORD4;
			out lowp vec4 vs_COLOR0;
			highp vec4 t0;
			highp vec3 t1;
			lowp vec3 t10_2;
			highp float t3;
			highp float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t10_2.xyz = t0.xyz * t1.xyz;
				t10_2.xyz = t0.zxy * t1.yzx + (-t10_2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t10_2.xyz = vec3(t3) * t10_2.xyz;
				vs_TEXCOORD1.y = t10_2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t10_2.y;
				vs_TEXCOORD3.y = t10_2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			in highp vec4 vs_TEXCOORD0;
			in lowp vec3 vs_TEXCOORD1;
			in lowp vec3 vs_TEXCOORD2;
			in lowp vec3 vs_TEXCOORD3;
			in highp vec3 vs_TEXCOORD4;
			in lowp vec4 vs_COLOR0;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec2 t0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec3 t10_4;
			lowp vec3 t10_5;
			mediump float t16_6;
			highp vec3 t7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_25;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t10_4.xyz = t1.xyz * vec3(t22) + _WorldSpaceLightPos0.xyz;
				t10_25 = dot(t10_4.xyz, t10_4.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_4.xyz = vec3(t10_25) * t10_4.xyz;
				t10_5.x = vs_TEXCOORD1.z;
				t10_5.y = vs_TEXCOORD2.z;
				t10_5.z = vs_TEXCOORD3.z;
				t10_25 = dot(t10_5.xyz, t10_5.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_5.xyz = vec3(t10_25) * t10_5.xyz;
				t10_4.x = dot(t10_5.xyz, t10_4.xyz);
				t10_4.y = dot(t10_5.xyz, _WorldSpaceLightPos0.xyz);
				t10_4.xy = max(t10_4.xy, vec2(0.0, 0.0));
				t16_6 = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6 = t16_6 * t16_13;
				t16_6 = exp2(t16_6);
				t16_6 = t0.x * t16_6;
				t10_4.xyz = t7.xyz * t10_4.yyy + vec3(t16_6);
				SV_Target0.xyz = t10_4.xyz * _LightColor0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 19 math
			Keywords{ "DIRECTIONAL" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 240
				Matrix 0[glstate_matrix_mvp]
				Matrix 64[_Object2World]
				Matrix 128[_World2Object]
				Vector 192[unity_WorldTransformParams]
				Vector 208[_MainTex_ST]
				Vector 224[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderUniform {
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				half tangentSign_2;
				half3 worldTangent_3;
				half3 worldNormal_4;
				float4 tmpvar_5;
				tmpvar_5.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_5.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float4 v_6;
				v_6.x = _mtl_u._World2Object[0].x;
				v_6.y = _mtl_u._World2Object[1].x;
				v_6.z = _mtl_u._World2Object[2].x;
				v_6.w = _mtl_u._World2Object[3].x;
				float4 v_7;
				v_7.x = _mtl_u._World2Object[0].y;
				v_7.y = _mtl_u._World2Object[1].y;
				v_7.z = _mtl_u._World2Object[2].y;
				v_7.w = _mtl_u._World2Object[3].y;
				float4 v_8;
				v_8.x = _mtl_u._World2Object[0].z;
				v_8.y = _mtl_u._World2Object[1].z;
				v_8.z = _mtl_u._World2Object[2].z;
				v_8.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_9;
				tmpvar_9 = normalize(((
					(v_6.xyz * _mtl_i._glesNormal.x)
					+
					(v_7.xyz * _mtl_i._glesNormal.y)
					) + (v_8.xyz * _mtl_i._glesNormal.z)));
				worldNormal_4 = half3(tmpvar_9);
				float3x3 tmpvar_10;
				tmpvar_10[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_10[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_10[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_11;
				tmpvar_11 = normalize((tmpvar_10 * _mtl_i._glesTANGENT.xyz));
				worldTangent_3 = half3(tmpvar_11);
				float tmpvar_12;
				tmpvar_12 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_2 = half(tmpvar_12);
				half3 tmpvar_13;
				tmpvar_13 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				half3 tmpvar_14;
				tmpvar_14.x = worldTangent_3.x;
				tmpvar_14.y = tmpvar_13.x;
				tmpvar_14.z = worldNormal_4.x;
				half3 tmpvar_15;
				tmpvar_15.x = worldTangent_3.y;
				tmpvar_15.y = tmpvar_13.y;
				tmpvar_15.z = worldNormal_4.y;
				half3 tmpvar_16;
				tmpvar_16.x = worldTangent_3.z;
				tmpvar_16.y = tmpvar_13.z;
				tmpvar_16.z = worldNormal_4.z;
				_mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				_mtl_o.xlv_TEXCOORD0 = tmpvar_5;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_14;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_15;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_16;
				_mtl_o.xlv_TEXCOORD4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec3 vs_TEXCOORD1;
			out vec3 vs_TEXCOORD2;
			out vec3 vs_TEXCOORD3;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_COLOR0;
			vec4 t0;
			vec3 t1;
			vec3 t2;
			float t3;
			float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t2.xyz = t0.xyz * t1.xyz;
				t2.xyz = t0.zxy * t1.yzx + (-t2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t2.xyz = vec3(t3) * t2.xyz;
				vs_TEXCOORD1.y = t2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t2.y;
				vs_TEXCOORD3.y = t2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			in  vec4 vs_TEXCOORD0;
			in  vec3 vs_TEXCOORD1;
			in  vec3 vs_TEXCOORD2;
			in  vec3 vs_TEXCOORD3;
			in  vec3 vs_TEXCOORD4;
			in  vec4 vs_COLOR0;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			vec4 t2;
			lowp vec4 t10_3;
			vec3 t4;
			vec2 t8;
			float t9;
			float t13;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t13 = dot(t1.xyz, t1.xyz);
				t13 = inversesqrt(t13);
				t1.xyz = t1.xyz * vec3(t13) + _WorldSpaceLightPos0.xyz;
				t13 = dot(t1.xyz, t1.xyz);
				t13 = inversesqrt(t13);
				t1.xyz = vec3(t13) * t1.xyz;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = vec3(t13) * t2.xyz;
				t1.x = dot(t2.xyz, t1.xyz);
				t1.y = dot(t2.xyz, _WorldSpaceLightPos0.xyz);
				t1.xy = max(t1.xy, vec2(0.0, 0.0));
				t1.x = log2(t1.x);
				t9 = _Shininess * 128.0;
				t1.x = t1.x * t9;
				t1.x = exp2(t1.x);
				t0.x = t0.x * t1.x;
				t0.xyz = t4.xyz * t1.yyy + t0.xxx;
				SV_Target0.xyz = t0.xyz * _LightColor0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "opengl " {
			// Stats: 52 math, 4 textures
			Keywords{ "SPOT" }
				"!!GLSL#version 120

#ifdef VERTEX

				uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec4 tmpvar_1;
				tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_1.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec4 v_2;
				v_2.x = _World2Object[0].x;
				v_2.y = _World2Object[1].x;
				v_2.z = _World2Object[2].x;
				v_2.w = _World2Object[3].x;
				vec4 v_3;
				v_3.x = _World2Object[0].y;
				v_3.y = _World2Object[1].y;
				v_3.z = _World2Object[2].y;
				v_3.w = _World2Object[3].y;
				vec4 v_4;
				v_4.x = _World2Object[0].z;
				v_4.y = _World2Object[1].z;
				v_4.z = _World2Object[2].z;
				v_4.w = _World2Object[3].z;
				vec3 tmpvar_5;
				tmpvar_5 = normalize(((
					(v_2.xyz * gl_Normal.x)
					+
					(v_3.xyz * gl_Normal.y)
					) + (v_4.xyz * gl_Normal.z)));
				mat3 tmpvar_6;
				tmpvar_6[0] = _Object2World[0].xyz;
				tmpvar_6[1] = _Object2World[1].xyz;
				tmpvar_6[2] = _Object2World[2].xyz;
				vec3 tmpvar_7;
				tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
				vec3 tmpvar_8;
				tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec3 tmpvar_9;
				tmpvar_9.x = tmpvar_7.x;
				tmpvar_9.y = tmpvar_8.x;
				tmpvar_9.z = tmpvar_5.x;
				vec3 tmpvar_10;
				tmpvar_10.x = tmpvar_7.y;
				tmpvar_10.y = tmpvar_8.y;
				tmpvar_10.z = tmpvar_5.y;
				vec3 tmpvar_11;
				tmpvar_11.x = tmpvar_7.z;
				tmpvar_11.y = tmpvar_8.z;
				tmpvar_11.z = tmpvar_5.z;
				gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
				xlv_TEXCOORD0 = tmpvar_1;
				xlv_TEXCOORD1 = tmpvar_9;
				xlv_TEXCOORD2 = tmpvar_10;
				xlv_TEXCOORD3 = tmpvar_11;
				xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
				xlv_COLOR0 = gl_Color;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform sampler2D _LightTexture0;
			uniform mat4 _LightMatrix0;
			uniform sampler2D _LightTextureB0;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec3 tmpvar_3;
				tmpvar_3 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
				vec4 tmpvar_4;
				tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_5;
				tmpvar_5 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_6;
				tmpvar_6.x = tmpvar_4.x;
				tmpvar_6.y = tmpvar_5.x;
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_4.y;
				tmpvar_7.y = tmpvar_5.y;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_4.z;
				tmpvar_8.y = tmpvar_5.z;
				vec2 tmpvar_9;
				tmpvar_9.x = tmpvar_4.w;
				tmpvar_9.y = tmpvar_5.w;
				vec2 tmpvar_10;
				float tmpvar_11;
				tmpvar_11 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_10 = mix(mix(tmpvar_6, tmpvar_7, vec2(clamp(tmpvar_11, 0.0, 1.0))), mix(tmpvar_8, tmpvar_9, vec2(clamp(
					(tmpvar_11 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_11 - 1.0), 0.0, 1.0)));
				vec4 tmpvar_12;
				tmpvar_12.w = 1.0;
				tmpvar_12.xyz = xlv_TEXCOORD4;
				vec4 tmpvar_13;
				tmpvar_13 = (_LightMatrix0 * tmpvar_12);
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				vec4 c_14;
				vec3 tmpvar_15;
				tmpvar_15 = normalize(worldN_1);
				c_14.xyz = ((_LightColor0.xyz * (
					(mix(tmpvar_10.xxx, mix(mix(vec3(
						clamp((tmpvar_10.x + ((1.0 - tmpvar_10.y) * (tmpvar_10.x * tmpvar_10.x))), 0.0, 1.0)
						), xlv_COLOR0.xyz, tmpvar_10.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0))) * max(0.0, dot(tmpvar_15, tmpvar_3)))
					+
					(pow(max(0.0, dot(tmpvar_15,
						normalize((normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)) + tmpvar_3))
						)), (_Shininess * 128.0)) * ((pow(
							((1.0 - tmpvar_10.y) + 0.4)
							, 3.0) + 0.2) * tmpvar_10.y))
					)) * ((
						float((tmpvar_13.z > 0.0))
						* texture2D (_LightTexture0,
							((tmpvar_13.xy / tmpvar_13.w) + 0.5)
							).w) * texture2D (_LightTextureB0, vec2(dot(tmpvar_13.xyz, tmpvar_13.xyz))).w));
				c_14.w = 1.0;
				c_2.xyz = c_14.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 35 math
			Keywords{ "SPOT" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 4[_Object2World] 3
				Matrix 7[_World2Object] 3
				Matrix 0[glstate_matrix_mvp]
				Vector 12[_Emissive_ST]
				Vector 11[_MainTex_ST]
				Vector 10[unity_WorldTransformParams]
				"vs_3_0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2.xyz
				dcl_texcoord2 o3.xyz
				dcl_texcoord3 o4.xyz
				dcl_texcoord4 o5.xyz
				dcl_color o6
				dp4 o0.x, c0, v0
				dp4 o0.y, c1, v0
				dp4 o0.z, c2, v0
				dp4 o0.w, c3, v0
				mad o1.xy, v3, c11, c11.zwzw
				mad o1.zw, v4.xyxy, c12.xyxy, c12
				dp4 o5.x, c4, v0
				dp4 o5.y, c5, v0
				dp4 o5.z, c6, v0
				dp3 r0.z, c4, v1
				dp3 r0.x, c5, v1
				dp3 r0.y, c6, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r1.xyz, c8.zxyw, v2.y
				mad r1.xyz, c7.zxyw, v2.x, r1
				mad r1.xyz, c9.zxyw, v2.z, r1
				dp3 r0.w, r1, r1
				rsq r0.w, r0.w
				mul r1.xyz, r0.w, r1
				mul r2.xyz, r0, r1
				mad r2.xyz, r1.zxyw, r0.yzxw, -r2
				mul r0.z, c10.w, v1.w
				mul r2.xyz, r0.z, r2
				mov o2.y, r2.x
				mov o2.z, r1.y
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r2.y
				mov o4.y, r2.z
				mov o3.z, r1.z
				mov o4.z, r1.x
				mov o6, v5

				"
		}
		SubProgram "d3d11 " {
			// Stats: 34 math
			Keywords{ "SPOT" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 272
				Vector 240[_MainTex_ST]
				Vector 256[_Emissive_ST]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityPerDraw" 1
				"vs_4_0
				root12:aaacaaaa
				eefiecedhaomgnoeigpocikojcffdbiamlplojojabaaaaaaaeaiaaaaadaaaaaa
				cmaaaaaaceabaaaapiabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				ahaiaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
				epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcaeagaaaa
				eaaaabaaibabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
				abaaaaaabgaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
				fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
				aeaaaaaafpaaaaadpcbabaaaahaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
				gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
				adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
				pccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
				aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
				abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
				aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
				dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
				egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
				aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadcaaaaalmccabaaaabaaaaaa
				agbebaaaaeaaaaaaagiecaaaaaaaaaaabaaaaaaakgiocaaaaaaaaaaabaaaaaaa
				diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
				diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
				aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
				ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
				ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
				bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
				hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
				aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
				dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
				aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
				abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
				abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
				dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
				egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
				egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
				aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaa
				aaaaaaaadkbabaaaabaaaaaadkiacaaaabaaaaaabfaaaaaadiaaaaahhcaabaaa
				acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaafcccabaaaacaaaaaa
				akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
				eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
				aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
				aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
				dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
				fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
				egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
				hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
				aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
				aaaaaaaaegacbaaaaaaaaaaadgaaaaafpccabaaaagaaaaaaegbobaaaahaaaaaa
				doaaaaab"
		}
		SubProgram "gles " {
			// Stats: 52 math, 4 textures
			Keywords{ "SPOT" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp float tangentSign_1;
				lowp vec3 worldTangent_2;
				lowp vec3 worldNormal_3;
				highp vec4 tmpvar_4;
				tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec4 v_5;
				v_5.x = _World2Object[0].x;
				v_5.y = _World2Object[1].x;
				v_5.z = _World2Object[2].x;
				v_5.w = _World2Object[3].x;
				highp vec4 v_6;
				v_6.x = _World2Object[0].y;
				v_6.y = _World2Object[1].y;
				v_6.z = _World2Object[2].y;
				v_6.w = _World2Object[3].y;
				highp vec4 v_7;
				v_7.x = _World2Object[0].z;
				v_7.y = _World2Object[1].z;
				v_7.z = _World2Object[2].z;
				v_7.w = _World2Object[3].z;
				highp vec3 tmpvar_8;
				tmpvar_8 = normalize(((
					(v_5.xyz * _glesNormal.x)
					+
					(v_6.xyz * _glesNormal.y)
					) + (v_7.xyz * _glesNormal.z)));
				worldNormal_3 = tmpvar_8;
				highp mat3 tmpvar_9;
				tmpvar_9[0] = _Object2World[0].xyz;
				tmpvar_9[1] = _Object2World[1].xyz;
				tmpvar_9[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
				worldTangent_2 = tmpvar_10;
				highp float tmpvar_11;
				tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_1 = tmpvar_11;
				lowp vec3 tmpvar_12;
				tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
				lowp vec3 tmpvar_13;
				tmpvar_13.x = worldTangent_2.x;
				tmpvar_13.y = tmpvar_12.x;
				tmpvar_13.z = worldNormal_3.x;
				lowp vec3 tmpvar_14;
				tmpvar_14.x = worldTangent_2.y;
				tmpvar_14.y = tmpvar_12.y;
				tmpvar_14.z = worldNormal_3.y;
				lowp vec3 tmpvar_15;
				tmpvar_15.x = worldTangent_2.z;
				tmpvar_15.y = tmpvar_12.z;
				tmpvar_15.z = worldNormal_3.z;
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_4;
				xlv_TEXCOORD1 = tmpvar_13;
				xlv_TEXCOORD2 = tmpvar_14;
				xlv_TEXCOORD3 = tmpvar_15;
				xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
				xlv_COLOR0 = _glesColor;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform highp vec4 _WorldSpaceLightPos0;
			uniform lowp vec4 _LightColor0;
			uniform sampler2D _LightTexture0;
			uniform mediump mat4 _LightMatrix0;
			uniform sampler2D _LightTextureB0;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp float atten_3;
				mediump vec4 lightCoord_4;
				lowp vec3 worldViewDir_5;
				lowp vec3 lightDir_6;
				highp vec4 tmpvar_7;
				highp vec3 tmpvar_8;
				tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
				lightDir_6 = tmpvar_8;
				highp vec3 tmpvar_9;
				tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
				worldViewDir_5 = tmpvar_9;
				lowp vec3 tmpvar_10;
				tmpvar_10 = normalize((worldViewDir_5 + lightDir_6));
				worldViewDir_5 = tmpvar_10;
				tmpvar_7 = xlv_COLOR0;
				lowp vec3 tmpvar_11;
				lowp float tmpvar_12;
				highp vec4 mask_13;
				highp vec4 color_14;
				lowp vec4 tmpvar_15;
				tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_14 = tmpvar_15;
				lowp vec4 tmpvar_16;
				tmpvar_16 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_13 = tmpvar_16;
				highp vec2 tmpvar_17;
				tmpvar_17.x = color_14.x;
				tmpvar_17.y = mask_13.x;
				highp vec2 tmpvar_18;
				tmpvar_18.x = color_14.y;
				tmpvar_18.y = mask_13.y;
				highp vec2 tmpvar_19;
				tmpvar_19.x = color_14.z;
				tmpvar_19.y = mask_13.z;
				highp vec2 tmpvar_20;
				tmpvar_20.x = color_14.w;
				tmpvar_20.y = mask_13.w;
				highp vec2 tmpvar_21;
				highp float tmpvar_22;
				tmpvar_22 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_21 = mix(mix(tmpvar_17, tmpvar_18, vec2(clamp(tmpvar_22, 0.0, 1.0))), mix(tmpvar_19, tmpvar_20, vec2(clamp(
					(tmpvar_22 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_22 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_23;
				tmpvar_23 = mix(tmpvar_21.xxx, mix(mix(vec3(
					clamp((tmpvar_21.x + ((1.0 - tmpvar_21.y) * (tmpvar_21.x * tmpvar_21.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_21.yyy), tmpvar_7.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_11 = tmpvar_23;
				highp float tmpvar_24;
				tmpvar_24 = pow(((1.0 - tmpvar_21.y) + 0.4), 3.0);
				tmpvar_12 = ((tmpvar_24 + 0.2) * tmpvar_21.y);
				highp vec4 tmpvar_25;
				tmpvar_25.w = 1.0;
				tmpvar_25.xyz = xlv_TEXCOORD4;
				highp vec4 tmpvar_26;
				tmpvar_26 = (_LightMatrix0 * tmpvar_25);
				lightCoord_4 = tmpvar_26;
				lowp vec4 tmpvar_27;
				mediump vec2 P_28;
				P_28 = ((lightCoord_4.xy / lightCoord_4.w) + 0.5);
				tmpvar_27 = texture2D (_LightTexture0, P_28);
				highp vec3 LightCoord_29;
				LightCoord_29 = lightCoord_4.xyz;
				highp float tmpvar_30;
				tmpvar_30 = dot(LightCoord_29, LightCoord_29);
				lowp vec4 tmpvar_31;
				tmpvar_31 = texture2D (_LightTextureB0, vec2(tmpvar_30));
				mediump float tmpvar_32;
				tmpvar_32 = ((float(
					(lightCoord_4.z > 0.0)
					) * tmpvar_27.w) * tmpvar_31.w);
				atten_3 = tmpvar_32;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				lowp vec4 c_33;
				lowp float spec_34;
				lowp vec3 tmpvar_35;
				tmpvar_35 = normalize(worldN_1);
				lowp float tmpvar_36;
				tmpvar_36 = max(0.0, dot(tmpvar_35, tmpvar_10));
				mediump float tmpvar_37;
				tmpvar_37 = (pow(tmpvar_36, (_Shininess * 128.0)) * tmpvar_12);
				spec_34 = tmpvar_37;
				c_33.xyz = ((_LightColor0.xyz * (
					(tmpvar_11 * max(0.0, dot(tmpvar_35, lightDir_6)))
					+ spec_34)) * atten_3);
				c_33.w = 1.0;
				c_2.xyz = c_33.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "SPOT" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out lowp vec3 vs_TEXCOORD1;
			out lowp vec3 vs_TEXCOORD2;
			out lowp vec3 vs_TEXCOORD3;
			out highp vec3 vs_TEXCOORD4;
			out lowp vec4 vs_COLOR0;
			highp vec4 t0;
			highp vec3 t1;
			lowp vec3 t10_2;
			highp float t3;
			highp float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t10_2.xyz = t0.xyz * t1.xyz;
				t10_2.xyz = t0.zxy * t1.yzx + (-t10_2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t10_2.xyz = vec3(t3) * t10_2.xyz;
				vs_TEXCOORD1.y = t10_2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t10_2.y;
				vs_TEXCOORD3.y = t10_2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			uniform lowp sampler2D _LightTexture0;
			uniform lowp sampler2D _LightTextureB0;
			in highp vec4 vs_TEXCOORD0;
			in lowp vec3 vs_TEXCOORD1;
			in lowp vec3 vs_TEXCOORD2;
			in lowp vec3 vs_TEXCOORD3;
			in highp vec3 vs_TEXCOORD4;
			in lowp vec4 vs_COLOR0;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec2 t0;
			mediump vec4 t16_0;
			highp vec4 t1;
			lowp float t10_1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec3 t10_4;
			lowp vec3 t10_5;
			mediump vec2 t16_6;
			highp vec3 t7;
			bool tb8;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			mediump float t16_15;
			lowp float t10_15;
			highp float t22;
			lowp float t10_25;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t1.xyz = vec3(t22) * t1.xyz;
				t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t2.xyz, t2.xyz);
				t22 = inversesqrt(t22);
				t10_4.xyz = t2.xyz * vec3(t22) + t1.xyz;
				t10_25 = dot(t10_4.xyz, t10_4.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_4.xyz = vec3(t10_25) * t10_4.xyz;
				t10_5.x = vs_TEXCOORD1.z;
				t10_5.y = vs_TEXCOORD2.z;
				t10_5.z = vs_TEXCOORD3.z;
				t10_25 = dot(t10_5.xyz, t10_5.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_5.xyz = vec3(t10_25) * t10_5.xyz;
				t10_4.x = dot(t10_5.xyz, t10_4.xyz);
				t10_4.y = dot(t10_5.xyz, t1.xyz);
				t10_4.xy = max(t10_4.xy, vec2(0.0, 0.0));
				t16_6.x = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6.x = t16_6.x * t16_13;
				t16_6.x = exp2(t16_6.x);
				t16_6.x = t0.x * t16_6.x;
				t10_4.xyz = t7.xyz * t10_4.yyy + t16_6.xxx;
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				t16_0 = vs_TEXCOORD4.yyyy * _LightMatrix0[1];
				t16_0 = _LightMatrix0[0] * vs_TEXCOORD4.xxxx + t16_0;
				t16_0 = _LightMatrix0[2] * vs_TEXCOORD4.zzzz + t16_0;
				t16_0 = t16_0 + _LightMatrix0[3];
				t16_6.xy = t16_0.xy / t16_0.ww;
				t16_6.xy = t16_6.xy + vec2(0.5, 0.5);
				t10_1 = texture(_LightTexture0, t16_6.xy).w;
				tb8 = 0.0<t16_0.z;
				t16_15 = dot(t16_0.xyz, t16_0.xyz);
				t10_15 = texture(_LightTextureB0, vec2(t16_15)).w;
				t10_25 = (tb8) ? 1.0 : 0.0;
				t10_25 = t10_1 * t10_25;
				t10_25 = t10_15 * t10_25;
				SV_Target0.xyz = vec3(t10_25) * t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 19 math
			Keywords{ "SPOT" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 240
				Matrix 0[glstate_matrix_mvp]
				Matrix 64[_Object2World]
				Matrix 128[_World2Object]
				Vector 192[unity_WorldTransformParams]
				Vector 208[_MainTex_ST]
				Vector 224[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderUniform {
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				half tangentSign_2;
				half3 worldTangent_3;
				half3 worldNormal_4;
				float4 tmpvar_5;
				tmpvar_5.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_5.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float4 v_6;
				v_6.x = _mtl_u._World2Object[0].x;
				v_6.y = _mtl_u._World2Object[1].x;
				v_6.z = _mtl_u._World2Object[2].x;
				v_6.w = _mtl_u._World2Object[3].x;
				float4 v_7;
				v_7.x = _mtl_u._World2Object[0].y;
				v_7.y = _mtl_u._World2Object[1].y;
				v_7.z = _mtl_u._World2Object[2].y;
				v_7.w = _mtl_u._World2Object[3].y;
				float4 v_8;
				v_8.x = _mtl_u._World2Object[0].z;
				v_8.y = _mtl_u._World2Object[1].z;
				v_8.z = _mtl_u._World2Object[2].z;
				v_8.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_9;
				tmpvar_9 = normalize(((
					(v_6.xyz * _mtl_i._glesNormal.x)
					+
					(v_7.xyz * _mtl_i._glesNormal.y)
					) + (v_8.xyz * _mtl_i._glesNormal.z)));
				worldNormal_4 = half3(tmpvar_9);
				float3x3 tmpvar_10;
				tmpvar_10[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_10[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_10[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_11;
				tmpvar_11 = normalize((tmpvar_10 * _mtl_i._glesTANGENT.xyz));
				worldTangent_3 = half3(tmpvar_11);
				float tmpvar_12;
				tmpvar_12 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_2 = half(tmpvar_12);
				half3 tmpvar_13;
				tmpvar_13 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				half3 tmpvar_14;
				tmpvar_14.x = worldTangent_3.x;
				tmpvar_14.y = tmpvar_13.x;
				tmpvar_14.z = worldNormal_4.x;
				half3 tmpvar_15;
				tmpvar_15.x = worldTangent_3.y;
				tmpvar_15.y = tmpvar_13.y;
				tmpvar_15.z = worldNormal_4.y;
				half3 tmpvar_16;
				tmpvar_16.x = worldTangent_3.z;
				tmpvar_16.y = tmpvar_13.z;
				tmpvar_16.z = worldNormal_4.z;
				_mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				_mtl_o.xlv_TEXCOORD0 = tmpvar_5;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_14;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_15;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_16;
				_mtl_o.xlv_TEXCOORD4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "SPOT" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec3 vs_TEXCOORD1;
			out vec3 vs_TEXCOORD2;
			out vec3 vs_TEXCOORD3;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_COLOR0;
			vec4 t0;
			vec3 t1;
			vec3 t2;
			float t3;
			float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t2.xyz = t0.xyz * t1.xyz;
				t2.xyz = t0.zxy * t1.yzx + (-t2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t2.xyz = vec3(t3) * t2.xyz;
				vs_TEXCOORD1.y = t2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t2.y;
				vs_TEXCOORD3.y = t2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			uniform  sampler2D _LightTexture0;
			uniform  sampler2D _LightTextureB0;
			in  vec4 vs_TEXCOORD0;
			in  vec3 vs_TEXCOORD1;
			in  vec3 vs_TEXCOORD2;
			in  vec3 vs_TEXCOORD3;
			in  vec3 vs_TEXCOORD4;
			in  vec4 vs_COLOR0;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			lowp vec4 t10_1;
			vec4 t2;
			lowp vec4 t10_2;
			vec3 t3;
			lowp vec4 t10_3;
			vec3 t4;
			float t5;
			vec2 t8;
			float t9;
			float t12;
			bool tb12;
			float t13;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
				t13 = dot(t1.xyz, t1.xyz);
				t13 = inversesqrt(t13);
				t1.xyz = vec3(t13) * t1.xyz;
				t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = t2.xyz * vec3(t13) + t1.xyz;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = vec3(t13) * t2.xyz;
				t3.x = vs_TEXCOORD1.z;
				t3.y = vs_TEXCOORD2.z;
				t3.z = vs_TEXCOORD3.z;
				t13 = dot(t3.xyz, t3.xyz);
				t13 = inversesqrt(t13);
				t3.xyz = vec3(t13) * t3.xyz;
				t1.w = dot(t3.xyz, t2.xyz);
				t1.x = dot(t3.xyz, t1.xyz);
				t1.xy = max(t1.xw, vec2(0.0, 0.0));
				t5 = log2(t1.y);
				t9 = _Shininess * 128.0;
				t5 = t5 * t9;
				t5 = exp2(t5);
				t0.x = t0.x * t5;
				t0.xyz = t4.xyz * t1.xxx + t0.xxx;
				t0.xyz = t0.xyz * _LightColor0.xyz;
				t1 = vs_TEXCOORD4.yyyy * _LightMatrix0[1];
				t1 = _LightMatrix0[0] * vs_TEXCOORD4.xxxx + t1;
				t1 = _LightMatrix0[2] * vs_TEXCOORD4.zzzz + t1;
				t1 = t1 + _LightMatrix0[3];
				t2.xy = t1.xy / t1.ww;
				t2.xy = t2.xy + vec2(0.5, 0.5);
				t10_2 = texture(_LightTexture0, t2.xy);
				tb12 = 0.0<t1.z;
				t1.x = dot(t1.xyz, t1.xyz);
				t10_1 = texture(_LightTextureB0, t1.xx);
				t12 = tb12 ? 1.0 : float(0.0);
				t12 = t10_2.w * t12;
				t12 = t10_1.w * t12;
				SV_Target0.xyz = vec3(t12) * t0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "opengl " {
			// Stats: 47 math, 4 textures
			Keywords{ "POINT_COOKIE" }
				"!!GLSL#version 120

#ifdef VERTEX

				uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec4 tmpvar_1;
				tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_1.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec4 v_2;
				v_2.x = _World2Object[0].x;
				v_2.y = _World2Object[1].x;
				v_2.z = _World2Object[2].x;
				v_2.w = _World2Object[3].x;
				vec4 v_3;
				v_3.x = _World2Object[0].y;
				v_3.y = _World2Object[1].y;
				v_3.z = _World2Object[2].y;
				v_3.w = _World2Object[3].y;
				vec4 v_4;
				v_4.x = _World2Object[0].z;
				v_4.y = _World2Object[1].z;
				v_4.z = _World2Object[2].z;
				v_4.w = _World2Object[3].z;
				vec3 tmpvar_5;
				tmpvar_5 = normalize(((
					(v_2.xyz * gl_Normal.x)
					+
					(v_3.xyz * gl_Normal.y)
					) + (v_4.xyz * gl_Normal.z)));
				mat3 tmpvar_6;
				tmpvar_6[0] = _Object2World[0].xyz;
				tmpvar_6[1] = _Object2World[1].xyz;
				tmpvar_6[2] = _Object2World[2].xyz;
				vec3 tmpvar_7;
				tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
				vec3 tmpvar_8;
				tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec3 tmpvar_9;
				tmpvar_9.x = tmpvar_7.x;
				tmpvar_9.y = tmpvar_8.x;
				tmpvar_9.z = tmpvar_5.x;
				vec3 tmpvar_10;
				tmpvar_10.x = tmpvar_7.y;
				tmpvar_10.y = tmpvar_8.y;
				tmpvar_10.z = tmpvar_5.y;
				vec3 tmpvar_11;
				tmpvar_11.x = tmpvar_7.z;
				tmpvar_11.y = tmpvar_8.z;
				tmpvar_11.z = tmpvar_5.z;
				gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
				xlv_TEXCOORD0 = tmpvar_1;
				xlv_TEXCOORD1 = tmpvar_9;
				xlv_TEXCOORD2 = tmpvar_10;
				xlv_TEXCOORD3 = tmpvar_11;
				xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
				xlv_COLOR0 = gl_Color;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform samplerCube _LightTexture0;
			uniform mat4 _LightMatrix0;
			uniform sampler2D _LightTextureB0;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec3 tmpvar_3;
				tmpvar_3 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
				vec4 tmpvar_4;
				tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_5;
				tmpvar_5 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_6;
				tmpvar_6.x = tmpvar_4.x;
				tmpvar_6.y = tmpvar_5.x;
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_4.y;
				tmpvar_7.y = tmpvar_5.y;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_4.z;
				tmpvar_8.y = tmpvar_5.z;
				vec2 tmpvar_9;
				tmpvar_9.x = tmpvar_4.w;
				tmpvar_9.y = tmpvar_5.w;
				vec2 tmpvar_10;
				float tmpvar_11;
				tmpvar_11 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_10 = mix(mix(tmpvar_6, tmpvar_7, vec2(clamp(tmpvar_11, 0.0, 1.0))), mix(tmpvar_8, tmpvar_9, vec2(clamp(
					(tmpvar_11 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_11 - 1.0), 0.0, 1.0)));
				vec4 tmpvar_12;
				tmpvar_12.w = 1.0;
				tmpvar_12.xyz = xlv_TEXCOORD4;
				vec3 tmpvar_13;
				tmpvar_13 = (_LightMatrix0 * tmpvar_12).xyz;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				vec4 c_14;
				vec3 tmpvar_15;
				tmpvar_15 = normalize(worldN_1);
				c_14.xyz = ((_LightColor0.xyz * (
					(mix(tmpvar_10.xxx, mix(mix(vec3(
						clamp((tmpvar_10.x + ((1.0 - tmpvar_10.y) * (tmpvar_10.x * tmpvar_10.x))), 0.0, 1.0)
						), xlv_COLOR0.xyz, tmpvar_10.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0))) * max(0.0, dot(tmpvar_15, tmpvar_3)))
					+
					(pow(max(0.0, dot(tmpvar_15,
						normalize((normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)) + tmpvar_3))
						)), (_Shininess * 128.0)) * ((pow(
							((1.0 - tmpvar_10.y) + 0.4)
							, 3.0) + 0.2) * tmpvar_10.y))
					)) * (texture2D (_LightTextureB0, vec2(dot(tmpvar_13, tmpvar_13))).w * textureCube(_LightTexture0, tmpvar_13).w));
				c_14.w = 1.0;
				c_2.xyz = c_14.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 35 math
			Keywords{ "POINT_COOKIE" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 4[_Object2World] 3
				Matrix 7[_World2Object] 3
				Matrix 0[glstate_matrix_mvp]
				Vector 12[_Emissive_ST]
				Vector 11[_MainTex_ST]
				Vector 10[unity_WorldTransformParams]
				"vs_3_0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2.xyz
				dcl_texcoord2 o3.xyz
				dcl_texcoord3 o4.xyz
				dcl_texcoord4 o5.xyz
				dcl_color o6
				dp4 o0.x, c0, v0
				dp4 o0.y, c1, v0
				dp4 o0.z, c2, v0
				dp4 o0.w, c3, v0
				mad o1.xy, v3, c11, c11.zwzw
				mad o1.zw, v4.xyxy, c12.xyxy, c12
				dp4 o5.x, c4, v0
				dp4 o5.y, c5, v0
				dp4 o5.z, c6, v0
				dp3 r0.z, c4, v1
				dp3 r0.x, c5, v1
				dp3 r0.y, c6, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r1.xyz, c8.zxyw, v2.y
				mad r1.xyz, c7.zxyw, v2.x, r1
				mad r1.xyz, c9.zxyw, v2.z, r1
				dp3 r0.w, r1, r1
				rsq r0.w, r0.w
				mul r1.xyz, r0.w, r1
				mul r2.xyz, r0, r1
				mad r2.xyz, r1.zxyw, r0.yzxw, -r2
				mul r0.z, c10.w, v1.w
				mul r2.xyz, r0.z, r2
				mov o2.y, r2.x
				mov o2.z, r1.y
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r2.y
				mov o4.y, r2.z
				mov o3.z, r1.z
				mov o4.z, r1.x
				mov o6, v5

				"
		}
		SubProgram "d3d11 " {
			// Stats: 34 math
			Keywords{ "POINT_COOKIE" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 272
				Vector 240[_MainTex_ST]
				Vector 256[_Emissive_ST]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityPerDraw" 1
				"vs_4_0
				root12:aaacaaaa
				eefiecedhaomgnoeigpocikojcffdbiamlplojojabaaaaaaaeaiaaaaadaaaaaa
				cmaaaaaaceabaaaapiabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				ahaiaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
				epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcaeagaaaa
				eaaaabaaibabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
				abaaaaaabgaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
				fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
				aeaaaaaafpaaaaadpcbabaaaahaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
				gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
				adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
				pccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
				aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
				abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
				aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
				dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
				egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
				aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadcaaaaalmccabaaaabaaaaaa
				agbebaaaaeaaaaaaagiecaaaaaaaaaaabaaaaaaakgiocaaaaaaaaaaabaaaaaaa
				diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
				diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
				aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
				ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
				ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
				bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
				hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
				aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
				dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
				aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
				abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
				abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
				dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
				egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
				egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
				aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaa
				aaaaaaaadkbabaaaabaaaaaadkiacaaaabaaaaaabfaaaaaadiaaaaahhcaabaaa
				acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaafcccabaaaacaaaaaa
				akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
				eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
				aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
				aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
				dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
				fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
				egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
				hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
				aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
				aaaaaaaaegacbaaaaaaaaaaadgaaaaafpccabaaaagaaaaaaegbobaaaahaaaaaa
				doaaaaab"
		}
		SubProgram "gles " {
			// Stats: 47 math, 4 textures
			Keywords{ "POINT_COOKIE" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp float tangentSign_1;
				lowp vec3 worldTangent_2;
				lowp vec3 worldNormal_3;
				highp vec4 tmpvar_4;
				tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec4 v_5;
				v_5.x = _World2Object[0].x;
				v_5.y = _World2Object[1].x;
				v_5.z = _World2Object[2].x;
				v_5.w = _World2Object[3].x;
				highp vec4 v_6;
				v_6.x = _World2Object[0].y;
				v_6.y = _World2Object[1].y;
				v_6.z = _World2Object[2].y;
				v_6.w = _World2Object[3].y;
				highp vec4 v_7;
				v_7.x = _World2Object[0].z;
				v_7.y = _World2Object[1].z;
				v_7.z = _World2Object[2].z;
				v_7.w = _World2Object[3].z;
				highp vec3 tmpvar_8;
				tmpvar_8 = normalize(((
					(v_5.xyz * _glesNormal.x)
					+
					(v_6.xyz * _glesNormal.y)
					) + (v_7.xyz * _glesNormal.z)));
				worldNormal_3 = tmpvar_8;
				highp mat3 tmpvar_9;
				tmpvar_9[0] = _Object2World[0].xyz;
				tmpvar_9[1] = _Object2World[1].xyz;
				tmpvar_9[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
				worldTangent_2 = tmpvar_10;
				highp float tmpvar_11;
				tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_1 = tmpvar_11;
				lowp vec3 tmpvar_12;
				tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
				lowp vec3 tmpvar_13;
				tmpvar_13.x = worldTangent_2.x;
				tmpvar_13.y = tmpvar_12.x;
				tmpvar_13.z = worldNormal_3.x;
				lowp vec3 tmpvar_14;
				tmpvar_14.x = worldTangent_2.y;
				tmpvar_14.y = tmpvar_12.y;
				tmpvar_14.z = worldNormal_3.y;
				lowp vec3 tmpvar_15;
				tmpvar_15.x = worldTangent_2.z;
				tmpvar_15.y = tmpvar_12.z;
				tmpvar_15.z = worldNormal_3.z;
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_4;
				xlv_TEXCOORD1 = tmpvar_13;
				xlv_TEXCOORD2 = tmpvar_14;
				xlv_TEXCOORD3 = tmpvar_15;
				xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
				xlv_COLOR0 = _glesColor;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform highp vec4 _WorldSpaceLightPos0;
			uniform lowp vec4 _LightColor0;
			uniform lowp samplerCube _LightTexture0;
			uniform mediump mat4 _LightMatrix0;
			uniform sampler2D _LightTextureB0;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 worldViewDir_3;
				lowp vec3 lightDir_4;
				highp vec4 tmpvar_5;
				highp vec3 tmpvar_6;
				tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
				lightDir_4 = tmpvar_6;
				highp vec3 tmpvar_7;
				tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
				worldViewDir_3 = tmpvar_7;
				lowp vec3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = xlv_COLOR0;
				lowp vec3 tmpvar_9;
				lowp float tmpvar_10;
				highp vec4 mask_11;
				highp vec4 color_12;
				lowp vec4 tmpvar_13;
				tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_12 = tmpvar_13;
				lowp vec4 tmpvar_14;
				tmpvar_14 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_11 = tmpvar_14;
				highp vec2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				highp vec2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				highp vec2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				highp vec2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				highp vec2 tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, vec2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, vec2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(vec3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = tmpvar_21;
				highp float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = ((tmpvar_22 + 0.2) * tmpvar_19.y);
				highp vec4 tmpvar_23;
				tmpvar_23.w = 1.0;
				tmpvar_23.xyz = xlv_TEXCOORD4;
				highp vec3 tmpvar_24;
				tmpvar_24 = (_LightMatrix0 * tmpvar_23).xyz;
				highp float tmpvar_25;
				tmpvar_25 = dot(tmpvar_24, tmpvar_24);
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				lowp vec4 c_26;
				lowp float spec_27;
				lowp vec3 tmpvar_28;
				tmpvar_28 = normalize(worldN_1);
				lowp float tmpvar_29;
				tmpvar_29 = max(0.0, dot(tmpvar_28, tmpvar_8));
				mediump float tmpvar_30;
				tmpvar_30 = (pow(tmpvar_29, (_Shininess * 128.0)) * tmpvar_10);
				spec_27 = tmpvar_30;
				c_26.xyz = ((_LightColor0.xyz * (
					(tmpvar_9 * max(0.0, dot(tmpvar_28, lightDir_4)))
					+ spec_27)) * (texture2D (_LightTextureB0, vec2(tmpvar_25)).w * textureCube(_LightTexture0, tmpvar_24).w));
				c_26.w = 1.0;
				c_2.xyz = c_26.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "POINT_COOKIE" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out lowp vec3 vs_TEXCOORD1;
			out lowp vec3 vs_TEXCOORD2;
			out lowp vec3 vs_TEXCOORD3;
			out highp vec3 vs_TEXCOORD4;
			out lowp vec4 vs_COLOR0;
			highp vec4 t0;
			highp vec3 t1;
			lowp vec3 t10_2;
			highp float t3;
			highp float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t10_2.xyz = t0.xyz * t1.xyz;
				t10_2.xyz = t0.zxy * t1.yzx + (-t10_2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t10_2.xyz = vec3(t3) * t10_2.xyz;
				vs_TEXCOORD1.y = t10_2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t10_2.y;
				vs_TEXCOORD3.y = t10_2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			uniform lowp sampler2D _LightTextureB0;
			uniform lowp samplerCube _LightTexture0;
			in highp vec4 vs_TEXCOORD0;
			in lowp vec3 vs_TEXCOORD1;
			in lowp vec3 vs_TEXCOORD2;
			in lowp vec3 vs_TEXCOORD3;
			in highp vec3 vs_TEXCOORD4;
			in lowp vec4 vs_COLOR0;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec2 t0;
			mediump float t16_0;
			lowp float t10_0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec3 t10_4;
			lowp vec3 t10_5;
			mediump vec3 t16_6;
			highp vec3 t7;
			lowp float t10_7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_25;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t1.xyz = vec3(t22) * t1.xyz;
				t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t2.xyz, t2.xyz);
				t22 = inversesqrt(t22);
				t10_4.xyz = t2.xyz * vec3(t22) + t1.xyz;
				t10_25 = dot(t10_4.xyz, t10_4.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_4.xyz = vec3(t10_25) * t10_4.xyz;
				t10_5.x = vs_TEXCOORD1.z;
				t10_5.y = vs_TEXCOORD2.z;
				t10_5.z = vs_TEXCOORD3.z;
				t10_25 = dot(t10_5.xyz, t10_5.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_5.xyz = vec3(t10_25) * t10_5.xyz;
				t10_4.x = dot(t10_5.xyz, t10_4.xyz);
				t10_4.y = dot(t10_5.xyz, t1.xyz);
				t10_4.xy = max(t10_4.xy, vec2(0.0, 0.0));
				t16_6.x = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6.x = t16_6.x * t16_13;
				t16_6.x = exp2(t16_6.x);
				t16_6.x = t0.x * t16_6.x;
				t10_4.xyz = t7.xyz * t10_4.yyy + t16_6.xxx;
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				t16_6.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
				t16_6.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t16_6.xyz;
				t16_6.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t16_6.xyz;
				t16_6.xyz = t16_6.xyz + _LightMatrix0[3].xyz;
				t16_0 = dot(t16_6.xyz, t16_6.xyz);
				t10_7 = texture(_LightTexture0, t16_6.xyz).w;
				t10_0 = texture(_LightTextureB0, vec2(t16_0)).w;
				t16_0 = t10_7 * t10_0;
				SV_Target0.xyz = vec3(t16_0) * t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 19 math
			Keywords{ "POINT_COOKIE" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 240
				Matrix 0[glstate_matrix_mvp]
				Matrix 64[_Object2World]
				Matrix 128[_World2Object]
				Vector 192[unity_WorldTransformParams]
				Vector 208[_MainTex_ST]
				Vector 224[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderUniform {
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				half tangentSign_2;
				half3 worldTangent_3;
				half3 worldNormal_4;
				float4 tmpvar_5;
				tmpvar_5.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_5.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float4 v_6;
				v_6.x = _mtl_u._World2Object[0].x;
				v_6.y = _mtl_u._World2Object[1].x;
				v_6.z = _mtl_u._World2Object[2].x;
				v_6.w = _mtl_u._World2Object[3].x;
				float4 v_7;
				v_7.x = _mtl_u._World2Object[0].y;
				v_7.y = _mtl_u._World2Object[1].y;
				v_7.z = _mtl_u._World2Object[2].y;
				v_7.w = _mtl_u._World2Object[3].y;
				float4 v_8;
				v_8.x = _mtl_u._World2Object[0].z;
				v_8.y = _mtl_u._World2Object[1].z;
				v_8.z = _mtl_u._World2Object[2].z;
				v_8.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_9;
				tmpvar_9 = normalize(((
					(v_6.xyz * _mtl_i._glesNormal.x)
					+
					(v_7.xyz * _mtl_i._glesNormal.y)
					) + (v_8.xyz * _mtl_i._glesNormal.z)));
				worldNormal_4 = half3(tmpvar_9);
				float3x3 tmpvar_10;
				tmpvar_10[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_10[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_10[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_11;
				tmpvar_11 = normalize((tmpvar_10 * _mtl_i._glesTANGENT.xyz));
				worldTangent_3 = half3(tmpvar_11);
				float tmpvar_12;
				tmpvar_12 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_2 = half(tmpvar_12);
				half3 tmpvar_13;
				tmpvar_13 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				half3 tmpvar_14;
				tmpvar_14.x = worldTangent_3.x;
				tmpvar_14.y = tmpvar_13.x;
				tmpvar_14.z = worldNormal_4.x;
				half3 tmpvar_15;
				tmpvar_15.x = worldTangent_3.y;
				tmpvar_15.y = tmpvar_13.y;
				tmpvar_15.z = worldNormal_4.y;
				half3 tmpvar_16;
				tmpvar_16.x = worldTangent_3.z;
				tmpvar_16.y = tmpvar_13.z;
				tmpvar_16.z = worldNormal_4.z;
				_mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				_mtl_o.xlv_TEXCOORD0 = tmpvar_5;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_14;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_15;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_16;
				_mtl_o.xlv_TEXCOORD4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "POINT_COOKIE" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec3 vs_TEXCOORD1;
			out vec3 vs_TEXCOORD2;
			out vec3 vs_TEXCOORD3;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_COLOR0;
			vec4 t0;
			vec3 t1;
			vec3 t2;
			float t3;
			float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t2.xyz = t0.xyz * t1.xyz;
				t2.xyz = t0.zxy * t1.yzx + (-t2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t2.xyz = vec3(t3) * t2.xyz;
				vs_TEXCOORD1.y = t2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t2.y;
				vs_TEXCOORD3.y = t2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			uniform  sampler2D _LightTextureB0;
			uniform  samplerCube _LightTexture0;
			in  vec4 vs_TEXCOORD0;
			in  vec3 vs_TEXCOORD1;
			in  vec3 vs_TEXCOORD2;
			in  vec3 vs_TEXCOORD3;
			in  vec3 vs_TEXCOORD4;
			in  vec4 vs_COLOR0;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			lowp vec4 t10_1;
			vec4 t2;
			lowp vec4 t10_2;
			vec3 t3;
			lowp vec4 t10_3;
			vec3 t4;
			float t5;
			vec2 t8;
			float t9;
			float t12;
			mediump float t16_12;
			float t13;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
				t13 = dot(t1.xyz, t1.xyz);
				t13 = inversesqrt(t13);
				t1.xyz = vec3(t13) * t1.xyz;
				t2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = t2.xyz * vec3(t13) + t1.xyz;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = vec3(t13) * t2.xyz;
				t3.x = vs_TEXCOORD1.z;
				t3.y = vs_TEXCOORD2.z;
				t3.z = vs_TEXCOORD3.z;
				t13 = dot(t3.xyz, t3.xyz);
				t13 = inversesqrt(t13);
				t3.xyz = vec3(t13) * t3.xyz;
				t1.w = dot(t3.xyz, t2.xyz);
				t1.x = dot(t3.xyz, t1.xyz);
				t1.xy = max(t1.xw, vec2(0.0, 0.0));
				t5 = log2(t1.y);
				t9 = _Shininess * 128.0;
				t5 = t5 * t9;
				t5 = exp2(t5);
				t0.x = t0.x * t5;
				t0.xyz = t4.xyz * t1.xxx + t0.xxx;
				t0.xyz = t0.xyz * _LightColor0.xyz;
				t1.xyz = vs_TEXCOORD4.yyy * _LightMatrix0[1].xyz;
				t1.xyz = _LightMatrix0[0].xyz * vs_TEXCOORD4.xxx + t1.xyz;
				t1.xyz = _LightMatrix0[2].xyz * vs_TEXCOORD4.zzz + t1.xyz;
				t1.xyz = t1.xyz + _LightMatrix0[3].xyz;
				t12 = dot(t1.xyz, t1.xyz);
				t10_1 = texture(_LightTexture0, t1.xyz);
				t10_2 = texture(_LightTextureB0, vec2(t12));
				t16_12 = t10_1.w * t10_2.w;
				SV_Target0.xyz = vec3(t16_12) * t0.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "opengl " {
			// Stats: 43 math, 3 textures
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GLSL#version 120

#ifdef VERTEX

				uniform mat4 _Object2World;
			uniform mat4 _World2Object;
			uniform vec4 unity_WorldTransformParams;
			uniform vec4 _MainTex_ST;
			uniform vec4 _Emissive_ST;
			attribute vec4 TANGENT;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec4 tmpvar_1;
				tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_1.zw = ((gl_MultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				vec4 v_2;
				v_2.x = _World2Object[0].x;
				v_2.y = _World2Object[1].x;
				v_2.z = _World2Object[2].x;
				v_2.w = _World2Object[3].x;
				vec4 v_3;
				v_3.x = _World2Object[0].y;
				v_3.y = _World2Object[1].y;
				v_3.z = _World2Object[2].y;
				v_3.w = _World2Object[3].y;
				vec4 v_4;
				v_4.x = _World2Object[0].z;
				v_4.y = _World2Object[1].z;
				v_4.z = _World2Object[2].z;
				v_4.w = _World2Object[3].z;
				vec3 tmpvar_5;
				tmpvar_5 = normalize(((
					(v_2.xyz * gl_Normal.x)
					+
					(v_3.xyz * gl_Normal.y)
					) + (v_4.xyz * gl_Normal.z)));
				mat3 tmpvar_6;
				tmpvar_6[0] = _Object2World[0].xyz;
				tmpvar_6[1] = _Object2World[1].xyz;
				tmpvar_6[2] = _Object2World[2].xyz;
				vec3 tmpvar_7;
				tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
				vec3 tmpvar_8;
				tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
				vec3 tmpvar_9;
				tmpvar_9.x = tmpvar_7.x;
				tmpvar_9.y = tmpvar_8.x;
				tmpvar_9.z = tmpvar_5.x;
				vec3 tmpvar_10;
				tmpvar_10.x = tmpvar_7.y;
				tmpvar_10.y = tmpvar_8.y;
				tmpvar_10.z = tmpvar_5.y;
				vec3 tmpvar_11;
				tmpvar_11.x = tmpvar_7.z;
				tmpvar_11.y = tmpvar_8.z;
				tmpvar_11.z = tmpvar_5.z;
				gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
				xlv_TEXCOORD0 = tmpvar_1;
				xlv_TEXCOORD1 = tmpvar_9;
				xlv_TEXCOORD2 = tmpvar_10;
				xlv_TEXCOORD3 = tmpvar_11;
				xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
				xlv_COLOR0 = gl_Color;
			}


#endif
#ifdef FRAGMENT
			uniform vec3 _WorldSpaceCameraPos;
			uniform vec4 _WorldSpaceLightPos0;
			uniform vec4 _LightColor0;
			uniform sampler2D _LightTexture0;
			uniform mat4 _LightMatrix0;
			uniform float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying vec4 xlv_TEXCOORD0;
			varying vec3 xlv_TEXCOORD1;
			varying vec3 xlv_TEXCOORD2;
			varying vec3 xlv_TEXCOORD3;
			varying vec3 xlv_TEXCOORD4;
			varying vec4 xlv_COLOR0;
			void main()
			{
				vec3 worldN_1;
				vec4 c_2;
				vec4 tmpvar_3;
				tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				vec4 tmpvar_4;
				tmpvar_4 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				vec2 tmpvar_5;
				tmpvar_5.x = tmpvar_3.x;
				tmpvar_5.y = tmpvar_4.x;
				vec2 tmpvar_6;
				tmpvar_6.x = tmpvar_3.y;
				tmpvar_6.y = tmpvar_4.y;
				vec2 tmpvar_7;
				tmpvar_7.x = tmpvar_3.z;
				tmpvar_7.y = tmpvar_4.z;
				vec2 tmpvar_8;
				tmpvar_8.x = tmpvar_3.w;
				tmpvar_8.y = tmpvar_4.w;
				vec2 tmpvar_9;
				float tmpvar_10;
				tmpvar_10 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_9 = mix(mix(tmpvar_5, tmpvar_6, vec2(clamp(tmpvar_10, 0.0, 1.0))), mix(tmpvar_7, tmpvar_8, vec2(clamp(
					(tmpvar_10 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_10 - 1.0), 0.0, 1.0)));
				vec4 tmpvar_11;
				tmpvar_11.w = 1.0;
				tmpvar_11.xyz = xlv_TEXCOORD4;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				vec4 c_12;
				vec3 tmpvar_13;
				tmpvar_13 = normalize(worldN_1);
				c_12.xyz = ((_LightColor0.xyz * (
					(mix(tmpvar_9.xxx, mix(mix(vec3(
						clamp((tmpvar_9.x + ((1.0 - tmpvar_9.y) * (tmpvar_9.x * tmpvar_9.x))), 0.0, 1.0)
						), xlv_COLOR0.xyz, tmpvar_9.yyy), xlv_COLOR0.xyz, xlv_TEXCOORD0.www), vec3(clamp(xlv_COLOR0.w, 0.0, 1.0))) * max(0.0, dot(tmpvar_13, _WorldSpaceLightPos0.xyz)))
					+
					(pow(max(0.0, dot(tmpvar_13,
						normalize((normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)) + _WorldSpaceLightPos0.xyz))
						)), (_Shininess * 128.0)) * ((pow(
							((1.0 - tmpvar_9.y) + 0.4)
							, 3.0) + 0.2) * tmpvar_9.y))
					)) * texture2D (_LightTexture0, (_LightMatrix0 * tmpvar_11).xy).w);
				c_12.w = 1.0;
				c_2.xyz = c_12.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "d3d9 " {
			// Stats: 35 math
			Keywords{ "DIRECTIONAL_COOKIE" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				Matrix 4[_Object2World] 3
				Matrix 7[_World2Object] 3
				Matrix 0[glstate_matrix_mvp]
				Vector 12[_Emissive_ST]
				Vector 11[_MainTex_ST]
				Vector 10[unity_WorldTransformParams]
				"vs_3_0
				dcl_position v0
				dcl_tangent v1
				dcl_normal v2
				dcl_texcoord v3
				dcl_texcoord1 v4
				dcl_color v5
				dcl_position o0
				dcl_texcoord o1
				dcl_texcoord1 o2.xyz
				dcl_texcoord2 o3.xyz
				dcl_texcoord3 o4.xyz
				dcl_texcoord4 o5.xyz
				dcl_color o6
				dp4 o0.x, c0, v0
				dp4 o0.y, c1, v0
				dp4 o0.z, c2, v0
				dp4 o0.w, c3, v0
				mad o1.xy, v3, c11, c11.zwzw
				mad o1.zw, v4.xyxy, c12.xyxy, c12
				dp4 o5.x, c4, v0
				dp4 o5.y, c5, v0
				dp4 o5.z, c6, v0
				dp3 r0.z, c4, v1
				dp3 r0.x, c5, v1
				dp3 r0.y, c6, v1
				dp3 r0.w, r0, r0
				rsq r0.w, r0.w
				mul r0.xyz, r0.w, r0
				mov o2.x, r0.z
				mul r1.xyz, c8.zxyw, v2.y
				mad r1.xyz, c7.zxyw, v2.x, r1
				mad r1.xyz, c9.zxyw, v2.z, r1
				dp3 r0.w, r1, r1
				rsq r0.w, r0.w
				mul r1.xyz, r0.w, r1
				mul r2.xyz, r0, r1
				mad r2.xyz, r1.zxyw, r0.yzxw, -r2
				mul r0.z, c10.w, v1.w
				mul r2.xyz, r0.z, r2
				mov o2.y, r2.x
				mov o2.z, r1.y
				mov o3.x, r0.x
				mov o4.x, r0.y
				mov o3.y, r2.y
				mov o4.y, r2.z
				mov o3.z, r1.z
				mov o4.z, r1.x
				mov o6, v5

				"
		}
		SubProgram "d3d11 " {
			// Stats: 34 math
			Keywords{ "DIRECTIONAL_COOKIE" }
				Bind "vertex" Vertex
				Bind "color" Color
				Bind "normal" Normal
				Bind "texcoord" TexCoord0
				Bind "texcoord1" TexCoord1
				Bind "tangent" TexCoord4
				ConstBuffer "$Globals" 272
				Vector 240[_MainTex_ST]
				Vector 256[_Emissive_ST]
				ConstBuffer "UnityPerDraw" 352
				Matrix 0[glstate_matrix_mvp]
				Matrix 192[_Object2World]
				Matrix 256[_World2Object]
				Vector 336[unity_WorldTransformParams]
				BindCB  "$Globals" 0
				BindCB  "UnityPerDraw" 1
				"vs_4_0
				root12:aaacaaaa
				eefiecedhaomgnoeigpocikojcffdbiamlplojojabaaaaaaaeaiaaaaadaaaaaa
				cmaaaaaaceabaaaapiabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
				aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
				abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaoaaaaaaaacaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafaepfdej
				feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
				epfcaaklepfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
				adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
				apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
				acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
				adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
				ahaiaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
				epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklfdeieefcaeagaaaa
				eaaaabaaibabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
				abaaaaaabgaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
				fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
				aeaaaaaafpaaaaadpcbabaaaahaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
				gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
				adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaad
				pccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
				aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
				abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
				aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
				dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
				egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
				aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadcaaaaalmccabaaaabaaaaaa
				agbebaaaaeaaaaaaagiecaaaaaaaaaaabaaaaaaakgiocaaaaaaaaaaabaaaaaaa
				diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
				diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
				diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
				diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
				aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
				ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
				ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
				bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
				hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
				aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
				dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
				aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
				abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
				abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
				dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
				egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
				egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
				aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaaiccaabaaa
				aaaaaaaadkbabaaaabaaaaaadkiacaaaabaaaaaabfaaaaaadiaaaaahhcaabaaa
				acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaafcccabaaaacaaaaaa
				akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
				eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
				aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
				aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
				dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
				fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
				egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
				hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
				aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
				aaaaaaaaegacbaaaaaaaaaaadgaaaaafpccabaaaagaaaaaaegbobaaaahaaaaaa
				doaaaaab"
		}
		SubProgram "gles " {
			// Stats: 43 math, 3 textures
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GLES
				#version 100

#ifdef VERTEX
				attribute vec4 _glesTANGENT;
			attribute vec4 _glesVertex;
			attribute vec4 _glesColor;
			attribute vec3 _glesNormal;
			attribute vec4 _glesMultiTexCoord0;
			attribute vec4 _glesMultiTexCoord1;
			uniform highp mat4 glstate_matrix_mvp;
			uniform highp mat4 _Object2World;
			uniform highp mat4 _World2Object;
			uniform highp vec4 unity_WorldTransformParams;
			uniform highp vec4 _MainTex_ST;
			uniform highp vec4 _Emissive_ST;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp float tangentSign_1;
				lowp vec3 worldTangent_2;
				lowp vec3 worldNormal_3;
				highp vec4 tmpvar_4;
				tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
				tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _Emissive_ST.xy) + _Emissive_ST.zw);
				highp vec4 v_5;
				v_5.x = _World2Object[0].x;
				v_5.y = _World2Object[1].x;
				v_5.z = _World2Object[2].x;
				v_5.w = _World2Object[3].x;
				highp vec4 v_6;
				v_6.x = _World2Object[0].y;
				v_6.y = _World2Object[1].y;
				v_6.z = _World2Object[2].y;
				v_6.w = _World2Object[3].y;
				highp vec4 v_7;
				v_7.x = _World2Object[0].z;
				v_7.y = _World2Object[1].z;
				v_7.z = _World2Object[2].z;
				v_7.w = _World2Object[3].z;
				highp vec3 tmpvar_8;
				tmpvar_8 = normalize(((
					(v_5.xyz * _glesNormal.x)
					+
					(v_6.xyz * _glesNormal.y)
					) + (v_7.xyz * _glesNormal.z)));
				worldNormal_3 = tmpvar_8;
				highp mat3 tmpvar_9;
				tmpvar_9[0] = _Object2World[0].xyz;
				tmpvar_9[1] = _Object2World[1].xyz;
				tmpvar_9[2] = _Object2World[2].xyz;
				highp vec3 tmpvar_10;
				tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
				worldTangent_2 = tmpvar_10;
				highp float tmpvar_11;
				tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
				tangentSign_1 = tmpvar_11;
				lowp vec3 tmpvar_12;
				tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
				lowp vec3 tmpvar_13;
				tmpvar_13.x = worldTangent_2.x;
				tmpvar_13.y = tmpvar_12.x;
				tmpvar_13.z = worldNormal_3.x;
				lowp vec3 tmpvar_14;
				tmpvar_14.x = worldTangent_2.y;
				tmpvar_14.y = tmpvar_12.y;
				tmpvar_14.z = worldNormal_3.y;
				lowp vec3 tmpvar_15;
				tmpvar_15.x = worldTangent_2.z;
				tmpvar_15.y = tmpvar_12.z;
				tmpvar_15.z = worldNormal_3.z;
				gl_Position = (glstate_matrix_mvp * _glesVertex);
				xlv_TEXCOORD0 = tmpvar_4;
				xlv_TEXCOORD1 = tmpvar_13;
				xlv_TEXCOORD2 = tmpvar_14;
				xlv_TEXCOORD3 = tmpvar_15;
				xlv_TEXCOORD4 = (_Object2World * _glesVertex).xyz;
				xlv_COLOR0 = _glesColor;
			}


#endif
#ifdef FRAGMENT
			uniform highp vec3 _WorldSpaceCameraPos;
			uniform mediump vec4 _WorldSpaceLightPos0;
			uniform lowp vec4 _LightColor0;
			uniform sampler2D _LightTexture0;
			uniform mediump mat4 _LightMatrix0;
			uniform mediump float _Shininess;
			uniform sampler2D _MainTex;
			uniform sampler2D _Emissive;
			varying highp vec4 xlv_TEXCOORD0;
			varying lowp vec3 xlv_TEXCOORD1;
			varying lowp vec3 xlv_TEXCOORD2;
			varying lowp vec3 xlv_TEXCOORD3;
			varying highp vec3 xlv_TEXCOORD4;
			varying lowp vec4 xlv_COLOR0;
			void main()
			{
				lowp vec3 worldN_1;
				lowp vec4 c_2;
				lowp vec3 worldViewDir_3;
				lowp vec3 lightDir_4;
				highp vec4 tmpvar_5;
				mediump vec3 tmpvar_6;
				tmpvar_6 = _WorldSpaceLightPos0.xyz;
				lightDir_4 = tmpvar_6;
				highp vec3 tmpvar_7;
				tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
				worldViewDir_3 = tmpvar_7;
				lowp vec3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = xlv_COLOR0;
				lowp vec3 tmpvar_9;
				lowp float tmpvar_10;
				highp vec4 mask_11;
				highp vec4 color_12;
				lowp vec4 tmpvar_13;
				tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
				color_12 = tmpvar_13;
				lowp vec4 tmpvar_14;
				tmpvar_14 = texture2D (_Emissive, xlv_TEXCOORD0.xy);
				mask_11 = tmpvar_14;
				highp vec2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				highp vec2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				highp vec2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				highp vec2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				highp vec2 tmpvar_19;
				highp float tmpvar_20;
				tmpvar_20 = (xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, vec2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, vec2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), vec2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				highp vec3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(vec3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, xlv_TEXCOORD0.www), vec3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = tmpvar_21;
				highp float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = ((tmpvar_22 + 0.2) * tmpvar_19.y);
				highp vec4 tmpvar_23;
				tmpvar_23.w = 1.0;
				tmpvar_23.xyz = xlv_TEXCOORD4;
				highp vec2 tmpvar_24;
				tmpvar_24 = (_LightMatrix0 * tmpvar_23).xy;
				worldN_1.x = xlv_TEXCOORD1.z;
				worldN_1.y = xlv_TEXCOORD2.z;
				worldN_1.z = xlv_TEXCOORD3.z;
				lowp vec4 c_25;
				lowp float spec_26;
				lowp vec3 tmpvar_27;
				tmpvar_27 = normalize(worldN_1);
				lowp float tmpvar_28;
				tmpvar_28 = max(0.0, dot(tmpvar_27, tmpvar_8));
				mediump float tmpvar_29;
				tmpvar_29 = (pow(tmpvar_28, (_Shininess * 128.0)) * tmpvar_10);
				spec_26 = tmpvar_29;
				c_25.xyz = ((_LightColor0.xyz * (
					(tmpvar_9 * max(0.0, dot(tmpvar_27, lightDir_4)))
					+ spec_26)) * texture2D (_LightTexture0, tmpvar_24).w);
				c_25.w = 1.0;
				c_2.xyz = c_25.xyz;
				c_2.w = 1.0;
				gl_FragData[0] = c_2;
			}


#endif
			"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GLES3
#ifdef VERTEX
				#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in highp vec4 in_POSITION0;
			in highp vec4 in_TANGENT0;
			in highp vec3 in_NORMAL0;
			in highp vec4 in_TEXCOORD0;
			in highp vec4 in_TEXCOORD1;
			in lowp vec4 in_COLOR0;
			out highp vec4 vs_TEXCOORD0;
			out lowp vec3 vs_TEXCOORD1;
			out lowp vec3 vs_TEXCOORD2;
			out lowp vec3 vs_TEXCOORD3;
			out highp vec3 vs_TEXCOORD4;
			out lowp vec4 vs_COLOR0;
			highp vec4 t0;
			highp vec3 t1;
			lowp vec3 t10_2;
			highp float t3;
			highp float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t10_2.xyz = t0.xyz * t1.xyz;
				t10_2.xyz = t0.zxy * t1.yzx + (-t10_2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t10_2.xyz = vec3(t3) * t10_2.xyz;
				vs_TEXCOORD1.y = t10_2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t10_2.y;
				vs_TEXCOORD3.y = t10_2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 300 es
				precision highp float;
			precision highp int;
			uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	mediump vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	mediump vec4 unity_4LightAtten0;
			uniform 	mediump vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	mediump vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	mediump vec4 unity_SHAr;
			uniform 	mediump vec4 unity_SHAg;
			uniform 	mediump vec4 unity_SHAb;
			uniform 	mediump vec4 unity_SHBr;
			uniform 	mediump vec4 unity_SHBg;
			uniform 	mediump vec4 unity_SHBb;
			uniform 	mediump vec4 unity_SHC;
			uniform 	mediump vec3 unity_LightColor0;
			uniform 	mediump vec3 unity_LightColor1;
			uniform 	mediump vec3 unity_LightColor2;
			uniform 	mediump vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	mediump vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	lowp vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	lowp vec4 unity_AmbientSky;
			uniform 	lowp vec4 unity_AmbientEquator;
			uniform 	lowp vec4 unity_AmbientGround;
			uniform 	lowp vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	mediump vec4 unity_SpecCube1_HDR;
			uniform 	lowp vec4 unity_ColorSpaceGrey;
			uniform 	lowp vec4 unity_ColorSpaceDouble;
			uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
			uniform 	mediump vec4 unity_ColorSpaceLuminance;
			uniform 	mediump vec4 unity_Lightmap_HDR;
			uniform 	mediump vec4 unity_DynamicLightmap_HDR;
			uniform 	lowp vec4 _LightColor0;
			uniform 	lowp vec4 _SpecColor;
			uniform 	mediump vec4 unity_LightGammaCorrectionConsts;
			uniform 	mediump mat4 _LightMatrix0;
			uniform 	mediump float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform lowp sampler2D _MainTex;
			uniform lowp sampler2D _Emissive;
			uniform lowp sampler2D _LightTexture0;
			in highp vec4 vs_TEXCOORD0;
			in lowp vec3 vs_TEXCOORD1;
			in lowp vec3 vs_TEXCOORD2;
			in lowp vec3 vs_TEXCOORD3;
			in highp vec3 vs_TEXCOORD4;
			in lowp vec4 vs_COLOR0;
			layout(location = 0) out lowp vec4 SV_Target0;
			highp vec2 t0;
			lowp float t10_0;
			highp vec4 t1;
			highp vec4 t2;
			lowp vec4 t10_3;
			lowp vec3 t10_4;
			lowp vec3 t10_5;
			mediump vec2 t16_6;
			highp vec3 t7;
			mediump float t16_13;
			highp vec2 t14;
			mediump float t16_14;
			highp float t22;
			lowp float t10_25;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t14.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t14.xy = clamp(t14.xy, 0.0, 1.0);
				t1.xy = t14.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t14.yy * t1.xy + t0.xy;
				t14.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t14.x = t1.x * t14.x + t0.y;
				t14.x = clamp(t14.x, 0.0, 1.0);
				t1.xzw = (-t14.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t14.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t16_14 = vs_COLOR0.w;
				t16_14 = clamp(t16_14, 0.0, 1.0);
				t7.xyz = vec3(t16_14) * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t22 = dot(t1.xyz, t1.xyz);
				t22 = inversesqrt(t22);
				t10_4.xyz = t1.xyz * vec3(t22) + _WorldSpaceLightPos0.xyz;
				t10_25 = dot(t10_4.xyz, t10_4.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_4.xyz = vec3(t10_25) * t10_4.xyz;
				t10_5.x = vs_TEXCOORD1.z;
				t10_5.y = vs_TEXCOORD2.z;
				t10_5.z = vs_TEXCOORD3.z;
				t10_25 = dot(t10_5.xyz, t10_5.xyz);
				t10_25 = inversesqrt(t10_25);
				t10_5.xyz = vec3(t10_25) * t10_5.xyz;
				t10_4.x = dot(t10_5.xyz, t10_4.xyz);
				t10_4.y = dot(t10_5.xyz, _WorldSpaceLightPos0.xyz);
				t10_4.xy = max(t10_4.xy, vec2(0.0, 0.0));
				t16_6.x = log2(t10_4.x);
				t16_13 = _Shininess * 128.0;
				t16_6.x = t16_6.x * t16_13;
				t16_6.x = exp2(t16_6.x);
				t16_6.x = t0.x * t16_6.x;
				t10_4.xyz = t7.xyz * t10_4.yyy + t16_6.xxx;
				t10_4.xyz = t10_4.xyz * _LightColor0.xyz;
				t16_6.xy = vs_TEXCOORD4.yy * _LightMatrix0[1].xy;
				t16_6.xy = _LightMatrix0[0].xy * vs_TEXCOORD4.xx + t16_6.xy;
				t16_6.xy = _LightMatrix0[2].xy * vs_TEXCOORD4.zz + t16_6.xy;
				t16_6.xy = t16_6.xy + _LightMatrix0[3].xy;
				t10_0 = texture(_LightTexture0, t16_6.xy).w;
				SV_Target0.xyz = vec3(t10_0) * t10_4.xyz;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
		SubProgram "metal " {
			// Stats: 19 math
			Keywords{ "DIRECTIONAL_COOKIE" }
				Bind "tangent" ATTR0
				Bind "vertex" ATTR1
				Bind "color" ATTR2
				Bind "normal" ATTR3
				Bind "texcoord" ATTR4
				Bind "texcoord1" ATTR5
				ConstBuffer "$Globals" 240
				Matrix 0[glstate_matrix_mvp]
				Matrix 64[_Object2World]
				Matrix 128[_World2Object]
				Vector 192[unity_WorldTransformParams]
				Vector 208[_MainTex_ST]
				Vector 224[_Emissive_ST]
				"metal_vs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 _glesTANGENT[[attribute(0)]];
				float4 _glesVertex[[attribute(1)]];
				float4 _glesColor[[attribute(2)]];
				float3 _glesNormal[[attribute(3)]];
				float4 _glesMultiTexCoord0[[attribute(4)]];
				float4 _glesMultiTexCoord1[[attribute(5)]];
			};
			struct xlatMtlShaderOutput {
				float4 gl_Position[[position]];
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderUniform {
				float4x4 glstate_matrix_mvp;
				float4x4 _Object2World;
				float4x4 _World2Object;
				float4 unity_WorldTransformParams;
				float4 _MainTex_ST;
				float4 _Emissive_ST;
			};
			vertex xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half4 tmpvar_1;
				tmpvar_1 = half4(_mtl_i._glesColor);
				half tangentSign_2;
				half3 worldTangent_3;
				half3 worldNormal_4;
				float4 tmpvar_5;
				tmpvar_5.xy = ((_mtl_i._glesMultiTexCoord0.xy * _mtl_u._MainTex_ST.xy) + _mtl_u._MainTex_ST.zw);
				tmpvar_5.zw = ((_mtl_i._glesMultiTexCoord1.xy * _mtl_u._Emissive_ST.xy) + _mtl_u._Emissive_ST.zw);
				float4 v_6;
				v_6.x = _mtl_u._World2Object[0].x;
				v_6.y = _mtl_u._World2Object[1].x;
				v_6.z = _mtl_u._World2Object[2].x;
				v_6.w = _mtl_u._World2Object[3].x;
				float4 v_7;
				v_7.x = _mtl_u._World2Object[0].y;
				v_7.y = _mtl_u._World2Object[1].y;
				v_7.z = _mtl_u._World2Object[2].y;
				v_7.w = _mtl_u._World2Object[3].y;
				float4 v_8;
				v_8.x = _mtl_u._World2Object[0].z;
				v_8.y = _mtl_u._World2Object[1].z;
				v_8.z = _mtl_u._World2Object[2].z;
				v_8.w = _mtl_u._World2Object[3].z;
				float3 tmpvar_9;
				tmpvar_9 = normalize(((
					(v_6.xyz * _mtl_i._glesNormal.x)
					+
					(v_7.xyz * _mtl_i._glesNormal.y)
					) + (v_8.xyz * _mtl_i._glesNormal.z)));
				worldNormal_4 = half3(tmpvar_9);
				float3x3 tmpvar_10;
				tmpvar_10[0] = _mtl_u._Object2World[0].xyz;
				tmpvar_10[1] = _mtl_u._Object2World[1].xyz;
				tmpvar_10[2] = _mtl_u._Object2World[2].xyz;
				float3 tmpvar_11;
				tmpvar_11 = normalize((tmpvar_10 * _mtl_i._glesTANGENT.xyz));
				worldTangent_3 = half3(tmpvar_11);
				float tmpvar_12;
				tmpvar_12 = (_mtl_i._glesTANGENT.w * _mtl_u.unity_WorldTransformParams.w);
				tangentSign_2 = half(tmpvar_12);
				half3 tmpvar_13;
				tmpvar_13 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
				half3 tmpvar_14;
				tmpvar_14.x = worldTangent_3.x;
				tmpvar_14.y = tmpvar_13.x;
				tmpvar_14.z = worldNormal_4.x;
				half3 tmpvar_15;
				tmpvar_15.x = worldTangent_3.y;
				tmpvar_15.y = tmpvar_13.y;
				tmpvar_15.z = worldNormal_4.y;
				half3 tmpvar_16;
				tmpvar_16.x = worldTangent_3.z;
				tmpvar_16.y = tmpvar_13.z;
				tmpvar_16.z = worldNormal_4.z;
				_mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
				_mtl_o.xlv_TEXCOORD0 = tmpvar_5;
				_mtl_o.xlv_TEXCOORD1 = tmpvar_14;
				_mtl_o.xlv_TEXCOORD2 = tmpvar_15;
				_mtl_o.xlv_TEXCOORD3 = tmpvar_16;
				_mtl_o.xlv_TEXCOORD4 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
				_mtl_o.xlv_COLOR0 = tmpvar_1;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GL3x
#ifdef VERTEX
				#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			in  vec4 in_POSITION0;
			in  vec4 in_TANGENT0;
			in  vec3 in_NORMAL0;
			in  vec4 in_TEXCOORD0;
			in  vec4 in_TEXCOORD1;
			in  vec4 in_COLOR0;
			out vec4 vs_TEXCOORD0;
			out vec3 vs_TEXCOORD1;
			out vec3 vs_TEXCOORD2;
			out vec3 vs_TEXCOORD3;
			out vec3 vs_TEXCOORD4;
			out vec4 vs_COLOR0;
			vec4 t0;
			vec3 t1;
			vec3 t2;
			float t3;
			float t9;
			void main()
			{
				t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
				t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
				t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
				gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
				vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _Emissive_ST.xy + _Emissive_ST.zw;
				t0.y = in_NORMAL0.x * _World2Object[0].x;
				t0.z = in_NORMAL0.x * _World2Object[1].x;
				t0.x = in_NORMAL0.x * _World2Object[2].x;
				t1.y = in_NORMAL0.y * _World2Object[0].y;
				t1.z = in_NORMAL0.y * _World2Object[1].y;
				t1.x = in_NORMAL0.y * _World2Object[2].y;
				t0.xyz = t0.xyz + t1.xyz;
				t1.y = in_NORMAL0.z * _World2Object[0].z;
				t1.z = in_NORMAL0.z * _World2Object[1].z;
				t1.x = in_NORMAL0.z * _World2Object[2].z;
				t0.xyz = t0.xyz + t1.xyz;
				t9 = dot(t0.xyz, t0.xyz);
				t9 = inversesqrt(t9);
				t0.xyz = vec3(t9) * t0.xyz;
				vs_TEXCOORD1.z = t0.y;
				t1.xyz = in_TANGENT0.yyy * _Object2World[1].yzx;
				t1.xyz = _Object2World[0].yzx * in_TANGENT0.xxx + t1.xyz;
				t1.xyz = _Object2World[2].yzx * in_TANGENT0.zzz + t1.xyz;
				t9 = dot(t1.xyz, t1.xyz);
				t9 = inversesqrt(t9);
				t1.xyz = vec3(t9) * t1.xyz;
				t2.xyz = t0.xyz * t1.xyz;
				t2.xyz = t0.zxy * t1.yzx + (-t2.xyz);
				t3 = in_TANGENT0.w * unity_WorldTransformParams.w;
				t2.xyz = vec3(t3) * t2.xyz;
				vs_TEXCOORD1.y = t2.x;
				vs_TEXCOORD1.x = t1.z;
				vs_TEXCOORD2.z = t0.z;
				vs_TEXCOORD3.z = t0.x;
				vs_TEXCOORD2.x = t1.x;
				vs_TEXCOORD3.x = t1.y;
				vs_TEXCOORD2.y = t2.y;
				vs_TEXCOORD3.y = t2.z;
				t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
				t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
				t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
				vs_TEXCOORD4.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
				vs_COLOR0 = in_COLOR0;
				return;
			}

#endif
#ifdef FRAGMENT
			#version 150
				#extension GL_ARB_shader_bit_encoding : enable
				uniform 	vec4 _Time;
			uniform 	vec4 _SinTime;
			uniform 	vec4 _CosTime;
			uniform 	vec4 unity_DeltaTime;
			uniform 	vec3 _WorldSpaceCameraPos;
			uniform 	vec4 _ProjectionParams;
			uniform 	vec4 _ScreenParams;
			uniform 	vec4 _ZBufferParams;
			uniform 	vec4 unity_OrthoParams;
			uniform 	vec4 unity_CameraWorldClipPlanes[6];
			uniform 	mat4 unity_CameraProjection;
			uniform 	mat4 unity_CameraInvProjection;
			uniform 	vec4 _WorldSpaceLightPos0;
			uniform 	vec4 _LightPositionRange;
			uniform 	vec4 unity_4LightPosX0;
			uniform 	vec4 unity_4LightPosY0;
			uniform 	vec4 unity_4LightPosZ0;
			uniform 	vec4 unity_4LightAtten0;
			uniform 	vec4 unity_LightColor[8];
			uniform 	vec4 unity_LightPosition[8];
			uniform 	vec4 unity_LightAtten[8];
			uniform 	vec4 unity_SpotDirection[8];
			uniform 	vec4 unity_SHAr;
			uniform 	vec4 unity_SHAg;
			uniform 	vec4 unity_SHAb;
			uniform 	vec4 unity_SHBr;
			uniform 	vec4 unity_SHBg;
			uniform 	vec4 unity_SHBb;
			uniform 	vec4 unity_SHC;
			uniform 	vec3 unity_LightColor0;
			uniform 	vec3 unity_LightColor1;
			uniform 	vec3 unity_LightColor2;
			uniform 	vec3 unity_LightColor3;
			uniform 	vec4 unity_ShadowSplitSpheres[4];
			uniform 	vec4 unity_ShadowSplitSqRadii;
			uniform 	vec4 unity_LightShadowBias;
			uniform 	vec4 _LightSplitsNear;
			uniform 	vec4 _LightSplitsFar;
			uniform 	mat4 unity_World2Shadow[4];
			uniform 	vec4 _LightShadowData;
			uniform 	vec4 unity_ShadowFadeCenterAndType;
			uniform 	mat4 glstate_matrix_mvp;
			uniform 	mat4 glstate_matrix_modelview0;
			uniform 	mat4 glstate_matrix_invtrans_modelview0;
			uniform 	mat4 _Object2World;
			uniform 	mat4 _World2Object;
			uniform 	vec4 unity_LODFade;
			uniform 	vec4 unity_WorldTransformParams;
			uniform 	mat4 glstate_matrix_transpose_modelview0;
			uniform 	mat4 glstate_matrix_projection;
			uniform 	vec4 glstate_lightmodel_ambient;
			uniform 	mat4 unity_MatrixV;
			uniform 	mat4 unity_MatrixVP;
			uniform 	vec4 unity_AmbientSky;
			uniform 	vec4 unity_AmbientEquator;
			uniform 	vec4 unity_AmbientGround;
			uniform 	vec4 unity_FogColor;
			uniform 	vec4 unity_FogParams;
			uniform 	vec4 unity_LightmapST;
			uniform 	vec4 unity_DynamicLightmapST;
			uniform 	vec4 unity_SpecCube0_BoxMax;
			uniform 	vec4 unity_SpecCube0_BoxMin;
			uniform 	vec4 unity_SpecCube0_ProbePosition;
			uniform 	vec4 unity_SpecCube0_HDR;
			uniform 	vec4 unity_SpecCube1_BoxMax;
			uniform 	vec4 unity_SpecCube1_BoxMin;
			uniform 	vec4 unity_SpecCube1_ProbePosition;
			uniform 	vec4 unity_SpecCube1_HDR;
			uniform 	vec4 unity_ColorSpaceGrey;
			uniform 	vec4 unity_ColorSpaceDouble;
			uniform 	vec4 unity_ColorSpaceDielectricSpec;
			uniform 	vec4 unity_ColorSpaceLuminance;
			uniform 	vec4 unity_Lightmap_HDR;
			uniform 	vec4 unity_DynamicLightmap_HDR;
			uniform 	vec4 _LightColor0;
			uniform 	vec4 _SpecColor;
			uniform 	vec4 unity_LightGammaCorrectionConsts;
			uniform 	mat4 _LightMatrix0;
			uniform 	float _Shininess;
			uniform 	float _Opacity;
			uniform 	float _RimFalloff;
			uniform 	vec4 _RimColor;
			uniform 	vec4 _MainTex_ST;
			uniform 	vec4 _Emissive_ST;
			uniform  sampler2D _MainTex;
			uniform  sampler2D _Emissive;
			uniform  sampler2D _LightTexture0;
			in  vec4 vs_TEXCOORD0;
			in  vec3 vs_TEXCOORD1;
			in  vec3 vs_TEXCOORD2;
			in  vec3 vs_TEXCOORD3;
			in  vec3 vs_TEXCOORD4;
			in  vec4 vs_COLOR0;
			out vec4 SV_Target0;
			vec3 t0;
			vec4 t1;
			lowp vec4 t10_1;
			vec4 t2;
			lowp vec4 t10_3;
			vec3 t4;
			vec2 t8;
			float t9;
			float t13;
			void main()
			{
				t0.x = vs_TEXCOORD0.z * 3.0;
				t0.x = t0.x;
				t0.x = clamp(t0.x, 0.0, 1.0);
				t1 = texture(_MainTex, vs_TEXCOORD0.xy);
				t2.yw = t1.yw;
				t10_3 = texture(_Emissive, vs_TEXCOORD0.xy);
				t2.xz = t10_3.yw;
				t1.yw = t10_3.xz;
				t2 = (-t1.yxwz) + t2;
				t0.xy = t0.xx * t2.xy + t1.yx;
				t8.xy = vs_TEXCOORD0.zz * vec2(3.0, 3.0) + vec2(-2.0, -1.0);
				t8.xy = clamp(t8.xy, 0.0, 1.0);
				t1.xy = t8.xx * t2.zw + t1.wz;
				t1.xy = (-t0.xy) + t1.xy;
				t0.xy = t8.yy * t1.xy + t0.xy;
				t8.x = t0.y * t0.y;
				t1.xy = (-t0.xx) + vec2(1.0, 1.39999998);
				t8.x = t1.x * t8.x + t0.y;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t1.xzw = (-t8.xxx) + vs_COLOR0.xyz;
				t1.xzw = t0.xxx * t1.xzw + t8.xxx;
				t2.xyz = (-t1.xzw) + vs_COLOR0.xyz;
				t1.xzw = vs_TEXCOORD0.www * t2.xyz + t1.xzw;
				t1.xzw = (-t0.yyy) + t1.xzw;
				t8.x = vs_COLOR0.w;
				t8.x = clamp(t8.x, 0.0, 1.0);
				t4.xyz = t8.xxx * t1.xzw + t0.yyy;
				t1.x = t1.y * t1.y;
				t1.x = t1.y * t1.x + 0.200000003;
				t0.x = t0.x * t1.x;
				t1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyzx.xyz;
				t13 = dot(t1.xyz, t1.xyz);
				t13 = inversesqrt(t13);
				t1.xyz = t1.xyz * vec3(t13) + _WorldSpaceLightPos0.xyz;
				t13 = dot(t1.xyz, t1.xyz);
				t13 = inversesqrt(t13);
				t1.xyz = vec3(t13) * t1.xyz;
				t2.x = vs_TEXCOORD1.z;
				t2.y = vs_TEXCOORD2.z;
				t2.z = vs_TEXCOORD3.z;
				t13 = dot(t2.xyz, t2.xyz);
				t13 = inversesqrt(t13);
				t2.xyz = vec3(t13) * t2.xyz;
				t1.x = dot(t2.xyz, t1.xyz);
				t1.y = dot(t2.xyz, _WorldSpaceLightPos0.xyz);
				t1.xy = max(t1.xy, vec2(0.0, 0.0));
				t1.x = log2(t1.x);
				t9 = _Shininess * 128.0;
				t1.x = t1.x * t9;
				t1.x = exp2(t1.x);
				t0.x = t0.x * t1.x;
				t0.xyz = t4.xyz * t1.yyy + t0.xxx;
				t0.xyz = t0.xyz * _LightColor0.xyz;
				t1.xy = vs_TEXCOORD4.yy * _LightMatrix0[1].xy;
				t1.xy = _LightMatrix0[0].xy * vs_TEXCOORD4.xx + t1.xy;
				t1.xy = _LightMatrix0[2].xy * vs_TEXCOORD4.zz + t1.xy;
				t1.xy = t1.xy + _LightMatrix0[3].xy;
				t10_1 = texture(_LightTexture0, t1.xy);
				SV_Target0.xyz = t0.xyz * t10_1.www;
				SV_Target0.w = 1.0;
				return;
			}

#endif
			"
		}
	}
	Program "fp" {
		SubProgram "opengl " {
			Keywords{ "POINT" }
				"!!GLSL"
		}
		SubProgram "d3d9 " {
			// Stats: 61 math, 3 textures
			Keywords{ "POINT" }
				Matrix 0[_LightMatrix0] 3
				Vector 5[_LightColor0]
				Float 6[_Shininess]
				Vector 3[_WorldSpaceCameraPos]
				Vector 4[_WorldSpaceLightPos0]
				SetTexture 0[_LightTexture0] 2D 0
				SetTexture 1[_MainTex] 2D 1
				SetTexture 2[_Emissive] 2D 2
				"ps_3_0
				def c7, 3, -2, -1, -1.39999998
				def c8, 0.200000003, 1, 0, 128
				dcl_texcoord v0
				dcl_texcoord1_pp v1.z
				dcl_texcoord2_pp v2.z
				dcl_texcoord3_pp v3.z
				dcl_texcoord4 v4.xyz
				dcl_color v5
				dcl_2d s0
				dcl_2d s1
				dcl_2d s2
				mul r0.x, c7.x, v0.z
				mov_sat r0.x, r0.x
				texld r1, v0, s1
				mov r2.xz, r1
				texld r3, v0, s2
				mov r2.yw, r3.xxzz
				mov r1.xz, r3.yyww
				lrp r3.xy, r0.x, r1, r2.yxzw
				mad_sat r0.xy, v0.z, c7.x, c7.yzzw
				lrp r3.zw, r0.x, r1, r2.xywz
				lrp r1.xy, r0.y, r3.zwzw, r3
				mul r0.x, r1.y, r1.y
				add r0.yz, -r1.x, -c7.xzww
				mad_sat r0.x, r0.y, r0.x, r1.y
				lrp r2.xyz, r1.x, v5, r0.x
				add r0.xyw, -r2.xyzz, v5.xyzz
				mad r0.xyw, v0.w, r0, r2.xyzz
				mov_sat r1.z, v5.w
				lrp_pp r2.xyz, r1.z, r0.xyww, r1.y
				mul r0.x, r0.z, r0.z
				mad r0.x, r0.z, r0.x, c8.x
				mul_pp r0.x, r1.x, r0.x
				add r0.yzw, c3.xxyz, -v4.xxyz
				dp3 r1.x, r0.yzww, r0.yzww
				rsq r1.x, r1.x
				add r1.yzw, c4.xxyz, -v4.xxyz
				nrm_pp r3.xyz, r1.yzww
				mad_pp r0.yzw, r0, r1.x, r3.xxyz
				nrm_pp r1.xyz, r0.yzww
				mov_pp r4.x, v1.z
				mov_pp r4.y, v2.z
				mov_pp r4.z, v3.z
				nrm_pp r5.xyz, r4
				dp3_pp r0.y, r5, r1
				dp3_pp r0.z, r5, r3
				max_pp r1.x, r0.z, c8.z
				max_pp r1.y, r0.y, c8.z
				mov r0.w, c8.w
				mul_pp r0.y, r0.w, c6.x
				pow_pp r2.w, r1.y, r0.y
				mul_pp r0.x, r0.x, r2.w
				mad_pp r0.xyz, r2, r1.x, r0.x
				mul_pp r0.xyz, r0, c5
				mad r1, v4.xyzx, c8.yyyz, c8.zzzy
				dp4 r2.x, c0, r1
				dp4 r2.y, c1, r1
				dp4 r2.z, c2, r1
				dp3 r0.w, r2, r2
				texld_pp r1, r0.w, s0
				mul_pp oC0.xyz, r0, r1.x
				mov_pp oC0.w, -c7.z

				"
		}
		SubProgram "d3d11 " {
			// Stats: 49 math, 3 textures
			Keywords{ "POINT" }
				SetTexture 0[_MainTex] 2D 1
				SetTexture 1[_Emissive] 2D 2
				SetTexture 2[_LightTexture0] 2D 0
				ConstBuffer "$Globals" 272
				Matrix 144[_LightMatrix0]
				Vector 96[_LightColor0]
				Float 208[_Shininess]
				ConstBuffer "UnityPerCamera" 144
				Vector 64[_WorldSpaceCameraPos] 3
				ConstBuffer "UnityLighting" 720
				Vector 0[_WorldSpaceLightPos0]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				"ps_4_0
				root12:adadadaa
				eefiecedddoclnajpoeaoigaaijodgikbmmmbgjnabaaaaaaemajaaaaadaaaaaa
				cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
				aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahaeaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaeaaaalmaaaaaa
				adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaeaaaalmaaaaaaaeaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaahahaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
				epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
				aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaaiaaaaeaaaaaaa
				aeacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
				afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
				fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
				aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
				acaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadecbabaaaacaaaaaa
				gcbaaaadecbabaaaadaaaaaagcbaaaadecbabaaaaeaaaaaagcbaaaadhcbabaaa
				afaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
				aeaaaaaadiaaaaahbcaabaaaaaaaaaaackbabaaaabaaaaaaabeaaaaaaaaaeaea
				dgcaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
				egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadgaaaaafkcaabaaa
				acaaaaaafganbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
				eghobaaaabaaaaaaaagabaaaacaaaaaadgaaaaaffcaabaaaacaaaaaafgahbaaa
				adaaaaaadgaaaaafkcaabaaaabaaaaaaagaibaaaadaaaaaaaaaaaaaipcaabaaa
				acaaaaaabgalbaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajdcaabaaa
				aaaaaaaaagaabaaaaaaaaaaaegaabaaaacaaaaaabgafbaaaabaaaaaadccaaaap
				mcaabaaaaaaaaaaakgbkbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaea
				aaaaeaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaialpdcaaaaajdcaabaaa
				abaaaaaakgakbaaaaaaaaaaaogakbaaaacaaaaaalgapbaaaabaaaaaaaaaaaaai
				dcaabaaaabaaaaaaegaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadcaaaaaj
				dcaabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaa
				diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaal
				dcaabaaaabaaaaaaagaabaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpddddlddp
				aaaaaaaaaaaaaaaadccaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
				aaaaaaaabkaabaaaaaaaaaaaaaaaaaaincaabaaaabaaaaaakgakbaiaebaaaaaa
				aaaaaaaaagbjbaaaagaaaaaadcaaaaajncaabaaaabaaaaaaagaabaaaaaaaaaaa
				agaobaaaabaaaaaakgakbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaigadbaia
				ebaaaaaaabaaaaaaegbcbaaaagaaaaaadcaaaaajncaabaaaabaaaaaapgbpbaaa
				abaaaaaaagajbaaaacaaaaaaagaobaaaabaaaaaaaaaaaaaincaabaaaabaaaaaa
				fgafbaiaebaaaaaaaaaaaaaaagaobaaaabaaaaaadgcaaaafecaabaaaaaaaaaaa
				dkbabaaaagaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaaaaaaaaaagaobaaa
				abaaaaaafgafbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
				bkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
				abaaaaaaabeaaaaamnmmemdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
				akaabaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
				egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
				egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
				hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
				acaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
				icaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
				abaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaa
				pgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
				acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
				diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaf
				bcaabaaaadaaaaaackbabaaaacaaaaaadgaaaaafccaabaaaadaaaaaackbabaaa
				adaaaaaadgaaaaafecaabaaaadaaaaaackbabaaaaeaaaaaabaaaaaahicaabaaa
				abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
				dkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaa
				adaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
				baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaak
				dcaabaaaabaaaaaamgaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
				aaaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiecaabaaa
				abaaaaaaakiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaa
				abaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafccaabaaaabaaaaaa
				bkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
				abaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaa
				agaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
				aaaaaaaaagaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaafaaaaaaegiccaaa
				aaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
				agbabaaaafaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
				aaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
				abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaa
				aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
				pgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahhccabaaa
				aaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
				abeaaaaaaaaaiadpdoaaaaab"
		}
		SubProgram "gles " {
			Keywords{ "POINT" }
				"!!GLES"
		}
		SubProgram "gles3 " {
			Keywords{ "POINT" }
				"!!GLES3"
		}
		SubProgram "metal " {
			// Stats: 46 math, 3 textures
			Keywords{ "POINT" }
				SetTexture 0[_LightTexture0] 2D 0
				SetTexture 1[_MainTex] 2D 1
				SetTexture 2[_Emissive] 2D 2
				ConstBuffer "$Globals" 74
				MatrixHalf 40[_LightMatrix0]
				Vector 0[_WorldSpaceCameraPos] 3
				Vector 16[_WorldSpaceLightPos0]
				VectorHalf 32[_LightColor0] 4
				ScalarHalf 72[_Shininess]
				"metal_fs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderOutput {
				half4 _glesFragData_0[[color(0)]];
			};
			struct xlatMtlShaderUniform {
				float3 _WorldSpaceCameraPos;
				float4 _WorldSpaceLightPos0;
				half4 _LightColor0;
				half4x4 _LightMatrix0;
				half _Shininess;
			};
			fragment xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]]
				,   texture2d<half> _LightTexture0[[texture(0)]], sampler _mtlsmp__LightTexture0[[sampler(0)]]
				,   texture2d<half> _MainTex[[texture(1)]], sampler _mtlsmp__MainTex[[sampler(1)]]
				,   texture2d<half> _Emissive[[texture(2)]], sampler _mtlsmp__Emissive[[sampler(2)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half3 worldN_1;
				half4 c_2;
				half3 worldViewDir_3;
				half3 lightDir_4;
				float4 tmpvar_5;
				float3 tmpvar_6;
				tmpvar_6 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD4));
				lightDir_4 = half3(tmpvar_6);
				float3 tmpvar_7;
				tmpvar_7 = normalize((_mtl_u._WorldSpaceCameraPos - _mtl_i.xlv_TEXCOORD4));
				worldViewDir_3 = half3(tmpvar_7);
				half3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = float4(_mtl_i.xlv_COLOR0);
				half3 tmpvar_9;
				half tmpvar_10;
				float4 mask_11;
				float4 color_12;
				half4 tmpvar_13;
				tmpvar_13 = _MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				color_12 = float4(tmpvar_13);
				half4 tmpvar_14;
				tmpvar_14 = _Emissive.sample(_mtlsmp__Emissive, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				mask_11 = float4(tmpvar_14);
				float2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				float2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				float2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				float2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				float2 tmpvar_19;
				float tmpvar_20;
				tmpvar_20 = (_mtl_i.xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, float2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, float2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), float2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				float3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(float3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, _mtl_i.xlv_TEXCOORD0.www), float3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = half3(tmpvar_21);
				float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = half(((tmpvar_22 + 0.2) * tmpvar_19.y));
				float4 tmpvar_23;
				tmpvar_23.w = 1.0;
				tmpvar_23.xyz = _mtl_i.xlv_TEXCOORD4;
				float3 tmpvar_24;
				tmpvar_24 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_23)).xyz;
				float tmpvar_25;
				tmpvar_25 = dot(tmpvar_24, tmpvar_24);
				worldN_1.x = _mtl_i.xlv_TEXCOORD1.z;
				worldN_1.y = _mtl_i.xlv_TEXCOORD2.z;
				worldN_1.z = _mtl_i.xlv_TEXCOORD3.z;
				half4 c_26;
				half spec_27;
				half3 tmpvar_28;
				tmpvar_28 = normalize(worldN_1);
				half tmpvar_29;
				tmpvar_29 = max((half)0.0, dot(tmpvar_28, tmpvar_8));
				half tmpvar_30;
				tmpvar_30 = (pow(tmpvar_29, (_mtl_u._Shininess * (half)128.0)) * tmpvar_10);
				spec_27 = tmpvar_30;
				c_26.xyz = ((_mtl_u._LightColor0.xyz * (
					(tmpvar_9 * max((half)0.0, dot(tmpvar_28, lightDir_4)))
					+ spec_27)) * _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(float2(tmpvar_25))).w);
				c_26.w = half(1.0);
				c_2.xyz = c_26.xyz;
				c_2.w = half(1.0);
				_mtl_o._glesFragData_0 = c_2;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "POINT" }
				"!!GL3x"
		}
		SubProgram "opengl " {
			Keywords{ "DIRECTIONAL" }
				"!!GLSL"
		}
		SubProgram "d3d9 " {
			// Stats: 51 math, 2 textures
			Keywords{ "DIRECTIONAL" }
				Vector 2[_LightColor0]
				Float 3[_Shininess]
				Vector 0[_WorldSpaceCameraPos]
				Vector 1[_WorldSpaceLightPos0]
				SetTexture 0[_MainTex] 2D 0
				SetTexture 1[_Emissive] 2D 1
				"ps_3_0
				def c4, 3, -2, -1, -1.39999998
				def c5, 0.200000003, 0, 128, 0
				dcl_texcoord v0
				dcl_texcoord1_pp v1.z
				dcl_texcoord2_pp v2.z
				dcl_texcoord3_pp v3.z
				dcl_texcoord4 v4.xyz
				dcl_color v5
				dcl_2d s0
				dcl_2d s1
				mul r0.x, c4.x, v0.z
				mov_sat r0.x, r0.x
				texld r1, v0, s0
				mov r2.xz, r1
				texld r3, v0, s1
				mov r2.yw, r3.xxzz
				mov r1.xz, r3.yyww
				lrp r3.xy, r0.x, r1, r2.yxzw
				mad_sat r0.xy, v0.z, c4.x, c4.yzzw
				lrp r3.zw, r0.x, r1, r2.xywz
				lrp r1.xy, r0.y, r3.zwzw, r3
				mul r0.x, r1.y, r1.y
				add r0.yz, -r1.x, -c4.xzww
				mad_sat r0.x, r0.y, r0.x, r1.y
				lrp r2.xyz, r1.x, v5, r0.x
				add r0.xyw, -r2.xyzz, v5.xyzz
				mad r0.xyw, v0.w, r0, r2.xyzz
				mov_sat r1.z, v5.w
				lrp_pp r2.xyz, r1.z, r0.xyww, r1.y
				mul r0.x, r0.z, r0.z
				mad r0.x, r0.z, r0.x, c5.x
				mul_pp r0.x, r1.x, r0.x
				add r0.yzw, c0.xxyz, -v4.xxyz
				dp3 r1.x, r0.yzww, r0.yzww
				rsq r1.x, r1.x
				mad_pp r0.yzw, r0, r1.x, c1.xxyz
				nrm_pp r1.xyz, r0.yzww
				mov_pp r3.x, v1.z
				mov_pp r3.y, v2.z
				mov_pp r3.z, v3.z
				nrm_pp r4.xyz, r3
				dp3_pp r0.y, r4, r1
				dp3_pp r0.z, r4, c1
				max_pp r1.x, r0.z, c5.y
				max_pp r1.y, r0.y, c5.y
				mov r0.z, c5.z
				mul_pp r0.y, r0.z, c3.x
				pow_pp r2.w, r1.y, r0.y
				mul_pp r0.x, r0.x, r2.w
				mad_pp r0.xyz, r2, r1.x, r0.x
				mul_pp oC0.xyz, r0, c2
				mov_pp oC0.w, -c4.z

				"
		}
		SubProgram "d3d11 " {
			// Stats: 39 math, 2 textures
			Keywords{ "DIRECTIONAL" }
				SetTexture 0[_MainTex] 2D 0
				SetTexture 1[_Emissive] 2D 1
				ConstBuffer "$Globals" 208
				Vector 96[_LightColor0]
				Float 144[_Shininess]
				ConstBuffer "UnityPerCamera" 144
				Vector 64[_WorldSpaceCameraPos] 3
				ConstBuffer "UnityLighting" 720
				Vector 0[_WorldSpaceLightPos0]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				"ps_4_0
				root12:acadacaa
				eefiecedanadjlokfdhjkjpjglknkbbmfpoflmdnabaaaaaanmahaaaaadaaaaaa
				cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
				aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahaeaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaeaaaalmaaaaaa
				adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaeaaaalmaaaaaaaeaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaahahaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
				epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
				aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaagaaaaeaaaaaaa
				kiabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
				afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
				fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
				aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadecbabaaa
				acaaaaaagcbaaaadecbabaaaadaaaaaagcbaaaadecbabaaaaeaaaaaagcbaaaad
				hcbabaaaafaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaa
				giaaaaacaeaaaaaadiaaaaahbcaabaaaaaaaaaaackbabaaaabaaaaaaabeaaaaa
				aaaaeaeadgcaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
				abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaf
				kcaabaaaacaaaaaafganbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
				abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadgaaaaaffcaabaaaacaaaaaa
				fgahbaaaadaaaaaadgaaaaafkcaabaaaabaaaaaaagaibaaaadaaaaaaaaaaaaai
				pcaabaaaacaaaaaabgalbaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
				dcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaabaaaacaaaaaabgafbaaaabaaaaaa
				dccaaaapmcaabaaaaaaaaaaakgbkbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
				aaaaeaeaaaaaeaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaialpdcaaaaaj
				dcaabaaaabaaaaaakgakbaaaaaaaaaaaogakbaaaacaaaaaalgapbaaaabaaaaaa
				aaaaaaaidcaabaaaabaaaaaaegaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaa
				dcaaaaajdcaabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
				aaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
				aaaaaaaldcaabaaaabaaaaaaagaabaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
				ddddlddpaaaaaaaaaaaaaaaadccaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaa
				ckaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaincaabaaaabaaaaaakgakbaia
				ebaaaaaaaaaaaaaaagbjbaaaagaaaaaadcaaaaajncaabaaaabaaaaaaagaabaaa
				aaaaaaaaagaobaaaabaaaaaakgakbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaa
				igadbaiaebaaaaaaabaaaaaaegbcbaaaagaaaaaadcaaaaajncaabaaaabaaaaaa
				pgbpbaaaabaaaaaaagajbaaaacaaaaaaagaobaaaabaaaaaaaaaaaaaincaabaaa
				abaaaaaafgafbaiaebaaaaaaaaaaaaaaagaobaaaabaaaaaadgcaaaafecaabaaa
				aaaaaaaadkbabaaaagaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaaaaaaaaa
				agaobaaaabaaaaaafgafbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
				abaaaaaabkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaa
				akaabaaaabaaaaaaabeaaaaamnmmemdodiaaaaahbcaabaaaaaaaaaaaakaabaaa
				aaaaaaaaakaabaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaa
				afaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
				abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
				dcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegiccaaa
				acaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafbcaabaaaacaaaaaa
				ckbabaaaacaaaaaadgaaaaafccaabaaaacaaaaaackbabaaaadaaaaaadgaaaaaf
				ecaabaaaacaaaaaackbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
				acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
				diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
				bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaiccaabaaa
				abaaaaaaegacbaaaacaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaakdcaabaaa
				abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
				cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaa
				akiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
				akaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
				abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
				dcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaafgafbaaaabaaaaaaagaabaaa
				aaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
				agaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
		}
		SubProgram "gles " {
			Keywords{ "DIRECTIONAL" }
				"!!GLES"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL" }
				"!!GLES3"
		}
		SubProgram "metal " {
			// Stats: 40 math, 2 textures
			Keywords{ "DIRECTIONAL" }
				SetTexture 0[_MainTex] 2D 0
				SetTexture 1[_Emissive] 2D 1
				ConstBuffer "$Globals" 34
				Vector 0[_WorldSpaceCameraPos] 3
				VectorHalf 16[_WorldSpaceLightPos0] 4
				VectorHalf 24[_LightColor0] 4
				ScalarHalf 32[_Shininess]
				"metal_fs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderOutput {
				half4 _glesFragData_0[[color(0)]];
			};
			struct xlatMtlShaderUniform {
				float3 _WorldSpaceCameraPos;
				half4 _WorldSpaceLightPos0;
				half4 _LightColor0;
				half _Shininess;
			};
			fragment xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]]
				,   texture2d<half> _MainTex[[texture(0)]], sampler _mtlsmp__MainTex[[sampler(0)]]
				,   texture2d<half> _Emissive[[texture(1)]], sampler _mtlsmp__Emissive[[sampler(1)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half3 worldN_1;
				half4 c_2;
				half3 worldViewDir_3;
				half3 lightDir_4;
				float4 tmpvar_5;
				half3 tmpvar_6;
				tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
				lightDir_4 = tmpvar_6;
				float3 tmpvar_7;
				tmpvar_7 = normalize((_mtl_u._WorldSpaceCameraPos - _mtl_i.xlv_TEXCOORD4));
				worldViewDir_3 = half3(tmpvar_7);
				half3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = float4(_mtl_i.xlv_COLOR0);
				half3 tmpvar_9;
				half tmpvar_10;
				float4 mask_11;
				float4 color_12;
				half4 tmpvar_13;
				tmpvar_13 = _MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				color_12 = float4(tmpvar_13);
				half4 tmpvar_14;
				tmpvar_14 = _Emissive.sample(_mtlsmp__Emissive, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				mask_11 = float4(tmpvar_14);
				float2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				float2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				float2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				float2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				float2 tmpvar_19;
				float tmpvar_20;
				tmpvar_20 = (_mtl_i.xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, float2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, float2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), float2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				float3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(float3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, _mtl_i.xlv_TEXCOORD0.www), float3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = half3(tmpvar_21);
				float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = half(((tmpvar_22 + 0.2) * tmpvar_19.y));
				worldN_1.x = _mtl_i.xlv_TEXCOORD1.z;
				worldN_1.y = _mtl_i.xlv_TEXCOORD2.z;
				worldN_1.z = _mtl_i.xlv_TEXCOORD3.z;
				half4 c_23;
				half spec_24;
				half3 tmpvar_25;
				tmpvar_25 = normalize(worldN_1);
				half tmpvar_26;
				tmpvar_26 = max((half)0.0, dot(tmpvar_25, tmpvar_8));
				half tmpvar_27;
				tmpvar_27 = (pow(tmpvar_26, (_mtl_u._Shininess * (half)128.0)) * tmpvar_10);
				spec_24 = tmpvar_27;
				c_23.xyz = (_mtl_u._LightColor0.xyz * ((tmpvar_9 *
					max((half)0.0, dot(tmpvar_25, lightDir_4))
					) + spec_24));
				c_23.w = half(1.0);
				c_2.xyz = c_23.xyz;
				c_2.w = half(1.0);
				_mtl_o._glesFragData_0 = c_2;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL" }
				"!!GL3x"
		}
		SubProgram "opengl " {
			Keywords{ "SPOT" }
				"!!GLSL"
		}
		SubProgram "d3d9 " {
			// Stats: 66 math, 4 textures
			Keywords{ "SPOT" }
				Matrix 0[_LightMatrix0]
				Vector 6[_LightColor0]
				Float 7[_Shininess]
				Vector 4[_WorldSpaceCameraPos]
				Vector 5[_WorldSpaceLightPos0]
				SetTexture 0[_LightTexture0] 2D 0
				SetTexture 1[_LightTextureB0] 2D 1
				SetTexture 2[_MainTex] 2D 2
				SetTexture 3[_Emissive] 2D 3
				"ps_3_0
				def c8, 3, -2, -1, -1.39999998
				def c9, 0.200000003, 1, 0, 0.5
				def c10, 128, 0, 0, 0
				dcl_texcoord v0
				dcl_texcoord1_pp v1.z
				dcl_texcoord2_pp v2.z
				dcl_texcoord3_pp v3.z
				dcl_texcoord4 v4.xyz
				dcl_color v5
				dcl_2d s0
				dcl_2d s1
				dcl_2d s2
				dcl_2d s3
				mul r0.x, c8.x, v0.z
				mov_sat r0.x, r0.x
				texld r1, v0, s2
				mov r2.xz, r1
				texld r3, v0, s3
				mov r2.yw, r3.xxzz
				mov r1.xz, r3.yyww
				lrp r3.xy, r0.x, r1, r2.yxzw
				mad_sat r0.xy, v0.z, c8.x, c8.yzzw
				lrp r3.zw, r0.x, r1, r2.xywz
				lrp r1.xy, r0.y, r3.zwzw, r3
				mul r0.x, r1.y, r1.y
				add r0.yz, -r1.x, -c8.xzww
				mad_sat r0.x, r0.y, r0.x, r1.y
				lrp r2.xyz, r1.x, v5, r0.x
				add r0.xyw, -r2.xyzz, v5.xyzz
				mad r0.xyw, v0.w, r0, r2.xyzz
				mov_sat r1.z, v5.w
				lrp_pp r2.xyz, r1.z, r0.xyww, r1.y
				mul r0.x, r0.z, r0.z
				mad r0.x, r0.z, r0.x, c9.x
				mul_pp r0.x, r1.x, r0.x
				add r0.yzw, c4.xxyz, -v4.xxyz
				dp3 r1.x, r0.yzww, r0.yzww
				rsq r1.x, r1.x
				add r1.yzw, c5.xxyz, -v4.xxyz
				nrm_pp r3.xyz, r1.yzww
				mad_pp r0.yzw, r0, r1.x, r3.xxyz
				nrm_pp r1.xyz, r0.yzww
				mov_pp r4.x, v1.z
				mov_pp r4.y, v2.z
				mov_pp r4.z, v3.z
				nrm_pp r5.xyz, r4
				dp3_pp r0.y, r5, r1
				dp3_pp r0.z, r5, r3
				max_pp r1.x, r0.z, c9.z
				max_pp r1.y, r0.y, c9.z
				mov r3.x, c7.x
				mul_pp r0.y, r3.x, c10.x
				pow_pp r2.w, r1.y, r0.y
				mul_pp r0.x, r0.x, r2.w
				mad_pp r0.xyz, r2, r1.x, r0.x
				mul_pp r0.xyz, r0, c6
				mad r1, v4.xyzx, c9.yyyz, c9.zzzy
				dp4 r0.w, c3, r1
				rcp r0.w, r0.w
				dp4 r2.x, c0, r1
				dp4 r2.y, c1, r1
				dp4 r2.z, c2, r1
				mad r1.xy, r2, r0.w, c9.w
				dp3 r0.w, r2, r2
				texld_pp r3, r0.w, s1
				texld_pp r1, r1, s0
				mul_pp r0.w, r3.x, r1.w
				cmp_pp r0.w, -r2.z, c9.z, r0.w
				mul_pp oC0.xyz, r0.w, r0
				mov_pp oC0.w, -c8.z

				"
		}
		SubProgram "d3d11 " {
			// Stats: 55 math, 4 textures
			Keywords{ "SPOT" }
				SetTexture 0[_MainTex] 2D 2
				SetTexture 1[_Emissive] 2D 3
				SetTexture 2[_LightTexture0] 2D 0
				SetTexture 3[_LightTextureB0] 2D 1
				ConstBuffer "$Globals" 272
				Matrix 144[_LightMatrix0]
				Vector 96[_LightColor0]
				Float 208[_Shininess]
				ConstBuffer "UnityPerCamera" 144
				Vector 64[_WorldSpaceCameraPos] 3
				ConstBuffer "UnityLighting" 720
				Vector 0[_WorldSpaceLightPos0]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				"ps_4_0
				root12:aeadaeaa
				eefiecedampepohjllgfcgjiifkmbbhpkkkpbkfnabaaaaaaeaakaaaaadaaaaaa
				cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
				aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahaeaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaeaaaalmaaaaaa
				adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaeaaaalmaaaaaaaeaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaahahaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
				epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
				aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeajaaaaeaaaaaaa
				ebacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
				afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
				fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
				adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
				ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
				ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaad
				ecbabaaaadaaaaaagcbaaaadecbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
				gcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
				diaaaaahbcaabaaaaaaaaaaackbabaaaabaaaaaaabeaaaaaaaaaeaeadgcaaaaf
				bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
				abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadgaaaaafkcaabaaaacaaaaaa
				fganbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
				abaaaaaaaagabaaaadaaaaaadgaaaaaffcaabaaaacaaaaaafgahbaaaadaaaaaa
				dgaaaaafkcaabaaaabaaaaaaagaibaaaadaaaaaaaaaaaaaipcaabaaaacaaaaaa
				bgalbaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajdcaabaaaaaaaaaaa
				agaabaaaaaaaaaaaegaabaaaacaaaaaabgafbaaaabaaaaaadccaaaapmcaabaaa
				aaaaaaaakgbkbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaaeaea
				aceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaialpdcaaaaajdcaabaaaabaaaaaa
				kgakbaaaaaaaaaaaogakbaaaacaaaaaalgapbaaaabaaaaaaaaaaaaaidcaabaaa
				abaaaaaaegaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
				aaaaaaaapgapbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaadiaaaaah
				ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaldcaabaaa
				abaaaaaaagaabaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpddddlddpaaaaaaaa
				aaaaaaaadccaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaa
				bkaabaaaaaaaaaaaaaaaaaaincaabaaaabaaaaaakgakbaiaebaaaaaaaaaaaaaa
				agbjbaaaagaaaaaadcaaaaajncaabaaaabaaaaaaagaabaaaaaaaaaaaagaobaaa
				abaaaaaakgakbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaigadbaiaebaaaaaa
				abaaaaaaegbcbaaaagaaaaaadcaaaaajncaabaaaabaaaaaapgbpbaaaabaaaaaa
				agajbaaaacaaaaaaagaobaaaabaaaaaaaaaaaaaincaabaaaabaaaaaafgafbaia
				ebaaaaaaaaaaaaaaagaobaaaabaaaaaadgcaaaafecaabaaaaaaaaaaadkbabaaa
				agaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaaaaaaaaaagaobaaaabaaaaaa
				fgafbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
				abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
				abeaaaaamnmmemdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
				abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaa
				acaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
				egbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
				abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaa
				dkaabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
				abaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
				egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
				hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafbcaabaaa
				adaaaaaackbabaaaacaaaaaadgaaaaafccaabaaaadaaaaaackbabaaaadaaaaaa
				dgaaaaafecaabaaaadaaaaaackbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
				egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
				abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
				baaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaah
				bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaakdcaabaaa
				abaaaaaamgaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
				cpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaa
				akiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaaabaaaaaa
				bkaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
				abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
				dcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaaagaabaaa
				aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
				agaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaafaaaaaaegiocaaaaaaaaaaa
				akaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaa
				afaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
				alaaaaaakgbkbaaaafaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaa
				egaobaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaaaoaaaaahdcaabaaaacaaaaaa
				egaabaaaabaaaaaapgapbaaaabaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaa
				acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
				acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaah
				icaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaabaaaaaahbcaabaaa
				abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
				agaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaabaaaaahicaabaaa
				aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
				dkaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
				abaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
				egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
				"
		}
		SubProgram "gles " {
			Keywords{ "SPOT" }
				"!!GLES"
		}
		SubProgram "gles3 " {
			Keywords{ "SPOT" }
				"!!GLES3"
		}
		SubProgram "metal " {
			// Stats: 52 math, 4 textures
			Keywords{ "SPOT" }
				SetTexture 0[_LightTexture0] 2D 0
				SetTexture 1[_LightTextureB0] 2D 1
				SetTexture 2[_MainTex] 2D 2
				SetTexture 3[_Emissive] 2D 3
				ConstBuffer "$Globals" 74
				MatrixHalf 40[_LightMatrix0]
				Vector 0[_WorldSpaceCameraPos] 3
				Vector 16[_WorldSpaceLightPos0]
				VectorHalf 32[_LightColor0] 4
				ScalarHalf 72[_Shininess]
				"metal_fs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderOutput {
				half4 _glesFragData_0[[color(0)]];
			};
			struct xlatMtlShaderUniform {
				float3 _WorldSpaceCameraPos;
				float4 _WorldSpaceLightPos0;
				half4 _LightColor0;
				half4x4 _LightMatrix0;
				half _Shininess;
			};
			fragment xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]]
				,   texture2d<half> _LightTexture0[[texture(0)]], sampler _mtlsmp__LightTexture0[[sampler(0)]]
				,   texture2d<half> _LightTextureB0[[texture(1)]], sampler _mtlsmp__LightTextureB0[[sampler(1)]]
				,   texture2d<half> _MainTex[[texture(2)]], sampler _mtlsmp__MainTex[[sampler(2)]]
				,   texture2d<half> _Emissive[[texture(3)]], sampler _mtlsmp__Emissive[[sampler(3)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half3 worldN_1;
				half4 c_2;
				half atten_3;
				half4 lightCoord_4;
				half3 worldViewDir_5;
				half3 lightDir_6;
				float4 tmpvar_7;
				float3 tmpvar_8;
				tmpvar_8 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD4));
				lightDir_6 = half3(tmpvar_8);
				float3 tmpvar_9;
				tmpvar_9 = normalize((_mtl_u._WorldSpaceCameraPos - _mtl_i.xlv_TEXCOORD4));
				worldViewDir_5 = half3(tmpvar_9);
				half3 tmpvar_10;
				tmpvar_10 = normalize((worldViewDir_5 + lightDir_6));
				worldViewDir_5 = tmpvar_10;
				tmpvar_7 = float4(_mtl_i.xlv_COLOR0);
				half3 tmpvar_11;
				half tmpvar_12;
				float4 mask_13;
				float4 color_14;
				half4 tmpvar_15;
				tmpvar_15 = _MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				color_14 = float4(tmpvar_15);
				half4 tmpvar_16;
				tmpvar_16 = _Emissive.sample(_mtlsmp__Emissive, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				mask_13 = float4(tmpvar_16);
				float2 tmpvar_17;
				tmpvar_17.x = color_14.x;
				tmpvar_17.y = mask_13.x;
				float2 tmpvar_18;
				tmpvar_18.x = color_14.y;
				tmpvar_18.y = mask_13.y;
				float2 tmpvar_19;
				tmpvar_19.x = color_14.z;
				tmpvar_19.y = mask_13.z;
				float2 tmpvar_20;
				tmpvar_20.x = color_14.w;
				tmpvar_20.y = mask_13.w;
				float2 tmpvar_21;
				float tmpvar_22;
				tmpvar_22 = (_mtl_i.xlv_TEXCOORD0.z * 3.0);
				tmpvar_21 = mix(mix(tmpvar_17, tmpvar_18, float2(clamp(tmpvar_22, 0.0, 1.0))), mix(tmpvar_19, tmpvar_20, float2(clamp(
					(tmpvar_22 - 2.0)
					, 0.0, 1.0))), float2(clamp((tmpvar_22 - 1.0), 0.0, 1.0)));
				float3 tmpvar_23;
				tmpvar_23 = mix(tmpvar_21.xxx, mix(mix(float3(
					clamp((tmpvar_21.x + ((1.0 - tmpvar_21.y) * (tmpvar_21.x * tmpvar_21.x))), 0.0, 1.0)
					), tmpvar_7.xyz, tmpvar_21.yyy), tmpvar_7.xyz, _mtl_i.xlv_TEXCOORD0.www), float3(clamp(tmpvar_7.w, 0.0, 1.0)));
				tmpvar_11 = half3(tmpvar_23);
				float tmpvar_24;
				tmpvar_24 = pow(((1.0 - tmpvar_21.y) + 0.4), 3.0);
				tmpvar_12 = half(((tmpvar_24 + 0.2) * tmpvar_21.y));
				float4 tmpvar_25;
				tmpvar_25.w = 1.0;
				tmpvar_25.xyz = _mtl_i.xlv_TEXCOORD4;
				float4 tmpvar_26;
				tmpvar_26 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_25));
				lightCoord_4 = half4(tmpvar_26);
				half4 tmpvar_27;
				half2 P_28;
				P_28 = ((lightCoord_4.xy / lightCoord_4.w) + (half)0.5);
				tmpvar_27 = _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(P_28));
				float3 LightCoord_29;
				LightCoord_29 = float3(lightCoord_4.xyz);
				float tmpvar_30;
				tmpvar_30 = dot(LightCoord_29, LightCoord_29);
				half4 tmpvar_31;
				tmpvar_31 = _LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_30)));
				half tmpvar_32;
				tmpvar_32 = ((half(
					(lightCoord_4.z > (half)0.0)
					) * tmpvar_27.w) * tmpvar_31.w);
				atten_3 = tmpvar_32;
				worldN_1.x = _mtl_i.xlv_TEXCOORD1.z;
				worldN_1.y = _mtl_i.xlv_TEXCOORD2.z;
				worldN_1.z = _mtl_i.xlv_TEXCOORD3.z;
				half4 c_33;
				half spec_34;
				half3 tmpvar_35;
				tmpvar_35 = normalize(worldN_1);
				half tmpvar_36;
				tmpvar_36 = max((half)0.0, dot(tmpvar_35, tmpvar_10));
				half tmpvar_37;
				tmpvar_37 = (pow(tmpvar_36, (_mtl_u._Shininess * (half)128.0)) * tmpvar_12);
				spec_34 = tmpvar_37;
				c_33.xyz = ((_mtl_u._LightColor0.xyz * (
					(tmpvar_11 * max((half)0.0, dot(tmpvar_35, lightDir_6)))
					+ spec_34)) * atten_3);
				c_33.w = half(1.0);
				c_2.xyz = c_33.xyz;
				c_2.w = half(1.0);
				_mtl_o._glesFragData_0 = c_2;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "SPOT" }
				"!!GL3x"
		}
		SubProgram "opengl " {
			Keywords{ "POINT_COOKIE" }
				"!!GLSL"
		}
		SubProgram "d3d9 " {
			// Stats: 62 math, 4 textures
			Keywords{ "POINT_COOKIE" }
				Matrix 0[_LightMatrix0] 3
				Vector 5[_LightColor0]
				Float 6[_Shininess]
				Vector 3[_WorldSpaceCameraPos]
				Vector 4[_WorldSpaceLightPos0]
				SetTexture 0[_LightTexture0] CUBE 0
				SetTexture 1[_LightTextureB0] 2D 1
				SetTexture 2[_MainTex] 2D 2
				SetTexture 3[_Emissive] 2D 3
				"ps_3_0
				def c7, 3, -2, -1, -1.39999998
				def c8, 0.200000003, 1, 0, 128
				dcl_texcoord v0
				dcl_texcoord1_pp v1.z
				dcl_texcoord2_pp v2.z
				dcl_texcoord3_pp v3.z
				dcl_texcoord4 v4.xyz
				dcl_color v5
				dcl_cube s0
				dcl_2d s1
				dcl_2d s2
				dcl_2d s3
				mul r0.x, c7.x, v0.z
				mov_sat r0.x, r0.x
				texld r1, v0, s2
				mov r2.xz, r1
				texld r3, v0, s3
				mov r2.yw, r3.xxzz
				mov r1.xz, r3.yyww
				lrp r3.xy, r0.x, r1, r2.yxzw
				mad_sat r0.xy, v0.z, c7.x, c7.yzzw
				lrp r3.zw, r0.x, r1, r2.xywz
				lrp r1.xy, r0.y, r3.zwzw, r3
				mul r0.x, r1.y, r1.y
				add r0.yz, -r1.x, -c7.xzww
				mad_sat r0.x, r0.y, r0.x, r1.y
				lrp r2.xyz, r1.x, v5, r0.x
				add r0.xyw, -r2.xyzz, v5.xyzz
				mad r0.xyw, v0.w, r0, r2.xyzz
				mov_sat r1.z, v5.w
				lrp_pp r2.xyz, r1.z, r0.xyww, r1.y
				mul r0.x, r0.z, r0.z
				mad r0.x, r0.z, r0.x, c8.x
				mul_pp r0.x, r1.x, r0.x
				add r0.yzw, c3.xxyz, -v4.xxyz
				dp3 r1.x, r0.yzww, r0.yzww
				rsq r1.x, r1.x
				add r1.yzw, c4.xxyz, -v4.xxyz
				nrm_pp r3.xyz, r1.yzww
				mad_pp r0.yzw, r0, r1.x, r3.xxyz
				nrm_pp r1.xyz, r0.yzww
				mov_pp r4.x, v1.z
				mov_pp r4.y, v2.z
				mov_pp r4.z, v3.z
				nrm_pp r5.xyz, r4
				dp3_pp r0.y, r5, r1
				dp3_pp r0.z, r5, r3
				max_pp r1.x, r0.z, c8.z
				max_pp r1.y, r0.y, c8.z
				mov r0.w, c8.w
				mul_pp r0.y, r0.w, c6.x
				pow_pp r2.w, r1.y, r0.y
				mul_pp r0.x, r0.x, r2.w
				mad_pp r0.xyz, r2, r1.x, r0.x
				mul_pp r0.xyz, r0, c5
				mad r1, v4.xyzx, c8.yyyz, c8.zzzy
				dp4 r2.x, c0, r1
				dp4 r2.y, c1, r1
				dp4 r2.z, c2, r1
				dp3 r0.w, r2, r2
				texld r1, r2, s0
				texld r2, r0.w, s1
				mul_pp r0.w, r1.w, r2.x
				mul_pp oC0.xyz, r0.w, r0
				mov_pp oC0.w, -c7.z

				"
		}
		SubProgram "d3d11 " {
			// Stats: 50 math, 4 textures
			Keywords{ "POINT_COOKIE" }
				SetTexture 0[_MainTex] 2D 2
				SetTexture 1[_Emissive] 2D 3
				SetTexture 2[_LightTextureB0] 2D 1
				SetTexture 3[_LightTexture0] CUBE 0
				ConstBuffer "$Globals" 272
				Matrix 144[_LightMatrix0]
				Vector 96[_LightColor0]
				Float 208[_Shininess]
				ConstBuffer "UnityPerCamera" 144
				Vector 64[_WorldSpaceCameraPos] 3
				ConstBuffer "UnityLighting" 720
				Vector 0[_WorldSpaceLightPos0]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				"ps_4_0
				root12:aeadaeaa
				eefiecedgkficgfdmbkmakkgmeclcmhpdbbckkclabaaaaaakiajaaaaadaaaaaa
				cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
				aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahaeaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaeaaaalmaaaaaa
				adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaeaaaalmaaaaaaaeaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaahahaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
				epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
				aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmaiaaaaeaaaaaaa
				blacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
				afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
				fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
				adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
				ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaa
				ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaad
				ecbabaaaadaaaaaagcbaaaadecbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
				gcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
				diaaaaahbcaabaaaaaaaaaaackbabaaaabaaaaaaabeaaaaaaaaaeaeadgcaaaaf
				bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
				abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadgaaaaafkcaabaaaacaaaaaa
				fganbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
				abaaaaaaaagabaaaadaaaaaadgaaaaaffcaabaaaacaaaaaafgahbaaaadaaaaaa
				dgaaaaafkcaabaaaabaaaaaaagaibaaaadaaaaaaaaaaaaaipcaabaaaacaaaaaa
				bgalbaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajdcaabaaaaaaaaaaa
				agaabaaaaaaaaaaaegaabaaaacaaaaaabgafbaaaabaaaaaadccaaaapmcaabaaa
				aaaaaaaakgbkbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaaeaea
				aceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaialpdcaaaaajdcaabaaaabaaaaaa
				kgakbaaaaaaaaaaaogakbaaaacaaaaaalgapbaaaabaaaaaaaaaaaaaidcaabaaa
				abaaaaaaegaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadcaaaaajdcaabaaa
				aaaaaaaapgapbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaadiaaaaah
				ecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaldcaabaaa
				abaaaaaaagaabaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpddddlddpaaaaaaaa
				aaaaaaaadccaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaa
				bkaabaaaaaaaaaaaaaaaaaaincaabaaaabaaaaaakgakbaiaebaaaaaaaaaaaaaa
				agbjbaaaagaaaaaadcaaaaajncaabaaaabaaaaaaagaabaaaaaaaaaaaagaobaaa
				abaaaaaakgakbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaigadbaiaebaaaaaa
				abaaaaaaegbcbaaaagaaaaaadcaaaaajncaabaaaabaaaaaapgbpbaaaabaaaaaa
				agajbaaaacaaaaaaagaobaaaabaaaaaaaaaaaaaincaabaaaabaaaaaafgafbaia
				ebaaaaaaaaaaaaaaagaobaaaabaaaaaadgcaaaafecaabaaaaaaaaaaadkbabaaa
				agaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaaaaaaaaaagaobaaaabaaaaaa
				fgafbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
				abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
				abeaaaaamnmmemdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
				abaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaa
				acaaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
				abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
				abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
				egbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
				abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaa
				dkaabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
				abaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
				egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
				hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaafbcaabaaa
				adaaaaaackbabaaaacaaaaaadgaaaaafccaabaaaadaaaaaackbabaaaadaaaaaa
				dgaaaaafecaabaaaadaaaaaackbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
				egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
				abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
				baaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaah
				bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaakdcaabaaa
				abaaaaaamgaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
				cpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaa
				akiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaaabaaaaaa
				bkaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
				abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaabaaaaaa
				dcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaabaaaaaaagaabaaa
				aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
				agaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaa
				akaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaa
				afaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
				alaaaaaakgbkbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
				egacbaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaaaaaaaaa
				egacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaa
				abaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
				pgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
				aaaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
				pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
				aaaaiadpdoaaaaab"
		}
		SubProgram "gles " {
			Keywords{ "POINT_COOKIE" }
				"!!GLES"
		}
		SubProgram "gles3 " {
			Keywords{ "POINT_COOKIE" }
				"!!GLES3"
		}
		SubProgram "metal " {
			// Stats: 47 math, 4 textures
			Keywords{ "POINT_COOKIE" }
				SetTexture 0[_LightTexture0] CUBE 0
				SetTexture 1[_LightTextureB0] 2D 1
				SetTexture 2[_MainTex] 2D 2
				SetTexture 3[_Emissive] 2D 3
				ConstBuffer "$Globals" 74
				MatrixHalf 40[_LightMatrix0]
				Vector 0[_WorldSpaceCameraPos] 3
				Vector 16[_WorldSpaceLightPos0]
				VectorHalf 32[_LightColor0] 4
				ScalarHalf 72[_Shininess]
				"metal_fs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderOutput {
				half4 _glesFragData_0[[color(0)]];
			};
			struct xlatMtlShaderUniform {
				float3 _WorldSpaceCameraPos;
				float4 _WorldSpaceLightPos0;
				half4 _LightColor0;
				half4x4 _LightMatrix0;
				half _Shininess;
			};
			fragment xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]]
				,   texturecube<half> _LightTexture0[[texture(0)]], sampler _mtlsmp__LightTexture0[[sampler(0)]]
				,   texture2d<half> _LightTextureB0[[texture(1)]], sampler _mtlsmp__LightTextureB0[[sampler(1)]]
				,   texture2d<half> _MainTex[[texture(2)]], sampler _mtlsmp__MainTex[[sampler(2)]]
				,   texture2d<half> _Emissive[[texture(3)]], sampler _mtlsmp__Emissive[[sampler(3)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half3 worldN_1;
				half4 c_2;
				half3 worldViewDir_3;
				half3 lightDir_4;
				float4 tmpvar_5;
				float3 tmpvar_6;
				tmpvar_6 = normalize((_mtl_u._WorldSpaceLightPos0.xyz - _mtl_i.xlv_TEXCOORD4));
				lightDir_4 = half3(tmpvar_6);
				float3 tmpvar_7;
				tmpvar_7 = normalize((_mtl_u._WorldSpaceCameraPos - _mtl_i.xlv_TEXCOORD4));
				worldViewDir_3 = half3(tmpvar_7);
				half3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = float4(_mtl_i.xlv_COLOR0);
				half3 tmpvar_9;
				half tmpvar_10;
				float4 mask_11;
				float4 color_12;
				half4 tmpvar_13;
				tmpvar_13 = _MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				color_12 = float4(tmpvar_13);
				half4 tmpvar_14;
				tmpvar_14 = _Emissive.sample(_mtlsmp__Emissive, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				mask_11 = float4(tmpvar_14);
				float2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				float2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				float2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				float2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				float2 tmpvar_19;
				float tmpvar_20;
				tmpvar_20 = (_mtl_i.xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, float2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, float2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), float2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				float3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(float3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, _mtl_i.xlv_TEXCOORD0.www), float3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = half3(tmpvar_21);
				float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = half(((tmpvar_22 + 0.2) * tmpvar_19.y));
				float4 tmpvar_23;
				tmpvar_23.w = 1.0;
				tmpvar_23.xyz = _mtl_i.xlv_TEXCOORD4;
				float3 tmpvar_24;
				tmpvar_24 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_23)).xyz;
				float tmpvar_25;
				tmpvar_25 = dot(tmpvar_24, tmpvar_24);
				worldN_1.x = _mtl_i.xlv_TEXCOORD1.z;
				worldN_1.y = _mtl_i.xlv_TEXCOORD2.z;
				worldN_1.z = _mtl_i.xlv_TEXCOORD3.z;
				half4 c_26;
				half spec_27;
				half3 tmpvar_28;
				tmpvar_28 = normalize(worldN_1);
				half tmpvar_29;
				tmpvar_29 = max((half)0.0, dot(tmpvar_28, tmpvar_8));
				half tmpvar_30;
				tmpvar_30 = (pow(tmpvar_29, (_mtl_u._Shininess * (half)128.0)) * tmpvar_10);
				spec_27 = tmpvar_30;
				c_26.xyz = ((_mtl_u._LightColor0.xyz * (
					(tmpvar_9 * max((half)0.0, dot(tmpvar_28, lightDir_4)))
					+ spec_27)) * (_LightTextureB0.sample(_mtlsmp__LightTextureB0, (float2)(float2(tmpvar_25))).w * _LightTexture0.sample(_mtlsmp__LightTexture0, (float3)(tmpvar_24)).w));
				c_26.w = half(1.0);
				c_2.xyz = c_26.xyz;
				c_2.w = half(1.0);
				_mtl_o._glesFragData_0 = c_2;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "POINT_COOKIE" }
				"!!GL3x"
		}
		SubProgram "opengl " {
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GLSL"
		}
		SubProgram "d3d9 " {
			// Stats: 55 math, 3 textures
			Keywords{ "DIRECTIONAL_COOKIE" }
				Matrix 0[_LightMatrix0] 2
				Vector 4[_LightColor0]
				Float 5[_Shininess]
				Vector 2[_WorldSpaceCameraPos]
				Vector 3[_WorldSpaceLightPos0]
				SetTexture 0[_LightTexture0] 2D 0
				SetTexture 1[_MainTex] 2D 1
				SetTexture 2[_Emissive] 2D 2
				"ps_3_0
				def c6, 3, -2, -1, -1.39999998
				def c7, 0.200000003, 1, 0, 128
				dcl_texcoord v0
				dcl_texcoord1_pp v1.z
				dcl_texcoord2_pp v2.z
				dcl_texcoord3_pp v3.z
				dcl_texcoord4 v4.xyz
				dcl_color v5
				dcl_2d s0
				dcl_2d s1
				dcl_2d s2
				mul r0.x, c6.x, v0.z
				mov_sat r0.x, r0.x
				texld r1, v0, s1
				mov r2.xz, r1
				texld r3, v0, s2
				mov r2.yw, r3.xxzz
				mov r1.xz, r3.yyww
				lrp r3.xy, r0.x, r1, r2.yxzw
				mad_sat r0.xy, v0.z, c6.x, c6.yzzw
				lrp r3.zw, r0.x, r1, r2.xywz
				lrp r1.xy, r0.y, r3.zwzw, r3
				mul r0.x, r1.y, r1.y
				add r0.yz, -r1.x, -c6.xzww
				mad_sat r0.x, r0.y, r0.x, r1.y
				lrp r2.xyz, r1.x, v5, r0.x
				add r0.xyw, -r2.xyzz, v5.xyzz
				mad r0.xyw, v0.w, r0, r2.xyzz
				mov_sat r1.z, v5.w
				lrp_pp r2.xyz, r1.z, r0.xyww, r1.y
				mul r0.x, r0.z, r0.z
				mad r0.x, r0.z, r0.x, c7.x
				mul_pp r0.x, r1.x, r0.x
				add r0.yzw, c2.xxyz, -v4.xxyz
				dp3 r1.x, r0.yzww, r0.yzww
				rsq r1.x, r1.x
				mad_pp r0.yzw, r0, r1.x, c3.xxyz
				nrm_pp r1.xyz, r0.yzww
				mov_pp r3.x, v1.z
				mov_pp r3.y, v2.z
				mov_pp r3.z, v3.z
				nrm_pp r4.xyz, r3
				dp3_pp r0.y, r4, r1
				dp3_pp r0.z, r4, c3
				max_pp r1.x, r0.z, c7.z
				max_pp r1.y, r0.y, c7.z
				mov r0.w, c7.w
				mul_pp r0.y, r0.w, c5.x
				pow_pp r2.w, r1.y, r0.y
				mul_pp r0.x, r0.x, r2.w
				mad_pp r0.xyz, r2, r1.x, r0.x
				mul_pp r0.xyz, r0, c4
				mad r1, v4.xyzx, c7.yyyz, c7.zzzy
				dp4 r2.x, c0, r1
				dp4 r2.y, c1, r1
				texld_pp r1, r2, s0
				mul_pp oC0.xyz, r0, r1.w
				mov_pp oC0.w, -c6.z

				"
		}
		SubProgram "d3d11 " {
			// Stats: 44 math, 3 textures
			Keywords{ "DIRECTIONAL_COOKIE" }
				SetTexture 0[_MainTex] 2D 1
				SetTexture 1[_Emissive] 2D 2
				SetTexture 2[_LightTexture0] 2D 0
				ConstBuffer "$Globals" 272
				Matrix 144[_LightMatrix0]
				Vector 96[_LightColor0]
				Float 208[_Shininess]
				ConstBuffer "UnityPerCamera" 144
				Vector 64[_WorldSpaceCameraPos] 3
				ConstBuffer "UnityLighting" 720
				Vector 0[_WorldSpaceLightPos0]
				BindCB  "$Globals" 0
				BindCB  "UnityPerCamera" 1
				BindCB  "UnityLighting" 2
				"ps_4_0
				root12:adadadaa
				eefiecedelgemoicagneiifoahocmedbgbaipdngabaaaaaamiaiaaaaadaaaaaa
				cmaaaaaaaaabaaaadeabaaaaejfdeheommaaaaaaahaaaaaaaiaaaaaalaaaaaaa
				aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
				adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
				ahaeaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaeaaaalmaaaaaa
				adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaeaaaalmaaaaaaaeaaaaaaaaaaaaaa
				adaaaaaaafaaaaaaahahaaaamfaaaaaaaaaaaaaaaaaaaaaaadaaaaaaagaaaaaa
				apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
				epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
				aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimahaaaaeaaaaaaa
				odabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
				afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
				fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
				aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
				acaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadecbabaaaacaaaaaa
				gcbaaaadecbabaaaadaaaaaagcbaaaadecbabaaaaeaaaaaagcbaaaadhcbabaaa
				afaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
				aeaaaaaadiaaaaahbcaabaaaaaaaaaaackbabaaaabaaaaaaabeaaaaaaaaaeaea
				dgcaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
				egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadgaaaaafkcaabaaa
				acaaaaaafganbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
				eghobaaaabaaaaaaaagabaaaacaaaaaadgaaaaaffcaabaaaacaaaaaafgahbaaa
				adaaaaaadgaaaaafkcaabaaaabaaaaaaagaibaaaadaaaaaaaaaaaaaipcaabaaa
				acaaaaaabgalbaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajdcaabaaa
				aaaaaaaaagaabaaaaaaaaaaaegaabaaaacaaaaaabgafbaaaabaaaaaadccaaaap
				mcaabaaaaaaaaaaakgbkbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaea
				aaaaeaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaaamaaaaaialpdcaaaaajdcaabaaa
				abaaaaaakgakbaaaaaaaaaaaogakbaaaacaaaaaalgapbaaaabaaaaaaaaaaaaai
				dcaabaaaabaaaaaaegaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadcaaaaaj
				dcaabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaa
				diaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaal
				dcaabaaaabaaaaaaagaabaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpddddlddp
				aaaaaaaaaaaaaaaadccaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaa
				aaaaaaaabkaabaaaaaaaaaaaaaaaaaaincaabaaaabaaaaaakgakbaiaebaaaaaa
				aaaaaaaaagbjbaaaagaaaaaadcaaaaajncaabaaaabaaaaaaagaabaaaaaaaaaaa
				agaobaaaabaaaaaakgakbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaigadbaia
				ebaaaaaaabaaaaaaegbcbaaaagaaaaaadcaaaaajncaabaaaabaaaaaapgbpbaaa
				abaaaaaaagajbaaaacaaaaaaagaobaaaabaaaaaaaaaaaaaincaabaaaabaaaaaa
				fgafbaiaebaaaaaaaaaaaaaaagaobaaaabaaaaaadgcaaaafecaabaaaaaaaaaaa
				dkbabaaaagaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaaaaaaaaaagaobaaa
				abaaaaaafgafbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
				bkaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
				abaaaaaaabeaaaaamnmmemdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
				akaabaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
				egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
				egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaak
				hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegiccaaaacaaaaaa
				aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
				eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
				pgapbaaaabaaaaaaegacbaaaabaaaaaadgaaaaafbcaabaaaacaaaaaackbabaaa
				acaaaaaadgaaaaafccaabaaaacaaaaaackbabaaaadaaaaaadgaaaaafecaabaaa
				acaaaaaackbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
				egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
				hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaa
				abaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaaiccaabaaaabaaaaaa
				egacbaaaacaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaakdcaabaaaabaaaaaa
				egaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
				bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaaakiacaaa
				aaaaaaaaanaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
				abaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
				diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
				hcaabaaaaaaaaaaajgahbaaaaaaaaaaafgafbaaaabaaaaaaagaabaaaaaaaaaaa
				diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
				diaaaaaidcaabaaaabaaaaaafgbfbaaaafaaaaaaegiacaaaaaaaaaaaakaaaaaa
				dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaa
				egaabaaaabaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaalaaaaaa
				kgbkbaaaafaaaaaaegaabaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaaegaabaaa
				abaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
				abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
				egacbaaaaaaaaaaapgapbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
				aaaaiadpdoaaaaab"
		}
		SubProgram "gles " {
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GLES"
		}
		SubProgram "gles3 " {
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GLES3"
		}
		SubProgram "metal " {
			// Stats: 43 math, 3 textures
			Keywords{ "DIRECTIONAL_COOKIE" }
				SetTexture 0[_LightTexture0] 2D 0
				SetTexture 1[_MainTex] 2D 1
				SetTexture 2[_Emissive] 2D 2
				ConstBuffer "$Globals" 66
				MatrixHalf 32[_LightMatrix0]
				Vector 0[_WorldSpaceCameraPos] 3
				VectorHalf 16[_WorldSpaceLightPos0] 4
				VectorHalf 24[_LightColor0] 4
				ScalarHalf 64[_Shininess]
				"metal_fs
#include <metal_stdlib>
				using namespace metal;
			struct xlatMtlShaderInput {
				float4 xlv_TEXCOORD0;
				half3 xlv_TEXCOORD1;
				half3 xlv_TEXCOORD2;
				half3 xlv_TEXCOORD3;
				float3 xlv_TEXCOORD4;
				half4 xlv_COLOR0;
			};
			struct xlatMtlShaderOutput {
				half4 _glesFragData_0[[color(0)]];
			};
			struct xlatMtlShaderUniform {
				float3 _WorldSpaceCameraPos;
				half4 _WorldSpaceLightPos0;
				half4 _LightColor0;
				half4x4 _LightMatrix0;
				half _Shininess;
			};
			fragment xlatMtlShaderOutput xlatMtlMain(xlatMtlShaderInput _mtl_i[[stage_in]], constant xlatMtlShaderUniform& _mtl_u[[buffer(0)]]
				,   texture2d<half> _LightTexture0[[texture(0)]], sampler _mtlsmp__LightTexture0[[sampler(0)]]
				,   texture2d<half> _MainTex[[texture(1)]], sampler _mtlsmp__MainTex[[sampler(1)]]
				,   texture2d<half> _Emissive[[texture(2)]], sampler _mtlsmp__Emissive[[sampler(2)]])
			{
				xlatMtlShaderOutput _mtl_o;
				half3 worldN_1;
				half4 c_2;
				half3 worldViewDir_3;
				half3 lightDir_4;
				float4 tmpvar_5;
				half3 tmpvar_6;
				tmpvar_6 = _mtl_u._WorldSpaceLightPos0.xyz;
				lightDir_4 = tmpvar_6;
				float3 tmpvar_7;
				tmpvar_7 = normalize((_mtl_u._WorldSpaceCameraPos - _mtl_i.xlv_TEXCOORD4));
				worldViewDir_3 = half3(tmpvar_7);
				half3 tmpvar_8;
				tmpvar_8 = normalize((worldViewDir_3 + lightDir_4));
				worldViewDir_3 = tmpvar_8;
				tmpvar_5 = float4(_mtl_i.xlv_COLOR0);
				half3 tmpvar_9;
				half tmpvar_10;
				float4 mask_11;
				float4 color_12;
				half4 tmpvar_13;
				tmpvar_13 = _MainTex.sample(_mtlsmp__MainTex, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				color_12 = float4(tmpvar_13);
				half4 tmpvar_14;
				tmpvar_14 = _Emissive.sample(_mtlsmp__Emissive, (float2)(_mtl_i.xlv_TEXCOORD0.xy));
				mask_11 = float4(tmpvar_14);
				float2 tmpvar_15;
				tmpvar_15.x = color_12.x;
				tmpvar_15.y = mask_11.x;
				float2 tmpvar_16;
				tmpvar_16.x = color_12.y;
				tmpvar_16.y = mask_11.y;
				float2 tmpvar_17;
				tmpvar_17.x = color_12.z;
				tmpvar_17.y = mask_11.z;
				float2 tmpvar_18;
				tmpvar_18.x = color_12.w;
				tmpvar_18.y = mask_11.w;
				float2 tmpvar_19;
				float tmpvar_20;
				tmpvar_20 = (_mtl_i.xlv_TEXCOORD0.z * 3.0);
				tmpvar_19 = mix(mix(tmpvar_15, tmpvar_16, float2(clamp(tmpvar_20, 0.0, 1.0))), mix(tmpvar_17, tmpvar_18, float2(clamp(
					(tmpvar_20 - 2.0)
					, 0.0, 1.0))), float2(clamp((tmpvar_20 - 1.0), 0.0, 1.0)));
				float3 tmpvar_21;
				tmpvar_21 = mix(tmpvar_19.xxx, mix(mix(float3(
					clamp((tmpvar_19.x + ((1.0 - tmpvar_19.y) * (tmpvar_19.x * tmpvar_19.x))), 0.0, 1.0)
					), tmpvar_5.xyz, tmpvar_19.yyy), tmpvar_5.xyz, _mtl_i.xlv_TEXCOORD0.www), float3(clamp(tmpvar_5.w, 0.0, 1.0)));
				tmpvar_9 = half3(tmpvar_21);
				float tmpvar_22;
				tmpvar_22 = pow(((1.0 - tmpvar_19.y) + 0.4), 3.0);
				tmpvar_10 = half(((tmpvar_22 + 0.2) * tmpvar_19.y));
				float4 tmpvar_23;
				tmpvar_23.w = 1.0;
				tmpvar_23.xyz = _mtl_i.xlv_TEXCOORD4;
				float2 tmpvar_24;
				tmpvar_24 = ((float4)(_mtl_u._LightMatrix0 * (half4)tmpvar_23)).xy;
				worldN_1.x = _mtl_i.xlv_TEXCOORD1.z;
				worldN_1.y = _mtl_i.xlv_TEXCOORD2.z;
				worldN_1.z = _mtl_i.xlv_TEXCOORD3.z;
				half4 c_25;
				half spec_26;
				half3 tmpvar_27;
				tmpvar_27 = normalize(worldN_1);
				half tmpvar_28;
				tmpvar_28 = max((half)0.0, dot(tmpvar_27, tmpvar_8));
				half tmpvar_29;
				tmpvar_29 = (pow(tmpvar_28, (_mtl_u._Shininess * (half)128.0)) * tmpvar_10);
				spec_26 = tmpvar_29;
				c_25.xyz = ((_mtl_u._LightColor0.xyz * (
					(tmpvar_9 * max((half)0.0, dot(tmpvar_27, lightDir_4)))
					+ spec_26)) * _LightTexture0.sample(_mtlsmp__LightTexture0, (float2)(tmpvar_24)).w);
				c_25.w = half(1.0);
				c_2.xyz = c_25.xyz;
				c_2.w = half(1.0);
				_mtl_o._glesFragData_0 = c_2;
				return _mtl_o;
			}

			"
		}
		SubProgram "glcore " {
			Keywords{ "DIRECTIONAL_COOKIE" }
				"!!GL3x"
		}
	}
	}
	}
		Fallback "Diffuse"
}