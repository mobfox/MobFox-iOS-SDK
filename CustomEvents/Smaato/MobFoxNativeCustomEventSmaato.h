//
//  MobFoxNativeCustomEventSmaato.h
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#ifndef MobFoxNativeCustomEventSmaato_h
#define MobFoxNativeCustomEventSmaato_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <iSoma/iSoma.h>

@interface MobFoxNativeCustomEventSmaato : MobFoxNativeCustomEvent <SOMANativeAdDelegate>

@property (strong, nonatomic) UIViewController *parentViewController;
@property (strong, nonatomic) SOMANativeAd     *nativeAd;

@end

#endif /* MobFoxNativeCustomEventSmaato_h */
