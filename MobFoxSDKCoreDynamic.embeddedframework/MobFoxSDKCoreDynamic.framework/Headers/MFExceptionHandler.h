//
//  MFExceptionHandler.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 9/18/16.
//  Copyright © 2016 Itamar Nabriski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MFExceptionHandler;

@protocol MFExceptionHandlerDelegate <NSObject>

@optional

- (void)MFExceptionHandlerDidReceivedException:(NSException *)exception;

@end

@interface MFExceptionHandler : NSObject

@property (nonatomic, weak) id <MFExceptionHandlerDelegate> delegate;


+ (instancetype)sharedInstance;
- (void)reportOnException;


@end
