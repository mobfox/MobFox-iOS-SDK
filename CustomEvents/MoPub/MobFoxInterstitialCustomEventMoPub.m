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
}

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    
    // Instantiate the interstitial using the class convenience method.
    interstitial = [MPInterstitialAdController
                    interstitialAdControllerForAdUnitId:networkId];
    
    interstitial.delegate = self;
    
    // Fetch the interstitial ad.
    [interstitial loadAd];
}

-(void)presentWithRootController:(UIViewController *)rootViewController{
    if (interstitial.ready){
        [interstitial showFromViewController:rootViewController];
    }
    else {
        // The interstitial wasn't ready, so continue as usual.
    }
}


- (void)interstitialDidLoadAd:(MPInterstitialAdController *)inter{
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
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
