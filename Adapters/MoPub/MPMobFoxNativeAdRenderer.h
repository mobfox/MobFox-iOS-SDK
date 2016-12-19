#ifndef MPMobFoxNativeAdRenderer_h
#define MPMobFoxNativeAdRenderer_h

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPStaticNativeAdRenderer.h"
#endif

@interface MPMobFoxNativeAdRenderer : MPStaticNativeAdRenderer


@end

#endif