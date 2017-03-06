//
//  MobFoxInterstitialCustomEventFacebook.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 1/13/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface MobFoxInterstitialCustomEventFacebook : MobFoxInterstitialCustomEvent <FBInterstitialAdDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@end
