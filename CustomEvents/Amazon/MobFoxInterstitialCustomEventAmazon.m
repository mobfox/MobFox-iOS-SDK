//
//  MobFoxInterstitialCustomEventAmazon.m
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#import "MobFoxInterstitialCustomEventAmazon.h"

@interface MobFoxInterstitialCustomEventAmazon()
    @property(nonatomic,weak) UIViewController* root;
@end

@implementation MobFoxInterstitialCustomEventAmazon

//============================================================================

- (void)interstitialDidLoad:(AmazonAdInterstitial *)interstitial
{
    NSLog(@"dbg: ### AMAZON: >>> INTERSTITIAL AMAZON: interstitialDidLoad <<<");
    
    if(interstitial.isReady) {
        
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
    
}

-(void)presentWithRootController:(UIViewController *)rootViewController{
    
    [self.interstitialAd presentFromViewController:rootViewController];
    
}

// Sent when load has failed, typically because of network failure, an application configuration error or lack of interstitial inventory
- (void)interstitialDidFailToLoad:(AmazonAdInterstitial *)interstitial withError:(AmazonAdError *)error
{
    NSLog(@"dbg: ### AMAZON: >>> INTERSTITIAL AMAZON: interstitialDidFailToLoad %@ <<<",error.errorDescription);
    
    NSError *myErr = [NSError errorWithDomain:error.errorDescription
                                         code:error.errorCode
                                     userInfo:nil];
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:myErr];
}

// Sent immediately before interstitial is presented on the screen. At this point you should pause any animations, timers or other
// activities that assume user interaction and save app state. User may press Home or touch links to other apps like iTunes within the
// interstitial, leaving your app.
- (void)interstitialWillPresent:(AmazonAdInterstitial *)interstitial
{
    
}

// Sent when interstitial has been presented on the screen.
- (void)interstitialDidPresent:(AmazonAdInterstitial *)interstitial
{
    NSLog(@"dbg: ### AMAZON: >>> INTERSTITIAL AMAZON: interstitialDidPresent <<<");
}

// Sent immediately before interstitial leaves the screen, restoring your app and your view controller used for presentAdFromViewController:.
// At this point you should restart any foreground activities paused as part of interstitialWillPresent:.
- (void)interstitialWillDismiss:(AmazonAdInterstitial *)interstitial
{
    
}

// Sent when the user has dismissed interstitial and it has left the screen.
- (void)interstitialDidDismiss:(AmazonAdInterstitial *)interstitial
{
    NSLog(@"dbg: ### AMAZON: >>> INTERSTITIAL AMAZON: interstitialDidDismiss <<<");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}

//============================================================================

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Amazon: loadAd ###");
    NSLog(@"dbg: ### Amazon: params: %@",info);
    NSLog(@"dbg: ### Amazon: networkID: %@",networkId);
    
    [[AmazonAdRegistration sharedRegistration] setAppKey:networkId];

    // Create an interstitial
    self.interstitialAd = [AmazonAdInterstitial amazonAdInterstitial];
    
    // Register the ViewController with the delegate to receive callbacks.
    self.interstitialAd.delegate = self;
    
    // Set the adOptions.
    AmazonAdOptions *options = [AmazonAdOptions options];
    
    // Turn on isTestRequest to load a test interstitial
    options.isTestRequest = YES;
    
    // Load an interstitial
    [self.interstitialAd load:options];
}

-(void)dealloc{
    self.interstitialAd.delegate = nil;
    self.interstitialAd = nil;
}
@end