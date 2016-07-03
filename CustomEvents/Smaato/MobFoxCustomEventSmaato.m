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
    
    NSLog(@"Smaato: >>> BANNER SMAATO: somaAdViewDidLoadAd <<<");
    
    [self.bannerView show];
    
    if (!self.mInFullScreen)
    {
        [self.delegate MFCustomEventAd:self didLoad:_bannerView];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Smaato: >>> BANNER SMAATO: didFailToReceiveAdWithError %@ <<<",error.description);
    
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void)somaAdViewWillEnterFullscreen:(SOMAAdView *)adview
{
    NSLog(@"Smaato: >>> BANNER SMAATO: somaAdViewWillEnterFullscreen <<<");
    
    self.mInFullScreen = TRUE;

    [self.delegate MFCustomEventMobFoxAdClicked];
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview
{
    NSLog(@"Smaato: >>> BANNER SMAATO: somaAdViewDidExitFullscreen <<<");
    
    self.mInFullScreen = FALSE;
    
    [self.bannerView hide];
}

- (void)somaAdView:(SOMAAdView *)adview didReceivedMediationResponse:(NSArray*)networksWithStatus
{
    NSLog(@"Smaato: >>> BANNER SMAATO: didReceivedMediationResponse %@ <<<",networksWithStatus);
}

- (void)somaAdView:(SOMAAdView *)adview csm:(SOMAMediatedNetworkConfiguration*)network status:(NSString*)status
{
    NSLog(@"Smaato: >>> BANNER SMAATO: csm %@ <<<",status);
}

- (void)somaAdViewWillHide:(SOMAAdView *)adview
{
    NSLog(@"Smaato: >>> BANNER SMAATO: somaAdViewWillHide <<<");
    
    [self.delegate MFCustomEventAdClosed];
}

/*
- (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview;

- (void)somaAdViewAutoRedrectionDetected:(SOMAAdView *)adview;
*/

//========================================================================

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    
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
    
    self.bannerView  = [[SOMAAdView alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)];
    
    self.bannerView.delegate = self;
    
    self.mInFullScreen = FALSE;
    
    UIViewController* rootVC = (UIViewController*)[[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
    
    self.bannerView.rootViewController = rootVC;
    
    self.bannerView.adSettings.publisherId = 0 ; //publisherId;//1100021907;
    self.bannerView.adSettings.adSpaceId   = 0; // adSpaceId;//130129911;
    
    [self.bannerView load];
}

-(void)dealloc{
    self.bannerView = nil;
}

@end