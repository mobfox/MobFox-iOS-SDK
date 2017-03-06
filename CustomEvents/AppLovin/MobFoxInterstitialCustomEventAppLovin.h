//
//  MobFoxInterstitialCustomEventAppLovin.h
//  CustomEvents
//
//  Created by Itamar Nabriski on 04/12/2016.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventAppLovin_h
#define MobFoxInterstitialCustomEventAppLovin_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <AppLovinSDK/AppLovinSDK.h>

@interface MobFoxInterstitialCustomEventAppLovin : MobFoxInterstitialCustomEvent <ALAdLoadDelegate>


-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@end

#endif /* MobFoxInterstitialCustomEventAppLovin_h */
