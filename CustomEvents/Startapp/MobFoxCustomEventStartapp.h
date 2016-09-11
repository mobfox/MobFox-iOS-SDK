//
//  MobFoxCustomEventStartapp.h
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#ifndef MobFoxCustomEventStartapp_h
#define MobFoxCustomEventStartapp_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <StartApp/StartApp.h>

@interface MobFoxCustomEventStartapp : MobFoxCustomEvent <STABannerDelegateProtocol>

@property(nonatomic, strong) STABannerView* sTABannerView;
@property (strong, nonatomic) UIViewController *parentViewController;

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@end

#endif /* MobFoxCustomEventStartapp_h */