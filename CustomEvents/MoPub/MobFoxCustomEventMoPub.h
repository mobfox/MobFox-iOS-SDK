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

/*
{"class":"MoPub","parameter":"9aa6ae18835c444ab82a5c5ae2ce02f9","pixel":"http:\/\/my.mobfox.com\/customevent.pixel.php?h=783f796a1dc5c2f154cd2b934c2993ad&stack_item_id=390955&pub=44301&inv=77199"}*/

#endif /* MobFoxCustomEventMoPub_h */
