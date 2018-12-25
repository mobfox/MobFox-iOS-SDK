

# MobFox-iOS-SDK

## [New documentation page](https://mobfox.atlassian.net/wiki/spaces/PUMD/pages/354156654/Getting+Started)

For any problems or questions not covered by the instructions below, please contact <sdk_support@mobfox.com> or open an issue.

Supports **iOS 9.0+**

<!-- toc -->

* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [CocoaPods](#cocoapods)
* [Manual Installation](#manual-installation)
* [ATS](#ats)
* [Usage](#usage)
* [Banner Ad](#banner-ad)
* [Interstitial Ad](#interstitial-ad)
* [Native Ad](#native-ad)
* [Custom Events](#custom-events)
* [Adapters](#adapters)
* [Plugins](#plugins)
* [Demo App Swift](#demo-app-swift)
* [GDPR](#gdpr)
* [Location Services](#location-services)
* [MOAT](#built-in-moat-viewability-measurement)

<!-- toc stop -->


# Prerequisites

You will need a [MobFox](http://www.mobfox.com/) account.

# Installation

Make sure the following are included in your project's *frameworks*: 
(In your Xcode project go to **General** - **Linked Frameworks and Libaries**)
- ```AdSupport.framework```



In **Build Settings** click on **All** tag.
Set ```Always Embed Swift Standard Libraries``` to Yes.

## CocoaPods


If you do not have podfile yet, 
1) In terminal, go to your project location and type `pod init` to create podfile.
2) use `open -a Xcode Podfile` to edit podfile.

Add to your Podfile:

```
pod 'MobFoxSDK','3.5.7'
```

save your pod file and type:
`pod install`

## Carthage

Add to your Cartfile:

```
github "mobfox/MobFox-iOS-SDK" "3.5.7"
```

Carthage only supports dynamic frameworks. MobFoxSDKCoreDynamic.framework must be under 'Embedded Binaries' and 'Linked Frameworks and Libraries'.


## Manual Installation

1. Download and unzip [MobFox-SDK](https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib/releases/latest) or clone this repository.

2. For integrating static lib: Drag ```MobFoxSDKCore.embeddedframework``` from the Finder into your project.
For dynamic lib: Drag ```MobFoxSDKCoreDynamic.embeddedframework``` from the Finder into your project. (MobFoxSDKCoreDynamic.framework must be under 'Embedded Binaries' and 'Linked Frameworks and Libraries')

3. Drag ```MATMoatMobileAppKit.framework``` from the Finder into your project.

## ATS

One of the changes in iOS9 is a default setting that requires apps to make network connections only over SSL, this is known as App Transport Security. MobFox is facilitating the transition to support this change for each of our demand partners in order to ensure they are compliant. In the meantime, developers who want to release apps that support iOS9, will need to disable ATS in order to ensure MobFox continues to work as expected, and in iOS10 and later only disable ATS for Media and Web content. To do so, developers should add the following to their ```plist```:
```xml
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
<key>NSAllowsArbitraryLoadsForMedia</key>
<true/>
<key>NSAllowsArbitraryLoadsInWebContent</key>
<true/>
</dict>

```
Developers can also edit the plist directly by adding ```NSAppTransportSecurity``` key of dictionary type with the parameters: ```NSAllowsArbitraryLoads```, ```NSAllowsArbitraryLoadsForMedia``` and ```NSAllowsArbitraryLoadsInWebContent``` set to ```true```.

In the future MobFox will provide an additional parameter for requesting only secure ads. We will inform our publishers via the [Control Panel](https://account.mobfox.com).

More information about this change can be found on Apple's website: https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html#//apple_ref/doc/uid/TP40016240

For further questions about iOS9 and ATS, please create a ticket at https://account.mobfox.com/www/cp/create_ticket.php

**If your app already relies on ```NSAllowsArbitraryLoads``` for some http request/s please do not modify your ```plist```.**


# Usage

```objective-c
#import <MobFoxSDKCore/MobFoxSDKCore.h>
```
Or
```objective-c
//For MobFoxSDKCoreDynamic.embeddedframework use
#import <MobFoxSDKCoreDynamic/MobFoxSDKCoreDynamic.h>
```

## Banner Ad

In order to ensure the best ad is ready when you wish to display it, please init the MobFox ad as soon as possible in your code:
```objective-c

//define the position and dimensions of your ad
CGRect  adRect = CGRectMake(0, 200, 320, 50);

//init your ad
MobFoxAd* mobfoxAd = [[MobFoxAd alloc] init:@"your-publication-hash" withFrame:adRect];

//add it to your view
[self.view addSubview: mobfoxAd];

```

### Setting Additional Parameters
Setting additional parameters on the ad object that can help you get better targeted ads or help you with reporting:
```objective-c
@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* demo_gender; //"m/f"
@property (nonatomic, copy) NSString* demo_age;
@property (nonatomic, copy) NSString* v_dur_min;
@property (nonatomic, copy) NSString* v_dur_max;
@property (nonatomic, copy) NSString* r_floor;


//set this (in seconds) to make the ad refresh
@property (nonatomic, assign) NSNumber* refresh;
```
More information can be found here: http://dev.mobfox.com/index.php?title=Ad_Request_API#Request_Parameters

#### Ad Delegate
In order to be notified when certain ad events occur you can register a delegate:

```objective-c
//The delegate should implement the following protocol:
@protocol MobFoxAdDelegate <NSObject>

@optional

//called when ad is displayed
- (void)MobFoxAdDidLoad:(MobFoxAd *)banner;
//called when an ad cannot be displayed
- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error;

//called when ad is closed/skipped
- (void)MobFoxAdClosed;

//called when ad is clicked
- (void)MobFoxAdClicked;

//called when if the ad is a video ad and it has finished playing
- (void)MobFoxAdFinished;

//called if the ad request returned custom events
- (void) MobFoxDelegateCustomEvents:(NSArray*) events;

@end
```
Set the delegate:

```objective-c
mobfoxAd.delegate = delegate;
```

#### Show Ad
Later when you wish to display the ad:
```objective-c
//call to display ad
[mobfoxAd loadAd];
```
---

## Interstitial Ad

In order to insure the best ad is ready when you wish to display it, please init the MobFox interstitial ad as soon as possible in your code:
```objective-c

//init the interstitial ad giving it your main/root controller
MobFoxInterstitialAd* mobfoxInterAd = [[MobFoxInterstitialAd alloc] init:@"your-publication-hash" withRootViewController:self];
```
### Setting Additional Parameters
Setting additional parameters on the internal ad object that can help you get better targeted ads or help you with reporting:
For example:
```objective-c
mobfoxInterAd.demo_gender = @"f";
```
The available properties are:
```objective-c
@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* demo_gender; //"m/f"
@property (nonatomic, copy) NSString* demo_age;
@property (nonatomic, copy) NSString* s_subid;
@property (nonatomic, copy) NSString* sub_name;
@property (nonatomic, copy) NSString* sub_domain;
@property (nonatomic, copy) NSString* sub_storeurl;
@property (nonatomic, copy) NSString* r_floor;

//set this (in seconds) to make the ad refresh
@property (nonatomic, assign) NSNumber* refresh;
@property (nonatomic, copy) NSNumber* v_dur_min;
@property (nonatomic, copy) NSNumber* v_dur_max;
```
More information can be found here: http://dev.mobfox.com/index.php?title=Ad_Request_API#Request_Parameters



#### Interstitial Ad Delegate
In order to be notified when certain ad events occur you can register a delegate:

```objective-c
//The delegate should implement the following protocol:
@protocol MobFoxInterstitialAdDelegate <NSObject>

@optional
//called when ad is displayed
- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial;

//called when an ad cannot be displayed
- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error;

//called when ad is closed/skipped
- (void)MobFoxInterstitialAdClosed;

//called w mobfoxInterAd.delegate = self;hen ad is clicked
- (void)MobFoxInterstitialAdClicked;

//called when if the ad is a video ad and it has finished playing
- (void)MobFoxInterstitialAdFinished;

@end
```

Set the delegate and preload the ad:

```objective-c
mobfoxInterAd.delegate = delegate;
[mobfoxInterAd loadAd];
```
Setting additional parametes on the ad object that can help you get better targeted ads or help you with reporting:
```objective-c
@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* demo_gender; //"m/f"
@property (nonatomic, copy) NSString* demo_age;
@property (nonatomic, copy) NSString* s_subid;
@property (nonatomic, copy) NSString* sub_name;
@property (nonatomic, copy) NSString* sub_domain;
@property (nonatomic, copy) NSString* sub_storeurl;
@property (nonatomic, copy) NSString* v_dur_min;
@property (nonatomic, copy) NSString* v_dur_max;
@property (nonatomic, copy) NSString* r_floor;
```
More information can be found here: http://dev.mobfox.com/index.php?title=Ad_Request_API#Request_Parameters

#### Show Interstitial Ad
Later when you wish to display the ad:
```objective-c

//best to show after delegate informs an ad was loaded
- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
if(mobfoxInterAd.ready){
[mobfoxInterAd show];
}
}

```
---

## Native Ad

This is a special type of ad as it returns a JSON object containing the ad data and it's the publisher's responsibility to display the ad assets, call the impression pixels and the click URL if clicked.

### ATS

Note that for native ads ```plist``` file should **not** include the following keys or set to false:

- ```NSAllowsArbitraryLoadsForMedia```
- ```NSAllowsArbitraryLoadsInWebContent```

```xml
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
<!--      <key>NSAllowsArbitraryLoadsForMedia</key>-->
<!--        <false/>-->
<!--        <key>NSAllowsArbitraryLoadsInWebContent</key>-->
<!--         <false/>-->
</dict>

```
### Initiate MobFox Native Ad
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

     //where my 'myView' is the view used to display the native ad
     self.nativeAd = [[MobFoxNativeAd alloc] init:@"your-publication-hash" nativeView:myView];
}
```

#### Native Ad Delegate
```objective-c
//you must define a delegate to get the JSON response
//The delegate should implement the following protocol:
@protocol MobFoxNativeAdDelegate <NSObject>

//called when ad response is returned
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData;

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error;

//called on ad click
- (void)MobFoxNativeAdClicked;
@end

nativeAd.delegate = delegate;
```

### Setting Additional Parameters
Setting additional parameters on the ad object that can help you get better targeted ads or help you with reporting:
```objective-c
@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* demo_gender; //"m/f"
@property (nonatomic, copy) NSString* demo_age;
@property (nonatomic, copy) NSString* s_subid;
@property (nonatomic, copy) NSString* sub_name;
@property (nonatomic, copy) NSString* sub_domain;
@property (nonatomic, copy) NSString* sub_storeurl;
@property (nonatomic, copy) NSString* v_dur_min;
@property (nonatomic, copy) NSString* v_dur_max;
@property (nonatomic, copy) NSString* r_floor;
```
More information can be found here: http://dev.mobfox.com/index.php?title=Ad_Request_API_-_Native

The response ```MobFoxNativeData*``` :
```objective-c

@interface MobFoxNativeData : NSObject

@property (nonatomic, strong) MobFoxNativeImage *icon;
@property (nonatomic, strong) MobFoxNativeImage *main;

@property (nonatomic, copy) NSString *assetHeadline;
@property (nonatomic, copy) NSString *assetDescription;
@property (nonatomic, copy) NSString *callToActionText;
@property (nonatomic, copy) NSString *advertiserName;
@property (nonatomic, copy) NSString *socialContext;
@property (nonatomic, copy) NSNumber *rating;
@property (nonatomic, copy) NSURL *clickURL;

@property (nonatomic, strong) NSMutableArray *trackersArray;

@end
```

You must call all ```trackers``` when you decide to render the ad and navigate to the ```click_url``` when the ad is clicked.


Please refer to [MobFox Native API](http://dev.mobfox.com/index.php?title=Ad_Request_API_-_Native) for full documentation.

#### Get Native Ad
```objective-c

[nativeAd loadAd];

```

#### Display Ad Assets & Fire Tracking Pixel
When the native ad loads you must fire tracking pixel:
```objective-c
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData {

    self.nativeAdTitle.text = adData.assetHeadline;
    self.nativeAdDescription.text = adData.assetDescription;
    self.nativeAdIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:adData.main.url]];
    self.clickURL = [adData.clickURL absoluteURL];
    self.mobFoxNativeData = adData;

    [ad fireTrackers];
}
```

---

## Custom Events

This feature lets you use your accounts on other advertising platforms such as MoPub inside MobFox's SDK.

[Custom Events](https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib/wiki/Custom-Events)

## Adapters

Adapters are the opposite of Custom Events, they let you use MobFox as a Custom Event in other networks. Currently AdMob and MoPub are supported.

[Adapters](https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib/wiki/Adapters)

## Plugins
[Plugins](https://github.com/mobfox/SDK-Plugins)


## Demo App Swift

[Demo App Swift](https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib/wiki/Demo-Application-in-Swift)

## GDPR

Configuration:

- MobFox set properties 
------------------------
@property (nonatomic, assign) BOOL      gdpr;

@property (nonatomic, assign) NSString* gdpr_consent;

-AdMob adapter use  "MFAdNetworkExtras" 
--------------------------------------------

Example:

        MFAdNetworkExtras *extras = [[MFAdNetworkExtras alloc] init];

        extras.gdpr = YES;
        extras.gdpr_consent = @"1";

        self.gadBannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, 320, 50)];
        self.gadBannerView.adUnitID = ADMOB_HASH_GAD_TAG_BANNER;
        self.gadBannerView.rootViewController = self;
        self.gadBannerView.delegate = self;
        [self.view addSubview: self.gadBannerView];
        GADRequest *request = [[GADRequest alloc] init];
        [request registerAdNetworkExtras:extras];
         [self.gadBannerView loadRequest:request];
      
MoPub adapter
---------------

1. Update to the latest MoPub SDK (MoPub SDK 5.0)
2. Use MobFox Adapter module to pass gdpr & gdpr_consent to MobFox



For more information about GDPR:
----------------------------------
https://www.mobfox.com/gdpr-faq/




## Location Services

The SDK will query the current location and set the ```longitude``` and ```latitude``` ad request parameters, as long as it permitted by the user (in Privacy, Location Services).

# Built-in MOAT Viewability Measurement

This enables publishers to measure their in-app inventory according to [Moat](https://moat.com/)’s viewability metrics, and make their inventory more available to advertisers who are only interested in ‘viewability-monitored’ traffic.


