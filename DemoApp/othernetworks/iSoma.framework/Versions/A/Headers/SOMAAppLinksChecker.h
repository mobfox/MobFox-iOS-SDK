//
//  SOMAAppLinksHandler.h
//  iSoma
//
//  Created by Aman Shaikh on 16/09/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SOMAAppLinksChecker : NSObject
@property NSString* appName;
@property NSString* appLink;
-(instancetype)initWithWebView:(UIWebView*)webview;
- (BOOL) isAppLinkAvailable;
@end
