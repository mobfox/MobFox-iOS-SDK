//
//  InlineVideoAd.h
//  Test
//
//  Created by Itamar Nabriski on 6/4/15.
//  Copyright (c) 2015 Itamar Nabriski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobFoxCustomEvent.h"
#import "MFWebViewJavascriptBridge.h"

@class MobFoxAd;

@protocol MobFoxAdDelegate <NSObject>

@optional

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner;

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MobFoxAdClosed;

- (void)MobFoxAdClicked;

- (void)MobFoxAdFinished;

- (void) MobFoxDelegateCustomEvents:(NSArray*) events;

@end


@interface MobFoxAd : UIView<UIWebViewDelegate,MobFoxCustomEventDelegate>


    @property (nonatomic, strong) id<MobFoxAdDelegate> adDelegate;

   
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

    @property (nonatomic, copy) NSString* type; //"waterfall" / "video"
    @property (nonatomic, copy) NSString* adFormat;

    @property (nonatomic, assign) BOOL autoplay;
    @property (nonatomic, assign) BOOL skip;

    @property (nonatomic, assign) BOOL delegateCustomEvents;


- (NSString *)getIPAddress;
- (id) init:(NSString*)invh;
- (id) init:(NSString*)invh withFrame:(CGRect)aRect;
- (void) loadAd;

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType;

- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webViewdidFailLoadWithError:(NSError *)error;

- (void)MFCustomEventAd:(MobFoxCustomEvent *)event didLoad:(UIView *)ad;
- (void)MFCustomEventAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MFCustomEventAdClosed;

- (void)MFCustomEventMobFoxAdClicked;

- (void)MFCustomEventMobFoxAdFinished;


@end


