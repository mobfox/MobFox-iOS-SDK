//
//  MobFoxNativeRequest.h
//  MobFoxSDKCore
//
//  Created by Itamar Nabriski on 9/29/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MobFoxNativeRequest_h
#define MobFoxNativeRequest_h

#import <UIKit/UIKit.h>
#import "MobFoxNativeCustomEvent.h"

@protocol MobFoxNativeAdDelegate <NSObject>

- (void)MobFoxNativeAdDidLoad:(NSDictionary *)ad;

- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error;

@end

@interface MobFoxNativeAd : NSObject<MobFoxNativeCustomEventDelegate>

    @property (nonatomic, strong) id<MobFoxNativeAdDelegate> adDelegate;
    
    @property (nonatomic, copy) NSString* longitude;
    @property (nonatomic, copy) NSString* latitude;
    @property (nonatomic, copy) NSString* demo_gender; //"m/f"
    @property (nonatomic, copy) NSString* demo_age;
    @property (nonatomic, copy) NSString* s_subid;
    @property (nonatomic, copy) NSString* sub_name;
    @property (nonatomic, copy) NSString* sub_domain;
    @property (nonatomic, copy) NSString* sub_storeurl;
    @property (nonatomic, copy) NSString* v_dur_min;
    @property (nonatomic, copy) NSString* v_dur_max;
    @property (nonatomic, copy) NSString* r_floor;
    
    - (id) init:(NSString*)invh;
    - (void) loadAd;

    - (void)MFNativeCustomEventAd:(MobFoxNativeCustomEvent *)event didLoad:(NSDictionary *)ad;

    - (void)MFNativeCustomEventAdDidFailToReceiveAdWithError:(NSError *)error;

@end

#endif /* MobFoxNativeRequest_h */
