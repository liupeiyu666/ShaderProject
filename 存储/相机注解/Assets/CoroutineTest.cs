using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

public class CoroutineTest
{
    public void Start()
    {
        CoroutineManager.Instance?.StartCoroutine(TestParamCoratiune("A"));
        CoroutineManager.Instance?.StartCoroutine(TestParamCoratiune("B"));
    }
    IEnumerator TestParamCoratiune(string name)
    {
        float a = Time.realtimeSinceStartup;
        Debug.LogError("Begin:" + name+"   "+Time.frameCount);
        yield return Vector3.one;
        Debug.LogError("End:" + name + "   " + Time.frameCount);
    }
}
public class CoroutineTestTwo
{
    public void Start()
    {
        var CC = TestParamCoratiune("C");
        CoroutineManager.Instance?.StartCoroutine(CC);
        CoroutineManager.Instance?.StartCoroutine(TestParamCoratiune("D"));
        CoroutineManager.Instance?.StopCoroutine(CC);
    }
    IEnumerator TestParamCoratiune(string name)
    {
        float a = Time.realtimeSinceStartup;
        Debug.LogError("Begin:" + name);
        yield return new WaitForSeconds(0.3f);
        Debug.LogError("End:" + name);
    }
}