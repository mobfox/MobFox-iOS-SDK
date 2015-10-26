# MobFox-iOS-SDK-Core-Lib

Supports **iOS 7.0+**

#Prerequisites

You will need a [MobFox](http://www.mobfox.com/) account.

# Installation

## CocoaPods

Add to your Podfile:

```
pod 'MobFoxSDKCoreLib', :git => 'https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib.git'
```
## Manual Installation

1. Download and unzip [MobFoxSDKCoreLib.zip](https://sdk.starbolt.io/MobFoxSDKCoreLib.zip) or clone this repository and extract the ```MobFoxSDKCore.embeddedframework```.

2. Add ```MobFoxSDKCore.embeddedframework``` to your project's **Build Phases** > **Link Binary With Libraries**.


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

## In-stream Ad

In order to insure the best ad is ready when you wish to display it, please init the MobFox ad as soon as possible in your code:
```objective-c

//define the position and dimensions of your ad
CGRect  adRect = CGRectMake(0, 200, 320, 50);

//init your ad
MobFoxAd* mobfoxAd = [[MobFoxAd alloc] init:@"your-publication-hash" withFrame:adRect];

//add it tour view
[self.view addSubview: mobfoxAd];

```

### Ad Delegate
In order to be notified when certain ad events occur you can register a delegate:

```objective-c
//The delegate should implement the following protocol:
@protocol MobFoxAdDelegate <NSObject>

@optional

//called when ad is displayed
- (void)MobFoxAdDidLoad:(MobFoxAd *)banner;
 [self.view addSubview: mobfoxAd];
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
mobfoxAd.adDelegate = delegate;
```

### Show Ad
Later when you wish to display the ad:
```objective-c
//call to display ad
[mobfoxAd loadAd];
```

## Interstitial Ad

In order to insure the best ad is ready when you wish to display it, please init the MobFox inerstitial ad as soon as possible in your code:
```objective-c

//init the interstital ad giving it your main/root controller
MobFoxInterstitialAd* mobfoxInterAd = [[MobFoxInterstitialAd alloc] init:@"your-publication-hash" withMainViewController:self];
```    

### Ad Delegate
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

Set the delegate:

```objective-c
mobfoxInterAd.delegate = delegate;
```

### Show Ad
```objective-c
[mobfoxInterAd loadAd];
```
