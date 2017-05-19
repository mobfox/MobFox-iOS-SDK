#import "MoPubNativeAdapterMobFox.h"
#import "MPMobFoxNativeAdAdapter.h"
#import "MPNativeAd.h"
#import "MPNativeAdError.h"




@interface MoPubNativeAdapterMobFox()

@property(nonatomic,strong) MobFoxNativeAd* ad;

@end

@implementation MoPubNativeAdapterMobFox

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    
    
    [MFReport log:@"mopub" withInventoryHash:[info valueForKey:@"invh"] andWithMessage:@"request"];
    

    self.ad = [[MobFoxNativeAd alloc] init:[info valueForKey:@"invh"]];
    self.ad.delegate = self;
    
    if(info != nil) {
        self.ad.demo_gender = [info objectForKey:@"demo_gender"];
        self.ad.demo_age = [info objectForKey:@"demo_age"];
        self.ad.longitude = [info objectForKey:@"longitude"];
        self.ad.latitude = [info objectForKey:@"latitude"];
        self.ad.accuracy = [info objectForKey:@"accuracy"];
    }
    
    NSLog(@"MoPub >> MobFox >> request: %@",[info description]);

    [self.ad loadAd];
}

- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData {
    
    //NSLog(@"adData ---> %@", adData);
    NSLog(@"MoPub >> MobFox >> Native ad >> response: %@", [ad description]);
    
    [MFReport log:@"mopub" withInventoryHash:ad.invh andWithMessage:@"impression"];

    
    if (adData.icon.url == nil || adData.main.url == nil) {
        
        NSError *error = [NSError errorWithDomain:@"Empty data return from custom event" code:200 userInfo:nil];
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    
    // fires tracking pixel.
    for (MobFoxNativeTracker *tracker in adData.trackersArray) {
        
        if ([tracker.url absoluteString].length > 0)
        {
            // Fire tracking pixel
            UIWebView* wv = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSString* userAgent = [wv stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
            NSURLSessionConfiguration* conf = [NSURLSessionConfiguration defaultSessionConfiguration];
            conf.HTTPAdditionalHeaders = @{ @"User-Agent" : userAgent };
            NSURLSession* session = [NSURLSession sessionWithConfiguration:conf];
            NSURLSessionDataTask* task = [session dataTaskWithURL:tracker.url completionHandler:
                                          ^(NSData *data,NSURLResponse *response, NSError *error){
                                              
                                              if(error) NSLog(@"err %@",[error description]);
                                              
                                          }];
            [task resume];
            
        }
    }

    
    MPMobFoxNativeAdAdapter *adAdapter = [[MPMobFoxNativeAdAdapter alloc] initWithMobFoxNativeAd:adData];
    MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:adAdapter];
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    
    [imageURLs addObject:adData.icon.url];
    [imageURLs addObject:adData.main.url];
    
    
    //NSLog(@">> got image assets: %@",[imageURLs description]);
    
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
