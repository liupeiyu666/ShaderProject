using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rot : MonoBehaviour
{
    public Vector3 rotation;
    // Start is called before the first frame update
    void Start()
    {        
        Array aa = new Array[1,2,3];
        ArrayList arrayList = new ArrayList();
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(rotation,Space.World);
    }
}
