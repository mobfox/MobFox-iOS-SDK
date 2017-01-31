//
//  MobFoxCustomEventAdMob.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 11/2/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxCustomEventAdMob.h"

#define TEST_DEVICES @""

@implementation MobFoxCustomEventAdMob

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info{
    
    NSLog(@"dbg: ### AdMob: >>> BANNER: loadAd <<<");

    CGRect rect = CGRectMake(0,0,size.width,size.height);
    self.bannerView = [[GADBannerView alloc] initWithFrame:rect];
    self.bannerView.delegate = self;
    
    UIViewController* rootVC = [info objectForKey:@"viewcontroller_parent"];
    
    self.bannerView.rootViewController = rootVC;
    self.bannerView.adUnitID = nid;
    
    GADRequest* request = [GADRequest request];
    //request.testDevices = @[ kGADSimulatorID ];

    
    if([info valueForKey:@"accuracy"] && [info valueForKey:@"latitude"] && [info valueForKey:@"longitude"]) {
    
        CGFloat accuracy = [[info valueForKey:@"accuracy"] floatValue];;
        CGFloat latitude = [[info valueForKey:@"latitude"] floatValue];
        CGFloat longitude = [[info valueForKey:@"longitude"] floatValue];

        [request setLocationWithLatitude:latitude longitude:longitude accuracy:accuracy];
    }
    
    NSString *gender = [info valueForKey:@"demo_gender"];
    
    if([gender isEqualToString:@"m"]) {
        
        request.gender = kGADGenderMale;
        
    } else if([gender isEqualToString:@"f"]) {
        
        request.gender = kGADGenderFemale;
        
    } else {
        
        request.gender = kGADGenderUnknown;
    }
        
    [self.bannerView loadRequest:request];
    
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    
    NSLog(@"dbg: ### AdMob: >>> BANNER: didReceiveAd <<<");

    [self.delegate MFCustomEventAd:self didLoad:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    
    NSLog(@"dbg: ### AdMob: >>> BANNER: ReceiveAdWithError <<<");

    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{

}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView{
    [self.delegate MFCustomEventAdClosed];
}

- (void)adViewWillDismissScreen:(GADBannerView *)bannerView{

}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{
    [self.delegate MFCustomEventMobFoxAdClicked];
}

-(void)dealloc{
    
    self.bannerView.delegate = nil;
    self.bannerView = nil;
}

@end
