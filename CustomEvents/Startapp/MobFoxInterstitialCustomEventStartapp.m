//
//  MobFoxInterstitialCustomEventStartapp.m
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#import "MobFoxInterstitialCustomEventStartapp.h"

@interface MobFoxInterstitialCustomEventStartapp()
@end

@implementation MobFoxInterstitialCustomEventStartapp

//============================================================================

- (void) didLoadAd:(STAAbstractAd*)ad
{
    NSLog(@"dbg: ### Startapp: >>> INTERSTITIAL Startapp: didLoadAd <<<");
    
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    
}

- (void) failedLoadAd:(STAAbstractAd*)ad withError:(NSError *)error
{
    NSLog(@"dbg: ### Startapp: >>> INTERSTITIAL Startapp: failedLoadAd %@ <<<",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void) didShowAd:(STAAbstractAd*)ad
{
    NSLog(@"dbg: ### Startapp: >>> INTERSTITIAL Startapp: didShowAd <<<");
}

- (void) failedShowAd:(STAAbstractAd*)ad withError:(NSError *)error
{
    NSLog(@"dbg: ### Startapp: >>> INTERSTITIAL Startapp: failedShowAd %@ <<<",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void) didCloseAd:(STAAbstractAd*)ad
{
    NSLog(@"dbg: ### Startapp: >>> INTERSTITIAL Startapp: didCloseAd <<<");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}

- (void) didClickAd:(STAAbstractAd*)ad
{
    NSLog(@"dbg: ### Startapp: >>> INTERSTITIAL Startapp: didClickAd <<<");
    
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

//============================================================================

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Startapp: loadAd ###");
    NSLog(@"dbg: ### Startapp: networkID: %@",networkId);
    
    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    sdk.appID = networkId;
    
    self.startAppAd = [[STAStartAppAd alloc] init];
    [self.startAppAd loadAdWithDelegate:self];
    
}

-(void)presentWithRootController:(UIViewController *)rootViewController {
    
    [self.startAppAd showAd];

}


-(void)dealloc{
    self.startAppAd  = nil;
}
@end