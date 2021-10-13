using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Common.Playables
{
    /// <summary>
    /// Author:LPY
    /// </summary>
    [Serializable]
    public class SceneDynamicClipAsset : PlayableAsset,ITimelineClipAsset
    {
        //[SerializeField]
        public ExposedReference<GameObject> DDD;
        public GameObject Target;
        public SceneDynamicClipData ClipBehaviourData;

        public ClipCaps clipCaps
        {
            get
            {
                return ClipCaps.None;
            }
        }
        public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
        {
            var playable = ScriptPlayable<SceneDynamicClipBehaviour>.Create(graph);
            SceneDynamicClipBehaviour tb = playable.GetBehaviour();
            var resolver = graph.GetResolver();
            tb.go = Target;
            tb.Data = ClipBehaviourData;
            return playable;
        }
    }
}