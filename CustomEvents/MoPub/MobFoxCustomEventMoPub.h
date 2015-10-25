//
//  MobFoxCustomEventMoPub.h
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/12/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MobFoxCustomEventMoPub_h
#define MobFoxCustomEventMoPub_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "MPAdView.h"

@interface MobFoxCustomEventMoPub : MobFoxCustomEvent<MPAdViewDelegate>

@property (nonatomic) MPAdView *adView;

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

- (UIViewController *)viewControllerForPresentingModalView;

- (void)adViewDidLoadAd:(MPAdView *)view;

- (void)adViewDidFailToLoadAd:(MPAdView *)view;

- (void)willLeaveApplicationFromAd:(MPAdView *)view;

@end


#endif /* MobFoxCustomEventMoPub_h */
