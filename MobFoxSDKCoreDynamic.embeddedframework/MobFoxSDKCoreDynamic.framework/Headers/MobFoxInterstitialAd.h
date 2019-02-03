//
//  MobFoxInterstitialAd.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 6/18/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//


#ifndef MobFoxInterstitialAd_h
#define MobFoxInterstitialAd_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//#import "MFWaterfallManager.h"
#import "MobFoxWebView.h"
#import "MobFoxCustomEvent.h"
#import "MobFoxInterstitialCustomEvent.h"
#import "MFLocationServicesManager.h"
#import "MobFoxInterstitialCustomEventRequest.h"

@class MobFoxInterstitialAd;

@protocol MobFoxInterstitialAdDelegate <NSObject>

@required

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial;

@optional

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MobFoxInterstitialAdWillShow:(MobFoxInterstitialAd *)interstitial;

- (void)MobFoxInterstitialAdDidShow:(MobFoxInterstitialAd *)interstitial;

- (void)MobFoxInterstitialAdClicked;

- (void)MobFoxInterstitialAdClosed;

- (void)MobFoxInterstitialAdFinished;


@end


@interface MobFoxInterstitialAd : NSObject <MobFoxWebViewAdDelegate,MobFoxInterstitialCustomEventRequestDelegate >


@property (nonatomic, weak) id <MobFoxInterstitialAdDelegate> delegate;
@property (nonatomic, weak) UIViewController* rootViewController;

@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* demo_gender; //"m/f"
@property (nonatomic, copy) NSString* accuracy;
@property (nonatomic, copy) NSString* demo_age;
@property (nonatomic, copy) NSString* s_subid;
@property (nonatomic, copy) NSString* sub_name;
@property (nonatomic, copy) NSString* sub_domain;
@property (nonatomic, copy) NSString* sub_storeurl;
@property (nonatomic, copy) NSString* r_floor;
@property (nonatomic, strong) NSString* v_rewarded;

@property (nonatomic, strong) MFLocationServicesManager *locationServicesManager;

@property (nonatomic, assign) BOOL      gdpr;
@property (nonatomic, strong) NSString* gdpr_consent;

@property (nonatomic, copy) NSNumber* v_dur_min;
@property (nonatomic, copy) NSNumber* v_dur_max;
@property (nonatomic, assign) BOOL v_autoplay;
@property (nonatomic, assign) BOOL v_startmute;

@property (nonatomic, strong) NSString* invh;
//@property (nonatomic, strong) NSString *requestID;

@property (nonatomic, assign) BOOL c_mraid;
@property (nonatomic, assign) BOOL dev_js;
@property (nonatomic, assign) BOOL imp_secure;
@property (nonatomic, assign) BOOL ready;
@property (nonatomic, strong) NSNumber* refresh;
@property (nonatomic, copy) NSString* debugReqCustomEventURLStr;
@property (nonatomic, copy) NSString* debug_ad_request_url;

@property (nonatomic, strong) NSString* adapter;

@property (nonatomic, strong) NSNumber* cpm;


- (id) init:(NSString*)invh;
- (id) init:(NSString*)invh withRootViewController:(UIViewController*)root;
- (void) loadAd;
- (void) show;
- (void) dismissAd;

@end


#endif /* MobFoxInterstitialAd_h */
