#ifndef MoPubCustomNativeEventMobFox_h
#define MoPubCustomNativeEventMobFox_h

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPNativeCustomEvent.h"
#endif

#ifdef  DemoAppDynamicTarget
#import <MobFoxSDKCoreDynamic/MobFoxSDKCoreDynamic.h>
#else
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#endif

@interface MoPubNativeAdapterMobFox : MPNativeCustomEvent <MobFoxNativeAdDelegate>

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info;

@end

#endif
