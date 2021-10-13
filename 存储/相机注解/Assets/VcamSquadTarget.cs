using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

public class VcamSquadTarget : MonoBehaviour
{
    public Transform TargetPhone;
    public Vector3 initEuler = Vector3.zero;                    //初始旋转对应欧拉角

    private Quaternion initRotation = Quaternion.identity;

    private Quaternion targetCameraRotation = Quaternion.identity; //摄像机要转向的目标位置

    private Vector3 lastInitEuler = Vector3.zero;              //用于判断初始欧拉角是否变化

    public float vertRotateRateScale = 0f;                      //垂直陀螺仪旋转速率缩放系数

    public float horiRotateRateScale = 0f;                      //水平陀螺仪旋转速率缩放系数

    public float restoreRate = 0.3f;                              //回复速率

    private float maxRotateRate = Mathf.PI;                    //陀螺仪单轴最大旋转速率

    private float factor = 0f;                                  //陀螺仪旋转速率和回复速率间的关联系数(旋转速率越大回复越快)

    private float vertRotateRate = 0f;                          //垂直方向旋转速率

    private float horiRotateRate = 0f;                          //水平方向旋转速率
    /// <summary>
    /// 最大旋转角度
    /// </summary>
    public float MaxAngle = 10f;
    public Transform CC;
    private Quaternion changeeulerAngles = Quaternion.identity; //初始旋转信息
    private Quaternion initCameraRot= Quaternion.identity;
    private Quaternion lerp = Quaternion.identity;//旋转信息
    private Vector3 result = Vector3.zero;
    private Vector3 resultx = Vector3.zero;
    private Vector3 resulty = Vector3.zero;

    private void Awake()
    {
        restoreRate = 0.2f;
    }
    void Init()
    {
        Input.gyro.enabled = true;
        changeeulerAngles = TargetPhone.rotation;// Input.gyro.attitude;
        initCameraRot = transform.rotation;
    }

    /// <summary>

    /// 根据陀螺仪控制主界面mainCamera的旋转

    /// </summary>

    void GetAngle()
    {
        lerp = Quaternion.Inverse(changeeulerAngles) * TargetPhone.rotation;

        Quaternion rotWithoutZ = lerp * Quaternion.Inverse(Quaternion.Euler(0, 0, lerp.eulerAngles.z));
        //--超过90度就会有轴翻转，不处理     
        Vector3 result = rotWithoutZ * Vector3.forward; 
         //--
         var normalX = Mathf.Abs(result.x) > restoreRate ? restoreRate : result.x;
        var normalY = Mathf.Abs(result.y) > restoreRate ? restoreRate : result.y;


        CC.forward = result;
        resultx = result;
        resultx.x = 0;
        resulty = result;
        resulty.y = 0;

        initEuler.x = Vector3.Angle(resultx, result);
        initEuler.y = Vector3.Angle(resulty, result);

        

        Debug.LogError(rotWithoutZ.eulerAngles+"   "+ initEuler+"   "+ result.x+"_"+ result.y+"_"+ result.z + "   "+Vector3.Angle(result, Vector3.forward)+"    "+
            Vector3.Angle(rotWithoutZ*Vector3.up, Vector3.up) +"   "+ Vector3.Angle(rotWithoutZ * Vector3.right, Vector3.right) + "   "+ result);
        float anglex = GetRotAngle(rotWithoutZ.eulerAngles.x, MaxAngle);
        float angley = GetRotAngle(rotWithoutZ.eulerAngles.y, MaxAngle);
        Quaternion rotWithLimit = Quaternion.Euler(anglex,angley ,0);
       
       
        targetCameraRotation = initCameraRot * rotWithLimit;



        //Vector3 axix = Vector3.zero;float rotAngle = 0;
        //lerp.ToAngleAxis(out rotAngle, out axix);
        //Debug.LogError(rotAngle+"    "+ axix+"   "+ lerp.eulerAngles);
        //rotAngle = rotAngle >= 180f ? 360 - rotAngle : rotAngle;
        //if (rotAngle >= 0)
        //{
        //    rotAngle = Mathf.Min(rotAngle, MaxAngle);
        //}
        //else
        //{
        //    rotAngle = Mathf.Max(rotAngle, -MaxAngle);
        //}
        //Quaternion endQuat = Quaternion.AngleAxis(rotAngle, axix);
        //targetCameraRotation = initCameraRot *(endQuat * Quaternion.Inverse(Quaternion.Euler(0, 0, endQuat.eulerAngles.z)));
    }
    float GetRotAngle(float rotAngle, float max)
    {
       
        var tempAngle = rotAngle >= 180f ? rotAngle-360f : rotAngle;
        if (tempAngle >= 0)
        {
            tempAngle = Mathf.Min(tempAngle, max);
        }
        else
        {
            tempAngle = Mathf.Max(tempAngle, -max);
        }
        //  Debug.LogError(rotAngle+"   "+tempAngle + "   " + Time.frameCount);  Debug.LogError(rotAngle+"   "+tempAngle + "   " + Time.frameCount);
        return tempAngle;
    }
    void CameraRotateControl()
    {
        if (!Input.gyro.enabled)
        {
            return;
        }
        GetAngle();//获取旋转角度       
        transform.rotation = Quaternion.Lerp(transform.rotation, targetCameraRotation, 0.5f);
    }

    // Use this for initialization
    public RuntimeAnimatorController controller;
    void Start()
    {
        //Init();
        Animator animator = GetComponent<Animator>();
        Debug.LogError(animator.runtimeAnimatorController.name);
        animator.runtimeAnimatorController = null;
        Debug.LogError("   --------"+animator.runtimeAnimatorController+"    "+gameObject.scene.name);
    }

    // Update is called once per fram

    void Update()
    {
      //  CameraRotateControl();
    }


    void OnGUI()
    {
        float a = 0;
        a = GUI.HorizontalSlider(new Rect(500, 300, 200, 40), a, -1f, 1f);
#if !UNITY_EDITOR
         GUI.Label(new Rect(500, 250, 200, 40),  "initRotation " +initRotation);
         GUI.Label(new Rect(500, 300, 200, 40),  "Input.gyro.attitude.eulerAngles " +Input.gyro.attitude.eulerAngles);
        GUI.Label(new Rect(500, 350, 200, 40), "changeeulerAngles" + changeeulerAngles);
        GUI.Label(new Rect(500, 400, 200, 40), "initEuler" + initEuler);
#endif
    }

}





