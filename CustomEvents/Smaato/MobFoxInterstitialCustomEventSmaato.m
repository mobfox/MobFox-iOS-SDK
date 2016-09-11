//
//  MobFoxInterstitialCustomEventSmaato.m
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#import "MobFoxInterstitialCustomEventSmaato.h"

@interface MobFoxInterstitialCustomEventSmaato()
@end

@implementation MobFoxInterstitialCustomEventSmaato

//============================================================================

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
    
    NSLog(@"dbg: ### Smaato: >>> INTERSTITIAL SMAATO: somaAdViewDidLoadAd <<<");

    if (!self.mInFullScreen)
    {
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"dbg: ### Smaato: >>> INTERSTITIAL SMAATO: didFailToReceiveAdWithError %@ <<<",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void)somaAdViewWillEnterFullscreen:(SOMAAdView *)adview
{
    NSLog(@"dbg: ### Smaato: >>> INTERSTITIAL SMAATO: somaAdViewWillEnterFullscreen <<<");
    
    self.mInFullScreen = TRUE;

    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview
{
    NSLog(@"dbg: ### Smaato: >>> INTERSTITIAL SMAATO: somaAdViewDidExitFullscreen <<<");
    
    self.mInFullScreen = FALSE;

    [self.delegate MFInterstitialCustomEventMobFoxAdFinished];
}

- (void)somaAdView:(SOMAAdView *)adview didReceivedMediationResponse:(NSArray*)networksWithStatus
{
    NSLog(@"dbg: ### Smaato: >>> INTERSTITIAL SMAATO: didReceivedMediationResponse %@ <<<",networksWithStatus);
}

- (void)somaAdView:(SOMAAdView *)adview csm:(SOMAMediatedNetworkConfiguration*)network status:(NSString*)status
{
    NSLog(@"dbg: ### Smaato: >>> INTERSTITIAL SMAATO: csm %@ <<<",status);
}

- (void)somaAdViewWillHide:(SOMAAdView *)adview
{
    NSLog(@"dbg: ### Smaato: >>> INTERSTITIAL SMAATO: somaAdViewWillHide <<<");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}

/*
 - (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview;
 
 - (void)somaAdViewAutoRedrectionDetected:(SOMAAdView *)adview;
 */

//============================================================================

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Smaato: loadAd ###");
    NSLog(@"dbg: ### Smaato: networkID: %@",networkId);
    
    long publisherId = 0;
    long adSpaceId   = 0;
    
    if ((networkId!=nil) && ([networkId length]>0))
    {
        NSArray *parts = [networkId componentsSeparatedByString:@";"];
        
        if ([parts count]>=2)
        {
            adSpaceId   = [((NSString *)[parts objectAtIndex:0]) intValue];
            publisherId = [((NSString *)[parts objectAtIndex:1]) intValue];
        }
    }
    NSLog(@"dbg: ### Smaato: pubId=%ld, adId=%ld",publisherId,adSpaceId);
    
    self.parentViewController = [info objectForKey:@"viewcontroller_parent"];
    CGFloat adSpaceWidth = [[info objectForKey:@"adspace_width"] floatValue];
    CGFloat adSpaceHeight = [[info objectForKey:@"adspace_height"] floatValue];
 
    self.mInFullScreen = FALSE;
    self.interstitial  = [[SOMAInterstitialAdView alloc] initWithFrame:CGRectMake(0, 0, adSpaceWidth, adSpaceHeight)];
    
    self.interstitial.delegate = self;
    self.interstitial.rootViewController = self.parentViewController;
    self.interstitial.adSettings.publisherId = publisherId;
    self.interstitial.adSettings.adSpaceId   = adSpaceId;
    
    [self.interstitial load];
}

-(void)presentWithRootController:(UIViewController *)rootViewController {
    
    [self.interstitial show];

}


-(void)dealloc{
    self.parentViewController = nil;
    self.interstitial.delegate = nil;
    self.interstitial = nil;
}
@end