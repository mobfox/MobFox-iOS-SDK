//
//  GADMAdapterMobFox.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 6/22/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "GADMAdapterMobFox.h"

@implementation GADMAdapterMobFox

#pragma mark GADMAdapterMobFox Delegate

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

- (void)getBannerWithSize:(GADAdSize)adSize {
    
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Ad Request");

    //The adapter should fail immediately if the adSize is not supported
    if (!GADAdSizeEqualToSize(adSize, kGADAdSizeBanner) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeMediumRectangle) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeFullBanner) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeLeaderboard)) {
        NSString *errorDesc =
        [NSString stringWithFormat:@"Invalid ad type %@, not going to get ad.",
         NSStringFromGADAdSize(adSize)];
        NSDictionary *errorInfo = [NSDictionary
                                   dictionaryWithObjectsAndKeys:errorDesc, NSLocalizedDescriptionKey, nil];
        NSError *error = [NSError errorWithDomain:kGADErrorDomain
                                             code:kGADErrorMediationInvalidAdSize
                                         userInfo:errorInfo];
        [self.connector adapter:self didFailAd:error];
        return;
    }

    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    self.banner = [[MobFoxAd alloc] init:invh withFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];
    self.banner.delegate = self;
    [self.banner loadAd];

}

- (void)getInterstitial {
    
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Ad Request");

    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    self.interstitial = [[MobFoxInterstitialAd alloc] init:invh];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)presentInterstitialFromRootViewController:
(UIViewController *)rootViewController {
    
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Display Request");
    
    if(self.interstitial.ready) {
        self.interstitial.rootViewController = rootViewController;
        [self.interstitial show];
    }
}

- (void)stopBeingDelegate {
    
    NSLog(@"MobFox >> GADMAdapterMobFox >> stopBeingDelegate");
}

- (BOOL)isBannerAnimationOK:(GADMBannerAnimationType)animType {
    
    return YES;
}


#pragma mark MobFox Ad Delegate

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Ad");
    
    [self.connector adapter:self didReceiveAdView:banner];
    
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"MobFox >> GADMAdapterMobFox >> Error: %@",[error description]);
    
    [self.connector adapter:self didFailAd:error];
    
}

- (void)MobFoxAdClicked {
    
    [self.connector adapterDidGetAdClick:self];
    [self.connector adapterWillLeaveApplication:self];
}

- (void)MobFoxAdClosed {
}

- (void)MobFoxAdFinished {
}


#pragma mark MobFox Interstitial Ad Delegate

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
    
    NSLog(@"MobFox >> GADMAdapterMobFox >> Interstitial Ad Loaded");
    
    [self.connector adapterDidReceiveInterstitial:self];

}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"MobFox >> GADMAdapterMobFox >> Interstitial Ad Load Error: %@",[error description]);
    
    [self.connector adapter:self didFailAd:error];

}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial{
    NSLog(@"MobFox >> GADMAdapterMobFox >> Interstitial Ad will show");
    [self.connector adapterWillPresentInterstitial:self];
}

//called when ad is closed/skipped
- (void)MobFoxInterstitialAdClosed{
    NSLog(@"MobFox >> GADMAdapterMobFox >> Interstitial Ad Closed");
    [self.connector adapterDidDismissInterstitial:self];
}

//called when ad is clicked
- (void)MobFoxInterstitialAdClicked {
    NSLog(@"MobFox >> GADMAdapterMobFox >> Interstitial Ad Clicked");
    [self.connector adapterDidGetAdClick:self];
    [self.connector adapterWillLeaveApplication:self];
}

//called when if the ad is a video ad and it has finished playing
- (void)MobFoxInterstitialAdFinished{
}

- (void) dealloc{
    
    [self stopBeingDelegate];
    self.banner.bridge          = nil;
    self.banner                 = nil;
    self.interstitial           = nil;
    self.interstitial.ad        = nil;
    self.interstitial.ad.bridge = nil;
}


@end
