//
//  MobFoxInterstitialCustomEventAdColony.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/25/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxInterstitialCustomEventAdColony.h"


@implementation MobFoxInterstitialCustomEventAdColony


- (void)requestInterstitialWithRootController:(UIViewController *)rootViewController networkId:(NSString*)networkId

    customEventInfo:(NSDictionary *)info{
    
    NSArray *lines = [networkId componentsSeparatedByString: @";"];
    
    [AdColony configureWithAppID:lines[1]
                         zoneIDs:@[lines[2]]
                        delegate:self
                         logging:YES];
}


- (void) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString *)zoneID{
    
    if(!available) return;
    
    if( [AdColony videoAdCurrentlyRunning]){
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
        return;
    }
    
    [AdColony playVideoAdForZone:zoneID withDelegate:self];
    
}

- (void) onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID{
    
    NSLog(@"zone attempted: %@",zoneID);
    if(!shown){
      
        NSError *err = [NSError errorWithDomain:@"MF ADColony - No Ad Shown" code:0 userInfo:nil];
       [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:err];
    }
    else{
        
        NSLog(@"MF Ad Colony >>> Finished !");
        [self.delegate MFInterstitialCustomEventAdClosed];
    }
    
}

@end
