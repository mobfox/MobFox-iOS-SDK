
#ifndef MoPubInterstitialAdapterMobFox_h
#define MoPubInterstitialAdapterMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPInterstitialCustomEvent.h"
#endif


@interface MoPubInterstitialAdapterMobFox : MPInterstitialCustomEvent<MobFoxInterstitialAdDelegate>

@property (strong, nonatomic) MobFoxInterstitialAd* mobFoxInterAd;

- (id)init;

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info;

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController;

@end

#endif
