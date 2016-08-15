//
//  ViewController.h
//  AdMobAdapterSample
//
//  Created by Shimi Sheetrit on 8/15/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;


@interface ViewController : UIViewController <GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *gadBannerView;
@property (nonatomic, strong) DFPBannerView *dfpBannerView;

@end

