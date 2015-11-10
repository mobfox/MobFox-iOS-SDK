#ifndef MoPubAdapterMobFox_h
#define MoPubAdapterMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "MPBannerCustomEvent.h"

@interface MoPubAdapterMobFox : MPBannerCustomEvent<MobFoxAdDelegate>

@property MobFoxAd* ad;

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info;

@end

#endif