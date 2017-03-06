//
//  MobFoxInterstitialCustomEventSmaato.h
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventSmaato_h
#define MobFoxInterstitialCustomEventSmaato_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <iSoma/iSoma.h>

@interface MobFoxInterstitialCustomEventSmaato : MobFoxInterstitialCustomEvent <SOMAAdViewDelegate>

@property (readwrite) BOOL mInFullScreen;
@property (nonatomic, strong) SOMAInterstitialAdView *interstitial;
@property (strong, nonatomic) UIViewController *parentViewController;


-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@end

#endif /* MobFoxInterstitialCustomEventSmaato_h */