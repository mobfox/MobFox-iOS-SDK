#import "MoPubInterstitialAdapterMobFox.h"

@implementation MoPubInterstitialAdapterMobFox

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info{

    NSLog(@"MoPub inter >> MobFox >> init");
    NSLog(@"MoPub inter >> MobFox >> data: %@",[info description]);
    self.mobFoxInterAd = [[MobFoxInterstitialAd alloc] init:[info valueForKey:@"invh"]];
    self.mobFoxInterAd.delegate = self;
    [self.mobFoxInterAd loadAd];
    
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
    NSLog(@"MoPub inter >> MobFox >> set root");
    self.mobFoxInterAd.rootViewController = rootViewController;
    [self.mobFoxInterAd show];
}

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
    NSLog(@"MoPub inter >> MobFox >> ad loaded");
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitial];
   
}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"MoPub inter >> MobFox >> ad error: %@",[error description]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial{
    [self.delegate interstitialCustomEventWillAppear:self];
    
}

- (void)MobFoxInterstitialAdClosed{
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)MobFoxInterstitialAdClicked{
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void)MobFoxInterstitialAdFinished{
    }

@end
