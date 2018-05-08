//
//  InlineVideoAd.h
//  Test
//
//  Created by Itamar Nabriski on 6/4/15.
//  Copyright (c) 2015 Itamar Nabriski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobFoxCustomEvent.h"
#import "MobFoxTagAd.h"

@class MobFoxAd;

@protocol MobFoxAdDelegate <NSObject>

@optional

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner;

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MobFoxAdClosed;

- (void)MobFoxAdClicked;

- (void)MobFoxAdFinished;

@end


@interface MobFoxAd : UIView <MobFoxCustomEventDelegate,MobFoxAdTagDelegate>

@property (nonatomic, weak) id <MobFoxAdDelegate> delegate;


@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, copy) NSString* latitude;

@property (nonatomic, copy) NSString* demo_gender; //"m/f"
@property (nonatomic, copy) NSString* demo_age;
@property (nonatomic, copy) NSString* r_floor;


@property (nonatomic, copy) NSNumber* v_dur_min;
@property (nonatomic, copy) NSNumber* v_dur_max;
@property (nonatomic, strong) NSString* invh;
@property (nonatomic, strong) NSNumber* refresh;
@property (nonatomic, assign) NSString* v_rewarded;

@property (nonatomic, assign) BOOL v_autoplay;
@property (nonatomic, assign) BOOL v_startmute;

@property (nonatomic, assign) BOOL dev_js;
@property (nonatomic, assign) BOOL imp_secure;

@property (nonatomic, assign, getter=isAdspace_strict) BOOL adspace_strict;

@property (nonatomic, copy) NSString* debugReqURLStr;
@property (nonatomic, copy) NSString* debugReqCustomEventURLStr;

-(NSDictionary*) getCustomEventInfo;

- (id) init:(NSString*)invh withFrame:(CGRect)aRect;
- (void)loadAd;

//- (BOOL)isViewVisible;

/*
- (void)_changeWidth:(float) newWidth;
- (void)_setSize:(CGSize)size withContainer:(CGSize)container;
- (void)_setFrame:(CGRect)aRect;
*/

//- (void)removeTimeout;

    

    
    

@end

