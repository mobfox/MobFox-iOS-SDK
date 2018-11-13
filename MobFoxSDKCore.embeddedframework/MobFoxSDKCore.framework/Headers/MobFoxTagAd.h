//
//  MobFoxTagAd.h
//  MobFoxSDKCore
//
//  Created by Itamar Nabriski on 15/05/2017.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxTagAd_h
#define MobFoxTagAd_h

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "MFLocationServicesManager.h"
#import "MFExceptionHandler.h"
#import "MobFoxScriptHandler.h"

@class MobFoxTagAd;

@protocol MobFoxAdTagDelegate <NSObject>

@optional

- (void)MobFoxTagAdDidLoad:(MobFoxTagAd *)banner;

- (void)MobFoxTagAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MobFoxTagAdClicked;

@end


@interface MobFoxTagAd : WKWebView <WKNavigationDelegate, MobFoxScriptHandlerDelegate, UIGestureRecognizerDelegate>


@property (nonatomic, weak) id <MobFoxAdTagDelegate> delegate;


@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* accuracy;
@property (nonatomic, copy) NSString* demo_gender; //"m/f"
@property (nonatomic, copy) NSString* demo_age;
@property (nonatomic, copy) NSString* s_subid;
@property (nonatomic, copy) NSString* sub_name;
@property (nonatomic, copy) NSString* sub_domain;
@property (nonatomic, copy) NSString* sub_storeurl;
@property (nonatomic, copy) NSString* r_floor;
@property (nonatomic, copy) NSString* v_rewarded;

//@property (nonatomic, copy) NSString* type; //"waterfall" / "video"
//@property (nonatomic, copy) NSString* adFormat;
//@property (nonatomic, strong) NSNumber* refresh;
//@property (nonatomic, assign) BOOL autoplay;
//@property (nonatomic, assign) BOOL skip;

@property (nonatomic, copy) NSNumber* v_dur_min;
@property (nonatomic, copy) NSNumber* v_dur_max;

@property (nonatomic, strong) NSString* invh;
@property (nonatomic, strong) NSString *requestID;

@property (nonatomic, assign) BOOL dev_js;
@property (nonatomic, assign) BOOL imp_secure;
@property (nonatomic, assign) BOOL adspace_strict;

@property (nonatomic, assign) BOOL      gdpr;
@property (nonatomic, strong) NSString* gdpr_consent;

- (id) initWithMoPubAdaper:(NSString*)invh withFrame:(CGRect)aRect;
- (id) initWithAdMobAdaper:(NSString*)invh withFrame:(CGRect)aRect;
- (id) init:(NSString*)invh withFrame:(CGRect)aRect;
- (void) loadAd;
- (void) renderAd:(NSArray*) cacheableParams withNonCacheableParams:(NSArray*) nonCacheableParams :(NSData*)respData withType:(NSString *) type andWithMoat:(BOOL)moat;

@end




#endif /* MobFoxTagAd_h */
