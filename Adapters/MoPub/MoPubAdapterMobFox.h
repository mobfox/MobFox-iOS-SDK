#ifndef MoPubAdapterMobFox_h
#define MoPubAdapterMobFox_h

#ifdef  DemoAppDynamicTarget
#import <MobFoxSDKCoreDynamic/MobFoxSDKCoreDynamic.h>
#else
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#endif

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPBannerCustomEvent.h"
#endif

@interface MoPubAdapterMobFox : MPBannerCustomEvent <MobFoxAdDelegate>


- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info;

//- (BOOL)enableAutomaticImpressionAndClickTracking;

@end

#endif
