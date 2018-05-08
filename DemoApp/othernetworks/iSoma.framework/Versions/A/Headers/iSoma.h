//
//  iSoma.h
//  iSoma
//
//  Created by Aman Shaikh on 30/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMAAdView.h"
#import "SOMAInterstitialAdView.h"
#import "SOMAInterstitialVideoAdView.h"
#import "SOMANativeAd.h"
#import "SOMAToasterAdView.h"
#import "SOMAMedRectAdView.h"
#import "SOMALeaderboardAdView.h"
#import "SOMASkyscraperAdView.h"
#import "SOMATypes.h"
#import "SOMAAdSettings.h"
#import "SOMAUserProfile.h"
#import "SOMAAd.h"
#import "SOMABeaconQueue.h"
#import "SOMANativeAdDTO.h"
#import "SOMAAppLinksChecker.h"
#import "SOMACloseButton.h"
#import "SOMAMediationPlugin.h"
#import "SOMAMediatedNetworkConfiguration.h"
#import "SOMANativeAdLayouter.h"
#import "SOMANativeAdLayouters.h"
#import "SOMANativeCSMPlugin.h"
#import "SOMAJSONAdParser.h"

extern BOOL SOMA_CRASHREPORTING_ENABLED;

//@import UIKit;
//@import Foundation;
//@import StoreKit;
//@import CoreTelephony;
//@import SystemConfiguration;
//@import MessageUI;
//@import AdSupport;
//@import QuartzCore;
//@import CoreLocation;
//@import CoreImage;
//@import CoreFoundation;
//@import EventKit;
//@import EventKitUI;
//@import MediaPlayer;

@interface iSoma : NSObject

+(SOMAAdSettings*) defaultAdSettings;

+(NSString*) SDKVersion;
+(NSString*) apiVersion;
+(NSString*) mraidVersion;
+(void) setDefaultPublisherId:(NSString*)publisher adSpaceId:(NSString*) adspace;

#pragma mark -
#pragma mark - Syntactical suger for defaultSettings
#pragma mark -
+ (BOOL) isGPSEnabled;
+ (void) setGPSEnabled:(BOOL)yesOrNo;
+ (void) setAutoReloadEnabled:(BOOL) yesOrNo;
+ (BOOL) isAutoReloadEnabled;
+ (void) setAutoReloadInterval:(int) interval;
+ (int) autoReloadInterval;


#pragma mark -
#pragma mark - Logging
#pragma mark -
+(void) setLogLevel:(SOMALogLevel)level;
+(void) setLogOption:(SOMALogOption) option;
@end
