//
//  MobFoxCustomEventSmaato.m
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxCustomEventSmaato.h"


@implementation MobFoxCustomEventSmaato

//========================================================================

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
    
    NSLog(@"dbg: ### Smaato: >>> BANNER SMAATO: somaAdViewDidLoadAd <<<");
    
    if (!self.mInFullScreen)
    {
        [self.delegate MFCustomEventAd:self didLoad:adview];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"dbg: ### Smaato: >>> BANNER SMAATO: didFailToReceiveAdWithError %@ <<<",error.description);
    
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void)somaAdViewWillEnterFullscreen:(SOMAAdView *)adview
{
    NSLog(@"dbg: ### Smaato: >>> BANNER SMAATO: somaAdViewWillEnterFullscreen <<<");
    
    self.mInFullScreen = TRUE;

    [self.delegate MFCustomEventMobFoxAdClicked];
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview
{
    NSLog(@"dbg: ### Smaato: >>> BANNER SMAATO: somaAdViewDidExitFullscreen <<<");
    
    self.mInFullScreen = FALSE;
    
    [self.bannerView hide];
}

- (void)somaAdView:(SOMAAdView *)adview didReceivedMediationResponse:(NSArray*)networksWithStatus
{
    NSLog(@"dbg: ### Smaato: >>> BANNER SMAATO: didReceivedMediationResponse %@ <<<",networksWithStatus);
}

- (void)somaAdView:(SOMAAdView *)adview csm:(SOMAMediatedNetworkConfiguration*)network status:(NSString*)status
{
    NSLog(@"dbg: ### Smaato: >>> BANNER SMAATO: csm %@ <<<",status);
}

- (void)somaAdViewWillHide:(SOMAAdView *)adview
{
    NSLog(@"dbg: ### Smaato: >>> BANNER SMAATO: somaAdViewWillHide <<<");
    
    [self.delegate MFCustomEventAdClosed];
}

/*
- (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview;

- (void)somaAdViewAutoRedrectionDetected:(SOMAAdView *)adview;
*/

//========================================================================

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    
    NSLog(@"dbg: ### Smaato: loadAd ###");
    NSLog(@"dbg: ### Smaato: networkID: %@",networkId);
    
    long publisherId = 0;
    long adSpaceId   = 0;
    
    self.parentViewController = [info objectForKey:@"viewcontroller_parent"];

    
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
    
    self.bannerView  = [[SOMAAdView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.bannerView.delegate = self;
    self.mInFullScreen = FALSE;
    
    self.bannerView.rootViewController = self.parentViewController;
    self.bannerView.adSettings.publisherId = publisherId;
    self.bannerView.adSettings.adSpaceId   = adSpaceId;
    [self.bannerView load];
}

-(void)dealloc{
    self.bannerView.delegate = nil;
    self.bannerView = nil;
}

@end