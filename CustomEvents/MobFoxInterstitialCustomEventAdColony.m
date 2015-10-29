//
//  MobFoxInterstitialCustomEventAdColony.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/25/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxInterstitialCustomEventAdColony.h"


@implementation MobFoxInterstitialCustomEventAdColony


- (void)requestInterstitialWithRootController:(UIViewController *)rootViewController networkId:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    [AdColony configureWithAppID:@"app4eed92e337694188b9"
                         zoneIDs:@[@"vzcb025bc601f94e37b4"]
                        delegate:self
                         logging:YES];
}


- (void) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString *)zoneID{
    
    if(!available) return;
    NSLog(@"Ad Colony >>> Ready !");
    [AdColony playVideoAdForZone:@"vzcb025bc601f94e37b4" withDelegate:self];
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

- (void) onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID{
     NSLog(@"Ad Colony >>> fin !");
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
    [AdColony turnAllAdsOff];
}

@end
