using UnityEngine;
using Cinemachine.Utility;
public class RootMotionTest : MonoBehaviour
{
    //public Transform rootBone;
    //public Transform A;
    //public Transform C;
    //public Transform D;
    //public bool UseSelf;
    //public float cash= 85000f;

    private void Start()
    {
        Matrix4x4 swl = Matrix4x4.TRS(Vector3.zero,
                    this.transform.rotation, Vector3.one);
        Quaternion localToWorld = this.gameObject.transform.rotation;
        Quaternion worldToLocal = Quaternion.Inverse(localToWorld);
        //--上一帧相机的位置，转化到相机空间的位置
        Vector3 temp= new Vector3(1, 1, 0);
        Vector3 cameraPos = worldToLocal * temp;
        
        Debug.LogError(swl.inverse.MultiplyPoint3x4(temp) +"    "+ cameraPos);
    }





    public Transform AA;
    public Transform BB;
    public Transform CC;

    public Transform DD;
    void Update()
    {
        //Vector3 screenPos= Input.mousePosition;
        //Vector3 viewPos= Camera.main.ScreenToViewportPoint(screenPos);
        //Vector3 worldPos = Camera.main.ScreenToWorldPoint(screenPos);
        //Vector3 camearLocal = Camera.main.transform.worldToLocalMatrix.MultiplyPoint3x4(worldPos);
        //Debug.LogError("screenPos:"+ screenPos+ "  viewPos:"+ viewPos+ "   worldPos:" + worldPos+ "    camearLocal:" + camearLocal);

        if (Input.GetKeyDown(KeyCode.A))
        {
            Matrix4x4 matrix = Matrix4x4.Perspective(Camera.main.fieldOfView,Camera.main.aspect,Camera.main.nearClipPlane,Camera.main.farClipPlane);
            Matrix4x4 inMatrix = matrix.inverse;
            Debug.LogError(matrix.MultiplyPoint3x4(AA.transform.position)+"   "+ inMatrix.MultiplyPoint3x4(AA.transform.position) + "   " + Camera.main.WorldToViewportPoint(AA.transform.position)+"    "+ Camera.main.WorldToScreenPoint(AA.transform.position) +"    "+Camera.main.worldToCameraMatrix.MultiplyPoint3x4(AA.transform.position));            

            //Bounds bounds = new Bounds(AA.transform.position, AA.transform.lossyScale);
            //bounds.Encapsulate(new Bounds(BB.transform.position, BB.transform.lossyScale));
            //bounds.Encapsulate(new Bounds(CC.transform.position, CC.transform.lossyScale));
            //Vector3 fwd = Camera.main.transform.rotation * Vector3.forward;
            ////--构建以相机为起始坐标的Bounds的矩阵
            //Matrix4x4 mat = Matrix4x4.TRS(
            //        bounds.center - (fwd * bounds.extents.magnitude),
            //        Camera.main.transform.rotation, Vector3.one);
            //Matrix4x4 mmm = mat.inverse;
            //Bounds inversBounds = new Bounds(mmm.MultiplyPoint3x4(AA.transform.position), AA.transform.lossyScale);
            //inversBounds.Encapsulate(new Bounds(mmm.MultiplyPoint3x4(BB.transform.position), BB.transform.lossyScale));
            //inversBounds.Encapsulate(new Bounds(mmm.MultiplyPoint3x4(CC.transform.position), CC.transform.lossyScale));

            //Bounds matBounds = new Bounds(mat.MultiplyPoint3x4(AA.transform.position), AA.transform.lossyScale);
            //matBounds.Encapsulate(new Bounds(mat.MultiplyPoint3x4(BB.transform.position), BB.transform.lossyScale));
            //matBounds.Encapsulate(new Bounds(mat.MultiplyPoint3x4(CC.transform.position), CC.transform.lossyScale));

            //Debug.LogError(bounds + "    "+ inversBounds+"    "+ matBounds);
            //Debug.LogError(mat.MultiplyPoint3x4(Vector3.zero) + "    " + mmm.MultiplyPoint3x4(Vector3.zero) + "   " + mat.rotation.eulerAngles + "   " + mmm.rotation.eulerAngles + "    " + mat.lossyScale + "    " + mmm.lossyScale);
            //    ttt.MultiplyPoint3x4(Vector3.zero) + "   " + ttt.rotation.eulerAngles + "    " + ttt.lossyScale);

            //Matrix4x4 mat = Matrix4x4.TRS(AA.transform.position,AA.transform.rotation,AA.transform.localScale);

            //var ttt= mat* mmm;
            //Debug.LogError(mat.MultiplyPoint3x4(Vector3.zero)+"    "+mmm.MultiplyPoint3x4(Vector3.zero)+"   "+mat.rotation.eulerAngles+"   "+mmm.rotation.eulerAngles+"    "+mat.lossyScale+"    "+mmm.lossyScale+"   "+
            //    ttt.MultiplyPoint3x4(Vector3.zero) + "   " + ttt.rotation.eulerAngles + "    " + ttt.lossyScale);


            //Debug.LogError(mat.MultiplyPoint3x4(BB.transform.localPosition)+"    "+ mat.MultiplyPoint3x4(BB.transform.position)+"     "+ mmm.MultiplyPoint3x4(BB.transform.localPosition) + "    " + mmm.MultiplyPoint3x4(BB.transform.position)) ;
        }

    }
    private void OnGUI()
    {

        
    }

}
