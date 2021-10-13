using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Internal;

public class CoroutineManager : MonoBehaviour
{
    public static CoroutineManager Instance { get; private set; }
    private void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
        }
        CoroutineTest ct =new CoroutineTest();
        ct.Start();
    }
    public new Coroutine StartCoroutine(IEnumerator routine)
    {
        return base.StartCoroutine(routine);
    }
    [Obsolete("无法使用此方法开启协程", true)]
    public new Coroutine StartCoroutine(string methodName)
    {
        return null;
    }
    [Obsolete("无法使用此方法开启协程", true)]
    public new Coroutine StartCoroutine(string methodName, [DefaultValue("null")] object value)
    {
        return null;
    }
    public new void  StopCoroutine(IEnumerator routine)
    {
        base.StopCoroutine(routine);
    }
    public new void StopCoroutine(Coroutine routine)
    {
        base.StopCoroutine(routine);
    }
    [Obsolete("无法使用此方法关闭协程", true)]
    public new void StopCoroutine(string methodName)
    {
        
    }

}






//public bool start;
//Coroutine coroutineA;
//Coroutine coroutineB;
//// Start is called before the first frame update

//void Start()
//{
//    Coroutine A = StartCoroutine("OneParamCoratiune", "A");
//    //Coroutine B = StartCoroutine("OneParamCoratiune", "B");
//    //IEnumerator EI = OneParamCoratiune("C");
//    //Coroutine E = StartCoroutine(EI);
//    //IEnumerator FI = OneParamCoratiune("D");
//    //Coroutine F = StartCoroutine(FI);
//    //StopCoroutine(B);
//    //StopCoroutine(E);
//    //StartCoroutine(TestParamCoratiune());
//    Debug.LogError("Start:" + Time.frameCount);
//    StartCoroutine(TestCoratiune());

//    CoroutineTest ct = new CoroutineTest();
//    CoroutineTestTwo ctt = new CoroutineTestTwo();
//    ct.Start();
//    ctt.Start();
//}
//IEnumerator TestParamCoratiune()
//{
//    float a = Time.realtimeSinceStartup;
//    Debug.LogError("Begin:" + name);
//    yield return new WaitUntil(() =>
//    {
//        Debug.LogError("WaitWhile:" + name + "   " + Time.frameCount);
//        if (Time.realtimeSinceStartup - a > 3)
//        {
//            return true;
//        }
//        return false;
//    });
//    Debug.LogError("End:" + name);
//}
//IEnumerator OneParamCoratiune(string name)
//{ Debug.LogError("Begin:" + name); yield return 0.3f; Debug.LogError("End:" + name); }
////IEnumerator OneParamCoratiune()
////{ Debug.LogError("SelfBegin:"); yield return 0.3f; Debug.LogError("SelfEnd"); }
////IEnumerator NoParamCoratiune()
////{ Debug.LogError("NoParamCoratiune:"); yield return 0.3f; Debug.LogError("NoParamCoratiuneEnd"); }

//void Update()
//{
//    if (Input.GetKeyDown(KeyCode.A))
//    {
//        StartCoroutine(TestCoratiune());
//        // StopCoroutine("OneParamCoratiune");
//        // StartCoroutine(TestCoratiune());
//    }
//    //Debug.LogError("Update--:" + Time.frameCount);
//}
//private void LateUpdate()
//{

//    // Debug.LogError("LateUpdate--:" + Time.frameCount);
//}
//private void FixedUpdate()
//{
//    // Debug.LogError("FixedUpdate--:" + Time.frameCount);
//}
//IEnumerator TestCoratiune()
//{

//    yield return new MyCoroutine(1);
//}
///// <summary>
///// 协程，等待多少帧后继续
///// </summary>
//public class MyCoroutine : CustomYieldInstruction
//{
//    private int waitFrameCount;
//    private int startFrameCount;
//    public MyCoroutine(int framCount)
//    {
//        waitFrameCount = framCount;
//        startFrameCount = Time.frameCount;
//    }
//    public override bool keepWaiting
//    {
//        get
//        {
//            return Time.frameCount - startFrameCount < waitFrameCount;
//        }
//    }
//}
