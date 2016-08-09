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

@interface MobFoxInterstitialCustomEventSmaato : MobFoxInterstitialCustomEvent<SOMAAdViewDelegate>

@property(nonatomic, strong) SOMAInterstitialAdView *interstitial;

@property(readwrite) BOOL mInFullScreen;

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;

@end

#endif /* MobFoxInterstitialCustomEventSmaato_h */