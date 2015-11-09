//
//  GADInterstitialAdapterMobFox.m
//  BannerExample
//
//  Created by Itamar Nabriski on 11/4/15.
//  Copyright © 2015 Google. All rights reserved.
//

#import "GADInterstitialAdapterMobFox.h"

@implementation GADInterstitalAdapterMobFox

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)request{
    
    NSLog(@"MobFox >> GADInterstitialAdapterMobFox >> Got Ad Request");
    self.interstitial = [[MobFoxInterstitialAd alloc] init:serverParameter];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    
     NSLog(@"MobFox >> GADInterstitialAdapterMobFox >> Got Display Request");
    self.interstitial.rootViewController = rootViewController;
    [self.interstitial show];
}

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
   
     NSLog(@"MobFox >> GADInterstitialAdapterMobFox >> Ad Loaded");
     [self.delegate customEventInterstitialDidReceiveAd:self];
}


- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
     NSLog(@"MobFox >> GADInterstitialAdapterMobFox >> Ad Load Error: %@",[error description]);
    [self.delegate customEventInterstitial:self didFailAd:error];
}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial{
     NSLog(@"MobFox >> GADInterstitialAdapterMobFox >> Ad will show");
    [self.delegate customEventInterstitialWillPresent:self];
}

//called when ad is closed/skipped
- (void)MobFoxInterstitialAdClosed{
    [self.delegate customEventInterstitialDidDismiss:self];
}

//called when ad is clicked
- (void)MobFoxInterstitialAdClicked{
    [self.delegate customEventInterstitialWasClicked:self];
    [self.delegate customEventInterstitialWillLeaveApplication:self];
}

//called when if the ad is a video ad and it has finished playing
- (void)MobFoxInterstitialAdFinished{
}

-(void) dealloc{
    self.delegate = nil;
}


@end
