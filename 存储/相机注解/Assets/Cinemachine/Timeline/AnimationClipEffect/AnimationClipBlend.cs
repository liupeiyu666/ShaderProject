using System;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

namespace Common.Playables
{
    /// <summary>
    /// @Author Lpy 自定义动画混合，及其权重
    /// </summary>
    public class AnimationClipBlend
    {
        private Func<float[]> updateWeightFunc;
        private AnimationMixerPlayable m_Mixer;
        private bool initSucess;
        AnimationClipPlayable[] clipPlayables;

        PlayableGraph m_Graph;
        public AnimationClipBlend(GameObject gameObject, AnimationClip[] animationClips, Func<float[]> initWeightFunc, Func<float[]> updateWeightFunc)
        {
            if (gameObject==null||(animationClips==null|| animationClips.Length<=0))
            {
                initSucess = false;
                return;
            }
            initSucess = true;
            this.updateWeightFunc = updateWeightFunc;

            Animator animator = gameObject.GetComponent<Animator>();
            if (animator==null)
            {
                animator = gameObject.AddComponent<Animator>();
            }

            m_Graph = PlayableGraph.Create("CustomAnimationClipBlend");
            m_Graph.SetTimeUpdateMode(DirectorUpdateMode.Manual);
            AnimationPlayableOutput m_Output = AnimationPlayableOutput.Create(m_Graph, "Animation", animator);

            m_Mixer = AnimationMixerPlayable.Create(m_Graph, animationClips.Length);
            m_Output.SetSourcePlayable(m_Mixer);
            clipPlayables = new AnimationClipPlayable[animationClips.Length];
            for (int i = 0; i < animationClips.Length; i++)
            {
                AnimationClipPlayable clipPlayable = AnimationClipPlayable.Create(m_Graph, animationClips[i]);
                clipPlayables[i] = clipPlayable;
                m_Graph.Connect(clipPlayable, 0, m_Mixer, i);
                m_Mixer.SetInputWeight(i, 0);                
            }
            if (initWeightFunc != null)
            {
                SetWeights(initWeightFunc.Invoke());
            }
            else
            {
                m_Mixer.SetInputWeight(0, 1); 
            }
        }
        public void Play(double localTime)
        {
            if (!initSucess)
            {
                return;
            }
            m_Graph.Play();
        }
        public void Update(double localTime)
        {
            if (!initSucess)
            {
                return;
            }
            if (initSucess&&updateWeightFunc != null)
            {
                SetWeights(updateWeightFunc.Invoke());
            }
            for (int i = 0; i < clipPlayables.Length; i++)
            {
                clipPlayables[i].SetTime(localTime);
            }
            m_Graph.Evaluate();
        }
        public void Stop()
        {
            if (!initSucess)
            {
                return;
            }
            m_Graph.Stop();
        }
        void SetWeights(float[] weights)
        {
            if (!initSucess)
            {
                return;
            }
            for (int i = 0; i < weights.Length; i++)
            {
                m_Mixer.SetInputWeight(i, weights[i]);
            }
        }
    }
}
