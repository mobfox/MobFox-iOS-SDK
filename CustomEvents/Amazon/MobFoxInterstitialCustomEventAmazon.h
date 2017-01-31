//
//  MobFoxInterstitialCustomEventAmazon.h
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventAmazon_h
#define MobFoxInterstitialCustomEventAmazon_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <AmazonAd/AmazonAdRegistration.h>
#import <AmazonAd/AmazonAdInterstitial.h>
#import <AmazonAd/AmazonAdView.h>
#import <AmazonAd/AmazonAdOptions.h>
#import <AmazonAd/AmazonAdError.h>

@interface MobFoxInterstitialCustomEventAmazon : MobFoxInterstitialCustomEvent <AmazonAdInterstitialDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@property (nonatomic, strong) AmazonAdInterstitial *interstitialAd;

@end

#endif /* MobFoxInterstitialCustomEventAmazon_h */
