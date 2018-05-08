//
//  SOMAAdRenderer.h
//  iSoma
//
//  Created by Aman Shaikh on 11/12/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOMARenderedAdViewDelegate.h"
#import "SOMAAd.h"
#import "SOMAWebView.h"

typedef void(^VASTImpressionCallback)(NSString *trackingEventName);
typedef void(^VASTBeaconsTracking)(NSArray *beacons);
typedef void(^MRAIDParametersTracking)(NSDictionary *parameters);

@class SOMAAdView;
@interface SOMAAdRenderer : UIView
@property SOMAWebView* webView;
@property (weak) UIViewController* viewController;
@property(getter=isExpanded, nonatomic) BOOL expanded;
@property (nonatomic, weak) id<SOMARenderedAdViewDelegate> delegate;
@property (getter=isOneTimeClickable, nonatomic) BOOL oneTimeClickable;
@property (nonatomic, copy) SOMAAd* ad;
@property BOOL hasPassback;
@property NSMutableArray* urlTraces;// used to trace auto redirect URLs, IOS-753
@property (weak) SOMAAdView* adView;
@property (nonatomic, copy) VASTImpressionCallback impressionCallback;
@property (nonatomic, copy) VASTBeaconsTracking callback;
@property (nonatomic, copy) MRAIDParametersTracking parametersMRAID;

- (void) render:(SOMAAd*)ad;
- (void) showCloseButton:(float)yOffset;
- (void)didShow;
- (void)didHide;
- (void)onClose:(id)sender;
- (void)onTapped:(UIGestureRecognizer*)gesture;
- (void)configureFullscreen;
- (void) performAutoRedirect:(NSURL*)redirectURL;
@end
