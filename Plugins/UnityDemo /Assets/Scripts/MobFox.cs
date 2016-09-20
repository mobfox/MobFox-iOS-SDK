using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using UnityEngine.UI;

public class MobFox : MonoBehaviour
{
	[DllImport("__Internal")]
	public static extern void _setUseLocation (bool useLocation);

	[DllImport("__Internal")]
	public static extern int _createBanner(string invh, float originX, float originY, float sizeWidth, float sizeHeight);

	[DllImport("__Internal")]
	public static extern void _setGameObject(string gameObject);

	[DllImport("__Internal")]
	public static extern void _createInterstitial(string invh);

	[DllImport("__Internal")]
	public static extern void _showInterstitial();


	[SerializeField] string MobFoxBannerInventoryHash       = "8769bb5eb962eb39170fc5d8930706a9";
	[SerializeField] string MobFoxInterstitialInventoryHash = "267d72ac3f77a3f447b32cf7ebf20673";
	[SerializeField] string MobFoxGameObjectName            = "MobFoxObject";

	bool useLocation = false;

	private AndroidJavaObject mobFoxPlugin = null;
	private AndroidJavaObject activityContext = null;

	//======================================================================================
	//======  I N I T                                                                 ======
	//======================================================================================

	void Awake()
	{
		ConnectToPlugin ();
	}

	void ConnectToPlugin()
	{
		if (Application.platform == RuntimePlatform.Android) {

			if (mobFoxPlugin == null) {
				using (AndroidJavaClass activityClass = new AndroidJavaClass ("com.unity3d.player.UnityPlayer")) {
					activityContext = activityClass.GetStatic<AndroidJavaObject> ("currentActivity");
				}

				using (AndroidJavaClass pluginClass = new AndroidJavaClass ("com.mobfox.unity.plugin.MobFoxPlugin")) {
					if (pluginClass != null) {
						mobFoxPlugin = pluginClass.CallStatic<AndroidJavaObject> ("instance");
						mobFoxPlugin.Call ("setContext", activityContext);
					}
				}
			}

			if ((mobFoxPlugin != null) && (activityContext != null)) {
				activityContext.Call("runOnUiThread", new AndroidJavaRunnable(() => {
					mobFoxPlugin.Call("setGameObject", MobFoxGameObjectName);
				}));
			}
		} else {
			_setGameObject (MobFoxGameObjectName);
		}
	}

	private void ShowToast(string message)
	{
		if (Application.platform == RuntimePlatform.Android) {
			if ((mobFoxPlugin != null) && (activityContext != null)) {
				activityContext.Call("runOnUiThread", new AndroidJavaRunnable(() => {
					mobFoxPlugin.Call("showMessage", message);
				}));
			}
		} else {
		}
	}

	//======================================================================================
	//======  L O C A T I O N   C H E C K B O X                                       ======
	//======================================================================================

	public void CheckboxPressed()
	{
		Debug.Log ("### CheckboxPressed ###");

		useLocation = !useLocation;

		SetUseLocation (useLocation);
	}

	//======================================================================================

	private void SetUseLocation_iPhone(bool in_useLocation)
	{
		_setUseLocation(in_useLocation);
	}

	private void SetUseLocation_Android(bool in_useLocation)
	{
		if ((mobFoxPlugin != null) && (activityContext != null)) {
			activityContext.Call("runOnUiThread", new AndroidJavaRunnable(() => {
				mobFoxPlugin.Call("setUseLocation", in_useLocation);
			}));
		}
	}

	private void SetUseLocation(bool in_useLocation)
	{	
		ConnectToPlugin ();

		if (Application.platform == RuntimePlatform.Android)
		{
			SetUseLocation_Android (in_useLocation);
		} else {
			SetUseLocation_iPhone (in_useLocation);
		}
	}

	//======================================================================================
	//======  B A N N E R                                                             ======
	//======================================================================================

	private void ShowMobFoxBanner_iPhone()
	{
		_createBanner (MobFoxBannerInventoryHash, 0, 0, 320, 50);
	}

	private void ShowMobFoxBanner_Android()
	{
		if ((mobFoxPlugin != null) && (activityContext != null)) {
			activityContext.Call("runOnUiThread", new AndroidJavaRunnable(() => {
				mobFoxPlugin.Call("createBanner", MobFoxBannerInventoryHash, 0, 0, 320, 50);
			}));
		}
	}

	public void ShowMobFoxBanner()
	{
		Debug.Log ("### ShowMobFoxBanner ###");

		ConnectToPlugin ();

		if (Application.platform == RuntimePlatform.Android)
		{
			ShowMobFoxBanner_Android ();
		} else {
			ShowMobFoxBanner_iPhone ();
		}
	}

	//======================================================================================

	public void bannerReady(string msg)
	{
		Debug.Log ("### bannerReady ###");
		ShowToast ("### bannerReady ###");
	}

	public void bannerError(string msg)
	{
		Debug.Log ("### bannerError: "+msg);
		ShowToast ("### bannerError: "+msg);
	}

	public void bannerClosed(string msg)
	{
		Debug.Log ("### bannerClosed ###");
		ShowToast ("### bannerClosed ###");
	}

	public void bannerClicked(string msg)
	{
		Debug.Log ("### bannerClicked ###");
		ShowToast ("### bannerClicked ###");
	}

	public void bannerFinished(string msg)
	{
		Debug.Log ("### bannerFinished ###");
		ShowToast ("### bannerFinished ###");
	}

	//======================================================================================
	//======  I N T E R S T I T I A L                                                 ======
	//======================================================================================

	private void ShowMobFoxInterstitial_iPhone()
	{
		_createInterstitial (MobFoxInterstitialInventoryHash);
	}

	private void ShowMobFoxInterstitial_Android()
	{
		if ((mobFoxPlugin != null) && (activityContext != null)) {
			activityContext.Call("runOnUiThread", new AndroidJavaRunnable(() => {
				mobFoxPlugin.Call("createInterstitial", MobFoxInterstitialInventoryHash);
			}));
		}
	}

	public void ShowMobFoxInterstitial()
	{
		Debug.Log ("### ShowMobFoxInterstitial... ###");

		ConnectToPlugin ();

		if (Application.platform == RuntimePlatform.Android) {
			ShowMobFoxInterstitial_Android ();
		} else {
			ShowMobFoxInterstitial_iPhone ();
		}
	}

	//======================================================================================

	public void interstitialReady(string msg)
	{
		Debug.Log ("### interstitialReady ###");
		ShowToast ("### interstitialReady ###");

		if (Application.platform == RuntimePlatform.Android) {
			if ((mobFoxPlugin != null) && (activityContext != null)) {
				activityContext.Call("runOnUiThread", new AndroidJavaRunnable(() => {
					mobFoxPlugin.Call("showInterstitial");
				}));
			}
		} else {
			_showInterstitial ();
		}
	}

	public void interstitalError(string msg)
	{
		Debug.Log ("### interstitalError: "+msg);
		ShowToast ("### interstitalError: "+msg);
	}

	public void interstitialClosed(string msg)
	{
		Debug.Log ("### interstitialClosed ###");
		ShowToast ("### interstitialClosed ###");
	}

	public void interstitialClicked(string msg)
	{
		Debug.Log ("### interstitialClicked ###");
		ShowToast ("### interstitialClicked ###");
	}

	public void interstitialFinished(string msg)
	{
		Debug.Log ("### interstitialFinished ###");
		ShowToast ("### interstitialFinished ###");
	}
}
