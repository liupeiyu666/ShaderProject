using System;
using UnityEngine;

namespace Cinemachine.Utility
{
    internal abstract class GaussianWindow1d<T>
    {
        /// <summary>
        /// 当前存储的数据
        /// </summary>
        protected T[] mData;
        /// <summary>
        /// 存储正太分布曲线数据
        /// </summary>
        protected float[] mKernel;
        /// <summary>
        /// 指定区域内正太分布的概率
        /// </summary>
        protected float mKernelSum;
        /// <summary>
        /// 
        /// </summary>
        protected int mCurrentPos;
        /// <summary>
        /// 方差
        /// </summary>
        public float Sigma { get; private set; }   // Filter strength: bigger numbers are stronger.  0.5 is minimal.
        /// <summary>
        /// 获取数据的长度
        /// </summary>
        public int KernelSize { get { return mKernel.Length; } }
        /// <summary>
        /// 根据中间值和方差sigma来计算正太分布曲线
        /// </summary>
        /// <param name="sigma"></param>
        /// <param name="maxKernelRadius"></param>
        void GenerateKernel(float sigma, int maxKernelRadius)
        {
            // Weight is close to 0 at a distance of sigma*3, so let's just cut it off a little early
            //--步长计算
            int kernelRadius = Math.Min(maxKernelRadius, Mathf.FloorToInt(Mathf.Abs(sigma) * 2.5f));
            mKernel = new float[2 * kernelRadius + 1];
            mKernelSum = 0;
            if (kernelRadius == 0)
                mKernelSum = mKernel[0] = 1;
            else for (int i = -kernelRadius; i <= kernelRadius; ++i)
            {
                mKernel[i + kernelRadius]
                    = (float)(Math.Exp(-(i * i) / (2 * sigma * sigma)) / Math.Sqrt(2.0 * Math.PI * sigma));
                mKernelSum += mKernel[i + kernelRadius];
            }
            Sigma = sigma;
        }

        protected abstract T Compute(int windowPos);

        public GaussianWindow1d(float sigma, int maxKernelRadius = 10)
        {
            GenerateKernel(sigma, maxKernelRadius);
            mCurrentPos = 0;
        }

        public void Reset() { mData = null; }

        public bool IsEmpty() { return mData == null; }

        public void AddValue(T v)
        {
            //--添加数据，设置数据存储量为正太分布的数据存储的概率区间
            if (mData == null)
            {
                mData = new T[KernelSize];
                for (int i = 0; i < KernelSize; ++i)
                    mData[i] = v;
                mCurrentPos = Mathf.Min(1, KernelSize-1);
            }
            //--存储这个数据
            mData[mCurrentPos] = v;
            //--当存储的数据超过了最大容量则重新存储
            if (++mCurrentPos == KernelSize)
                mCurrentPos = 0;
        }

        public T Filter(T v)
        {
            //--如果正太分布数量小于三，直接返回
            if (KernelSize < 3)
                return v;
            AddValue(v);
            return Value();    
        }

        /// Returned value will be kernelRadius old
        /// 返回数据
        public T Value() { return Compute(mCurrentPos); }
    }
    /// <summary>
    /// Vector3类型的正太分布
    /// </summary>
    internal class GaussianWindow1D_Vector3 : GaussianWindow1d<Vector3>
    {
        public GaussianWindow1D_Vector3(float sigma, int maxKernelRadius = 10)
            : base(sigma, maxKernelRadius) {}

        protected override Vector3 Compute(int windowPos)
        {
            Vector3 sum = Vector3.zero;
            ///根据正太分布求出平均值
            for (int i = 0; i < KernelSize; ++i)
            {
                sum += mData[windowPos] * mKernel[i];
                if (++windowPos == KernelSize)
                    windowPos = 0;
            }
            return sum / mKernelSum;
        }
    }

    internal class GaussianWindow1D_Quaternion : GaussianWindow1d<Quaternion>
    {
        public GaussianWindow1D_Quaternion(float sigma, int maxKernelRadius = 10)
            : base(sigma, maxKernelRadius) {}
        protected override Quaternion Compute(int windowPos)
        {
            Quaternion sum = new Quaternion(0, 0, 0, 0);
            Quaternion q = mData[mCurrentPos];
            Quaternion qInverse = Quaternion.Inverse(q);
            for (int i = 0; i < KernelSize; ++i)
            {
                // Make sure the quaternion is in the same hemisphere, or averaging won't work
                float scale = mKernel[i];
                Quaternion q2 = qInverse * mData[windowPos];
                if (Quaternion.Dot(Quaternion.identity, q2) < 0)
                    scale = -scale;
                sum.x += q2.x * scale;
                sum.y += q2.y * scale;
                sum.z += q2.z * scale;
                sum.w += q2.w * scale;

                if (++windowPos == KernelSize)
                    windowPos = 0;
            }
            return q * sum;
        }
    }

    internal class GaussianWindow1D_CameraRotation : GaussianWindow1d<Vector2>
    {
        public GaussianWindow1D_CameraRotation(float sigma, int maxKernelRadius = 10)
            : base(sigma, maxKernelRadius) {}

        protected override Vector2 Compute(int windowPos)
        {
            Vector2 sum = Vector2.zero;
            Vector2 v = mData[mCurrentPos];
            for (int i = 0; i < KernelSize; ++i)
            {
                Vector2 v2 = mData[windowPos] - v;
                if (v2.y > 180f)
                    v2.y -= 360f;
                if (v2.y < -180f)
                    v2.y += 360f;
                sum += v2 * mKernel[i];
                if (++windowPos == KernelSize)
                    windowPos = 0;
            }
            return v + (sum / mKernelSum);
        }
    }
}
