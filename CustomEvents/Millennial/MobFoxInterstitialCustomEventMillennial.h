//
//  MobFoxInterstitialCustomEventMillennial.h
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventMillennial_h
#define MobFoxInterstitialCustomEventMillennial_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <MMAdSDK/MMAdSDK.h>

@interface MobFoxInterstitialCustomEventMillennial : MobFoxInterstitialCustomEvent <MMInterstitialDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@property (nonatomic, strong) MMInterstitialAd *mInterstitialAd;

@end

#endif /* MobFoxInterstitialCustomEventMillennial_h */