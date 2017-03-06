//
//  MobFoxNativeCustomEventAdMob.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 9/1/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventAdMob_h
#define MobFoxInterstitialCustomEventAdMob_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface MobFoxNativeCustomEventAdMob : MobFoxNativeCustomEvent <GADNativeAdDelegate, GADAdLoaderDelegate, GADNativeContentAdLoaderDelegate, GADNativeAppInstallAdLoaderDelegate>

- (void)registerViewWithInteraction:(UIView *)view withViewController:(UIViewController *)viewController;
- (void)requestAdWithNetworkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@property(nonatomic, strong) GADNativeAd *native;

@end

#endif /* MobFoxInterstitialCustomEventAdMob_h */
