using UnityEditor;
using UnityEngine;

public class Builder : MonoBehaviour
{
    [MenuItem("Build/AssetBundle")]
    public static void BuildAssets()
    {
        BuildPipeline.BuildAssetBundles("AssetBundles", BuildAssetBundleOptions.UncompressedAssetBundle, BuildTarget.StandaloneWindows64);
    }
}