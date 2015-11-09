//
//  MobFoxInterstitialCustomEventAdMob.m
//  BannerExample
//
//  Created by Itamar Nabriski on 11/3/15.
//  Copyright © 2015 Google. All rights reserved.
//

#import "MobFoxInterstitialCustomEventAdMob.h"

@interface MobFoxInterstitialCustomEventAdMob()
    @property(nonatomic,weak) UIViewController* root;
@end

@implementation MobFoxInterstitialCustomEventAdMob

- (void)requestInterstitialWithRootController:(UIViewController *)rootViewController networkId:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    
    self.root = rootViewController;
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:networkId];
    self.interstitial.delegate = self;
    GADRequest* request = [GADRequest request];
    //request.testDevices = @[ kGADSimulatorID ];
    
    [self.interstitial loadRequest:request];
}

// Sent when an interstitial ad request succeeded.  Show it at the next
// transition point in your application such as when transitioning between view
// controllers.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self.root];
    }
}

// Sent when an interstitial ad request completed without an interstitial to
// show.  This is common since interstitials are shown sparingly to users.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error{
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}



// Sent just before presenting an interstitial.  After this method finishes the
// interstitial will animate onto the screen.  Use this opportunity to stop
// animations and save the state of your application in case the user leaves
// while the interstitial is on screen (e.g. to visit the App Store from a link
// on the interstitial).
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

// Sent before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
}

// Sent just after dismissing an interstitial and it has animated off the
// screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    [self.delegate MFInterstitialCustomEventAdClosed];
}

// Sent just before the application will background or terminate because the
// user clicked on an ad that will launch another application (such as the App
// Store).  The normal UIApplicationDelegate methods, like
// applicationDidEnterBackground:, will be called immediately before this.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

-(void)dealloc{
    self.interstitial = nil;
}
@end
