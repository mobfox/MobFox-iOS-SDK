
#ifndef MoPubInterstitialAdapterMobFox_h
#define MoPubInterstitialAdapterMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "MPInterstitialCustomEvent.h"

@interface MoPubInterstitialAdapterMobFox : MPInterstitialCustomEvent<MobFoxInterstitialAdDelegate>

@property MobFoxInterstitialAd* mobFoxInterAd;

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info;

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController;

@end

#endif