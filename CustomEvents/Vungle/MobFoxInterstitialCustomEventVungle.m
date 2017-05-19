//
//  MobFoxCustomEventVungle.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/22/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxInterstitialCustomEventVungle.h"

@interface MobFoxInterstitialCustomEventVungle()

@property BOOL wasPlayed;

@end

@implementation MobFoxInterstitialCustomEventVungle


-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info{
    NSLog(@"MF Vungle >> request");
    self.wasPlayed = NO;
    VungleSDK* sdk = [VungleSDK sharedSDK];
    // start vungle publisher library
    [sdk setDelegate:self];
    [sdk startWithAppId:networkId];

}

-(void)presentWithRootController:(UIViewController *)rootViewController{
    NSLog(@"MF Vungle >> present");
    VungleSDK* sdk = [VungleSDK sharedSDK];
    NSError *error;
    [sdk playAd:rootViewController error:&error];
    
    if(error){
        [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
        return;
    }
}


- (void)vungleSDKAdPlayableChanged:(BOOL)isAdPlayable{
   
    if(isAdPlayable && !self.wasPlayed){
        NSLog(@"MF Vungle >> ad is playable");
        self.wasPlayed = YES;
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
    
}

- (void)vungleSDKwillShowAd{
    NSLog(@"MF Vungle >> will show ad");
    //[self.delegate MFInterstitialCustomEventAdWillShow:self];
}

- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary*)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet{
    [self.delegate MFInterstitialCustomEventAdClosed];
}

- (void)vungleSDKwillCloseProductSheet:(id)productSheet{
    
}

@end
