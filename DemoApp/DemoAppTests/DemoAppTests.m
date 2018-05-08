//
//  DemoAppTests.m
//  DemoAppTests
//
//  Created by Shimi Sheetrit on 2/1/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "MFDemoConstants.h"
#import "URLProtocol.h"
/*** third party ad networks ***/
@import GoogleMobileAds;
#import "MoPub.h"
#import "MPAdView.h"



@interface DemoAppTests : XCTestCase <GADAdLoaderDelegate, GADBannerViewDelegate, MPAdViewDelegate> {
    
    XCTestExpectation *expectationAdMobAdapter;
    XCTestExpectation *expectationMoPubAdapter;


}

@property (nonatomic, strong) GADBannerView *gadBannerView;
@property (nonatomic, strong) MPAdView *mpAdView;


@end

@implementation DemoAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSLog(@"setUp");
    
    bool registerSuccesfully = [NSURLProtocol registerClass:[URLProtocol class]];
    NSLog(@"URLProtocol -- registerSuccesfully: %d", registerSuccesfully);

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    NSLog(@"tearDown");
    
    [NSURLProtocol unregisterClass:[URLProtocol class]];
    
    expectationAdMobAdapter = nil;
    expectationMoPubAdapter = nil;
    
    [super tearDown];
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testExample_1 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


- (void)testMoPubAdapter {
    
    expectationMoPubAdapter = [self expectationWithDescription:@"testMoPubAdapter test"];
    
    UIView *view = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    self.mpAdView = [[MPAdView alloc] initWithAdUnitId:MOPUB_HASH_BANNER
                                                  size:MOPUB_BANNER_SIZE];
    self.mpAdView.delegate = self;
    self.mpAdView.frame = CGRectMake(0, 0, MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    [view addSubview:self.mpAdView];
    [self.mpAdView loadAd];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        NSLog(@"testMoPubAdapter error: %@", error);
    }];
    
}

- (void)testAdMobAdapter {
    
    expectationAdMobAdapter = [self expectationWithDescription:@"testAdMobAdapter test"];
    
    UIView *view = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];

    self.gadBannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 430, 300, 250)];
    //self.gadBannerView.adUnitID = @"ca-app-pub-6224828323195096/5677489566";
    self.gadBannerView.adUnitID = ADMOB_HASH_GAD_BANNER;
    UIViewController *vc = [[UIViewController alloc] init];
    self.gadBannerView.rootViewController = vc;
    self.gadBannerView.delegate = self;
    [view addSubview: self.gadBannerView];
    
    GADRequest *request = [[GADRequest alloc] init];
    //request.testDevices = @[ kGADSimulatorID ];

    //request.testDevices = @[ @"b94fb34e17824e61ad7e612ebc278a31" ];
    [self.gadBannerView loadRequest:request];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        NSLog(@"testAdMobAdapter error: %@", error);
    }];
}

#pragma mark AdMob Ad Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    
    NSLog(@"AdMob -- adViewDidReceiveAd");
    
    if(expectationAdMobAdapter) {
        [expectationAdMobAdapter fulfill];
    }
    
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"AdMob -- didFailToReceiveAdWithError: %@", error);
    
}

#pragma mark Mopub Ad Delegate

- (void)adViewDidLoadAd:(MPAdView *)view
{
    NSLog(@"Mopub -- adViewDidLoadAd");
    
    if(expectationMoPubAdapter) {
        [expectationMoPubAdapter fulfill];
    }
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    
    NSLog(@"Mopub -- adViewDidFailToLoadAd");
    
}



@end
