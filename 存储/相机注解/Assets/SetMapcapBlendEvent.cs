using UnityEngine;
using System.Collections;
using System;
public class SetMapcapBlendEvent : MonoBehaviour
{
    public float BeginTime;
    public Multiply Multiply;
    public Additive Additive;
    public Special Special;
}
[Serializable]
public class Multiply
{
    public float MultiplyStrength;
    public Color MultiplyColor;
    public AnimationCurve MultiplyCurve;
    public bool MultiplyReflect;
}
[Serializable]
public class Additive
{
    public Texture2D AdditiveTex;
    public string AdditiveName;
    public float AdditiveStrength;
    public Color AdditiveColor;
    public AnimationCurve AdditiveCurve;
}
[Serializable]
public class Special
{
    public bool SpecialOpen;
    public float SpecialStrength;
}