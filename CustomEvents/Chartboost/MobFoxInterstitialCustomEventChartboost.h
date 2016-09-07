//
//  MobFoxInterstitialCustomEventChartboost.h
//  MobFox demo
//
//  Created by Shimon Shnitzer on 29/05/2016.
//  Copyright © 2016 Shimon Shnitzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <Chartboost/Chartboost.h>

@interface MobFoxInterstitialCustomEventChartboost : MobFoxInterstitialCustomEvent <ChartboostDelegate>

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info;
-(void)presentWithRootController:(UIViewController *)rootViewController;

@end
