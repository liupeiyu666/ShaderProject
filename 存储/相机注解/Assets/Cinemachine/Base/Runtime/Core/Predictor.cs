using System;
using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine.Utility
{
    /// <summary>
    /// λ��Ԥ����
    /// </summary>
    internal class PositionPredictor
    {
        Vector3 m_Position;

        const float kSmoothingDefault = 10;
        float mSmoothing = kSmoothingDefault;
        /// <summary>
        /// ��̫�ֲ��ķ���
        /// </summary>
        public float Smoothing 
        {
            get { return mSmoothing; }
            set 
            {
                if (value != mSmoothing)
                {
                    //--����ƽ��ֵ�����ٶȺͼ��ٶ�
                    mSmoothing = value;
                    int maxRadius = Mathf.Max(10, Mathf.FloorToInt(value * 1.5f));
                    //--�ٶ���̫�ֲ�����
                    m_Velocity = new GaussianWindow1D_Vector3(mSmoothing, maxRadius);
                    //--���ٶ���̫�ֲ�����
                    m_Accel = new GaussianWindow1D_Vector3(mSmoothing, maxRadius);
                }
            }
        }

        GaussianWindow1D_Vector3 m_Velocity = new GaussianWindow1D_Vector3(kSmoothingDefault);
        GaussianWindow1D_Vector3 m_Accel = new GaussianWindow1D_Vector3(kSmoothingDefault);
        /// <summary>
        /// ��̫�ֲ��������Ƿ�Ϊ��
        /// </summary>
        public bool IsEmpty { get { return m_Velocity.IsEmpty(); } }

        public void Reset()
        {
            m_Velocity.Reset();
            m_Accel.Reset();
        }

        public void AddPosition(Vector3 pos)
        {
            //���Ϊ�գ����������
            if (IsEmpty)
                m_Velocity.AddValue(Vector3.zero);
            else
            {
                //��һ�ε��ٶ�
                Vector3 vel = m_Velocity.Value();
                //��ǰ���ٶȣ�·��/ʱ��=�ٶ�
                Vector3 vel2 = (pos - m_Position) / Time.deltaTime;
                //����ٶ�����ͳ�ƣ������˷���
                m_Velocity.AddValue(vel2);
                //��Ӽ��ٶ�����ͳ��
                m_Accel.AddValue(vel2 - vel);
            }
            //��¼λ��
            m_Position = pos;
        }
        /// <summary>
        /// λ��Ԥ��
        /// </summary>
        /// <param name="lookaheadTime">Ԥ��೤ʱ���</param>
        /// <returns></returns>
        public Vector3 PredictPosition(float lookaheadTime)
        {
            //--����Ԥ��ʱ����ҪԤ�ƵĲ���
            int numSteps = Mathf.Min(Mathf.RoundToInt(lookaheadTime / Time.deltaTime), 6);
            //--ÿһ��ҪԤ��ʱ��
            float dt = lookaheadTime / numSteps;
            Vector3 pos = m_Position;
            //������̫�ֲ���ȡ��ǰ���ٶ�
            Vector3 vel = m_Velocity.IsEmpty() ? Vector3.zero : m_Velocity.Value();
            //������̫�ֲ���ȡ��ǰ�ļ��ٶ�
            Vector3 accel = m_Accel.IsEmpty() ? Vector3.zero : m_Accel.Value();
            for (int i = 0; i < numSteps; ++i)
            {
                //--��ǰλ�õ���ÿһ�������ߵ�λ��
                pos += vel * dt;
                //--������һ�����ٶ�Ԥ��
                Vector3 vel2 = vel + (accel * dt);
                //-��Ҫ������Ҳ����һ�ε��ӣ�����ÿһ�μ��ٶȷ��򶼻�͵�һ��һ��
                //-�������Ҳ���գ���Ϊ��ÿ��Ԥ��ʱ��Ӳ�����ô����ΪnumSteps��СֵΪ6����ve1��vel2�ļн�С
                //��30��ʱ����ʱ�˶��켣��һ������
                accel = Quaternion.FromToRotation(vel, vel2) * accel;
                vel = vel2;
            }
            //-��������λ��
            return pos;
        }
    }

    /// <summary>Utility to perform realistic damping of float or Vector3 values.
    /// The algorithm is based on exponentially decaying the delta until only
    /// a negligible amount remains.</summary>
    public static class Damper
    {
        const float Epsilon = UnityVectorExtensions.Epsilon;

        //��ȡ˥��ϵ��       
        public static float DecayConstant(float time, float residual)
        {
            return Mathf.Log(1f / residual) / time;
        }

        // ��ɢ˥����
        public static float Decay(float initial, float decayConstant, float deltaTime)
        {
            return initial /  Mathf.Exp(decayConstant * deltaTime);
        }

        /// <summary>��׼˥��</summary>
        public const float kNegligibleResidual = 0.01f;

        /// <summary>
        /// ����˥��
        /// </summary>
        /// <param name="initial">��Ҫ˥������</param>
        /// <param name="dampTime">Ҫ�ڶ���ʱ������� ˥��</param>
        /// <param name="deltaTime">����ʱ��</param>
        /// <returns></returns>
        public static float Damp(float initial, float dampTime, float deltaTime)
        {
            if (dampTime < Epsilon || Mathf.Abs(initial) < Epsilon)
                return initial;
            if (deltaTime < Epsilon)
                return 0;
            return initial - Decay(
                initial, DecayConstant(dampTime, kNegligibleResidual), deltaTime);
        }
        public static Vector3 Damp(Vector3 initial, Vector3 dampTime, float deltaTime)
        {
            for (int i = 0; i < 3; ++i)
                initial[i] = Damp(initial[i], dampTime[i], deltaTime);
            return initial;
        }
        public static Vector3 Damp(Vector3 initial, float dampTime, float deltaTime)
        {
            for (int i = 0; i < 3; ++i)
                initial[i] = Damp(initial[i], dampTime, deltaTime);
            return initial;
        }
    }
}
