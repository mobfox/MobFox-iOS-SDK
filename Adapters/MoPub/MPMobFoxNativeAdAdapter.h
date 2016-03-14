#ifndef MoPubNativeAdapterMobFox_h
#define MoPubNativeAdapterMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPNativeAdAdapter.h"
#endif

@interface MPMobFoxNativeAdAdapter : NSObject<MPNativeAdAdapter>

@property (nonatomic, readonly) NSDictionary *properties;

/**
 * The default click-through URL for the ad.
 *
 * This may safely be set to nil if your network doesn't expose this value (for example, it may only
 * provide a method to handle a click, lacking another for retrieving the URL itself).
 */
@property (nonatomic, readonly) NSURL *defaultActionURL;

/**
 * The `MPNativeAdAdapterDelegate` to send messages to as events occur.
 *
 * The `delegate` object defines several methods that you should call in order to inform MoPub
 * of interactions with the ad. This delegate needs to be implemented if third party impression and/or
 * click tracking is enabled.
 */
@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;

- (instancetype)initWithMobFoxNativeAd:(MobFoxNativeData *)ad;


@end

#endif