//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Toon Basic Transparent Emission Outline Later" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_MainAlpha ("Main Alpha(0-1.0)", Range(0, 1)) = 0.5
_EmissionColor ("Main Emission Color(128 is standard)", Color) = (1,1,1,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineMax ("Outline Max", Float) = 0.005
_OutlineMin ("Outline Min", Float) = 0.002
_Outline ("Outline width(0.002-0.005)", Float) = 0.005
_OutlineAlpha ("Outline Alpha(0-1.0)", Range(0, 1)) = 0.5
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 UsePass "miHoYo/Toon Basic Transparent Emission Outline/BASE"
 UsePass "miHoYo/Toon Basic Transparent Emission Outline/OUTLINE"
}
Fallback "Diffuse"
}