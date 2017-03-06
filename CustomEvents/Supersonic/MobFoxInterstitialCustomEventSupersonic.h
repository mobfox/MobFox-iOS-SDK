//
//  MobFoxInterstitialCustomEventSupersonic.h
//  MobFox demo
//
//  Created by Shimon Shnitzer on 24/05/2016.
//  Copyright © 2016 Shimon Shnitzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "Supersonic/Supersonic.h"

@interface MobFoxInterstitialCustomEventSupersonic : MobFoxInterstitialCustomEvent <SupersonicISDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSMutableDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@end
