//
//  GADMNativeAdapterMobFox.m
//  Adapters
//
//  Created by Shimi Sheetrit on 12/7/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "GADMNativeAdapterMobFox.h"
#import "MFEventsHandler.h"

@interface GADMNativeAdapterMobFox()

@property (nonatomic, strong) MFEventsHandler *eventsHandler;

@end


@implementation GADMNativeAdapterMobFox

#pragma mark GADMAdNetworkAdapter Delegate


+ (NSString *)adapterVersion {
    
    return @"1.0";
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    
    return nil;
}

- (id)initWithGADMAdNetworkConnector:(id<GADMAdNetworkConnector>)c {
    if ((self = [super init])) {
        _connector = c;

    }
    return self;
}

- (void)requestNativeAdWithParameter:(NSString *)serverParameter
                             request:(GADCustomEventRequest *)request
                             adTypes:(NSArray *)adTypes
                             options:(NSArray *)options
                  rootViewController:(UIViewController *)rootViewController {
    
    NSLog(@"MobFox >> GADMNativeAdapterMobFox >> Got Native Ad Request");
    
    [_eventsHandler resetNativeEventBlocker];

    self.native = [[MobFoxNativeAd alloc] init:serverParameter];
    self.native.delegate = self;
    [self.native loadAd];
    
    [MFReport log:@"admob" withInventoryHash:serverParameter andWithMessage:@"request"];
    

}

/*
- (void)getNativeAdWithAdTypes:(NSArray *)adTypes options:(NSArray *)options {
    
    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    self.native = [[MobFoxNativeAd alloc] init:invh];
    self.native.delegate = self;
    [self.native loadAd];
    
}*/


#pragma mark MobFox Native Ad Delegate

//called when ad response is returned
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd *)ad withAdData:(MobFoxNativeData *)adData {
    
    NSLog(@"MobFox >> GADMNativeAdapterMobFox >> Native Ad Loaded");
    
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
    
    [MFReport log:@"admob" withInventoryHash:ad.invh andWithMessage:@"impression"];

    
    //MFMediatedNativeContentAd_ *mediatedNativeContentAd = [[MFMediatedNativeContentAd_ alloc] initWithMFNativeContentAd:adData];
   // MFMediatedNativeContentAd_ *mediatedNativeContentAd = [[MFMediatedNativeContentAd_ alloc] init];
   // [self.delegate customEventNativeAd:self didReceiveMediatedNativeAd:mediatedNativeContentAd];
    
    
    //MFMediatedNativeContentAd_ *media = [[MFMediatedNativeContentAd_ alloc] init];
    //[media changeStatus];
    
    //MFMediatedNativeContentAd_ *media = [[MFMediatedNativeContentAd_ alloc] initWithMFNativeContentAd:nil];

    
    
    
}

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"MobFox >> GADMNativeAdapterMobFox >> DidFailToReceiveAdWithError: %@", [error description]);
        
    [self.delegate customEventNativeAd:self didFailToLoadWithError:error];

}


#pragma mark GADCustomEventNativeAd Delegate

- (BOOL)handlesUserClicks {
    
    return YES;
    
}

- (BOOL)handlesUserImpressions {
    
    return YES;

}


@end
