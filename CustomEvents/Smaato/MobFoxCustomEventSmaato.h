//
//  MobFoxCustomEventSmaato.h
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#ifndef MobFoxCustomEventSmaato_h
#define MobFoxCustomEventSmaato_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <iSoma/iSoma.h>

@interface MobFoxCustomEventSmaato : MobFoxCustomEvent<SOMAAdViewDelegate>

@property (strong, nonatomic) UIViewController *parentViewController;
@property(nonatomic, strong) SOMAAdView* bannerView;

@property(readwrite) BOOL mInFullScreen;

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@end

#endif /* MobFoxCustomEventSmaato_h */