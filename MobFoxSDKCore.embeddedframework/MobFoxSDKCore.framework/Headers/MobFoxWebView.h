//
//  MobFoxWebView.h
//  MobFoxSDKCore
//
//  Created by Itamar Nabriski on 11/07/2017.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxWebView_h
#define MobFoxWebView_h

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "MobFoxScriptHandler.h"

@class MobFoxWebView;

@protocol MobFoxWebViewAdDelegate <NSObject>

- (void)MobFoxWebViewAdClicked;
- (void)MobFoxWebViewAdReady;
- (void)MobFoxWebViewAdSucceeded;
- (void)MobFoxWebViewAdClose;

@end

@interface MobFoxWebView : WKWebView <MobFoxScriptHandlerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) id <MobFoxWebViewAdDelegate> adDelegate;

//+ (NSString*)tagOriginDomain;
//+ (NSString*)tagDomain;
//+ (NSString*)tagPath;

- (id) initWithFrame:(CGRect)frame;

@end

#endif /* MobFoxWebView_h */
