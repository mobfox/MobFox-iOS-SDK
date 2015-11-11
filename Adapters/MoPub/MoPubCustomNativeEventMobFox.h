#ifndef MoPubCustomNativeEventMobFox_h
#define MoPubCustomNativeEventMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPNativeCustomEvent.h"
#endif

#import <MobFoxSDKCore/MobFoxSDKCore.h>

@interface MoPubCustomNativeEventMobFox : MPNativeCustomEvent<MobFoxNativeAdDelegate>

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info;

@end

#endif