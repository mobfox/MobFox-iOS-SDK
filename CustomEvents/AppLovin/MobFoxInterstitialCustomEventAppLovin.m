//
//  MobFoxInterstitialCustomEventAppLovin.m
//  CustomEvents
//
//  Created by Itamar Nabriski on 04/12/2016.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MobFoxInterstitialCustomEventAppLovin.h"

@interface MobFoxInterstitialCustomEventAppLovin ()<ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
    @property (nonatomic, strong) ALInterstitialAd *interstitial;
@end

@implementation MobFoxInterstitialCustomEventAppLovin


-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ALSdk initializeSdk];
    });
   

    self.interstitial = [[ALInterstitialAd alloc] initWithSdk: [ALSdk shared]];
    self.interstitial.adLoadDelegate            = self;
    self.interstitial.adDisplayDelegate         = self;
    self.interstitial.adVideoPlaybackDelegate   = self;
    
    // [[ALSdk shared].adService loadNextAd: [ALAdSize sizeInterstitial] andNotify: self];

}

-(void)presentWithRootController:(UIViewController *)rootViewController {
    
    if([ALInterstitialAd isReadyForDisplay]){
        [ALInterstitialAd show];
    }
    else{
        // No interstitial ad is currently available.  Perform failover logic...
    }
}

-(void)dealloc{
    
}

#pragma mark -
#pragma mark ALAdLoadDelegate methods

-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad {
    
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code {
    
    NSError* err = [NSError errorWithDomain:@"Applovin Custom Event" code:code userInfo:nil];
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:err];
}

-(void) ad:(ALAd *) ad wasClickedIn: (UIView *)view {
    
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

-(void) videoPlaybackEndedInAd: (ALAd*) ad atPlaybackPercent:(NSNumber*) percentPlayed fullyWatched: (BOOL) wasFullyWatched {
    
    [self.delegate MFInterstitialCustomEventMobFoxAdFinished];
}

-(void) ad:(ALAd *) ad wasDisplayedIn: (UIView *)view{}
-(void) ad:(ALAd *) ad wasHiddenIn: (UIView *)view{}
-(void) videoPlaybackBeganInAd: (ALAd*) ad{}

@end
