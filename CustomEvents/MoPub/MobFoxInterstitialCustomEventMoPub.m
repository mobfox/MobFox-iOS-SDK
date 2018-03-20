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
    
    NSMutableArray* keywordsArr = [NSMutableArray arrayWithCapacity:5];
    if(info[@"demo_gender"]){
        [keywordsArr addObject:[NSString stringWithFormat:@"m_gender:%@",[info[@"demo_gender"] lowercaseString]]];
    }
    if(info[@"demo_age"]){
        [keywordsArr addObject:[NSString stringWithFormat:@"m_age:%@",info[@"demo_age"]]];
    }
    
    if(keywordsArr.count > 0){
        interstitial.keywords = [keywordsArr componentsJoinedByString:@","];
    }
    
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
