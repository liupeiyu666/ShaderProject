using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShadowMapTest : MonoBehaviour
{
    public bool isUpdate;
    public float Speed=1;
    private void Update()
    {
        if (Input.GetKey(KeyCode.A))
        {
            transform.position += transform.forward * Time.deltaTime* Speed;
        }
        if (Input.GetKey(KeyCode.S))
        {
            transform.position += -transform.forward * Time.deltaTime* Speed;
        }
    }
    private void FixedUpdate()
    {
       
    }

    private void OnGUI()
    {
        if (GUI.Button(new Rect(50, 50, 30, 30), "切换为true"))
        {
            Debug.LogError("--------------------------------------------------切换为true："+Time.frameCount);
            isUpdate = true;
        }
        if (GUI.Button(new Rect(50, 100, 30, 30), "切换为false"))
        {
            Debug.LogError("==================================================切换为false:"+Time.frameCount);
            isUpdate = false;
        }
    }
}