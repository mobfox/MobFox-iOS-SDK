//
//  MoatVideoTracker.h
//  MoatMobileAppKit
//
//  Created by Moat on 2/20/15.
//  Copyright © 2016 Moat. All rights reserved.
//
//  This class is used for tracking AVPlayer and MPMoviePlayerController based ads.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "MATMoatBaseTracker.h"

@interface MATMoatVideoTracker : MATMoatBaseTracker

+ (MATMoatVideoTracker *)trackerWithPartnerCode:(NSString *)partnerCode;

- (bool)trackVideoAd:(NSDictionary *)adIds
   usingMPMoviePlayer:(MPMoviePlayerController *)player;

- (bool)trackVideoAd:(NSDictionary *)adIds
   usingAVMoviePlayer:(AVPlayer *)player
            withLayer:(CALayer *)layer
   withContainingView:(UIView *)view;

- (void)changeTargetLayer:(CALayer *)newLayer
        withContainingView:(UIView *)view;

- (void)stopTracking;

@end
