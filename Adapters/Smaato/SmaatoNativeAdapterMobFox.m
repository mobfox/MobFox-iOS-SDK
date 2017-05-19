//
//  SmaatoNativeAdapterMobFox.m
//  Adapters
//
//  Created by Shimi Sheetrit on 11/16/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "SmaatoNativeAdapterMobFox.h"

@implementation SmaatoNativeAdapterMobFox

- (void)loadNative {
    
    NSLog(@"MobFox >> Smaato banner >> loadNative");
    
    NSData *data = [self.network.customClassData dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *inv_h = [json objectForKey:@"AD_UNIT_ID"];
    NSLog(@"loadNative invh: %@", inv_h);
    self.native = [[MobFoxNativeAd alloc] init:inv_h];
    self.native.delegate = self;
    [self.native loadAd];
    
}

- (void)registerViewForUserInteraction:(UIView*)view withRootViewController:(UIViewController*)rootViewController {
}


#pragma mark MobFox Native Ad Delegate

//called when ad response is returned
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd *)ad withAdData:(MobFoxNativeData *)adData {
    
    NSLog(@"MobFox >> SmaatoNativeAdapterMobFox >> Got Ad");
    
    for (MobFoxNativeTracker *tracker in adData.trackersArray) {
        if ([tracker.url absoluteString].length > 0)
        {
            // Fire tracking pixel
            UIWebView* wv = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSString* userAgent = [wv stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
            //NSLog(@"userAgent: %@", userAgent);
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
    
    SOMANativeAdDTO* dto = [SOMANativeAdDTO new];
    dto.iconImageURL = adData.icon.url;
    dto.callToAction = adData.callToActionText;
    dto.title = adData.assetHeadline;
    dto.text = adData.assetDescription;
    
    [self.csmDelegate nativeCSMPluginDidLoad:self withDTO:dto];
    
}

- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"MobFox >> SmaatoNativeAdapterMobFox >> Error: %@", error);
    [self.csmDelegate nativeCSMPluginDidFail:self];
}


@end
