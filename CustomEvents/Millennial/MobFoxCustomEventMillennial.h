//
//  MobFoxCustomEventMillennial.h
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#ifndef MobFoxCustomEventMillennial_h
#define MobFoxCustomEventMillennial_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <MMAdSDK/MMAdSDK.h>

@interface MobFoxCustomEventMillennial : MobFoxCustomEvent <MMInlineDelegate>

@property (strong, nonatomic) MMInlineAd *mInlineAd;
@property (strong, nonatomic) UIViewController *parentViewController;

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@end

#endif /* MobFoxCustomEventMillennial_h */