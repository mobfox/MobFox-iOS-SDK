//
//  MFTestAdapter.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 12/20/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "MFTestAdapterBase.h"

@interface MFTestAdapter : MFTestAdapterBase <MobFoxAdDelegate, MobFoxAdTagDelegate, MobFoxTagInterstitialAdDelegate, MobFoxNativeAdDelegate>

@property (strong, nonatomic) MobFoxAd *bannerAd;
@property (strong, nonatomic) MobFoxTagAd *bannerTagAd;
@property (strong, nonatomic) MobFoxTagInterstitialAd *interstitialAd;
@property (strong, nonatomic) MobFoxNativeAd *nativeAd;

- (id)init;
- (void)requestAdWithFrame:(CGRect)rect networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;
- (void)requestTagAdWithFrame:(CGRect)rect networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;
- (void)requestInterstitialAdWithFrame:(CGRect)rect networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;
- (void)requestNativeAdWithFrame:(CGRect)rect networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@end
