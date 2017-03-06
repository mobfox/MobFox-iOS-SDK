//
//  MobFoxNativeCustomEventMillennial.h
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#ifndef MobFoxNativeCustomEventMillennial_h
#define MobFoxNativeCustomEventMillennial_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <MMAdSDK/MMAdSDK.h>

@interface MobFoxNativeCustomEventMillennial : MobFoxNativeCustomEvent <MMNativeAdDelegate>

@property (strong, nonatomic) MMNativeAd *nativeAd;
@property (strong, nonatomic) UIViewController *parentViewController;

@end

#endif /* MobFoxNativeCustomEventMillennial_h */
