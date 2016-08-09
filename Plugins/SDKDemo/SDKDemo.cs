using UnityEngine;
using System;
using System.Collections;
 

public class SDKDemo : MonoBehaviour {

	private GUIStyle labelStyle = new GUIStyle();
	private float centerX = Screen.width / 2;

	// MobFox Ad Delegate

	void bannerReady (string message) {

		System.Console.WriteLine(message);

	}

	void bannerError (string message) {

		System.Console.WriteLine(message);

	}

	void banneClosed (string message) {

		System.Console.WriteLine(message);

	}

	void banneClicked (string message) {

		System.Console.WriteLine(message);

	}

	void banneFinished (string message) {

		System.Console.WriteLine(message);

	}

	// MobFox Interstitial Ad Delegate

	void interstitialReady (string message) {

		System.Console.WriteLine(message);

		MobFox.showInterstitial();


	}

	void interstitalError (string message) {

		System.Console.WriteLine(message);

	}

	void interstitialClosed (string message) {

		System.Console.WriteLine(message);

	}

	void interstitialClicked (string message) {

		System.Console.WriteLine(message);

	}

	void interstitialFinished (string message) {

		System.Console.WriteLine(message);

	}


	// Use this for initialization
	void Start ()
	{   
		labelStyle.fontSize = 24;
		labelStyle.normal.textColor = Color.black;
		labelStyle.alignment = TextAnchor.MiddleCenter;
	}

	void OnGUI ()
	{

		GUI.Label(new Rect(centerX - 200, 20, 400, 35), "SDK Demo", labelStyle);

		if (GUI.Button(new Rect(centerX - 75, 80, 150, 35), "DoStuff"))
		{

			// Display banner.
			int bannerId = MobFox.createBanner(this.gameObject, "fe96717d9875b9da4339ea5367eff1ec", new Rect(0, 0, 320, 50));
		    MobFox.showBanner(bannerId);

			// Display interstitial.
			MobFox.createInterstitial (this.gameObject, "267d72ac3f77a3f447b32cf7ebf20673");

		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}
				

}
