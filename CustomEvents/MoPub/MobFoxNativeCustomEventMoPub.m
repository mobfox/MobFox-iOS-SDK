//
//  MobFoxNativeCustomEventMoPub.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/14/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxNativeCustomEventMoPub.h"
#import "MPNativeAdRequest.h"
#import "MPNativeAd.h"

@implementation MobFoxNativeCustomEventMoPub

- (void)requestAdWithNetworkID:(NSString*)nid customEventInfo:(NSDictionary *)info{
    
    NSArray* empty = [NSArray array];
    MPNativeAdRequest* req = [MPNativeAdRequest requestWithAdUnitIdentifier:nid rendererConfigurations:empty];
    [req startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd* response, NSError *error) {
        if(error){
            [self.delegate MFNativeCustomEventAdDidFailToReceiveAdWithError:error];
            return;
        }
        
        [self.delegate MFNativeCustomEventAd:self didLoad:[response properties]];
    }];
}


@end
