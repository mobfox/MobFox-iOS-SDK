//
//  MobFoxInterstitialCustomEventAdColony.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/25/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxInterstitialCustomEventAdColony.h"


@implementation MobFoxInterstitialCustomEventAdColony


- (void)requestInterstitial:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    [AdColony configureWithAppID:@"app4eed92e337694188b9"
                         zoneIDs:@[@"vzcb025bc601f94e37b4"]
                        delegate:self
                         logging:YES];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
    NSLog(@"Ad Colony >>> Play It!");
    [AdColony playVideoAdForZone:@"vzcb025bc601f94e37b4" withDelegate:self];

}

- (void) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString *)zoneID{
    
    if(!available) return;
    NSLog(@"Ad Colony >>> Ready !");
    [self.delegate MFInterstitialCustomEventAd:self didLoad:nil];
}

- (void) onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID{
     NSLog(@"Ad Colony >>> fin !");
    [self.delegate MFInterstitialCustomEventMobFoxAdFinished];
}

@end
