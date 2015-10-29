//
//  MobFoxInterstitialCustomEventMoPub.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/13/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxInterstitialCustomEventMoPub.h"


@implementation MobFoxInterstitialCustomEventMoPub
{
    MPInterstitialAdController *interstitial;
    UIViewController *rootViewController;
}

- (void)requestInterstitialWithRootController:(UIViewController *)rootViewController networkId:(NSString*)networkId customEventInfo:(NSDictionary *)info{

    // Instantiate the interstitial using the class convenience method.
    interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:networkId];
    
    interstitial.delegate = self;
    
    // Fetch the interstitial ad.
    [interstitial loadAd];
}


- (void)interstitialDidLoadAd:(MPInterstitialAdController *)inter{
    if (interstitial.ready){
        [interstitial showFromViewController:rootViewController];
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
    else {
        // The interstitial wasn't ready, so continue as usual.
    }
}


- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)inter{
    NSError* err = [NSError errorWithDomain:@"MoPubFailed"
                                       code:40401
                                   userInfo:nil];
    [self.delegate  MFInterstitialCustomEventAdDidFailToReceiveAdWithError:err];
   
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)inter{
    [self.delegate MFInterstitialCustomEventAdClosed];
}



@end
