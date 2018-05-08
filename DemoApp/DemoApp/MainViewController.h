//
//  ViewController.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/1/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <iSoma/iSoma.h>
#import "MoPub.h"
#import "MPNativeAdConstants.h"
#import "MPAdView.h"
#import "MPCollectionViewAdPlacer.h"
#import "MFTestAdapter.h"

@import FBAudienceNetwork;
@import GoogleMobileAds;



@interface MainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, MobFoxAdDelegate, MobFoxInterstitialAdDelegate, MobFoxNativeAdDelegate, FBAdViewDelegate, MPAdViewDelegate, MPInterstitialAdControllerDelegate, MPNativeAdDelegate, MPCollectionViewAdPlacerDelegate, GADInterstitialDelegate, GADBannerViewDelegate, SOMAAdViewDelegate, SOMANativeAdDelegate, MFTestAdapterBaseDelegate, MobFoxAdTagDelegate,MobFoxTagInterstitialAdDelegate, MobFoxInterstitialAdDelegate>


@property (strong, nonatomic) NSString *invh;
@property (strong, nonatomic) NSNumber *refresh;







@end

