//
//  MFJSContext.h
//  MobFoxSDKCore
//
//  Created by Itamar Nabriski on 14/11/2017.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxJSContext_h
#define MobFoxJSContext_h

#import <JavaScriptCore/JavaScriptCore.h>

typedef void (^evaluateUrlCB)(JSValue *value, NSError *err);
typedef void (^mfImportCB)(void);

@interface MobFoxJSContext : JSContext

- (id) init;

- (JSValue *)evaluateScriptFromURL:(NSURL*) url;
- (void)evaluateScriptFromURLWithBlock:(NSURL*) url andWithCB:(evaluateUrlCB)cb;
@end

#endif /* MFJSContext_h */
