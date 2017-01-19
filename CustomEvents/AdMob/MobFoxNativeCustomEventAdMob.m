//
//  MobFoxNativeCustomEventAdMob.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 9/1/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxNativeCustomEventAdMob.h"

@interface MobFoxNativeCustomEventAdMob()
@property (nonatomic, strong) GADAdLoader *adLoader;
@property (nonatomic, strong) GADNativeContentAdView *contentAdView;
@property (nonatomic, strong) UIViewController* rootVC;
@end

@implementation MobFoxNativeCustomEventAdMob

#pragma mark MobFoxNativeCustomEvent

- (void)requestAdWithNetworkID:(NSString*)nid customEventInfo:(NSDictionary *)info {
    
    NSLog(@"dbg: ### AdMob: >>> Native ad loadAd");
    
    _rootVC = [info objectForKey:@"viewcontroller_parent"];

    self.adLoader = [[GADAdLoader alloc]
                     initWithAdUnitID:nid
                     rootViewController:_rootVC
                     adTypes:@[kGADAdLoaderAdTypeNativeAppInstall, kGADAdLoaderAdTypeNativeContent]
                     options:nil];
    self.adLoader.delegate = self;
    
    GADRequest *request = [[GADRequest alloc] init];
    //request.testDevices = @[ kGADSimulatorID ];
    
    
    [self.adLoader loadRequest:request];
    
}

- (void)registerViewWithInteraction:(UIView *)view withViewController:(UIViewController *)viewController {

}

#pragma mark GADNativeAd Delegate

/// Called just before presenting the user a full screen view, such as a browser, in response to
/// clicking on an ad. Use this opportunity to stop animations, time sensitive interactions, etc.
- (void)nativeAdWillPresentScreen:(GADNativeAd *)nativeAd {
    
    //NSLog(@"nativeAdWillPresentScreen:");
    
}

/// Called just before dismissing a full screen view.
- (void)nativeAdWillDismissScreen:(GADNativeAd *)nativeAd {
    
    //NSLog(@"nativeAdWillDismissScreen:");
    
}

/// Called just after dismissing a full screen view. Use this opportunity to restart anything you
/// may have stopped as part of nativeAdWillPresentScreen:.
- (void)nativeAdDidDismissScreen:(GADNativeAd *)nativeAd {
    
    //NSLog(@"nativeAdDidDismissScreen:");
    
}

/// Called just before the application will go to the background or terminate due to an ad action
/// that will launch another application (such as the App Store). The normal UIApplicationDelegate
/// methods, like applicationDidEnterBackground:, will be called immediately before this.
- (void)nativeAdWillLeaveApplication:(GADNativeAd *)nativeAd {
    
    //NSLog(@"nativeAdWillLeaveApplication:");
}


#pragma mark GADNativeAppInstallAdLoader Delegate


- (void)adLoader:(GADAdLoader *)adLoader
didReceiveNativeAppInstallAd:(GADNativeAppInstallAd *)nativeAppInstallAd {
    
    NSLog(@"dbg: ### AdMob: >>> Receive Native App Install Ad");

    // Create and place ad in view hierarchy.
    GADNativeAppInstallAdView *appInstallAdView =
    [[[NSBundle mainBundle] loadNibNamed:@"NativeAppInstallAdView"
                                   owner:nil
                                 options:nil] firstObject];
    // TODO: Make sure to add the GADNativeAppInstallAdView to the view hierarchy.
    
    [_rootVC.view addSubview:appInstallAdView];
    
    // Associate the app install ad view with the app install ad object. This is required to make the
    // ad clickable.
    appInstallAdView.nativeAppInstallAd = nativeAppInstallAd;
    
    // Populate the app install ad view with the app install ad assets.
    // Some assets are guaranteed to be present in every app install ad.
    ((UILabel *)appInstallAdView.headlineView).text = nativeAppInstallAd.headline;
    ((UIImageView *)appInstallAdView.iconView).image = nativeAppInstallAd.icon.image;
    ((UILabel *)appInstallAdView.bodyView).text = nativeAppInstallAd.body;
    ((UIImageView *)appInstallAdView.imageView).image =
    ((GADNativeAdImage *)[nativeAppInstallAd.images firstObject]).image;
    [((UIButton *)appInstallAdView.callToActionView)setTitle:nativeAppInstallAd.callToAction
                                                    forState:UIControlStateNormal];
    
    // Other assets are not, however, and should be checked first.
    if (nativeAppInstallAd.starRating) {
        /*
        ((UIImageView *)appInstallAdView.starRatingView).image =
        [self imageForStars:nativeAppInstallAd.starRating];
         */
        appInstallAdView.starRatingView.hidden = NO;
    } else {
        appInstallAdView.starRatingView.hidden = YES;
    }
    
    if (nativeAppInstallAd.store) {
        ((UILabel *)appInstallAdView.storeView).text = nativeAppInstallAd.store;
        appInstallAdView.storeView.hidden = NO;
    } else {
        appInstallAdView.storeView.hidden = YES;
    }
    
    if (nativeAppInstallAd.price) {
        ((UILabel *)appInstallAdView.priceView).text = nativeAppInstallAd.price;
        appInstallAdView.priceView.hidden = NO;
    } else {
        appInstallAdView.priceView.hidden = YES;
    }
    
    // In order for the SDK to process touch events properly, user interaction should be disabled on
    // all views associated with the GADNativeAppInstallAdView. Since UIButton has
    // userInteractionEnabled set to YES by default, views of this type must explicitly set
    // userInteractionEnabled to NO.
    appInstallAdView.callToActionView.userInteractionEnabled = NO;
    
    [self.delegate MFNativeCustomEventAd:self didLoad:nil];


    
}

