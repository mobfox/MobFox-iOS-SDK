using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

public class MobFox : MonoBehaviour
{

	//public delegate void InterstitialReadyDelegate();
	//public InterstitialReadyDelegate interstitialReadyDelegate;

	[DllImport("__Internal")]
	public static extern void _setGameObject(string gameObject);

	[DllImport("__Internal")]
	public static extern int _createBanner(string invh);

	[DllImport("__Internal")]
	public static extern void _showBanner (int bannerId);

	[DllImport("__Internal")]
	public static extern void  _hideBanner (int bannerId);

	[DllImport("__Internal")]
	public static extern void _createInterstitial(string invh);

	[DllImport("__Internal")]
	public static extern void  _showInterstitial();

	//public static void showInterstital(int interId){
	//	_showInterstitial(interId);
	//}

	/*public static void setGameObject(string gameObj){
		_setGameObject(gameObj);
	}*/
	
	//banners
	public static int createBanner(GameObject obj,string invh){
		_setGameObject (obj.name);
		return _createBanner(invh);
	}

	public static void showBanner (int bannerId){
		_showBanner (bannerId);
	}

	public static void  hideBanner (int bannerId){
		_hideBanner (bannerId);
	}

	//interstitial
	public static void showInterstitial(){
		_showInterstitial();
	}

	public static void createInterstitial(GameObject obj,string invh){
		_setGameObject (obj.name);
		_createInterstitial(invh);
	}

	
	
}
