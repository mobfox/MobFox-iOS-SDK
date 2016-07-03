//
//  MobFoxInterstitialCustomEventSmaato.m
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#import "MobFoxInterstitialCustomEventSmaato.h"

@interface MobFoxInterstitialCustomEventSmaato()
    @property(nonatomic,weak) UIViewController* root;
@end

@implementation MobFoxInterstitialCustomEventSmaato

//============================================================================

/*
 - (void)MFInterstitialCustomEventAdClosed;
 
 - (void)MFInterstitialCustomEventMobFoxAdClicked;
 
 - (void)MFInterstitialCustomEventMobFoxAdFinished;
*/

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
    
    NSLog(@"Smaato: >>> INTERSTITIAL SMAATO: somaAdViewDidLoadAd <<<");

    [self.interstitial show];
    
    if (!self.mInFullScreen)
    {
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Smaato: >>> INTERSTITIAL SMAATO: didFailToReceiveAdWithError %@ <<<",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void)somaAdViewWillEnterFullscreen:(SOMAAdView *)adview
{
    NSLog(@"Smaato: >>> INTERSTITIAL SMAATO: somaAdViewWillEnterFullscreen <<<");
    
    self.mInFullScreen = TRUE;

    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview
{
    NSLog(@"Smaato: >>> INTERSTITIAL SMAATO: somaAdViewDidExitFullscreen <<<");
    
    self.mInFullScreen = FALSE;

    [self.delegate MFInterstitialCustomEventMobFoxAdFinished];
}

- (void)somaAdView:(SOMAAdView *)adview didReceivedMediationResponse:(NSArray*)networksWithStatus
{
    NSLog(@"Smaato: >>> INTERSTITIAL SMAATO: didReceivedMediationResponse %@ <<<",networksWithStatus);
}

- (void)somaAdView:(SOMAAdView *)adview csm:(SOMAMediatedNetworkConfiguration*)network status:(NSString*)status
{
    NSLog(@"Smaato: >>> INTERSTITIAL SMAATO: csm %@ <<<",status);
}

- (void)somaAdViewWillHide:(SOMAAdView *)adview
{
    NSLog(@"Smaato: >>> INTERSTITIAL SMAATO: somaAdViewWillHide <<<");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}

/*
 - (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview;
 
 - (void)somaAdViewAutoRedrectionDetected:(SOMAAdView *)adview;
 */

//============================================================================

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"Smaato: loadAd ###");
    NSLog(@"Smaato: params: %@",info);
    NSLog(@"Smaato: networkID: %@",networkId);
    
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
    NSLog(@"Smaato: pubId=%ld, adId=%ld",publisherId,adSpaceId);
    

    UIViewController* rootVC = (UIViewController*)[[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];

    self.root = rootVC;
    
    self.mInFullScreen = FALSE;
    
    self.interstitial  = [[SOMAInterstitialAdView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    
    self.interstitial.delegate = self;
    
    self.interstitial.rootViewController = rootVC;
    
    self.interstitial.adSettings.publisherId = 0; //publisherId;//1100021907;
    self.interstitial.adSettings.adSpaceId   = 0; //adSpaceId;//130129911;
    
    [self.interstitial load];
}

-(void)dealloc{
    self.interstitial = nil;
}
@end