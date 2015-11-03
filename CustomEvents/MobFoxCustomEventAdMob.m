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
    
    //self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    //GADBannerView* bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
   
    CGRect rect =CGRectMake(0,0,size.width,size.height);
    self.bannerView = [[GADBannerView alloc] initWithFrame:rect];
    
    self.bannerView.delegate = self;
    
    UIViewController* rootVC = (UIViewController*)[[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
    //NSLog(@"root vc: %@",[rootVC description]);
    
    self.bannerView.rootViewController = rootVC;
    
    self.bannerView.adUnitID = nid;
    
    GADRequest* request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [self.bannerView loadRequest:request];
    
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    [self.delegate MFCustomEventAd:self didLoad:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
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

}

@end
