//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Util/Draw_Wireframe" {
Properties {
[PowerSlider(3.0)] _WireframeVal ("Wireframe width", Range(0, 0.5)) = 0.05
_FrontColor ("Front color", Color) = (1,1,1,1)
_BackColor ("Back color", Color) = (1,1,1,1)
[Toggle] _RemoveDiag ("Remove diagonals?", Float) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 45720
Program "vp" {
}
Program "fp" {
}
Program "gp" {
}
}
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  GpuProgramID 97328
Program "vp" {
}
Program "fp" {
}
Program "gp" {
}
}
}
}