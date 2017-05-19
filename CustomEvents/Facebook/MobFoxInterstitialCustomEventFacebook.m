//
//  MobFoxInterstitialCustomEventFacebook.m
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 1/13/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxInterstitialCustomEventFacebook.h"

@interface MobFoxInterstitialCustomEventFacebook ()

@property (nonatomic, strong) FBInterstitialAd *interstitialAd;

@end

@implementation MobFoxInterstitialCustomEventFacebook


-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info {
    
    self.interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:networkId];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];
}

-(void)presentWithRootController:(UIViewController *)rootViewController {
    
    [self.interstitialAd showAdFromRootViewController:rootViewController];
}

#pragma mark FB Interstitial Ad Delegate

- (void)interstitialAdDidLoad:(FBInterstitialAd *)interstitialAd
{
    NSLog(@"FB Ad is loaded and ready to be displayed");
    // You can now display the full screen ad using this code:
    
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

- (void)interstitialAd:(FBInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"FB Ad failed to load");
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)interstitialAd
{
    NSLog(@"FB The user clicked on the ad and will be taken to its destination");
    // Use this function as indication for a user's click on the ad.
    
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

- (void)interstitialAdWillClose:(FBInterstitialAd *)interstitialAd
{
    NSLog(@"FB The user clicked on the close button, the ad is just about to close");
    // Consider to add code here to resume your app's flow
    
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)interstitialAd
{
    NSLog(@"FB Interstitial had been closed");
    // Consider to add code here to resume your app's flow
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}




@end
