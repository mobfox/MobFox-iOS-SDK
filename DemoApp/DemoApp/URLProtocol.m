//
//  URLProtocol.m
//  DemoApp
//
//  Created by Itamar Nabriski on 16/01/2017.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//


#import "URLProtocol.h"
#import "TestsDefines.h"


@implementation URLProtocol
static int requestCount;

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    NSLog(@"canInitWithRequest -- Request #%lu: URL = %@", (unsigned long)requestCount++, request.URL);
    
    
    if([[request.URL absoluteString] hasPrefix:MFURLs.GoogleAdServices]) {
        return NO;
    } else if([[request.URL absoluteString] hasPrefix:MFURLs.GoogleDoubleClick]) {
        return NO;
    } else if([[request.URL absoluteString] hasPrefix:MFURLs.MobFoxAdrta]) {
        return NO;
    } else if([[request.URL absoluteString] hasPrefix:MFURLs.MoPubAds]) {
        return NO;
    }
    
    return YES;
    
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void) sendFile:(NSURL*)url{
    
    //NSLog(@"URL>: %@",url.absoluteString);
    
    
    NSString *fileName;
    if([[url absoluteString] hasPrefix:MFURLs.Index] || [[url absoluteString] hasPrefix:MFURLs.SecuredIndex]) {
        
        NSLog(@"index -- fileName: %@", fileName);

        fileName = @"index.html";
        
    } else if([[url absoluteString] hasPrefix:MFURLs.AdJS] || [[url absoluteString] hasPrefix:MFURLs.SecuredAdJS]) {
        
        fileName = @"sdk_video.js";
        
    } else if([[url absoluteString] hasPrefix:MFURLs.Waterfall]) {
        
        fileName = @"waterfalls.json";
        
    } else if ([[url absoluteString] hasPrefix:MFURLs.Impression] || [[url absoluteString] hasPrefix:MFURLs.HqMyImpression]) {
        
        fileName = @"empty_response.xml";
        
    } else if ([[url absoluteString] hasPrefix:MFURLs.Creative] || [[url absoluteString] hasPrefix:MFURLs.SecuredCreative]) {
        
        fileName = @"empty_response.xml";
        
    } else if ([[url absoluteString] hasPrefix:MFURLs.Exchange] || [[url absoluteString] hasPrefix:MFURLs.TokyoMyExchange]) {
        
        fileName = @"empty_response.xml";
        
    } else if ([[url absoluteString] hasPrefix:MFURLs.Store]) {
        
        fileName = @"empty_response.xml";
        
    } else if ([[url absoluteString] hasPrefix:MFURLs.Redirect]) {
        
        fileName = @"empty_response.xml";
        
    } else if([[url absoluteString] hasPrefix:MFURLs.Request]) {
        
        NSLog(@"-- request.php --");
        
        if([TestsDefines isNoResponse]) {
            return;
            
        } else if([TestsDefines isRenderingTimeout]) {
            
            fileName = @"rendering_timeout_response.xml";
            
        } else if([TestsDefines isAutoRedirect]) {
            
            fileName = @"banner_redirect.xml";
            
        } else if([TestsDefines isAutoRedirect2]) {
            
            fileName = @"banner_redirect2.xml";
            
        } /*else if([TestsDefines isStoreAutoRedirect]) {
            
            fileName = @"banner_store_redirect.xml";
        }*/
        
        /* regular ads responses */
        
        else if ([[url absoluteString] rangeOfString:@"imp_instl=1"].location == NSNotFound) {
            
            fileName = @"banner_response.xml";
            
        }else {
            
            fileName = @"interstitial_response.xml";
            
        }
        
    }
    
    NSLog(@"fileName: %@", fileName);
    
    if (fileName == nil || !fileName.length) {
        
        NSLog(@"fileName -- NULL   !!!!!!!!");

        return;
    }
    
    NSString* name  = [fileName componentsSeparatedByString:@"."][0];
    NSString* ext   = [fileName componentsSeparatedByString:@"."][1];
    
    
    NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:name ofType:ext];
    NSLog(@"name: %@, path: %@",name,path);
    NSString* contents = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:NULL];
    
    // NSLog(@"$contents: %@",contents);
    
    NSData* data;
    if(contents != nil) {
        data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    NSDictionary *extToMime =[[NSDictionary alloc] initWithObjectsAndKeys:
                              @"text/xml;charset=utf-8",@"xml",
                              @"application/json",@"json",
                              @"text/javascript",@"js",
                              @"text/html;charset=utf-8",@"html",
                              nil];
    
    //NSLog(@"url: %@,filename: %@, ext: %@, mime: %@",url.absoluteString,fileName,ext,[extToMime objectForKey:ext]);
    
    
    NSDictionary *dictHeaders = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 //@"Thu, 23 Feb 2017 09:59:56 GMT", @"Date",
                                 [extToMime objectForKey:ext], @"Content-Type",
                                 @"keep-alive", @"Connection",
                                 @"Accept-Encoding", @"Vary",
                                 @"true", @"Access-Control-Allow-Credentials",
                                 @"3.795", @"X-Pricing-CPM",
                                 @"http://sdk.starbolt.io", @"Access-Control-Allow-Origin",
                                 @"X-Pricing-CPM", @"Access-Control-Expose-Headers",
                                 nil];
    
    //NSLog(@"dict: %@",dictHeaders);
    
    NSHTTPURLResponse *res = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:dictHeaders];
    
    [self.client URLProtocol:self didReceiveResponse:res cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    
    [self.client URLProtocol:self didLoadData:data];
    
    [self.client URLProtocolDidFinishLoading:self];
    
    
}

- (void)startLoading {
    
    NSURLRequest *request = [self request];
    [self sendFile:request.URL];
}

- (void)stopLoading {
    
}


@end
