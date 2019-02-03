//
//  Constants.h
//  MobFoxSDKCore
//
//  Created by Itamar Nabriski on 11/9/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//


#import <UIKit/UIKit.h>

/* Core target's name  */
extern NSString* const CORE_TARGET;


/* Versions */
#define SDK_VERSION @"3.6.0"
#define OS_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
#define FW_VERSION        [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]
#define BUILD_VERSION     [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]

/* Errors */
#define ERROR_DOMAIN      @""

/* Screen Dimentions */
#define SCREEN_WIDTH         [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT        [UIScreen mainScreen].bounds.size.height

/* Request URLs */
#define TAG_DOMAIN           @"sdk.starbolt.io" //@"sdk-origin.starbolt.io" 
#define TAG_PATH             @"dist"
#define AD_DOMAIN            @"my.mobfox.com"
#define AD_PATH              @"request.php"

#define AD_REQUEST_DOMAIN    @"my.mobfox.com"

#define TAG_VIDEO_FILE_NAME  @"tags/tagVideoiOS.html"
#define TAG_BANNER_FILE_NAME @"tags/tagiOS.html"

#define SUBJECT_TO_GDPR      @"IABConsent_SubjectToGDPR"
#define CONSENT_STRING       @"IABConsent_ConsentString"









