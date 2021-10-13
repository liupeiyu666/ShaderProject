using UnityEngine;
public class PeiYuQuaternion
{
    private float x;
    private float y;
    private float z;
    private float w;
    private Quaternion rotWithLimit;

    public PeiYuQuaternion(float x, float y, float z,float w)
    {
        this.x = x;this.y = y;this.z = z;this.w = w;
    }
    public PeiYuQuaternion(float xAngle,float yAngle,float zAngle)
    {
        DoAnlge(xAngle, yAngle, zAngle);
    }



    private void DoAnlge(float xAngle, float yAngle, float zAngle)
    {
        float halfX = xAngle * Mathf.Deg2Rad / 2;
        float halfY = yAngle * Mathf.Deg2Rad / 2;
        float halfZ = zAngle * Mathf.Deg2Rad / 2;
        float cosX = Mathf.Cos(halfX);
        float sinX = Mathf.Sin(halfX);
        float cosY = Mathf.Cos(halfY);
        float sinY = Mathf.Sin(halfY);
        float cosZ = Mathf.Cos(halfZ);
        float sinZ = Mathf.Sin(halfZ);
        w = cosX * cosY * cosZ + sinX * sinY * sinZ;
        x = sinX * cosY * cosZ - cosX * sinY * sinZ;
        y = cosX * sinY * cosZ + sinX * cosY * sinZ;
        z = cosX * cosY * sinZ - sinX * sinY * cosZ;
    }
    public static PeiYuQuaternion Euler(float xAngle, float yAngle, float zAngle)
    {
        PeiYuQuaternion pyq = new PeiYuQuaternion(xAngle, yAngle, zAngle);
        return pyq;
    }
    public static PeiYuQuaternion UnityQuaternion(Quaternion quaternion)
    {
        PeiYuQuaternion pyq = new PeiYuQuaternion(quaternion.x, quaternion.y, quaternion.z, quaternion.w);
        return pyq;
    }
    public Vector3 eulerAngles
    {
        get
        {
            Vector3 result = Vector3.zero;
            result.x = Mathf.Rad2Deg* Mathf.Atan2(2 * (w * x + y * z), 1 - 2 * (x * x + y * y));
            result.y = Mathf.Rad2Deg * Mathf.Asin(2 * (w * y - z * x));
            result.z = Mathf.Rad2Deg * Mathf.Atan2(2 * (w * z + x * y), 1 - 2 * (y * y + z * z));
            return result;
        }
        set {
            DoAnlge(value.x, eulerAngles.y, eulerAngles.z);
        }
    }
    public override string ToString()
    {
        Vector3 euler = eulerAngles;
        return string.Format("x:{0}-y:{1}-z:{2}-w:{3}   Euler:x:{4}-y:{5}-z:{6}",x,y,z,w, euler.x, euler.y, euler.z);
    }
}