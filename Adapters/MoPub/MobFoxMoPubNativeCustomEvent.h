//
//  MPMobFoxNativeCustomEvent.h
//  DemoApp
//
//  Created by ofirkariv on 12/12/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoPub.h"
#import <MobFoxSDKCore/MobFoxSDKCore.h>



@interface MobFoxMoPubNativeCustomEvent : MPNativeCustomEvent <MobFoxNativeAdDelegate>

@property (nonatomic, strong) MobFoxNativeAd* ad;

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info;
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData;

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error;

//called on ad click
- (void)MobFoxNativeAdClicked;





@end
