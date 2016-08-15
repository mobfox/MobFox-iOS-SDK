//
//  ViewController.m
//  AdMobAdapterSample
//
//  Created by Shimi Sheetrit on 8/15/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    float bannerWidth = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 728.0 : 320.0;
    float bannerHeight = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 90.0 : 50.0;
    
    // banner.
    self.gadBannerView = [[GADBannerView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-bannerWidth)/2, SCREEN_HEIGHT - bannerHeight, bannerWidth, bannerHeight)];
    self.gadBannerView.adUnitID = @"ca-app-pub-6224828323195096/5240875564";
    self.gadBannerView.rootViewController = self;
    self.gadBannerView.delegate = self;
    [self.view addSubview: self.gadBannerView];
    GADRequest *request = [[GADRequest alloc] init];
    [self.gadBannerView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark AdMob Ad Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    
    NSLog(@"AdMob -- adViewDidReceiveAd:");
    
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    
    NSLog(@"AdMob -- adView:didFailToReceiveAdWithError:");
    
}

@end
