#ifndef MoPubAdapterMobFox_h
#define MoPubAdapterMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPBannerCustomEvent.h"
#endif

@interface MoPubAdapterMobFox : MPBannerCustomEvent<MobFoxAdDelegate>

@property MobFoxAd* ad;

- (id) init;

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info;

@end

#endif