using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestGC : MonoBehaviour
{
    public GameObject temp;
    public int cout;
    // Start is called before the first frame update
    void Start()
    {
        
    }
    List<GameObject> testList = new List<GameObject>();
    List<HHH> testListClass = new List<HHH>();
    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.A))
        {
            for (int i = 0; i < cout; i++)
            {
                testListClass.Add(new HHH());
            }
           
        }
        if (Input.GetKeyDown(KeyCode.B))
        {
            for (int i = 0; i < testList.Count; i++)
            {
                testListClass.Clear();
            }
        }
        for (int i = 0; i < cout; i++)
        {
            testList.Add(Instantiate(temp));
        }
        for (int i = 0; i < testList.Count; i++)
        {
            Destroy(testList[i]);
        }
        testList.Clear();
    }
}
public class HHH
{
    public string aaa;
    public string b;
    public HHHA HHHA = new HHHA();
}
public class HHHA
{
    public HHHB HHHB = new HHHB();
    public string aaa;
    public string b;
}
public class HHHB
{
    public string aaa;
    public string b;
}
