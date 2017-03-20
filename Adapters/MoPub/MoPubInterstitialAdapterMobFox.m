#import "MoPubInterstitialAdapterMobFox.h"
#import "MFEventsHandler.h"


@interface MoPubInterstitialAdapterMobFox()

@property (nonatomic, strong) MFEventsHandler *eventsHandler;

@end

@implementation MoPubInterstitialAdapterMobFox

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info{

    NSLog(@"MoPub inter >> MobFox >> init");
    NSLog(@"MoPub inter >> MobFox >> data: %@",[info description]);
    
    [MFReport log:@"mopub" withInventoryHash:[info valueForKey:@"invh"] andWithMessage:@"request"];
    
    _eventsHandler = [[MFEventsHandler alloc] init];
    [_eventsHandler resetInterstitialEventBlocker];

    self.mobFoxInterAd = [[MobFoxInterstitialAd alloc] init:[info valueForKey:@"invh"]];
    self.mobFoxInterAd.delegate = self;
    [self.mobFoxInterAd loadAd];
        
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
    NSLog(@"MoPub inter >> MobFox >> set root");
    self.mobFoxInterAd.rootViewController = rootViewController;
    [self.mobFoxInterAd show];
}

- (BOOL)enableAutomaticImpressionAndClickTracking
{
    // Subclasses may override this method to return NO to perform impression and click tracking
    // manually.
    return NO;
}

#pragma mark MobFox Interstitial Ad Delegate

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
    NSLog(@"MoPub inter >> MobFox >> ad loaded");
    
    __weak id weakself = self;
    
    
     [_eventsHandler invokeInterstitialEventBlocker:^(BOOL isReported) {

        if (isReported) return;
            
        MoPubInterstitialAdapterMobFox *strongself = weakself;

         if(strongself) {
             [strongself.delegate trackImpression];
             [strongself.delegate interstitialCustomEvent:self didLoadAd:interstitial];
        }
         
        [MFReport log:@"mopub" withInventoryHash:interstitial.invh andWithMessage:@"impression"];

    }];

   
}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"MoPub inter >> MobFox >> ad error: %@",[error description]);
    
    __weak id weakself = self;

    [_eventsHandler invokeInterstitialEventBlocker:^(BOOL isReported) {

        if (isReported) return;
        
        MoPubInterstitialAdapterMobFox *strongself = weakself;

        if(strongself) {
            [strongself.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
        }

        
    }];
    
}

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial {
    
    [self.delegate interstitialCustomEventWillAppear:self];
    
}

- (void)MobFoxInterstitialAdClosed {
    
   [self.delegate interstitialCustomEventDidDisappear:self];
            
}

- (void)MobFoxInterstitialAdClicked {
    

    [self.delegate trackClick];
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
    
}

- (void)MobFoxInterstitialAdFinished{
}

- (void)dealloc {
    
    //self.mobFoxInterAd.ad.bridge = nil;
    //self.mobFoxInterAd.ad        = nil;
    _eventsHandler               = nil;
    self.mobFoxInterAd.delegate  = nil;
    self.mobFoxInterAd           = nil;
    
}
 
@end
