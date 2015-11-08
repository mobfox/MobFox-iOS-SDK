//
//  MoFoxInterstitialCustomEventAdColony.h
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/25/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MoFoxInterstitialCustomEventAdColony_h
#define MoFoxInterstitialCustomEventAdColony_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <AdColony/AdColony.h>


@interface MobFoxInterstitialCustomEventAdColony : MobFoxInterstitialCustomEvent<AdColonyDelegate,AdColonyAdDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;

-(void)presentWithRootController:(UIViewController *)rootViewController;

@end

#endif /* MoFoxInterstitialCustomEventAdColony_h */
