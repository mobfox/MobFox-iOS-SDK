//
//  MobFoxTagInterstitialAd.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 6/18/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//


#ifndef MobFoxTagInterstitialAd_h
#define MobFoxTagInterstitialAd_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//#import "MFWaterfallManager.h"
#import "MobFoxWebView.h"

@class MobFoxTagInterstitialAd;

@protocol MobFoxTagInterstitialAdDelegate <NSObject>

@optional

- (void)MobFoxTagInterstitialAdDidLoad:(MobFoxTagInterstitialAd *)interstitial;

- (void)MobFoxTagInterstitialAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MobFoxTagInterstitialAdWillShow:(MobFoxTagInterstitialAd *)interstitial;

- (void)MobFoxTagInterstitialAdDidShow:(MobFoxTagInterstitialAd *)interstitial;

- (void)MobFoxTagInterstitialAdClicked;

- (void)MobFoxTagInterstitialAdClosed;

@end


@interface MobFoxTagInterstitialAd : NSObject <MobFoxWebViewAdDelegate>


@property (nonatomic, weak) id <MobFoxTagInterstitialAdDelegate> delegate;
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

@property (nonatomic, assign) BOOL      gdpr;
@property (nonatomic, strong) NSString* gdpr_consent;

-(id) initWithAdMobAdaper:(NSString*)invh;
-(id) initWithMoPubAdaper:(NSString*)invh;
- (id) init:(NSString*)invh;
- (id) init:(NSString*)invh withRootViewController:(UIViewController*)root;
- (void) loadAd;
- (void) show;
- (void) dismissAd;

@end


#endif /* MobFoxTagInterstitialAd_h */
