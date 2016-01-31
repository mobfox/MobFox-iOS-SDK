//
//  MobFoxNativeCustomEventFacebook.m
//  MobFox-iOS-Demo
//
//  Created by Shimi Sheetrit on 1/18/16.
//  Copyright © 2016 Shimi Sheetrit. All rights reserved.
//

#import "MobFoxNativeCustomEventFacebook.h"

@interface MobFoxNativeCustomEventFacebook ()

@property (nonatomic, strong) FBNativeAd *nativeAd;

@end

@implementation MobFoxNativeCustomEventFacebook



- (void)requestAdWithNetworkID:(NSString*)nid customEventInfo:(NSDictionary *)info {
    
    
    self.nativeAd = [[FBNativeAd alloc] initWithPlacementID:nid];
    self.nativeAd.delegate = self;
    
    // When testing on a device, add its hashed ID to force test ads.
    // The hash ID is printed to console when running on a device.
    [FBAdSettings addTestDevice:@"70906627c2231c2a8a79d733ff37bbe90f6a3a58"];
    
    [self.nativeAd loadAd];
    
}

- (void)registerViewWithInteraction:(UIView *)view withViewController:(UIViewController *)viewController {
    
    [self.nativeAd registerViewForInteraction:view
                        withViewController:viewController];
    
}


#pragma mark FB Native Ad Delegate

- (void)nativeAdDidLoad:(FBNativeAd *)nativeAd {
    
    NSLog(@"FB Native Ad Delegate - nativeAdDidLoad:");

    MobFoxNativeData *mobFoxNativeData = [[MobFoxNativeData alloc] init];
    
    mobFoxNativeData.icon = [[MobFoxNativeImage alloc] initWithURL:nativeAd.icon.url width:[NSNumber numberWithInteger:nativeAd.icon.width] height:[NSNumber numberWithInteger:nativeAd.icon.height]];
    mobFoxNativeData.main = [[MobFoxNativeImage alloc] initWithURL:nativeAd.coverImage.url width:[NSNumber numberWithInteger:nativeAd.coverImage.width]  height:[NSNumber numberWithInteger:nativeAd.coverImage.width] ];

    mobFoxNativeData.assetHeadline = nativeAd.title;
    mobFoxNativeData.assetDescription = nativeAd.body;
    mobFoxNativeData.callToActionText = nativeAd.callToAction;
    mobFoxNativeData.socialContext = nativeAd.socialContext;
    
    

    [self.delegate MFNativeCustomEventAd:self didLoad:mobFoxNativeData];
    
}

- (void)nativeAd:(FBNativeAd *)nativeAd didFailWithError:(NSError *)error {
    
    NSLog(@"FB Native Ad Delegate - Ad failed to load with error: %@", error);
    
    [self.delegate MFNativeCustomEventAdDidFailToReceiveAdWithError:error];
    
}



@end
