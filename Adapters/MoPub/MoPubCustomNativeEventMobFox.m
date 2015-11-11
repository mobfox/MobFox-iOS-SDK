#import "MoPubCustomNativeEventMobFox.h"
#import "MoPubNativeAdapterMobFox.h"
#import "MPNativeAd.h"
#import "MPNativeAdError.h"

@interface MoPubCustomNativeEventMobFox()

@property(nonatomic,strong) MobFoxNativeAd* ad;

@end

@implementation MoPubCustomNativeEventMobFox

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info{
    self.ad = [[MobFoxNativeAd alloc] init:[info valueForKey:@"invh"]];
    self.ad.delegate = self;
}

- (void)MobFoxNativeAdDidLoad:(NSDictionary *)ad{
    
    MoPubNativeAdapterMobFox *adAdapter = [[MoPubNativeAdapterMobFox alloc] initWithMobFoxNativeAd:ad];
    MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:adAdapter];
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    
    NSDictionary* imageAssets = [ad valueForKey:@"imageassets"];
    [imageURLs addObject:[[imageAssets valueForKey:@"icon"] valueForKey:@"url"]];
    [imageURLs addObject:[[imageAssets valueForKey:@"main"] valueForKey:@"url"]];
   
    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray *errors) {
        if (errors) {
            NSLog(@"MoPub >> MobFox >> pre cache images errors: %@", errors);
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForImageDownloadFailure()];
        } else {
            [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
        }
    }];
}

- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error{
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
}


@end