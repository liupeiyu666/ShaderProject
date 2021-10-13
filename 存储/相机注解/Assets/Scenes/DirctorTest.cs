using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.Playables;

public class DirctorTest : MonoBehaviour
{
    public PlayableDirector playableDirector;
    public float Speed = 1;
    // Start is called before the first frame update
    private void Awake()
    {
        Debug.LogError("Awake");
    }
    private void OnEnable()
    {
        Debug.LogError("OnEnable");
    }
    private void OnDisable()
    {
        Debug.LogError("OnDisable");
    }
    void Start()
    {
        ColorGrading colorGrading11 = new ColorGrading();
        Type dd = typeof(FloatParameter);
        if (colorGrading11.toneCurveToeStrength.GetType() == typeof(FloatParameter))
        {

        }
        object colorGrading = colorGrading11;
        BindingFlags bindingAttr = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;      
        FieldInfo fi= colorGrading.GetType().GetField("toneCurveToeStrength");
        object paramValue = fi.GetValue(colorGrading);
        
        FieldInfo fiValue = fi.FieldType.GetField("value");
        FieldInfo fiState = fi.FieldType.GetField("overrideState");
        Debug.LogError(fiValue.GetValue(paramValue) +"    "+ fiState.GetValue(paramValue)) ; 
    }

    // Update is called once per frame
    void Update()
    {
       // Debug.LogError("*********:" + playableDirector.playableGraph.IsValid());
       // Debug.LogError("=========:"+ playableDirector.playableGraph.ToString());
        //playableDirector.playableGraph.GetRootPlayable(0).SetSpeed(Speed);

    }
}
public abstract class ParameterOverride
{
    public bool overrideState;
}
public class ParameterOverride<T> : ParameterOverride
{
    public T value;
    public ParameterOverride()
           : this(default(T), false)
    {
    }
    public ParameterOverride(T value)
    : this(value, false)
    {
    }
    public ParameterOverride(T value, bool overrideState)
    {
        this.value = value;
        this.overrideState = overrideState;
    }
}
public sealed class FloatParameter : ParameterOverride<float>
{
    
}
public sealed class ColorGrading
{
    public FloatParameter toneCurveToeStrength = new FloatParameter { value = 10f };
}






