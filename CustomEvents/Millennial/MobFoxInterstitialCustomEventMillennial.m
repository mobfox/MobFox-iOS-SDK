//
//  MobFoxInterstitialCustomEventMillennial.m
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#import "MobFoxInterstitialCustomEventMillennial.h"

@interface MobFoxInterstitialCustomEventMillennial()
@end

@implementation MobFoxInterstitialCustomEventMillennial

//============================================================================

-(void)interstitialAdLoadDidSucceed:(MMInterstitialAd*)ad
{
    NSLog(@"dbg: ### MILLENIAL: >>> INTERSTITIAL MILLENIAL: interstitialAdLoadDidSucceed <<<");
    
    if(ad.ready) {
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
}

/**
 * Callback fired when an ad load fails. The failure can be caused by failure to either retrieve or parse
 * ad content.
 *
 * This method is always invoked on the main thread.
 *
 * @param ad The ad placement for which the request failed.
 * @param error The error indicating the failure.
 */
-(void)interstitialAd:(MMInterstitialAd*)ad loadDidFailWithError:(NSError*)error
{
    NSLog(@"dbg: ### MILLENIAL: >>> INTERSTITIAL MILLENIAL: loadDidFailWithError %@ <<<",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}


/**
 *  Callback fired when an interstitial will be displayed, but before the display action begins.
 *  Note that the ad could still fail to display at this point.
 *
 * This method is always called on the main thread.
 *
 *  @param ad The interstitial which will display.
 */
-(void)interstitialAdWillDisplay:(MMInterstitialAd*)ad
{
    
}


/**
 * Callback fired when the interstitial is displayed.
 *
 * This method is always called on the main thread.
 *
 * @param ad The interstitial which is displayed.
 */
-(void)interstitialAdDidDisplay:(MMInterstitialAd*)ad
{
    NSLog(@"dbg: ### MILLENIAL: >>> INTERSTITIAL MILLENIAL: interstitialAdDidDisplay <<<");
    
}


/**
 * Callback fired when an attempt to show the interstitial fails.
 *
 * This method is always called on the main thread.
 *
 * @param ad The interstitial which failed to show.
 * @param error The error indicating the failure.
 */
-(void)interstitialAd:(MMInterstitialAd*)ad showDidFailWithError:(NSError*)error
{
    NSLog(@"dbg: ### MILLENIAL: >>> INTERSTITIAL MILLENIAL: showDidFailWithError %@ <<<",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}


/**
 * Callback fired when an interstitial will be dismissed, but before the dismiss action begins.
 *
 * This method is always called on the main thread.
 *
 *  @param ad The interstitial which will be dismissed.
 */
-(void)interstitialAdWillDismiss:(MMInterstitialAd*)ad
{
    
}


/**
 * Callback fired when the interstitial is dismissed.
 *
 * This method is always called on the main thread.
 *
 * @param ad The interstitial which was dismissed.
 */
-(void)interstitialAdDidDismiss:(MMInterstitialAd*)ad
{
    NSLog(@"dbg: ### MILLENIAL: >>> INTERSTITIAL MILLENIAL: interstitialAdDidDismiss <<<");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}


/**
 * Callback fired when the ad expires.
 *
 * After receiving this message, your app should call -load before attempting to display the interstitial.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement which expired.
 */
-(void)interstitialAdDidExpire:(MMInterstitialAd*)ad
{
    
}


/**
 * Callback fired when the ad is tapped.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement which was tapped.
 */
-(void)interstitialAdTapped:(MMInterstitialAd*)ad
{
    NSLog(@"dbg: ### MILLENIAL: >>> INTERSTITIAL MILLENIAL: interstitialAdTapped <<<");
    
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}


/**
 * Callback invoked prior to the application going into the background due to a user interaction with an ad.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)interstitialAdWillLeaveApplication:(MMInterstitialAd*)ad
{
    
}


//============================================================================

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Millennial: loadAd ###");
    NSLog(@"dbg: ### Millennial: params: %@",info);
    NSLog(@"dbg: ### Millennial: networkID: %@",networkId);
    
    [[MMSDK sharedInstance] initializeWithSettings:nil withUserSettings:nil];
    
    self.mInterstitialAd = [[MMInterstitialAd alloc] initWithPlacementId:networkId];
    self.mInterstitialAd.delegate = self;
    [self.mInterstitialAd load:nil];

}

-(void)presentWithRootController:(UIViewController *)rootViewController {
    
    [self.mInterstitialAd showFromViewController:rootViewController];

}


-(void)dealloc{
    self.mInterstitialAd.delegate = nil;
    self.mInterstitialAd = nil;
}

@end