//
//  MobFoxMoPubCustomAdapter.m
//  DemoApp
//
//  Created by ofirkariv on 11/12/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxMoPubCustomAdapter.h"




@interface MobFoxMoPubCustomAdapter () <MPNativeAdAdapter>



@property (nonatomic, strong) MobFoxNativeData *adData;

@end


@implementation MobFoxMoPubCustomAdapter

- (instancetype)initWithAd: (MobFoxNativeData *)ad{
    self = [super init];
    if (self) {
        self.localProperties = [NSMutableDictionary new];
        self.adData = ad;
    }
    return self;
}

- (void)setAdData:(MobFoxNativeData *)ad {
    _adData = ad;
    if (ad.assetHeadline) [self.localProperties setObject:ad.assetHeadline forKey:kAdTitleKey];
    if (ad.assetDescription) [self.localProperties setObject:ad.assetDescription forKey:kAdTextKey];
    if (ad.icon.url.absoluteString) [self.localProperties setObject:ad.icon.url.absoluteString forKey:kAdIconImageKey];
    if (ad.main.url.absoluteString) [self.localProperties setObject:ad.main.url.absoluteString forKey:kAdMainImageKey];
    if (ad.callToActionText) [self.localProperties setObject:ad.callToActionText forKey:kAdCTATextKey];
    if (ad.rating) [self.localProperties setObject:ad.rating forKey:kAdStarRatingKey];
    if (ad.clickURL.absoluteString) [self.localProperties setObject:ad.clickURL.absoluteString forKey:kDefaultActionURLKey]; 
    
    /* The next feature is native video, and was not developed in mobfox yet.
    self.localProperties[kVASTVideoKey] = ad.vastString;  */
}



- (NSURL *)defaultActionURL {
    return nil;
}

- (void)willAttachToView:(UIView *)view {
    if (!view) {
        return;
    }
    for (MobFoxNativeTracker* impressionTracker in _adData.trackersArray) {
        if ([impressionTracker.url absoluteString].length > 0)
        {
          
            UIWebView* wv = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSString* userAgent = [wv stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
            NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            configuration.HTTPAdditionalHeaders = @{ @"User-Agent" : userAgent };
            
            static NSURLSession * sharedSessionMainQueue = nil;
            if(!sharedSessionMainQueue){
                sharedSessionMainQueue = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
            }
            NSURLSessionDataTask* task = [sharedSessionMainQueue dataTaskWithURL:impressionTracker.url completionHandler:
                                          ^(NSData *data,NSURLResponse *response, NSError *error){
                                              
                                              if(error) NSLog(@"err %@",[error description]);
                                          }];
            [task resume];
            
        }
        
        
        
    }
    
  //  [self.ad registerViewForInteraction:view forClickableSubviews:nil];
}



- (void)trackClick{
    
    for (MobFoxNativeTracker* clickTracker in _adData.clickTrackersArray) {
        if ([clickTracker.url absoluteString].length > 0)
        {
            // Fire tracking pixel
            UIWebView* wv = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSString* userAgent = [wv stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
            NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            configuration.HTTPAdditionalHeaders = @{ @"User-Agent" : userAgent };
            
            static NSURLSession * sharedSessionMainQueue = nil;
            if(!sharedSessionMainQueue){
                sharedSessionMainQueue = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
            }
            NSURLSessionDataTask* task = [sharedSessionMainQueue dataTaskWithURL:clickTracker.url completionHandler:
                                          ^(NSData *data,NSURLResponse *response, NSError *error){
                                              
                                              if(error) NSLog(@"err %@",[error description]);
                                          }];
            [task resume];
            
        }
      
        
        
    }
}



- (void)displayContentForURL:(NSURL *)URL rootViewController:(UIViewController *)controller{
    
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.localProperties objectForKey:kDefaultActionURLKey]]];
}


- (NSDictionary *)properties {
    return self.localProperties;
}


@end
