//
//  MobFoxInterstitialCustomEventStartapp.h
//  BannerExample
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Google. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventStartapp_h
#define MobFoxInterstitialCustomEventStartapp_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <StartApp/StartApp.h>

@interface MobFoxInterstitialCustomEventStartapp : MobFoxInterstitialCustomEvent <STADelegateProtocol>

@property (nonatomic, strong) STAStartAppAd* startAppAd;

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@end

#endif /* MobFoxInterstitialCustomEventStartapp_h */
