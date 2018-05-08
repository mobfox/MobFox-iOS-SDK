//
//  SOMAMediationPlugin.h
//  iSoma
//
//  Created by Aman Shaikh on 17.09.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//
#import "SOMAMediatedNetworkConfiguration.h"
#import "SOMATypes.h"
#import <QuartzCore/QuartzCore.h>
@class UIView;
@class UIViewController;
@class SOMAMediationPlugin;

@protocol SOMAMediationPluginDelegate <NSObject>
- (void)mediationPlugin:(SOMAMediationPlugin*)plugin adLoaded:(UIView*)view;
- (void)mediationPluginFailed:(SOMAMediationPlugin*)plugin withError:(NSError*)error;

- (UIViewController*)mediationPluginViewController:(SOMAMediationPlugin*)plugin;
- (void)mediationPluginWillLeaveApplication:(SOMAMediationPlugin*)plugin;
- (void)mediationPluginClicked:(SOMAMediationPlugin*)plugin;
- (void)mediationPluginDidDismissedFullscreen:(SOMAMediationPlugin*)plugin;

@end

@interface SOMAMediationPlugin : NSObject
@property BOOL isNative;
@property BOOL isPresented;
@property BOOL isInterstitial;
@property SOMAAdDimension adDimension;
@property CGSize somaBannerSize;
@property CGSize preferredSize;
@property SOMAMediatedNetworkConfiguration* network;
@property (nonatomic, weak) id<SOMAMediationPluginDelegate> delegate;
- (instancetype)initWithConfiguration:(SOMAMediatedNetworkConfiguration*)network;
- (void)load;

#pragma mark -
#pragma mark - Subclasses MUST call these methods when applicable
#pragma mark -

- (UIViewController*)rootViewController;
- (void)showAdView:(UIView*)adview;
- (void)presentInterstitial;
- (void)adLoadedWithView:(UIView*)view;
- (void)adLoadFailedWithError:(NSError*) error;
- (void)adLoadFailedWithMessage:(NSString*) errorDescription;
- (void)adWillPresentFullscreen;
- (void)adWillLeaveApplication;
- (void)adDidDismissFullscreen;

@end
