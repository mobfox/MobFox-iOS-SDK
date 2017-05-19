//
//  MobFoxCustomEventUnity.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/28/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxInterstitialCustomEventApplifier.h"

@implementation MobFoxInterstitialCustomEventApplifier

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    NSLog(@"MF-Unity >>> request");
    [[UnityAds sharedInstance] setDelegate:self];
    [[UnityAds sharedInstance] setDebugMode:NO];
    [[UnityAds sharedInstance] setTestMode:NO];
    [[UnityAds sharedInstance] startWithGameId:networkId];
}

-(void)presentWithRootController:(UIViewController *)rootViewController{
    NSLog(@"MF-Unity >>> present");
    [[UnityAds sharedInstance] setViewController:rootViewController];
    [[UnityAds sharedInstance] show];
    
}

- (void)unityAdsVideoCompleted:(NSString *)rewardItemKey skipped:(BOOL)skipped{
    [self.delegate MFInterstitialCustomEventMobFoxAdFinished];
}

- (void)unityAdsDidHide{
    [self.delegate MFInterstitialCustomEventAdClosed];
}

- (void)unityAdsFetchCompleted {
    
    NSLog(@"MF-Unity >>> fetch complete");
    if ([[UnityAds sharedInstance] canShow])
    {
        NSLog(@"MF-Unity >>> show ad");
        // If both are ready, show the ad.
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
}

- (void)unityAdsFetchFailed{

     NSLog(@"MF-Unity >>> Failed to fetch ads");
     NSError* err = [NSError errorWithDomain:@"MF-Unity >>> Failed to fetch ads" code:0 userInfo:nil];
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:err];
}

@end




