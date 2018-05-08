//
//  TestsDefines.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 3/2/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


struct MFErrorsStruct {
    __unsafe_unretained NSString * const BnrTimeOut;
    __unsafe_unretained NSString * const IntTimeOut;
    __unsafe_unretained NSString * const NatvTimeOut;
    __unsafe_unretained NSString * const AutoRedirect;
    
};

extern const struct MFErrorsStruct MFErrors;


struct MFURLsStruct {
    __unsafe_unretained NSString * const Index;
    __unsafe_unretained NSString * const SecuredIndex;
    __unsafe_unretained NSString * const AdJS;
    __unsafe_unretained NSString * const SecuredAdJS;
    __unsafe_unretained NSString * const Waterfall;
    __unsafe_unretained NSString * const Request;
    __unsafe_unretained NSString * const Creative;
    __unsafe_unretained NSString * const SecuredCreative;
    __unsafe_unretained NSString * const Impression;
    __unsafe_unretained NSString * const HqMyImpression;
    __unsafe_unretained NSString * const Exchange;
    __unsafe_unretained NSString * const TokyoMyExchange;
    __unsafe_unretained NSString * const Store;
    __unsafe_unretained NSString * const Redirect;
    __unsafe_unretained NSString * const GoogleDoubleClick;
    __unsafe_unretained NSString * const GoogleAdServices;
    __unsafe_unretained NSString * const MobFoxAdrta;
    __unsafe_unretained NSString * const MoPubAds;
    
};

extern const struct MFURLsStruct MFURLs;


@interface TestsDefines : NSObject

+ (void)setNoResponse:(BOOL)value;
+ (BOOL)isNoResponse;

+ (void)setRenderingTimeout:(BOOL)value;
+ (BOOL)isRenderingTimeout;

+ (void)setAutoRedirect:(BOOL)value;
+ (BOOL)isAutoRedirect;

+ (void)setAutoRedirect2:(BOOL)value;
+ (BOOL)isAutoRedirect2;

+ (void)setATSEnabled:(BOOL)value;
+ (BOOL)isATSEnabled;

+ (void)setItunesAppleAutoRedirect:(BOOL)value;
+ (BOOL)isItunesAppleAutoRedirect;
+ (void)setAppStoreAutoRedirect:(BOOL)value;
+ (BOOL)isAppStoreAutoRedirect;

@end
