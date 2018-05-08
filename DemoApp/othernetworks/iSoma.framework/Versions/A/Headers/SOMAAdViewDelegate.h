//
//  SOMAAdViewDelegate.h
//  iSoma
//
//  Created by Aman Shaikh on 30/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMAMediatedNetworkConfiguration.h"

@class SOMAAdView;

@protocol SOMAAdViewDelegate <NSObject>
@optional
- (UIViewController*)somaRootViewController;
- (void)somaAdViewWillLoadAd:(SOMAAdView *)adview;
- (void)somaAdViewDidLoadAd:(SOMAAdView *)adview;
- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error;
- (void)somaAdViewWillEnterFullscreen:(SOMAAdView *)adview;

- (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview;

/*!
  This method is deprectad. Please use @c somaAdViewWillEnterFullscreen.
 */
- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView *)adview DEPRECATED_ATTRIBUTE;
- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview;
- (void)somaAdViewAutoRedrectionDetected:(SOMAAdView *)adview;
- (void)somaAdViewWillHide:(SOMAAdView *)adview;
- (void)somaAdView:(SOMAAdView *)adview didReceivedMediationResponse:(NSArray*)networksWithStatus;
- (void)somaAdView:(SOMAAdView *)adview csm:(SOMAMediatedNetworkConfiguration*)network status:(NSString*)status;
@end
