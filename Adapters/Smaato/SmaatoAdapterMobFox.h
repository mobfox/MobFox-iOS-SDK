//
//  SmatooAdapterMobFox.h
//  Adapters
//
//  Created by Shimi Sheetrit on 11/14/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iSoma/iSoma.h>
#import <iAd/iAd.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>


@interface SmaatoAdapterMobFox : SOMAMediationPlugin <MobFoxAdDelegate, MobFoxInterstitialAdDelegate>

@property (nonatomic, strong) MobFoxAd* banner;
@property (nonatomic, strong) MobFoxInterstitialAd* interstitial;

- (void)loadBanner;
- (void)loadInterstitial;

@end
