//
//  MobFoxInterstitialCustomEventAdColony.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/25/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxInterstitialCustomEventAdColony.h"

@interface MobFoxInterstitialCustomEventAdColony()
    @property NSString* zoneId;
@end

@implementation MobFoxInterstitialCustomEventAdColony


-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    
    NSArray *lines = [networkId componentsSeparatedByString: @";"];
    
    [AdColony configureWithAppID:lines[1]
                         zoneIDs:@[lines[2]]
                        delegate:self
                         logging:YES];
}

-(void)presentWithRootController:(UIViewController *)rootViewController{
    [AdColony playVideoAdForZone:self.zoneId withDelegate:self];
}


- (void) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString *)zoneID{
    
    if(!available || [AdColony videoAdCurrentlyRunning]) return;
    
    self.zoneId = zoneID;
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    
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
