//
//  TestsDefines.m
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 3/2/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import "TestsDefines.h"

@implementation TestsDefines



const struct MFErrorsStruct MFErrors = {
    .BnrTimeOut = @"Error Domain=request timeout out Code=0",
    .IntTimeOut = @"Error Domain=request timeout out Code=0",
    .NatvTimeOut = @"Error Domain=request timeout out Code=0",
    .AutoRedirect = @"Error Domain=auto redirect has been found Code Code=0"
    

};

const struct MFURLsStruct MFURLs = {
    .Index = @"http://sdk.starbolt.io/dist/index.html",
    .SecuredIndex = @"https://sdk.starbolt.io/dist/index.html",
    .AdJS = @"http://sdk.starbolt.io/dist/sdk_video.js",
    .SecuredAdJS = @"https://sdk.starbolt.io/dist/sdk_video.js",
    .Waterfall = @"http://sdk.starbolt.io/waterfalls.json",
    .Request = @"http://my.mobfox.com/request.php",
    .Creative = @"http://creative2cdn.mobfox.com",
    .SecuredCreative = @"https://creative2cdn.mobfox.com",
    .Impression = @"http://my.mobfox.com/rtb.impression.pixel.php",
    .HqMyImpression =  @"https://hq-my.mobfox.com/rtb.impression.pixel.php",
    .Exchange = @"http://my.mobfox.com/exchange.pixel.php",
    .TokyoMyExchange = @"http://tokyo-my.mobfox.com/exchange.pixel.php",
    .Store = @"http://itunes.apple.com",
    .Redirect = @"http://good.click.koko/yo",
    .MobFoxAdrta = @"http://adrta.com",
    .GoogleDoubleClick = @"https://googleads.g.doubleclick.net",
    .GoogleAdServices = @"https://pagead2.googleadservices.com",
    .MoPubAds = @"https://ads.mopub.com"
        
    
};

static bool noResponse;
static bool renderingTimeout;
static bool autoRedirect;
static bool autoRedirect2;
static bool atsEnabled;


static bool itunesAppleAutoRedirect;
static bool appStoreAutoRedirect;


+ (void)setRenderingTimeout:(BOOL)value {
    renderingTimeout = value;
}

+ (BOOL)isRenderingTimeout {
    return renderingTimeout;
}

+ (void)setAutoRedirect:(BOOL)value {
    autoRedirect = value;
}

+ (BOOL)isAutoRedirect {
    return autoRedirect;
}

+ (void)setAutoRedirect2:(BOOL)value {
    autoRedirect2 = value;
}

+ (BOOL)isAutoRedirect2 {
    return autoRedirect2;
}

+ (void)setNoResponse:(BOOL)value {
    noResponse = value;
}

+ (BOOL)isNoResponse {
    return noResponse;
}

//static bool itunesAppleAutoRedirect;
//static bool appStoreAutoRedirect;

+ (void)setItunesAppleAutoRedirect:(BOOL)value {
    itunesAppleAutoRedirect = value;
    
}

+ (BOOL)isItunesAppleAutoRedirect {
    return itunesAppleAutoRedirect;
}

+ (void)setAppStoreAutoRedirect:(BOOL)value {
    appStoreAutoRedirect = value;
    
}

+ (BOOL)isAppStoreAutoRedirect {
    return appStoreAutoRedirect;
}

+ (void)setATSEnabled:(BOOL)value {
    atsEnabled = value;
    
}

+ (BOOL)isATSEnabled {
    return atsEnabled;
}

@end
