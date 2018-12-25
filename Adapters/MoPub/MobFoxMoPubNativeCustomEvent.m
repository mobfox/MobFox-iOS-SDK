//
//  MPMobFoxNativeCustomEvent.m
//  DemoApp
//
//  Created by ofirkariv on 12/12/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxMoPubNativeCustomEvent.h"
#import "MobFoxMoPubCustomAdapter.h"
#import "MPConsentManager.h"
#import "MPNativeAd+Internal.h"
#import "MPNativeAd.h"
@implementation MobFoxMoPubNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info{
    
        if (!info) {
            NSLog(@"MobFoxMoPubNativeCustomEvent - empty info!");
            [self requestDidFail];
            return;
        }
        
        self.ad = [[MobFoxNativeAd alloc] init :[info valueForKey:@"invh"] nativeView:nil]; //might be @"placement_id"
        self.ad.delegate = self;
        
        if(info != nil) {
            self.ad.demo_gender = [info objectForKey:@"demo_gender"];
            self.ad.demo_age = [info objectForKey:@"demo_age"];
            self.ad.longitude = [info objectForKey:@"longitude"];
            self.ad.latitude = [info objectForKey:@"latitude"];
            self.ad.accuracy = [info objectForKey:@"accuracy"];
        }
    
    
   

    MPBool gdpr= [[MoPub sharedInstance] isGDPRApplicable];
        NSString *consentStatusStr;
        
        MPConsentStatus consentStatus= [[MoPub sharedInstance] currentConsentStatus];
        
        if (consentStatus == MPConsentStatusConsented) {
            consentStatusStr = @"1";
        }
        else {
            consentStatusStr = @"0";
        }
    
    //26339392
    //601
    switch (gdpr) {
        case MPBoolNo:
            self.ad.gdpr = NO;
            break;
        case MPBoolYes:
           self.ad.gdpr = YES;
            break;
            
        
        case MPBoolUnknown:
           self.ad.gdpr = YES;
            break;
        default:
            break;
    }
    
    
        self.ad.gdpr_consent = consentStatusStr;
        
        NSLog(@"MoPub >> MobFox >> request: %@",[info description]);
        
        [self.ad loadAd];

}



- (void)requestDidFail {
    NSError *error = [[NSError alloc] initWithDomain:@"com.mopub.NativeCustomEvent" code:901 userInfo:nil];
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    
}


/* MobFox Native delegated */
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData{
    MobFoxMoPubCustomAdapter *mfAdapter = [[MobFoxMoPubCustomAdapter alloc] initWithAd:adData];
    MPNativeAd *mpAd = [[MPNativeAd alloc] initWithAdAdapter:mfAdapter];
    [self.delegate nativeCustomEvent:self didLoadAd:mpAd];
    
}

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"MobFox error");
    NSLog(@"%@", [error description]);
}

//called on ad click
- (void)MobFoxNativeAdClicked{
    
}

@end
