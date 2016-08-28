//
//  MobFoxInterstitialCustomEventAdMob.h
//  BannerExample
//
//  Created by Itamar Nabriski on 11/3/15.
//  Copyright © 2015 Google. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventAdMob_h
#define MobFoxInterstitialCustomEventAdMob_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface MobFoxInterstitialCustomEventAdMob : MobFoxInterstitialCustomEvent <GADInterstitialDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

#endif /* MobFoxInterstitialCustomEventAdMob_h */
