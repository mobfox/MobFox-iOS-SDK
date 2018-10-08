#import "MoPubInterstitialAdapterMobFox.h"
#import "MoPub.h"
#import "MPConsentManager.h"

@interface MoPubInterstitialAdapterMobFox()

@end

@implementation MoPubInterstitialAdapterMobFox

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info{

    NSLog(@"MoPub inter >> MobFox >> init");
    NSLog(@"MoPub inter >> MobFox >> data: %@",[info description]);
    
    MPBool gdpr= [[MoPub sharedInstance] isGDPRApplicable];
    NSString *consentStatusStr;
    
    MPConsentStatus consentStatus= [[MoPub sharedInstance] currentConsentStatus];
    
    if (consentStatus == MPConsentStatusConsented) {
        consentStatusStr = @"1";
    }
    else {
        consentStatusStr = @"0";
    }
    
    self.mobFoxInterAd = [[MobFoxInterstitialAd alloc] init:[info valueForKey:@"invh"]];
    self.mobFoxInterAd.adapter = @"mopub";
    self.mobFoxInterAd.gdpr = gdpr;
    self.mobFoxInterAd.gdpr_consent = consentStatusStr;
    
    self.mobFoxInterAd.delegate = self;
    [self.mobFoxInterAd loadAd];
    
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
    NSLog(@"MoPub inter >> MobFox >> set root");
    self.mobFoxInterAd.rootViewController = rootViewController;
    [self.mobFoxInterAd show];
}

#pragma mark MobFox Interstitial Ad Delegate

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
    NSLog(@"MoPub inter >> MobFox >> ad loaded");

   // [self.delegate trackImpression];
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitial];

}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"MoPub inter >> MobFox >> ad error: %@",[error description]);
    
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];

}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial {
    [self.delegate interstitialCustomEventWillAppear:self];
}

- (void)MobFoxInterstitialAdDidShow:(MobFoxInterstitialAd *)interstitial {
     [self.delegate interstitialCustomEventDidAppear:self];
}


- (void)MobFoxInterstitialAdClosed {
   [self.delegate interstitialCustomEventWillDisappear:self];
   [self.delegate interstitialCustomEventDidDisappear:self];
            
}

- (void)MobFoxInterstitialAdClicked {
    [self.delegate trackClick];
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void)MobFoxInterstitialAdFinished{
}

- (void)dealloc {
    
    self.mobFoxInterAd.delegate  = nil;
    self.mobFoxInterAd           = nil;
    
}
 
@end
