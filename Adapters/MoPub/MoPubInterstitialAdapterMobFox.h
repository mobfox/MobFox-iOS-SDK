
#ifndef MoPubInterstitialAdapterMobFox_h
#define MoPubInterstitialAdapterMobFox_h

#ifdef  DemoAppDynamicTarget
#import <MobFoxSDKCoreDynamic/MobFoxSDKCoreDynamic.h>
#else
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#endif

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPInterstitialCustomEvent.h"
#endif

//
@interface MoPubInterstitialAdapterMobFox : MPInterstitialCustomEvent<MobFoxInterstitialAdDelegate>

@property (strong, nonatomic) MobFoxInterstitialAd* mobFoxInterAd;

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info;

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController;

//- (BOOL)enableAutomaticImpressionAndClickTracking;


@end

#endif
