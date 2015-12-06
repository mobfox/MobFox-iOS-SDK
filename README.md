# MobFox-iOS-SDK-Core-Lib

Supports **iOS 7.0+**


<!-- toc -->

* [Prerequisites](#prerequisites)
* [Installation](#installation)
  * [CocoaPods](#cocoapods)
  * [Manual Installation](#manual-installation)
  * [iOS 9+ Specific](#ios-9-specific)
* [Usage](#usage)
  * [Banner Ad](#banner-ad)
  * [Interstitial Ad](#interstitial-ad)
  * [Native Ad](#native-ad)
  * [Custom Events](#custom-events)
  * [Adapters](#adapters)

<!-- toc stop -->



#Prerequisites

You will need a [MobFox](http://www.mobfox.com/) account.

# Installation

Make sure ```AdSupport.framework``` is included in your project's frameworks. 

## CocoaPods

Add to your Podfile:

```
pod 'MobFoxSDKCoreLib', :git => 'https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib.git'
```
## Manual Installation

1. Download and unzip [MobFox-SDK-Core-Lib](https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib/releases/latest) or clone this repository and extract the ```MobFoxSDKCore.embeddedframework```.

2. Drag ```MobFoxSDKCore.embeddedframework``` from the Finder into your project

3. If you prefer a Dynamic Framework use ```MobFoxSDKCoreDynamic.embeddedframework``` instead.


## iOS 9+ Specific
One of the changes in iOS9 is a default setting that requires apps to make network connections only over SSL, this is known as App Transport Security. MobFox is facilitating the transition to support this change for each of our demand partners in order to ensure they are compliant. In the meantime, developers who want to release apps that support iOS9, will need to disable ATS in order to ensure MobFox continues to work as expected. To do so, developers should add the following to their plist:
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
Developers can also edit the plist directly by adding ```NSAppTransportSecurity``` key of dictionary type with a dictionary element of ```NSAllowsArbitraryLoads``` of boolean type set to ```Yes```.

In the future MobFox will provide an additional parameter for requesting only secure ads. We will inform our publishers via the [Control Panel](https://account.mobfox.com).

More information about this change can be found on Apple's website: https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html#//apple_ref/doc/uid/TP40016240

For further questions about iOS9 and ATS, please create a ticket at https://account.mobfox.com/www/cp/create_ticket.php

# Usage

## Banner Ad

In order to insure the best ad is ready when you wish to display it, please init the MobFox ad as soon as possible in your code:
```objective-c

//define the position and dimensions of your ad
CGRect  adRect = CGRectMake(0, 200, 320, 50);

//init your ad
MobFoxAd* mobfoxAd = [[MobFoxAd alloc] init:@"your-publication-hash" withFrame:adRect];

//add it to your view
[self.view addSubview: mobfoxAd];

```

### Setting Additonal Parameters
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
### Setting Additonal Parameters
Setting additional parametes on the internal ad object that can help you get better targeted ads or help you with reporting:
For example:
```objective-c
mobfoxInterAd.ad.demo_gender = @"f";
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
@property (nonatomic, copy) NSString* v_dur_min;
@property (nonatomic, copy) NSString* v_dur_max;
@property (nonatomic, copy) NSString* r_floor;

//set this (in seconds) to make the ad refresh
@property (nonatomic, assign) NSNumber* refresh;
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

```objective-c

MobFoxNativeAd* nativeAd = [[MobFoxNativeAd alloc] init:@"your-publication-hash"];
```

#### Native Ad Delegate
```objective-c
//you must define a delegate to get the JSON response
//The delegate should implement the following protocol:
@protocol MobFoxNativeAdDelegate <NSObject>

//called when ad response is returned
- (void)MobFoxNativeAdDidLoad:(NSDictionary *)ad;

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error;
@end

nativeAd.delegate = delegate;
```

### Setting Additonal Parameters
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
More information can be found here: http://dev.mobfox.com/index.php?title=Ad_Request_API_-_Native 

The response ```NSDictionary*``` is a JSON object of the following structure:
```json
{
   "imageassets":{
      "icon":{
         "url":"<IMAGE_URL>",
         "width":"512",
         "height":"512"
      },
      "main":{
         "url":"<IMAGE_URL>",
         "width":"1200",
         "height":"627"
      }
   },
   "textassets":{
      "headline":"Hay Day",
      "description":"Hay Day is a totally new farming experience with smooth gestural controls lovingly hand..."
   },
   "click_url":"<CLICK_URL>",
   "trackers":[
      {
         "type":"impression",
         "url":"<PIXEL_URL>"
      },
      {
         "type":"impression",
         "url":"<PIXEL_URL>"
      },
      {
         "type":"impression",
         "url":"<PIXEL_URL>"
      }
   ]
}
```
You must call all ```trackers``` when you decide to render the ad and navigate to the ```click_url``` when the ad is clicked.

Please refer to [MobFox Native API](http://dev.mobfox.com/index.php?title=Ad_Request_API_-_Native) for full documentation.

#### Get Native Ad
```objective-c
[nativeAd loadAd];

```
---

## Custom Events

This feature lets you use your accounts on other advertising platforms such as MoPub inside MobFox's SDK.

[Custom Events](https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib/wiki/Custom-Events)

## Adapters

Adapters are the opposite of Custom Events, they let you use MobFox as a Custom Event in other networks. Currently only AdMob is supported.

[Adapters](https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib/wiki/Adapters)
