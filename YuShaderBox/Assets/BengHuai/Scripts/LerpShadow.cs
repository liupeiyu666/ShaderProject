using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
/// <summary>
/// @author Lpy
/// 设置角色的明暗过度，使变化更具有动感.
/// 设置阴影的偏移矩阵，只要有数值变化就会在规定时间内完成此次变化。
/// </summary>
public class LerpShadow : MonoBehaviour
{
    public GameObject myGo;

    public float lerpTime = 1f;
    /// <summary>
    /// 超过多少角度后就会执行角度跟随，这个值只能小于180
    /// </summary>
    public float LimitValue = 60;
    private Matrix4x4 rotMaxtrix;
    private Material myMat;

    private Vector3 recordAngle;
    private Vector3 preFrameAngle;
    private float recordChangeAngle;
    /// <summary>
    /// 记录当前的系数
    /// </summary>
    private int recordRadio = 0;
    private QTimer qTimer = new QTimer();
    // Start is called before the first frame update
    void Start()
    {
        recordAngle = transform.eulerAngles;
        preFrameAngle= transform.eulerAngles;
        recordRadio = 0;
        recordChangeAngle = 0;
    }
    private void OnEnable()
    {
        recordAngle = transform.eulerAngles;
        preFrameAngle = transform.eulerAngles;
        recordRadio = 0;
        recordChangeAngle = 0;
    }
    // Update is called once per frame
    void Update()
    {
        if (!myMat)
        {
            myMat = myGo.GetComponent<MeshRenderer>().material;
        }
        float betweenAngle = GetRealAngle(transform.eulerAngles.y, preFrameAngle.y);
        if (Mathf.Abs(betweenAngle)  > float.Epsilon)
        {
            qTimer.StartOrReset(lerpTime);
         
        }
        if (qTimer.IsRuning())
        {
            if (qTimer.IsOK())
            {
                recordAngle = transform.eulerAngles;
                recordRadio = 0;
                recordChangeAngle = 0;
            }
            else
            {
                float angleToRecord = GetRealAngle(recordAngle.y, transform.eulerAngles.y);



                //if (Mathf.Abs(angleToRecord) >= LimitValue)
                //{
                //    //如果夹角大于了限定角度，直接设置到限定角度
                //    float radio = angleToRecord >= 0 ? 1 : -1;
                //    float toAngle = (Mathf.Abs(angleToRecord)-LimitValue) * radio;
                //    myMat.SetMatrix("_TempLightPos", GetMatrix(new Vector3(0, -toAngle, 0)));
                //    //同时重新设定计时器和记录的角度
                //    qTimer.StartOrReset(lerpTime);
                //  //  recordAngle = (Quaternion.Euler(0, transform.eulerAngles.y, 0) * Quaternion.Euler(0, LimitValue * radio, 0)).eulerAngles;
                //  //  Debug.LogError("-----:"+ transform.eulerAngles.y+"  "+ recordAngle.y);
                //}
                //else
                //{
                //    float deltaAngle = angleToRecord * (1 - qTimer.GetPercent());
                //    myMat.SetMatrix("_TempLightPos", GetMatrix(new Vector3(0, deltaAngle, 0)));
                //}

                //如果是符号发生了变化，那就说明已经转了180度了,如果当前已经是超出最大角度了，则不进行其他处理
                //还有一种情况，就是转了一个大圈，转回来了，这种需要记录知道上一个记录的角度和现在的角度

                //1.突变不予理会，假定突变角度为60，则认为任何超过60度突变的行为，都不会影响此次衰减，正常的操作
                //都会是有过程的。没有过程的操作不建议使用这种衰减。

                int radio = angleToRecord >= 0 ? 1 : -1;
                float deltaAngle = 0;
                if (recordRadio == 0)
                {
                    recordRadio = radio;
                    recordChangeAngle = radio * Mathf.Min(angleToRecord * radio, LimitValue);
                    deltaAngle =  recordChangeAngle * (1 - qTimer.GetPercent());
                    
                }
                else
                {
                    //符号反向，或者符号相同，数值变小，我们认为是逆向旋转，只要是逆向旋转，都认为是突变
                    if (recordRadio != radio)
                    {
                        //有可能的一种情况是先转了5，然后反向转到-5，也是符号相反了
                        //说明一应超过了一定角度了，继续使用最大角度
                        deltaAngle = recordRadio * LimitValue * (1 - qTimer.GetPercent());
                        recordChangeAngle = recordRadio * LimitValue;
                    }
                    else
                    {
                        recordChangeAngle = radio * Mathf.Min(angleToRecord * radio, LimitValue);
                        //当转动了一大圈回来之后，如果跟记录的数据差距很大则忽略影响
                        //比如，上一次是56，转了330度后，变成26度。如果不做限制，就会变成从56到26的突变。
                        //那我们如何确定突变数值，我们认为一帧的变化数据不能超过LimitValue*0.04的角度，凡是超过了这个角度
                        //的突变，都是无效的变化。继续执行上一次的数据
                        deltaAngle = recordChangeAngle * (1 - qTimer.GetPercent());
                    }
                }
                
                Debug.LogError("=============:"+ angleToRecord +"    "+ deltaAngle+"  "+Time.frameCount);
                myMat.SetMatrix("_TempLightPos", GetMatrix(new Vector3(0, deltaAngle, 0)));
                
            }
        }
        preFrameAngle = transform.eulerAngles; 
    }
    float GetRealAngle(float a,float b)
    {       
        float result = Quaternion.Angle(Quaternion.Euler(0, a, 0), Quaternion.Euler(0, b, 0));
        Quaternion qa= Quaternion.LookRotation(Vector3.one,Vector3.up);
        Vector3 forwadA = (qa * Quaternion.Euler(0, a, 0))*Vector3.forward;
        Vector3 forwadB = qa * Quaternion.Euler(0, b, 0) * Vector3.forward;
        float tangle= Vector3.Angle(forwadA, forwadB);
        tangle *= Vector3.Cross(forwadA, forwadB).y>=0?1:-1;
        return tangle;
    }
    Matrix4x4 GetMatrix(Vector3 pangle)
    {
        rotMaxtrix.m00 = Mathf.Cos(pangle.y * Mathf.Deg2Rad);
        rotMaxtrix.m02 = Mathf.Sin(pangle.y * Mathf.Deg2Rad);
        rotMaxtrix.m11 = 1;
        rotMaxtrix.m20 = -Mathf.Sin(pangle.y * Mathf.Deg2Rad);
        rotMaxtrix.m22 = Mathf.Cos(pangle.y * Mathf.Deg2Rad);
        rotMaxtrix.m33 = 1;
        return rotMaxtrix;
    }
}

