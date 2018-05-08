//
//  MFEventsHandler.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/15/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFEventsHandler : NSObject

typedef void(^completion)(BOOL);


- (instancetype)init;

- (void)resetAdEventBlocker;
- (void)resetInterstitialEventBlocker;
- (void)resetNativeEventBlocker;


- (void)invokeAdEventBlocker:(void (^)(BOOL isReported))completion;
- (void)invokeInterstitialAdEventBlocker:(void (^)(BOOL isReported))completion;
- (void)invokeNativeAdEventBlocker:(void (^)(BOOL isReported))completion;





@end
