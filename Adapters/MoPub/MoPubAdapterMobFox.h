#ifndef MoPubAdapterMobFox_h
#define MoPubAdapterMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPBannerCustomEvent.h"
#endif

@interface MoPubAdapterMobFox : MPBannerCustomEvent <MobFoxAdDelegate>

@property (strong, nonatomic) MobFoxAd* ad;

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info;

- (BOOL)enableAutomaticImpressionAndClickTracking;

@end

#endif
