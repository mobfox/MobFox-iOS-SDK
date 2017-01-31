//
//  MobFoxCustomEventStartapp.h
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#ifndef MobFoxNativeCustomEventStartapp_h
#define MobFoxNativeCustomEventStartapp_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <StartApp/StartApp.h>

@interface MobFoxNativeCustomEventStartapp : MobFoxNativeCustomEvent <STADelegateProtocol>

@property (nonatomic, strong) STAStartAppNativeAd* startAppNativeAd;

@end

#endif /* MobFoxNativeCustomEventStartapp_h */
