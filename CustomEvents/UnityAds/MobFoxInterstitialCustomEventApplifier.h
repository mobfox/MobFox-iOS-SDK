//
//  MobFoxCustomEventUnity.h
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/28/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MobFoxCustomEventUnity_h
#define MobFoxCustomEventUnity_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <UnityAds/UnityAds.h>

@interface MobFoxInterstitialCustomEventApplifier : MobFoxInterstitialCustomEvent<UnityAdsDelegate>

- (void)requestInterstitialWithRootController:(UIViewController *)rootViewController networkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;

@end

#endif /* MobFoxCustomEventUnity_h */
