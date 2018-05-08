//
//  SOMAAdSettings.h
//  iSoma
//
//  Created by Aman Shaikh on 31/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMATypes.h"
#import "SOMAUserProfile.h"
#import <CoreGraphics/CoreGraphics.h>

@interface SOMAAdSettings : NSObject<NSCopying>
@property(nonatomic, assign) SOMAAdType type;
@property(nonatomic, assign) SOMAAdSize size;
@property(nonatomic, assign) SOMAAdDimension dimension;
@property(nonatomic, assign, getter = isDimensionStrict) BOOL dimensionStrict;
@property(nonatomic, assign, getter = isFormatStrict) BOOL formatStrict;

@property(nonatomic, copy) SOMAUserProfile* userProfile;
@property(nonatomic, assign, getter = isCoppaEnabled) BOOL coppaEnabled;

@property(nonatomic, assign) int bannerWidth;
@property(nonatomic, assign) int bannerHeight;

@property(nonatomic, strong) NSString* keywords;
@property(nonatomic, strong) NSString* searchQuery;

@property(nonatomic, strong) NSString* nsupport;// for native ad, IOS-513

@property(nonatomic, assign) NSInteger publisherId;
@property(nonatomic, assign) NSInteger adSpaceId;
@property(nonatomic, assign) CGFloat longitude;
@property(nonatomic, assign) CGFloat latitude;

@property(nonatomic, assign) BOOL httpsOnly;

@property(nonatomic, assign, getter = isFrequencyCappingEnabled) BOOL frequencyCappingEnabled;
@property(nonatomic, assign, getter = isTestModeEnabled) BOOL testModeEnabled;

@property(nonatomic, assign, getter = isAutoReloadEnabled) BOOL autoReloadEnabled;
@property(nonatomic, assign) int autoReloadInterval;

@end

