using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Cinemachine.Timeline
{
    internal sealed class CinemachineShotPlayable : PlayableBehaviour
    {
        public CinemachineVirtualCameraBase VirtualCamera;
        public override void OnBehaviourDelay(Playable playable, FrameData info)
        {
           // Debug.LogError(VirtualCamera.name+"OnBehaviourDelay" + Time.frameCount);
            base.OnBehaviourDelay(playable, info);

        }
        public override void OnBehaviourPause(Playable playable, FrameData info)
        {
         //   Debug.LogError(VirtualCamera.name + "OnBehaviourPause" + Time.frameCount);
            base.OnBehaviourPause(playable, info);
        }
        public override void OnBehaviourPlay(Playable playable, FrameData info)
        {
          //  Debug.LogError(VirtualCamera.name + "OnBehaviourPlay" + Time.frameCount);
            base.OnBehaviourPlay(playable, info);
        }
        public override void OnGraphStart(Playable playable)
        {
         //   Debug.LogError(VirtualCamera.name + "OnGraphStart" + Time.frameCount);
            base.OnGraphStart(playable);
        }
        public override void OnGraphStop(Playable playable)
        {
         //   Debug.LogError(VirtualCamera.name + "OnGraphStop" + Time.frameCount);         
        }
        public override void OnPlayableCreate(Playable playable)
        {
        //    Debug.LogError("OnPlayableCreate" + Time.frameCount);
            base.OnPlayableCreate(playable);
        }
        public override void OnPlayableDestroy(Playable playable)
        {
        //    Debug.LogError(VirtualCamera.name + "OnPlayableDestroy" + Time.frameCount);
            base.OnPlayableDestroy(playable);
        }
        public override void PrepareData(Playable playable, FrameData info)
        {
          //  Debug.LogError(VirtualCamera.name + "     ---PrepareData   "+ info.weight+"    " + Time.frameCount);
            base.PrepareData(playable, info);
        }
        public override void PrepareFrame(Playable playable, FrameData info)
        {
         //   Debug.LogError(VirtualCamera.name + "     ****PrepareFrame   " + info.weight + "    " + Time.frameCount);
            //  Debug.LogError(VirtualCamera.name+"----:" +info.weight+"     "+info.effectiveSpeed+"   "+info.effectiveWeight+"   "+info.seekOccurred+"   "+info.timeHeld+"   "+info.timeLooped);
            //  Debug.LogError(VirtualCamera.name + "PrepareFrame" + Time.frameCount);
            // mPlaying = info.evaluationType == FrameData.EvaluationType.Playback;
        }

        public override void ProcessFrame(Playable playable, FrameData info, object playerData)
        {
            base.ProcessFrame(playable, info, playerData);
          //  Debug.LogError(playerData.GetType()+"   ----------");
            //for (int i = 0; i < playable.GetGraph().GetRootPlayableCount(); i++)
            //{
            //    Debug.LogError("++++RootPlayAble:"+i+"   "+ playable.GetGraph().GetRootPlayable(i) + "   " + Time.frameCount);
            //    for (int j = 0; j < playable.GetGraph().GetRootPlayable(i).GetInputCount(); j++)
            //    {
            //        Debug.LogError("----GetInputCount:" + j + "   " + playable.GetGraph().GetRootPlayable(i).GetInput(j).GetPlayableType() + "   " + Time.frameCount);
            //    }
            //    //for (int j = 0; j < playable.GetGraph().GetRootPlayable(i).GetOutputCount(); j++)
            //    //{
            //    //    Debug.LogError("******GetOutputCount:" + j + "   " + playable.GetGraph().GetRootPlayable(i).GetOutput(j).GetPlayableType() + "   " + Time.frameCount);
            //    //}
            //}
        }
    }

    public sealed class CinemachineShot : PlayableAsset, IPropertyPreview,ITimelineClipAsset
    {
        public ExposedReference<CinemachineVirtualCameraBase> VirtualCamera;

        public ClipCaps clipCaps {
            get {
                return ClipCaps.All;
            }
        }

        public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
        {
            var playable = ScriptPlayable<CinemachineShotPlayable>.Create(graph);
            playable.GetBehaviour().VirtualCamera = VirtualCamera.Resolve(graph.GetResolver());
            Debug.LogError("-----------:CreatePlayable");
            //foreach (var item in outputs)
            //{
            //    Debug.LogError("====================:"+item.streamName+"   "+ item.outputTargetType+"   "+item.sourceObject);
            //}
            return playable;
        }

        // IPropertyPreview implementation
        public void GatherProperties(PlayableDirector director, IPropertyCollector driver)
        {
            driver.AddFromName<Transform>("m_LocalPosition.x");
            //driver.AddFromName<Transform>("m_LocalPosition.y");
            //driver.AddFromName<Transform>("m_LocalPosition.z");
            //driver.AddFromName<Transform>("m_LocalRotation.x");
            //driver.AddFromName<Transform>("m_LocalRotation.y");
            //driver.AddFromName<Transform>("m_LocalRotation.z");

            //driver.AddFromName<Camera>("field of view");
            //driver.AddFromName<Camera>("near clip plane");
            //driver.AddFromName<Camera>("far clip plane");
        }
    }
}