#pragma mark GADNativeContentAdLoader Delegate

- (void)adLoader:(GADAdLoader *)adLoader
didReceiveNativeContentAd:(GADNativeContentAd *)nativeContentAd {
    
    NSLog(@"dbg: ### AdMob: >>> Receive Native Content Ad");
    
    // Create and place ad in view hierarchy.
    GADNativeContentAdView *contentAdView = [[[NSBundle mainBundle] loadNibNamed:@"NativeContentAdView"
                                   owner:nil
                                 options:nil] firstObject];
    // TODO: Make sure to add the GADNativeContentAdView to the view hierarchy.
    
    [_rootVC.view addSubview:contentAdView];
    
    
    // Associate the content ad view with the content ad object. This is required to make the ad
    // clickable.
    contentAdView.nativeContentAd = nativeContentAd;
    contentAdView.nativeContentAd.delegate = self;
    
    // Populate the content ad view with the content ad assets.
    // Some assets are guaranteed to be present in every content ad.
    ((UILabel *)contentAdView.headlineView).text = nativeContentAd.headline;
    ((UILabel *)contentAdView.bodyView).text = nativeContentAd.body;
    ((UIImageView *)contentAdView.imageView).image =
    ((GADNativeAdImage *)[nativeContentAd.images firstObject]).image;
    ((UILabel *)contentAdView.advertiserView).text = nativeContentAd.advertiser;
    [((UIButton *)contentAdView.callToActionView)setTitle:nativeContentAd.callToAction
                                                 forState:UIControlStateNormal];
    
    // Other assets are not, however, and should be checked first.
    if (nativeContentAd.logo && nativeContentAd.logo.image) {
        ((UIImageView *)contentAdView.logoView).image = nativeContentAd.logo.image;
        contentAdView.logoView.hidden = NO;
    } else {
        contentAdView.logoView.hidden = YES;
    }
    
    // In order for the SDK to process touch events properly, user interaction should be disabled on
    // all views associated with the GADNativeContentAdView. Since UIButton has userInteractionEnabled
    // set to YES by default, views of this type must explicitly set userInteractionEnabled to NO.
    
    contentAdView.callToActionView.userInteractionEnabled = NO;
    
    [self.delegate MFNativeCustomEventAd:self didLoad:nil];
    
}


- (void)adView:(DFPBannerView *)banner didReceiveAppEvent:(NSString *)name withInfo:(NSString *)info {
    
}

#pragma mark GADAdLoader Delegate

- (void)adLoader:(GADAdLoader *)adLoader
didFailToReceiveAdWithError:(GADRequestError *)error {
    
    NSLog(@"dbg: ### AdMob: >>> Failed To Receive Ad With Error: %@", [error description]);

    [self.delegate MFNativeCustomEventAdDidFailToReceiveAdWithError:error];
    
}

@end
