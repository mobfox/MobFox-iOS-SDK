//
//  GADInterstitialAdapterMobFox.h
//  BannerExample
//
//  Created by Itamar Nabriski on 11/4/15.
//  Copyright © 2015 Google. All rights reserved.
//

#ifndef DFPInterstitialAdapterMobFox_h
#define DFPInterstitialAdapterMobFox_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface DFPInterstitalAdapterMobFox : NSObject <GADCustomEventInterstitial, MobFoxInterstitialAdDelegate>

@property(nonatomic,weak)id <GADCustomEventInterstitialDelegate> delegate;
@property(nonatomic,strong) MobFoxInterstitialAd* interstitial;

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)request;

- (void)presentFromRootViewController:(UIViewController *)rootViewController;

@end
#endif /* GADInterstitialAdapterMobFox_h */
