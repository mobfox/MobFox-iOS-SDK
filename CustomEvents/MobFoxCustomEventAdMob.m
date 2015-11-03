//
//  MobFoxCustomEventAdMob.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 11/2/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxCustomEventAdMob.h"


@implementation MobFoxCustomEventAdMob

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info{
    
    NSLog(@"AdMob >>> got custom event: %@",nid);
    
    //GADBannerView* bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    GADBannerView* bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
     NSLog(@"AdMob >>> init banner");
    //self.bannerView.frame = CGRectMake(0.0,0.0,size.width,size.height);
    
    
    bannerView.delegate = self;
    NSLog(@"AdMob >>> about to config network id");
    bannerView.adUnitID = nid;
    NSLog(@"AdMob >>> about to send request");
    [bannerView loadRequest:[GADRequest request]];
    NSLog(@"AdMob >>> sent request");
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    NSLog(@"AdMob >>> showing it");
    [self.delegate MFCustomEventAd:self didLoad:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"AdMob >>> failed");
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
}

@end
