//
//  GADMAdapterMobFox.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 6/22/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "GADMAdapterMobFox.h"
#import "MFAdNetworkExtras.h"

@interface GADMAdapterMobFox()

//@property (nonatomic, strong) MFEventsHandler *eventsHandler;
@property (nonatomic, strong) MobFoxAd* banner;
@property (nonatomic, strong) MobFoxInterstitialAd* interstitial;
@property (nonatomic, weak) id <GADMAdNetworkConnector> connector;

@property (nonatomic) CGRect bannerAdRect;

@end

@implementation GADMAdapterMobFox

#pragma mark GADMAdNetworkAdapter Delegate

+ (NSString *)adapterVersion {
    
    return @"1.2";
}

//+ (Class<GADAdNetworkExtras>)networkExtrasClass {
//
//    return nil;
//}


+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return [MFAdNetworkExtras class];
}



- (id)initWithGADMAdNetworkConnector:(id<GADMAdNetworkConnector>)c {
    if ((self = [super init])) {
        _connector = c;
        //_eventsHandler = [[MFEventsHandler alloc] init];
    }
    
    
//    //  GMA SDK forward consent patameters into onto the adapters
//    
//    NSDictionary *cred= [self.connector credentials];
//
//    NSString *publisherId = [self.connector publisherId];
//    BOOL testMode = [self.connector testMode];
//    NSNumber *childDirectedTreatment = [self.connector childDirectedTreatment];
//    GADGender gn= [self.connector userGender];
//    NSDate *userBirthday = [self.connector userBirthday];
//    BOOL userHasLocation = [self.connector userHasLocation];
//    
//    
//    CGFloat userLatitude = [self.connector userLatitude];
//    CGFloat userLongitude = [self.connector userLongitude];
//    CGFloat userLocationAccuracyInMeters = [self.connector userLocationAccuracyInMeters];
//    
//    NSString *userLocationDescription = [self.connector userLocationDescription];
//    NSArray *userKeywords = [self.connector userKeywords];
//    
//    //NSDictionary *additionalParameters = [self.connector additionalParameters];
//    //BOOL isTesting = [self.connector isTesting];
//
//    
//    // NSDictionary *ne = [self.connector networkExtras];
//    // [[self.connector credentials] objectForKey:@"ad_unit"];
//    // NSLog(@"cred=%@",cred);
    
    
    return self;
}

- (void)getBannerWithSize:(GADAdSize)adSize {
    
    
    
    //[_eventsHandler resetAdEventBlocker];
   
    NSLog(@"MobFox >> GADMAdapterMobFox >> Ad Request");

    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    
    if (GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerPortrait) || GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerLandscape)){
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat bannerHeight;
        
        if (GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerPortrait)) {
            bannerHeight = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 90.0 : 50.0;

        } else {
            bannerHeight = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 90.0 : 32.0;
            
        }
        
        //NSLog(@"screen width: %f   banner height: %f", screenWidth, bannerHeight);
        
        self.bannerAdRect = CGRectMake(0,0, screenWidth, bannerHeight);
        self.banner = [[MobFoxAd alloc] init:invh withFrame:self.bannerAdRect];
        
        
        MFAdNetworkExtras *ne = [self.connector networkExtras];
        
        if (ne) {
            self.banner.gdpr = ne.gdpr;
            self.banner.gdpr_consent = ne.gdpr_consent;
        }
        
        self.banner.delegate = self;
        [self.banner loadAd];
        
        //[MFReport log:@"admob" withInventoryHash:invh andWithMessage:@"request" requestID:self.banner.requestID];
        
        return;
        
    }
    

    
    self.bannerAdRect = CGRectMake(0,0, adSize.size.width, adSize.size.height);
    self.banner = [[MobFoxAd alloc] init:invh withFrame:self.bannerAdRect];
    
    MFAdNetworkExtras *ne = [self.connector networkExtras];
    
    if (ne) {
        self.banner.gdpr = ne.gdpr;
        self.banner.gdpr_consent = ne.gdpr_consent;
    }
    
    self.banner.delegate = self;
    [self.banner loadAd];
    
//    [MFReport log:@"admob" withInventoryHash:invh andWithMessage:@"request" requestID:self.banner.requestID];
    

}

- (void)getInterstitial {
    
    NSLog(@"MobFox >> GADMAdapterMobFox >> Got Interstitial Ad Request");
    

    
    NSString *invh = [[self.connector credentials] objectForKey:@"pubid"];
    self.interstitial = [[MobFoxInterstitialAd alloc] init:invh];
    
    MFAdNetworkExtras *ne = [self.connector networkExtras];
    
    if (ne) {
        self.interstitial.gdpr = ne.gdpr;
        self.interstitial.gdpr_consent = ne.gdpr_consent;
    }
    
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
    
  //  [MFReport log:@"admob" withInventoryHash:invh andWithMessage:@"request" requestID:self.interstitial.requestID];
        
    
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
    NSLog(@"MobFox >> GADMAdapterMobFox >> Ad Loaded");
    [self.connector adapter:self didReceiveAdView:banner];
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"MobFox >> GADMAdapterMobFox >> Ad Loaded Failed: %@", error);
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
    
    NSLog(@"admob >>> MobFoxInterstitialAdDidLoad:");
    
    [self.connector adapterDidReceiveInterstitial:self];
        
   // [MFReport log:@"admob" withInventoryHash:interstitial.invh andWithMessage:@"impression" requestID:interstitial.requestID];
}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    [self.connector adapter:self didFailAd:error];
}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial{
    
    [self.connector adapterWillPresentInterstitial:self];
}

- (void)MobFoxInterstitialAdDidShow:(MobFoxInterstitialAd *)interstitial {
    
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
    //self.eventsHandler          = nil;
    self.banner.delegate        = nil;
    self.banner                 = nil;
    self.interstitial.delegate  = nil;
    self.interstitial           = nil;
}

@end
