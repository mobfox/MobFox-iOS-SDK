//
//  GADMAdapterMobFox.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 6/22/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "GADMAdapterMobFox.h"
#import "MFEventsHandler.h"


@interface GADMAdapterMobFox()
@property (nonatomic, assign, getter=isSmart) BOOL smart;
@property (nonatomic, strong) MFEventsHandler *eventsHandler;


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
        _eventsHandler = [[MFEventsHandler alloc] init];
    }
    return self;
}

- (void)getBannerWithSize:(GADAdSize)adSize {
    
    
    [_eventsHandler resetAdEventBlocker];
    self.smart = NO;
    NSLog(@"MobFox >> GADMAdapterMobFox >> Ad Request");

    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    
    //The adapter should fail immediately if the adSize is not supported
    if (GADAdSizeEqualToSize(adSize, kGADAdSizeBanner) ||
        GADAdSizeEqualToSize(adSize, kGADAdSizeMediumRectangle) ||
        GADAdSizeEqualToSize(adSize, kGADAdSizeFullBanner) ||
        GADAdSizeEqualToSize(adSize, kGADAdSizeLeaderboard)) {
        
        self.banner = [[MobFoxAd alloc] init:invh withFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];
        self.banner.delegate = self;
        [self.banner loadAd];
        
        [MFReport log:@"admob" withInventoryHash:invh andWithMessage:@"request"];

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
        
        [MFReport log:@"admob" withInventoryHash:invh andWithMessage:@"request"];

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
    
    [_eventsHandler resetInterstitialEventBlocker];


    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    self.interstitial = [[MobFoxInterstitialAd alloc] init:invh];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
    
    [MFReport log:@"admob" withInventoryHash:invh andWithMessage:@"request"];
        
    
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

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner {
    
    __weak id weakself = self;
    
    [_eventsHandler invokeAdEventBlocker:^(BOOL isReported) {

        if (isReported) return;
        
        GADMAdapterMobFox *strongself = weakself;

        if(self.smart){
            [banner _changeWidth:[[UIScreen mainScreen] bounds].size.width];
        }
        if(strongself) {
            [strongself.connector adapter:self didReceiveAdView:banner];
        }
        
        [MFReport log:@"admob" withInventoryHash:banner.invh andWithMessage:@"impression"];

    }];
    

       
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error {
    
    __weak id weakself = self;
    
    [_eventsHandler invokeAdEventBlocker:^(BOOL isReported) {
 
        if (isReported) return;
            
        GADMAdapterMobFox *strongself = weakself;
        
        if(strongself) {
            [strongself.connector adapter:self didFailAd:error];
        }

        
    }];
    
    
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
    
    __weak id weakself = self;
    
    [_eventsHandler invokeInterstitialEventBlocker:^(BOOL isReported) {

        if (isReported) return;
            
        GADMAdapterMobFox *strongself = weakself;
        if(strongself) {
            [strongself.connector adapterDidReceiveInterstitial:self];
        }

        [MFReport log:@"admob" withInventoryHash:interstitial.invh andWithMessage:@"impression"];

    }];

}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    
    __weak id weakself = self;

    [_eventsHandler invokeInterstitialEventBlocker:^(BOOL isReported) {

        if (isReported) return;
        
        GADMAdapterMobFox *strongself = weakself;

        if(strongself) {
            [self.connector adapter:self didFailAd:error];
        }
        
    }];
    

}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial{
    
    [self.connector adapterWillPresentInterstitial:self];
}

//called when ad is closed/skipped
- (void)MobFoxInterstitialAdClosed{
    
    [self.connector adapterDidDismissInterstitial:self];
            
}

//called when ad is clicked
- (void)MobFoxInterstitialAdClicked {
    
    [self.connector adapterDidGetAdClick:self];
    [self.connector adapterWillLeaveApplication:self];
    
}

//called when if the ad is a video ad and it has finished playing
- (void)MobFoxInterstitialAdFinished{
}



- (void) dealloc{
    
    self.eventsHandler          = nil;
    self.banner.delegate        = nil;
    self.banner                 = nil;
    self.interstitial.delegate  = nil;
    self.interstitial           = nil;

}


@end
