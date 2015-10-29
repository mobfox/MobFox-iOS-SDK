//
//  MobFoxInterstitialCustomEventMoPub.h
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/13/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventMoPub_h
#define MobFoxInterstitialCustomEventMoPub_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "MPInterstitialAdController.h"

@interface MobFoxInterstitialCustomEventMoPub : MobFoxInterstitialCustomEvent<MPInterstitialAdControllerDelegate>

- (void)requestInterstitialWithRootController:(UIViewController *)rootViewController networkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
@end

#endif /* MobFoxInterstitialCustomEventMoPub_h */
