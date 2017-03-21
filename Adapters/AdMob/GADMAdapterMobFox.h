//
//  GADMAdapterMobFox.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 6/22/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface GADMAdapterMobFox : NSObject <GADMAdNetworkAdapter, MobFoxAdDelegate, MobFoxInterstitialAdDelegate>

@property (nonatomic, strong) MobFoxAd* banner;
@property (nonatomic, strong) MobFoxInterstitialAd* interstitial;
@property (nonatomic, weak) id <GADMAdNetworkConnector> connector;

@end
