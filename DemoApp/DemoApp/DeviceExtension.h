//
//  DeviceExtention.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 3/16/16.
//  Copyright © 2016 Itamar Nabriski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceExtension : NSObject

+ (BOOL)isIpad;
+ (BOOL)isIphoneX;
+ (BOOL)isIphone;
+ (BOOL)isTV;
+ (NSString *)ipAddress;

@end
