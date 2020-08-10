using System;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// @author Lpy
/// 简易计时器
/// </summary>
public class QTimer
{
    private bool m_IsRunning;

    private float m_TotalTime;

    private float m_LeftTime;

    private float m_BeginTime;
    public void StartOrReset(float totalTime)
    {
        m_BeginTime = Time.realtimeSinceStartup;
        m_TotalTime = totalTime;
        m_IsRunning = true;
    }
    public bool IsOK()
    {
        return GetPercent()==1;
    }
    public bool IsRuning()
    {
        return m_IsRunning;
    }

    public float GetPercent()
    {
        float duringTime = Time.realtimeSinceStartup - m_BeginTime;
        if (duringTime - m_TotalTime>=float.Epsilon)
        {
            m_IsRunning = false;
            return 1f;
        }
        else
        {
            return duringTime / m_TotalTime;
        }
    }

}
