//
//  MobFoxCustomEventVungle.h
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/22/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MobFoxCustomEventVungle_h
#define MobFoxCustomEventVungle_h

#ifndef MobFoxCustomEventDummy_h
#define MobFoxCustomEventDummy_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <VungleSDK/VungleSDK.h>

@interface MobFoxInterstitialCustomEventVungle : MobFoxInterstitialCustomEvent<VungleSDKDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;

-(void)presentWithRootController:(UIViewController *)rootViewController;

@end

#endif /* MobFoxCustomEventDummy_h */

#endif /* MobFoxCustomkioEventVungle_h */
