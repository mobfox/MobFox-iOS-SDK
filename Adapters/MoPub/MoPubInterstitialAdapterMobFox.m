#import "MoPubInterstitialAdapterMobFox.h"

@implementation MoPubInterstitialAdapterMobFox

- (id)init {
    
    self = [super init];
    if (self)
    {
        self.mobFoxInterAd = [[MobFoxInterstitialAd alloc] init:nil];
        self.mobFoxInterAd.delegate = self;
    }
    return self;
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info{

    NSLog(@"MoPub inter >> MobFox >> init");
    NSLog(@"MoPub inter >> MobFox >> data: %@",[info description]);

    self.mobFoxInterAd.ad.invh = [info valueForKey:@"invh"];
    [self.mobFoxInterAd loadAd];
        
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
    NSLog(@"MoPub inter >> MobFox >> set root");
    self.mobFoxInterAd.rootViewController = rootViewController;
    [self.mobFoxInterAd show];
}

-(BOOL)enableAutomaticImpressionAndClickTracking {
    
    return NO;
}

#pragma mark -
#pragma mark MobFoxInterstitialAdDelegate methods

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
    NSLog(@"MoPub inter >> MobFox >> ad loaded");
    [self.delegate trackImpression];
    [self.delegate interstitialCustomEvent:self didLoadAd:interstitial];
   
}

- (void)MobFoxInterstitialAdClicked{
    NSLog(@"MoPub inter >> MobFox >> MobFoxInterstitialAdClicked");
    [self.delegate trackClick];
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"MoPub inter >> MobFox >> ad error: %@",[error description]);
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial{
    NSLog(@"MoPub inter >> MobFox >> MobFoxInterstitialAdWillShow");
    [self.delegate interstitialCustomEventWillAppear:self];
    
}

- (void)MobFoxInterstitialAdClosed{
    NSLog(@"MoPub inter >> MobFox >> MobFoxInterstitialAdClosed");
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)MobFoxInterstitialAdFinished{
}

- (void)dealloc {
    
    self.mobFoxInterAd.ad.bridge = nil;
    self.mobFoxInterAd.ad        = nil;
    self.mobFoxInterAd           = nil;

}


@end
