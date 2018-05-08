//
//  MobFoxScriptHandler.h
//  MobFoxSDKCore
//
//  Created by Itamar Nabriski on 16/05/2017.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxScriptHandler_h
#define MobFoxScriptHandler_h
#import <WebKit/WebKit.h>

@class MobFoxScriptHandler;

@protocol MobFoxScriptHandlerDelegate <NSObject>

- (void)MobFoxScriptHandlerOnSuccess;
- (void)MobFoxScriptHandlerOnReady;
- (void)MobFoxScriptHandlerOnFail:(NSString *)reason;
- (void)MobFoxScriptHandlerOnAdClose;

@end


@interface MobFoxScriptHandler : NSObject <WKScriptMessageHandler>

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message;

@property (nonatomic, weak) id <MobFoxScriptHandlerDelegate> delegate;

@end


#endif /* MobFoxScriptHandler_h */
