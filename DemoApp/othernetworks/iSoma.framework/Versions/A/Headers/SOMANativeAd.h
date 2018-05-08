//
//  SOMANativeAd.h
//  iSoma
//
//  Created by Aman Shaikh on 17/12/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SOMANativeAdTemplateView.h"
#import "SOMAAdView.h"
#import "SOMANativeCSMPlugin.h"

typedef enum NSInteger{
	SOMANativeAdLayoutNone = 0,
	SOMANativeAdLayoutContentWall,
	SOMANativeAdLayoutAppWall,
	SOMANativeAdLayoutNewsFeed,
	SOMANativeAdLayoutContentStream,
	SOMANativeAdLayoutChatList,
	SOMANativeAdLayoutCarousel
} SOMANativeAdLayout;

@class SOMANativeAd;
@class SOMAStarView;
@protocol SOMANativeCSMPluginDelegate;
@protocol SOMAAdFetcher;
typedef void (^SOMANativeAdRequestAdCallback)(SOMANativeAdDTO* dto, NSError* error);
@protocol SOMANativeAdDelegate <SOMAAdViewDelegate>
@required
- (void)somaNativeAdDidLoad:(SOMANativeAd*)nativeAd;
- (void)somaNativeAdDidFailed:(SOMANativeAd*)nativeAd withError:(NSError*)error;
- (BOOL)somaNativeAdShouldEnterFullScreen:(SOMANativeAd *)nativeAd;
- (UIViewController*) somaRootViewController;
@end

@interface SOMANativeAd : SOMAAdView<UIGestureRecognizerDelegate, SOMANativeCSMPluginDelegate>
@property float rating;
@property(nonatomic, assign) SOMANativeAdLayout layout;
@property SOMANativeAdTemplateView* templateView;
@property (nonatomic, copy) NSString* callToAction;
@property BOOL shouldAddSponsoredLabel;
@property NSURL* clickURL;
@property(readonly) NSArray* beacons;
@property BOOL isMediated;

@property(nonatomic, weak) id<SOMANativeAdDelegate> delegate;

@property(nonatomic, weak) UILabel* labelForTitle;
@property(nonatomic, weak) UIButton* calltoActionButton;
@property(nonatomic, weak) UILabel* labelForDescription;
@property(nonatomic, weak) UIImageView* imageViewForIcon;
@property(nonatomic, weak) UIView* viewForMainImage;
@property(nonatomic, weak) SOMAStarView* starView;
@property id<SOMAAdFetcher> fetcher;
-(instancetype) initWithPublisherId:(NSString*)publisherId adSpaceId:(NSString*)adSpaceId;
- (void)load;
- (void)requestAd:(SOMANativeAdRequestAdCallback)callback;
- (void)loadPassback:(NSURL*)passbackURL;
- (void)registerViewForUserInteraction:(UIView*)view;
- (void)displayAd:(SOMANativeAdDTO*) dto;
@end
