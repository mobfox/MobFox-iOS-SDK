//
//  AdsViewController.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 1/15/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;
#import <iSoma/iSoma.h>
#import "MoPub.h"
#import <MobFoxSDKCore/MobFoxSDKCore.h>


@interface AdsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource,GADInterstitialDelegate, GADBannerViewDelegate, GADNativeContentAdLoaderDelegate, GADAdLoaderDelegate, SOMAAdViewDelegate, SOMANativeAdDelegate, MPAdViewDelegate, MPInterstitialAdControllerDelegate, MPNativeAdDelegate, MPNativeAdRendering,GADRewardBasedVideoAdDelegate>

@property (nonatomic, strong) NSString *sdkName;

@end
