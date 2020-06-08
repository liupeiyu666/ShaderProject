using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TargetSetting : MonoBehaviour
{
    public Vector3 Offest;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 endPos = Offest + transform.position;
        var tt = Camera.main.worldToCameraMatrix * new Vector4(endPos.x, endPos.y, endPos.z, 1);
        Shader.SetGlobalVector("_TargetPos", tt);
        Debug.LogError("=WorldToScreenPoint===============:" + Camera.main.WorldToViewportPoint(transform.position).x+"   "+ Camera.main.WorldToViewportPoint(transform.position).y
            +"       "+ Camera.main.WorldToViewportPoint(transform.position).z);
       

        Debug.LogError("#####:"+tt.x+"  "+tt.y+"  "+tt.z);
        tt= Camera.main.worldToCameraMatrix*new Vector4(transform.position.x, transform.position.y, transform.position.z,1) ;
        Debug.LogError("----worldToCameraMatrix#####:" + tt.x + "  " + tt.y + "  " + tt.z);
    }
}
