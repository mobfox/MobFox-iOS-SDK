//
//  MobFoxCustomEventAdMob.h
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 11/2/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MobFoxCustomEventAdMob_h
#define MobFoxCustomEventAdMob_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>


@interface MobFoxCustomEventAdMob : MobFoxCustomEvent <GADBannerViewDelegate>

@property(nonatomic, strong) GADBannerView* bannerView;

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@end

#endif /* MobFoxCustomEventAdMob_h */
