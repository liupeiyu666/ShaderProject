using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Effect.YuPost
{
    /// <summary>
    /// 添加Outline组件
    /// </summary>
    public class OutLineGo : MonoBehaviour
    {
        private void OnEnable()
        {
            Debug.LogError("OnEnable");
            OutLinePostEffect.instance.AddGameObject(this.gameObject);
        }
        private void OnDisable()
        {
            Debug.LogError("OnDisable");
            OutLinePostEffect.instance.RemoveGameObject(this.gameObject);
        }
    }

}