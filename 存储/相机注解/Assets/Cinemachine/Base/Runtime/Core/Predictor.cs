using System;
using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine.Utility
{
    /// <summary>
    /// 位置预测器
    /// </summary>
    internal class PositionPredictor
    {
        Vector3 m_Position;

        const float kSmoothingDefault = 10;
        float mSmoothing = kSmoothingDefault;
        /// <summary>
        /// 正太分布的方差
        /// </summary>
        public float Smoothing 
        {
            get { return mSmoothing; }
            set 
            {
                if (value != mSmoothing)
                {
                    //--根据平滑值计算速度和加速度
                    mSmoothing = value;
                    int maxRadius = Mathf.Max(10, Mathf.FloorToInt(value * 1.5f));
                    //--速度正太分布计算
                    m_Velocity = new GaussianWindow1D_Vector3(mSmoothing, maxRadius);
                    //--加速度正太分布计算
                    m_Accel = new GaussianWindow1D_Vector3(mSmoothing, maxRadius);
                }
            }
        }

        GaussianWindow1D_Vector3 m_Velocity = new GaussianWindow1D_Vector3(kSmoothingDefault);
        GaussianWindow1D_Vector3 m_Accel = new GaussianWindow1D_Vector3(kSmoothingDefault);
        /// <summary>
        /// 正太分布的数据是否为空
        /// </summary>
        public bool IsEmpty { get { return m_Velocity.IsEmpty(); } }

        public void Reset()
        {
            m_Velocity.Reset();
            m_Accel.Reset();
        }

        public void AddPosition(Vector3 pos)
        {
            //如果为空，先添加数据
            if (IsEmpty)
                m_Velocity.AddValue(Vector3.zero);
            else
            {
                //上一次的速度
                Vector3 vel = m_Velocity.Value();
                //当前的速度，路程/时间=速度
                Vector3 vel2 = (pos - m_Position) / Time.deltaTime;
                //添加速度数据统计，包含了方向
                m_Velocity.AddValue(vel2);
                //添加加速度数据统计
                m_Accel.AddValue(vel2 - vel);
            }
            //记录位置
            m_Position = pos;
        }
        /// <summary>
        /// 位置预测
        /// </summary>
        /// <param name="lookaheadTime">预测多长时间后</param>
        /// <returns></returns>
        public Vector3 PredictPosition(float lookaheadTime)
        {
            //--根据预测时间获得要预计的步长
            int numSteps = Mathf.Min(Mathf.RoundToInt(lookaheadTime / Time.deltaTime), 6);
            //--每一步要预测时长
            float dt = lookaheadTime / numSteps;
            Vector3 pos = m_Position;
            //根据正太分布获取当前的速度
            Vector3 vel = m_Velocity.IsEmpty() ? Vector3.zero : m_Velocity.Value();
            //根据正太分布获取当前的加速度
            Vector3 accel = m_Accel.IsEmpty() ? Vector3.zero : m_Accel.Value();
            for (int i = 0; i < numSteps; ++i)
            {
                //--当前位置叠加每一步的行走的位置
                pos += vel * dt;
                //--计算下一步的速度预测
                Vector3 vel2 = vel + (accel * dt);
                //-需要将方向也进行一次叠加，否则每一次加速度方向都会和第一次一样
                //-这个操作也是谜，是为了每次预测时添加波动性么？因为numSteps最小值为6，当ve1与vel2的夹角小
                //于30度时，此时运动轨迹是一个弧线
                accel = Quaternion.FromToRotation(vel, vel2) * accel;
                vel = vel2;
            }
            //-返回最终位置
            return pos;
        }
    }

    /// <summary>Utility to perform realistic damping of float or Vector3 values.
    /// The algorithm is based on exponentially decaying the delta until only
    /// a negligible amount remains.</summary>
    public static class Damper
    {
        const float Epsilon = UnityVectorExtensions.Epsilon;

        //获取衰减系数       
        public static float DecayConstant(float time, float residual)
        {
            return Mathf.Log(1f / residual) / time;
        }

        // 就散衰减量
        public static float Decay(float initial, float decayConstant, float deltaTime)
        {
            return initial /  Mathf.Exp(decayConstant * deltaTime);
        }

        /// <summary>标准衰减</summary>
        public const float kNegligibleResidual = 0.01f;

        /// <summary>
        /// 计算衰减
        /// </summary>
        /// <param name="initial">想要衰减的量</param>
        /// <param name="dampTime">要在多少时间内完成 衰减</param>
        /// <param name="deltaTime">单次时间</param>
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
