//
//  RewardedAdmobAdapter.m
//  
//
//  Created by Shahaf Shmuel on 7/17/17.
//
//

#import "RewardedAdmobAdapter.h"
#import "MFAdNetworkExtras.h"

static NSString *const customEventErrorDomain = @"com.google.CustomEvent";


@interface RewardedAdmobAdapter ()
    
    @property (nonatomic, strong) MobFoxTagInterstitialAd* interstitial;
    @property (nonatomic, weak) id<GADMRewardBasedVideoAdNetworkConnector> connector;


@end


@implementation RewardedAdmobAdapter
+ (NSString *)adapterVersion {
    return @"1.0";
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return Nil;
}



- (void)stopBeingDelegate {
   
}


#pragma mark Reward-based Video Ad Methods


- (instancetype)initWithRewardBasedVideoAdNetworkConnector:
(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    if (!connector) {
        return nil;
    }
    
    self = [super init];
    self.connector = connector;
    return self;
}


- (void)setUp {
    [self.connector adapterDidSetUpRewardBasedVideoAd:self];
}




- (void)requestRewardBasedVideoAd {
    
    NSString *invh = [self.connector.credentials objectForKey:GADCustomEventParametersServer];
    self.interstitial = [[MobFoxTagInterstitialAd alloc] initWithAdMobAdaper:invh];
    self.interstitial.delegate = self;
    self.interstitial.v_rewarded = @"1";
    //self.interstitial.type = @"video";
    
    MFAdNetworkExtras *ne = [self.connector networkExtras];
    
    if (ne) {
        self.interstitial.gdpr = ne.gdpr;
        self.interstitial.gdpr_consent = ne.gdpr_consent;
    }
    [self.interstitial loadAd];

}


- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
    if(self.interstitial.ready){
        self.interstitial.rootViewController = viewController;
        [self.interstitial show];
    }
}



#pragma mark MobFox Interstitial Ad Delegate

- (void)MobFoxTagInterstitialAdDidLoad:(MobFoxTagInterstitialAd *)interstitial{
    [self.connector adapterDidReceiveRewardBasedVideoAd:self];
}

- (void)MobFoxTagInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    [self.connector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
}

- (void)MobFoxTagInterstitialAdWillShow:(MobFoxTagInterstitialAd *)interstitial{
    [self.connector adapterDidOpenRewardBasedVideoAd:self];
    
}

- (void)MobFoxTagInterstitialAdDidShow:(MobFoxTagInterstitialAd *)interstitial{
    
}


//called when ad is closed/skipped
- (void)MobFoxTagInterstitialAdClosed{
    
    [self.connector adapterDidCloseRewardBasedVideoAd:self];
    
}

//called when ad is clicked
- (void)MobFoxTagInterstitialAdClicked {
    
    [self.connector adapterDidGetAdClick:self];
    [self.connector adapterWillLeaveApplication:self];
    
}


- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial {
    
}

@end
