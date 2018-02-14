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

@end


#endif /* MobFoxCustomEventMoPub_h */
