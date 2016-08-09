#import "MoPubNativeAdapterMobFox.h"
#import "MPMobFoxNativeAdAdapter.h"
#import "MPNativeAd.h"
#import "MPNativeAdError.h"

@interface MoPubNativeAdapterMobFox()

@property(nonatomic,strong) MobFoxNativeAd* ad;

@end

@implementation MoPubNativeAdapterMobFox

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info{
    NSLog(@"dict %@",[info description]);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.ad = [[MobFoxNativeAd alloc] init:[info valueForKey:@"invh"]];
    });
    self.ad.delegate = self;
    [self.ad loadAd];
}

- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData {
    
    NSLog(@"adData ---> %@", adData);
    NSLog(@"MoPub >> MobFox >> Native ad >> response: %@",[ad description]);
    
    MPMobFoxNativeAdAdapter *adAdapter = [[MPMobFoxNativeAdAdapter alloc] initWithMobFoxNativeAd:adData];
    MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:adAdapter];
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    
    [imageURLs addObject:adData.icon.url];
    [imageURLs addObject:adData.main.url];
    
    
    NSLog(@">> got image assets: %@",[imageURLs description]);
    
    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray *errors) {
        
        NSLog(@"MoPub >> MobFox >> Native ad >> cached images");
        
        if (errors) {
            NSLog(@"MoPub >> MobFox >> pre cache images errors: %@", errors);
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:MPNativeAdNSErrorForImageDownloadFailure()];
        } else {
            [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
        }
    }];
}

- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"MoPub >> MobFox >> Native ad >> error: %@",[error description]);
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
}


@end