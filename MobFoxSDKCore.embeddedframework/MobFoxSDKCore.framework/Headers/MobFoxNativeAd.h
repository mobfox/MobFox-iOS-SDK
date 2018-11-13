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
#import "MobFoxNativeData.h"
#import "MFExceptionHandler.h"


@class MobFoxNativeAd;


@protocol MobFoxNativeAdDelegate <NSObject,UIGestureRecognizerDelegate>

@required

- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData;
//- (void)MobFoxNativeGeusture;




@optional

- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error;
- (void)MobFoxNativeAdClicked ;

@end

@interface MobFoxNativeAd : NSObject

    @property (nonatomic, weak) id <MobFoxNativeAdDelegate> delegate;
    
    @property (nonatomic, copy) NSString* longitude;
    @property (nonatomic, copy) NSString* latitude;
    @property (nonatomic, copy) NSString* accuracy;

    @property (nonatomic, copy) NSString* demo_gender; //"m/f"
    @property (nonatomic, copy) NSString* demo_age;
    @property (nonatomic, copy) NSString* s_subid;
    @property (nonatomic, copy) NSString* sub_name;
    @property (nonatomic, copy) NSString* sub_domain;
    @property (nonatomic, copy) NSString* sub_storeurl;
    @property (nonatomic, copy) NSString* v_dur_min;
    @property (nonatomic, copy) NSString* v_dur_max;
    @property (nonatomic, copy) NSString* r_floor;
    @property (nonatomic, strong) NSString* invh;
    @property (nonatomic, strong) NSString* serverURL;

    @property (nonatomic, assign) BOOL      gdpr;
    @property (nonatomic, strong) NSString* gdpr_consent;

    // new properties (required for 1.1)
    //@property (nonatomic, strong) NSString* i_ipaddress;


    - (id) init:(NSString*)invh nativeView:(UIView *) view;
    - (void) loadAd;
    -(void) fireTrackers;

@end

#endif /* MobFoxNativeRequest_h */
