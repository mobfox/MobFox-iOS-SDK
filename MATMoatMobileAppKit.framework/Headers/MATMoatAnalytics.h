//
//  MATMoatAnalytics.h
//  MATMoatMobileAppKit
//
//  Created by Moat on 6/2/16.
//  Copyright © 2016 Moat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MATMoatWebTracker.h"
#import "MATMoatNativeDisplayTracker.h"
#import "MATMoatVideoTracker.h"

@interface MATMoatOptions : NSObject<NSCopying>

@property BOOL locationServicesEnabled;
@property BOOL debugLoggingEnabled;
@property BOOL IDFACollectionEnabled;

@end

@interface MATMoatAnalytics : NSObject

+ (instancetype)sharedInstance;

- (void)start;

- (void)startWithOptions:(MATMoatOptions *)options;

- (void)prepareNativeDisplayTracking:(NSString *)partnerCode;

@end
