//
//  GADMobFoxCustomEvent.h
//  BannerExample
//
//  Created by Itamar Nabriski on 11/3/15.
//  Copyright © 2015 Google. All rights reserved.
//

#ifndef GADMobFoxCustomEvent_h
#define GADMobFoxCustomEvent_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface GADMAdapterMobFox : NSObject<GADCustomEventBanner,MobFoxAdDelegate>

    @property(nonatomic,weak)id<GADCustomEventBannerDelegate> delegate;
    @property(nonatomic,strong) MobFoxAd* banner;

    - (void)requestBannerAd:(GADAdSize)adSize parameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request;
@end

#endif /* GADMobFoxCustomEvent_h */
