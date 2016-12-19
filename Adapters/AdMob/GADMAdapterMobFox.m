//
//  GADMAdapterMobFox.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 6/22/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "GADMAdapterMobFox.h"

@interface GADMAdapterMobFox()
@property (nonatomic, assign) BOOL smart;
@end

@implementation GADMAdapterMobFox

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

- (void)getBannerWithSize:(GADAdSize)adSize {
    
    self.smart = NO;
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Ad Request");

    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    
    //The adapter should fail immediately if the adSize is not supported
    if (GADAdSizeEqualToSize(adSize, kGADAdSizeBanner) ||
        GADAdSizeEqualToSize(adSize, kGADAdSizeMediumRectangle) ||
        GADAdSizeEqualToSize(adSize, kGADAdSizeFullBanner) ||
        GADAdSizeEqualToSize(adSize, kGADAdSizeLeaderboard)) {
        /**/
        
        self.banner = [[MobFoxAd alloc] init:invh withFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];
        self.banner.delegate = self;
        [self.banner loadAd];
        return;
    }
    
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerPortrait) && UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        float width = 320.0f;
        float height = 50.0f;
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            width = 728.0f;
            height = 90.0f;
        }
        
        self.banner = [[MobFoxAd alloc] init:invh withFrame:CGRectMake(0, 0, width, height)];
        self.banner.delegate = self;
        [self.banner loadAd];
        self.smart = YES;
        return;
    }
            
    NSString *errorDesc =
    [NSString stringWithFormat:@"Invalid ad type %@.",NSStringFromGADAdSize(adSize)];
    NSLog(@"MobFox >> GADAdapterMobFox: %@",errorDesc);
            
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:errorDesc, NSLocalizedDescriptionKey, nil];
    NSError *error = [NSError errorWithDomain:kGADErrorDomain
                            code:kGADErrorMediationInvalidAdSize
                            userInfo:errorInfo];
    [self.connector adapter:self didFailAd:error];
            

}

- (void)getInterstitial {
    
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Interstitial Ad Request");

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

}

- (BOOL)isBannerAnimationOK:(GADMBannerAnimationType)animType {
    
    return YES;
}


#pragma mark MobFox Ad Delegate

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Ad");
    
    if(self.smart){
        [banner _changeWidth:[[UIScreen mainScreen] bounds].size.width];
    }
  
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
    
    self.banner.delegate        = nil;
    self.banner                 = nil;
    self.interstitial.delegate  = nil;
    self.interstitial           = nil;

}


@end
