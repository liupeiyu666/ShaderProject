using System;
using UnityEngine;
using UnityEngine.Playables;
namespace Common.Playables
{
    /// <summary>
    /// Author:LPY
    /// Data:2021/5/8
    /// </summary>
    public class SceneDynamicClipBehaviour : PlayableBehaviour
    {
        public GameObject go;
        public SceneDynamicClipData Data;        
        private AnimationClipBlend clipBlend;
        
        private float lerpTime;
        //--由于外部驱动的更新会导致deltatime为0，所以需要记录
        private float recordLerpStartTime;
        private SceneDynamicClipData.BlendParam blendParam;
        private float[] blendWeights;
        //--需要混合时，记录当前的权重
        private float[] recordWeights;
        public override void OnPlayableCreate(Playable playable)
        {
            base.OnPlayableCreate(playable);
        }
        public override void OnPlayableDestroy(Playable playable)
        {
            base.OnPlayableDestroy(playable);
        }
        public override void OnBehaviourPlay(Playable playable, FrameData info)
        {
            base.OnBehaviourPlay(playable, info);
           
        }
        public override void OnGraphStop(Playable playable)
        {
            base.OnGraphStop(playable);
            if (clipBlend != null)
            {
                clipBlend.Stop();
            }
        }
        public override void PrepareData(Playable playable, FrameData info)
        {
            base.PrepareData(playable, info);
        }
        public override void ProcessFrame(Playable playable, FrameData info, object playerData)
        {
            base.ProcessFrame(playable, info, playerData);
            
        }
       
    }
    [Serializable]
    public class SceneDynamicClipData
    {
        [Serializable]
        public class BlendParam
        {
            public float BlendTime=0.5f;
        }
        public AnimationClip[] AnimationClips;
        public BlendParam[] BlendParams;
    }   
}