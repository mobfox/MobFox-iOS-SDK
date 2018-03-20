#import "MoPubInterstitialAdapterMobFox.h"

@interface MoPubInterstitialAdapterMobFox()

@end

@implementation MoPubInterstitialAdapterMobFox

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info{

    NSLog(@"MoPub inter >> MobFox >> init");
    NSLog(@"MoPub inter >> MobFox >> data: %@",[info description]);
    
    self.mobFoxInterAd = [[MobFoxTagInterstitialAd alloc] init:[info valueForKey:@"invh"]];
    self.mobFoxInterAd.delegate = self;
    [self.mobFoxInterAd loadAd];
    
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
    NSLog(@"MoPub inter >> MobFox >> set root");
    self.mobFoxInterAd.rootViewController = rootViewController;
    [self.mobFoxInterAd show];
}

#pragma mark MobFox Interstitial Ad Delegate

- (void)MobFoxTagInterstitialAdDidLoad:(MobFoxTagInterstitialAd *)interstitial{
    NSLog(@"MoPub inter >> MobFox >> ad loaded");

   // [self.delegate trackImpression];
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitial];

}

- (void)MobFoxTagInterstitialAdDidFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"MoPub inter >> MobFox >> ad error: %@",[error description]);
    
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];

}

- (void)MobFoxTagInterstitialAdWillShow:(MobFoxTagInterstitialAd *)interstitial {
    [self.delegate interstitialCustomEventWillAppear:self];
}

- (void)MobFoxTagInterstitialAdDidShow:(MobFoxTagInterstitialAd *)interstitial {
     [self.delegate interstitialCustomEventDidAppear:self];
}


- (void)MobFoxTagInterstitialAdClosed {
   [self.delegate interstitialCustomEventWillDisappear:self];
   [self.delegate interstitialCustomEventDidDisappear:self];
            
}

- (void)MobFoxTagInterstitialAdClicked {
    [self.delegate trackClick];
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void)MobFoxTagInterstitialAdFinished{
}

- (void)dealloc {
    
    self.mobFoxInterAd.delegate  = nil;
    self.mobFoxInterAd           = nil;
    
}
 
@end
