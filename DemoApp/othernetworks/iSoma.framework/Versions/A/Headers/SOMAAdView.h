//
//  SOMAAdView.h
//  iSoma
//
//  Created by Aman Shaikh on 30/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOMATypes.h"
#import "SOMAAdViewDelegate.h"
#import "SOMAAdSettings.h"
#import "SOMAAdRenderer.h"
#import "SOMAMediatedNetworkConfiguration.h"
@class SOMAFullScreenAdViewController;
@class SOMARenderedAdView;

@interface SOMAAdView : UIView
#pragma mark -
#pragma mark - Properties to be using from XCode Interface Builder
#pragma mark -

/*!
 If set, the ad will not start loading automatically.
 You have to explicitely call the @p load method
 @remarks Set this property only from IB. If set by coding, it may not have any effect
 */
@property(nonatomic, assign)  BOOL doNotStartLoadingAd;

/*!
 AdSpace value for this ad.
 @remarks Set this property only from IB. If set by coding, it may not have any effect
 */
@property(nonatomic, strong) NSNumber* adSpaceId;

/*!
 Publisher id for this ad
 @remarks Set this property only from IB. If set by coding, it may not have any effect
 */
@property(nonatomic, strong) NSNumber* publisherId;

/*!
 If set @c true, the ad will not auto reload.
 @remarks Set this property only from IB. If set by coding, it may not have any effect
 */
@property(nonatomic, assign) BOOL disableAutoReload;

/*!
 Auto releoad interval. Make sure @c disableAutoReload is set to @c false
 @remarks Set this property only from IB. If set by coding, it may not have any effect
 */
@property(nonatomic, strong) NSNumber* autoReloadInterval;

#pragma mark -
#pragma mark - Public properties to be set/configure
#pragma mark -

/*!
	Configure it before calling the @c load method
 */
@property(nonatomic, copy) SOMAAdSettings* adSettings;

/*!
	The delegate for this ad.
	@remarks delegate should implement @c somaRootViewController method to avoid
	any unexpected behavior
 */
@property(nonatomic, weak)IBOutlet id<SOMAAdViewDelegate> delegate;

#pragma mark -
#pragma mark - Other properties
#pragma mark -

/*!
	UIViewController to present interstitial and/or fullscreen landing page
 */
@property(nonatomic, weak, getter=rootViewController) UIViewController* rootViewController;

/*!
	If set @c YES, the ad will @b not show automatically once loaded. 
	To show the ad, @c show method need to be called explicitely.
	@remarks Useful in ad mediation from 3rd party networks @c e.g. MoPub
 */
@property(nonatomic, assign) BOOL shouldAppearAutomatically;

#pragma mark -
#pragma mark - Public methods
#pragma mark -

-(void)load;
-(void)show;
-(void)hide;
-(void) pause;
-(void) resume;
- (UIViewController*) rootViewController;


// TMP
@property NSArray* mediatedNetworks;
- (void)mediationStartedForNetwork:(SOMAMediatedNetworkConfiguration*)network;
- (void)mediationFailedForNetwork:(SOMAMediatedNetworkConfiguration*)network;
- (void)mediationLoadedForNetwork:(SOMAMediatedNetworkConfiguration*)network;
#pragma mark -
#pragma mark - Internal method for Unity3d
#pragma mark -
-(void)sizeChanged;

#pragma mark -
#pragma mark - Internal properties
#pragma mark -
@property(nonatomic, readonly) BOOL isLoaded;
@property SOMAAdRenderer* currentRenderedAd;
@property(nonatomic, assign) BOOL isNewAdAvailable;
@property(nonatomic, strong) SOMAFullScreenAdViewController* fullScreenViewController;
@property BOOL isPresented;
@property BOOL isAdShown;
- (SOMAAdSettings*) preferredSettings;
@end
