//
//  ViewController.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/1/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "CollectionViewCell.h"
#import "ScanHashViewController.h"
#import "NativeAdViewController.h"
#import "AppDelegate.h"
#import "GenericAdapterViewController.h"
#import "MFDemoConstants.h"
#import "DeviceExtension.h"


#define ADS_TYPE_NUM 11
#define AD_REFRESH   0



typedef NS_ENUM(NSInteger, MFRandomStringPart) {
    MFAdTypeBanner = 0,
    MFAdTypeInterstitial,
    MFAdTypeNative,
    MFAdTypeVideoBanner,
    MFAdTypeVideoInterstitial,
    MFTestWaterfall,
    MFTestScrolView,
    MFTestGenericAdapter,
    MFTestAdapters,
    MFTagBanner,
    MFTagInterstitial
};



@interface MainViewController ()

@property (strong, nonatomic) MobFoxAd *mobfoxAd;
@property (strong, nonatomic) MobFoxAd *mobfoxAdWaterfall;
@property (strong, nonatomic) MobFoxInterstitialAd *mobfoxInterAd;
@property (strong, nonatomic) MobFoxNativeAd* mobfoxNativeAd;
@property (strong, nonatomic) MobFoxAd *mobfoxVideoAd;
@property (strong, nonatomic) MobFoxInterstitialAd *mobfoxVideoInterstitial;
@property (strong, nonatomic) MobFoxTagAd *mobFoxTagAd;
@property (strong, nonatomic) MobFoxTagInterstitialAd *mobFoxTagInterstitialAd;
@property (strong, nonatomic) MobFoxNativeClickTracker *clickTracker;
@property (strong, nonatomic) MobFoxNativeData *mobFoxNativeData;

@property (strong, nonatomic) NSURL *clickURL;
@property (strong, nonatomic) NSString *cellID;
@property (strong, nonatomic) UIViewController *vc;

@property (weak, nonatomic) IBOutlet UITextField *invhInput;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *nativeAdView;
@property (weak, nonatomic) IBOutlet UIView *innerNativeAdView;

@property (weak, nonatomic) IBOutlet UIImageView *nativeAdIcon;
@property (weak, nonatomic) IBOutlet UILabel *nativeAdTitle;
@property (weak, nonatomic) IBOutlet UILabel *nativeAdDescription;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;


@property (nonatomic) CGRect videoAdRect;
@property (nonatomic) CGRect bannerAdRect;
@property (nonatomic) NSIndexPath *lastIndexSelected;


@property (nonatomic, strong) MFTestAdapter *testAdapter;


/*** AdMob ***/
@property (nonatomic, strong) GADBannerView *gadBannerView;
@property (nonatomic, strong) DFPBannerView *dfpBannerView;
@property (nonatomic, strong) GADInterstitial *gadInterstitial;
@property (nonatomic, strong) DFPInterstitial *dfpInterstitial;
@property (nonatomic, strong) GADNativeAd *gadNative;
//@property (nonatomic, strong) GADAdLoader *adLoader;


/*** Smaato ***/
@property (nonatomic, strong) SOMAAdView* somaBanner;
@property (nonatomic, strong) SOMAInterstitialAdView* somaInterstitial;
@property (nonatomic, strong) SOMANativeAd* somaNative;


/*** MoPub ***/
@property (nonatomic, retain) MPAdView *adView;
@property (nonatomic, retain) MPCollectionViewAdPlacer* placer;
@property (strong, nonatomic) MPAdView *mpAdView;
@property (strong, nonatomic) MPInterstitialAdController *mpInterstitialAdController;
@property (strong, nonatomic) MPNativeAd *mpNativeAd;


@end



@implementation MainViewController


static bool perform_segue_enabled;

- (void)settingsBtnSelected:(id)sender {
    
    NSLog(@"settingsBtnSelected");
    
    [self performSegueWithIdentifier:@"MainToSettings" sender:self];
}

- (void)scanHashBtnSelected {
    
    NSLog(@"scanHashBtnSelected");
    
    [self performSegueWithIdentifier:@"MainToScanHash" sender:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"-- viewDidLoad --");

    // Hides back button from current view.
    self.navigationItem.hidesBackButton = YES;

    
    
    UIBarButtonItem *scanHashButton = [[UIBarButtonItem alloc] initWithTitle:@"Set Inv" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(scanHashBtnSelected)];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(settingsBtnSelected:)];
    
    _navigationItem.rightBarButtonItem = scanHashButton;
    _navigationItem.leftBarButtonItem = settingsButton;


#ifdef  DemoAppDynamicTarget
    self.title =[NSString stringWithFormat:@"D-%@",SDK_VERSION];
#else
    self.title =[NSString stringWithFormat:@"S-%@",SDK_VERSION];
#endif

    
    self.cellID = @"cellID";
    //self.invhInput.delegate = self;
    self.nativeAdView.hidden = true;
    self.invhInput.hidden = true;

    float bannerWidth = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 728.0 : 320.0;
    float bannerHeight = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 90.0 : 50.0;
    float videoWidth = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 500.0 : 300.0;
    float videoHeight = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 450.0 : 250.0;
    float iPhoneXHeightFix = [DeviceExtension isIphoneX] ? 34:0;
    
    MainViewController *rootController =(MainViewController*)[[(AppDelegate*)
                                                               [[UIApplication sharedApplication]delegate] window] rootViewController];
    

    
    /*** Banner ***/
    self.bannerAdRect = CGRectMake((SCREEN_WIDTH-bannerWidth)/2, SCREEN_HEIGHT- bannerHeight -iPhoneXHeightFix, bannerWidth, bannerHeight);
    self.mobfoxAd = [[MobFoxAd alloc] init:MOBFOX_HASH_BANNER withFrame:self.bannerAdRect];
    self.mobfoxAd.delegate = self;
    self.mobfoxAd.refresh = self.refresh;
    self.mobfoxAd.adspace_strict = false;
    [rootController.view addSubview:self.mobfoxAd];
    
    
    /*** Interstitial ***/
    self.mobfoxInterAd = [[MobFoxInterstitialAd alloc] init:MOBFOX_HASH_INTER withRootViewController:rootController];
    self.mobfoxInterAd.delegate = self;
    
    
    /*** Native ***/
    self.mobfoxNativeAd = [[MobFoxNativeAd alloc] init:MOBFOX_HASH_NATIVE nativeView:self.innerNativeAdView];
    self.mobfoxNativeAd.delegate = self;
    
    
    /*** Video (Banner) ***/
    float videoTopMargin = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 200.0 : 80.0;
    self.videoAdRect = CGRectMake((SCREEN_WIDTH - videoWidth)/2, self.collectionView.frame.size.height + videoTopMargin, videoWidth, videoHeight);
    self.mobfoxVideoAd = [[MobFoxAd alloc] init:MOBFOX_HASH_VIDEO withFrame:self.videoAdRect];
    
    self.mobfoxVideoAd.delegate = self;
  
    [self.view addSubview:self.mobfoxVideoAd];
    
    
    /*** Video (Inter) ***/
    self.mobfoxVideoInterstitial = [[MobFoxInterstitialAd alloc] init:MOBFOX_HASH_VIDEO withRootViewController:self];
    self.mobfoxVideoInterstitial.delegate = self;
    
    
    /*** Tag Banner ***/
    self.mobFoxTagAd = [[MobFoxTagAd alloc] init:MOBFOX_HASH_BANNER withFrame:CGRectMake((SCREEN_WIDTH-bannerWidth)/2, SCREEN_HEIGHT-bannerHeight-iPhoneXHeightFix, 320, 50)];
    self.mobFoxTagAd.delegate = self;
    [self.view addSubview:self.mobFoxTagAd];
    
    
    /*** Tag Interstitial ***/
    self.mobFoxTagInterstitialAd = [[MobFoxTagInterstitialAd alloc] init:MOBFOX_HASH_INTER withRootViewController:rootController];
    self.mobFoxTagInterstitialAd.delegate = self;
    
    if ([DeviceExtension isIphoneX]) {
        CGRect frame = self.collectionView.frame;
        frame.origin.y += 32;
        self.collectionView.frame = frame;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    //NSLog(@"-- viewDidAppear: --");
    [super viewDidAppear:true];
    //NSLog(@"invh: %@", self.invh);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //NSLog(@"viewWillDisappear");
    [super viewWillDisappear:animated];
    //self.mobfoxVideoAd = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"MainToGenericAdapter"] || [identifier isEqualToString:@"MainToAdapters"]) {
        
        if ([identifier isEqualToString:@"MainToGenericAdapter"]) {
            [self hideAds:_lastIndexSelected];
        }
        
        //NSLog(@"_lastIndexSelected.item: %ld", (long)_lastIndexSelected.item);
        
        if(perform_segue_enabled == true) {
            
            perform_segue_enabled = false;
            return YES;
        }
    }
    
    return NO;
}

- (UIViewController *)viewControllerForPresentingModalView {
    
    return self;
}

#pragma mark Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return ADS_TYPE_NUM;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{

    CollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    cell.title.text = [self adTitle:indexPath];
    cell.image.image = [self adImage:indexPath];
    
    if (cell.selected) {
        cell.backgroundColor = [UIColor lightGrayColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor]; // Default color
    }
    
    return cell;
}


#pragma mark Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    _lastIndexSelected = indexPath;
    
    switch (indexPath.item) {
            
        case MFAdTypeBanner:

            [self hideAds:indexPath];
            
            self.mobfoxAd.invh = self.invh.length > 0 ? self.invh: MOBFOX_HASH_BANNER;
            self.mobfoxAd.refresh = self.refresh;
            //NSLog(@"FINAL REFRESH: %@", self.refresh);
            [self.mobfoxAd loadAd];
            
            break;
            
        case MFAdTypeInterstitial:

            [self hideAds:indexPath];
          
            self.mobfoxInterAd.invh = self.invh.length > 0 ? self.invh: MOBFOX_HASH_INTER;
            [self.mobfoxInterAd loadAd];

            break;
            
        case MFAdTypeNative:
            
            [self hideAds:indexPath];
           
            self.mobfoxNativeAd.invh = self.invh.length > 0 ? self.invh: MOBFOX_HASH_NATIVE;
            [self.mobfoxNativeAd loadAd];
            
            break;
            
        case MFAdTypeVideoBanner:
            
            [self hideAds:indexPath];
            self.mobfoxVideoAd.invh = self.invh.length > 0 ? self.invh: MOBFOX_HASH_VIDEO;
            [self.mobfoxVideoAd loadAd];
            break;
            
        case MFAdTypeVideoInterstitial:
            
            [self hideAds:indexPath];
          
            self.mobfoxVideoInterstitial.invh = self.invh.length > 0 ? self.invh: MOBFOX_HASH_VIDEO;
            [self.mobfoxVideoInterstitial loadAd];
            break;
            
        case MFTestWaterfall:
            
            // waterfall
            [self hideAds:indexPath];
            

            self.mobfoxAdWaterfall = [[MobFoxAd alloc] init:MOBFOX_HASH_BANNER withFrame:self.bannerAdRect];
            self.mobfoxAdWaterfall.invh = self.invh.length > 0 ? self.invh: MOBFOX_HASH_BANNER;
            self.mobfoxAdWaterfall.delegate = self;
            [self.view addSubview:self.mobfoxAdWaterfall];
            [self.mobfoxAdWaterfall loadAd];
            
            break;
            
        case MFTestScrolView: {
            
            [self hideAds:indexPath];
            
            float bannerWidth_ = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 728.0 : 320.0;
            float bannerHeight_ = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 90.0 : 50.0;
            self.bannerAdRect = CGRectMake((SCREEN_WIDTH-bannerWidth_)/2, 1350.0 /*screenHeight-bannerHeight*/, bannerWidth_, bannerHeight_);
            self.mobfoxAd = [[MobFoxAd alloc] init:MOBFOX_HASH_BANNER withFrame:self.bannerAdRect];
            self.mobfoxAd.delegate = self;
            self.mobfoxAd.refresh = self.refresh;
            self.mobfoxAd.hidden = NO;

            // close button.
            UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeButton addTarget:self
                            action:@selector(dismissVC)
                  forControlEvents:UIControlEventTouchUpInside];
            [closeButton setTitle:@"Close" forState:UIControlStateNormal];
            closeButton.frame = CGRectMake(0, 0.0, SCREEN_WIDTH, 50.0);
            closeButton.backgroundColor = [UIColor blueColor];
            
            // loadAd button(1).
            UIButton *loadAdButton_1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [loadAdButton_1 addTarget:self
                            action:@selector(loadAd1)
                  forControlEvents:UIControlEventTouchUpInside];
            [loadAdButton_1 setTitle:@"Load Ad" forState:UIControlStateNormal];
            loadAdButton_1.frame = CGRectMake(0, 1250.0, SCREEN_WIDTH, 50.0);
            loadAdButton_1.backgroundColor = [UIColor blueColor];
            
            // loadAd button(2).
            UIButton *loadAdButton_2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [loadAdButton_2 addTarget:self
                             action:@selector(loadAd2)
                   forControlEvents:UIControlEventTouchUpInside];
            [loadAdButton_2 setTitle:@"Load Ad" forState:UIControlStateNormal];
            loadAdButton_2.frame = CGRectMake(0, 250.0, SCREEN_WIDTH, 50.0);
            loadAdButton_2.backgroundColor = [UIColor blueColor];
            
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            scrollView.backgroundColor = [UIColor grayColor];
            [scrollView addSubview:self.mobfoxAd];
            [scrollView addSubview:closeButton];
            [scrollView addSubview:loadAdButton_1];
            [scrollView addSubview:loadAdButton_2];

            scrollView.scrollEnabled = YES;
            scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1400);
            
            UIView *view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 200)];
            UIView *view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, 600, SCREEN_WIDTH, 250)];
            UIView *view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, 800, SCREEN_WIDTH, 300)];
            view_1.backgroundColor = [UIColor redColor];
            view_2.backgroundColor = [UIColor yellowColor];
            view_3.backgroundColor = [UIColor greenColor];
            [scrollView addSubview:view_1];
            [scrollView addSubview:view_2];
            [scrollView addSubview:view_3];

            
            self.vc = [[UIViewController alloc] init];
            self.vc.view.backgroundColor = [UIColor whiteColor];
            [self.vc.view addSubview:scrollView];
            
            [self.mobfoxAd loadAd];
            
            [self presentViewController:self.vc animated:YES completion:^{
                // Verify it's not visible.
                //[self.mobfoxAd loadAd];
                
            }];
    
    
            break;
        }
    
        case MFTestGenericAdapter:
            
            [self hideAds:indexPath];
            
            perform_segue_enabled = true;
            [self shouldPerformSegueWithIdentifier:@"MainToGenericAdapter" sender:nil];
            [self performSegueWithIdentifier:@"MainToGenericAdapter" sender:nil];

            break;
            
        case MFTestAdapters:
            
            [self hideAds:indexPath];
            
            perform_segue_enabled = true;
            [self shouldPerformSegueWithIdentifier:@"MainToAdapters" sender:nil];
            [self performSegueWithIdentifier:@"MainToAdapters" sender:nil];
            
            break;
            
        case MFTagBanner:
            
            [self hideAds:indexPath];
            
            self.mobFoxTagAd.invh = self.invh.length > 0 ? self.invh: MOBFOX_HASH_BANNER;
            [self.mobFoxTagAd loadAd];
            
            break;
            
        case MFTagInterstitial:
            
            [self hideAds:indexPath];
            
            self.mobFoxTagInterstitialAd.invh = self.invh.length > 0 ? self.invh:MOBFOX_HASH_INTER;
            [self.mobFoxTagInterstitialAd loadAd];
            
            break;
                    

    }
  
}

- (void)loadAd1 {
    [self.mobfoxAd loadAd];
}

- (void)loadAd2 {
    [self.mobfoxAd loadAd];
}

- (void)dismissVC {
    
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    //self.vc = nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark Tag Ad Delegate

- (void)MobFoxTagAdDidLoad:(MobFoxTagAd *)banner {
    
    NSLog(@"MobFoxTagAdDidLoad:");

}

- (void)MobFoxTagAdDidFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"MobFoxTagAdDidFailToReceiveAdWithError: %@", [error description]);
    
}

- (void)MobFoxTagAdClicked {
    
    NSLog(@"MobFoxTagAdClicked:");
    
}

#pragma mark Tag Interstitial Ad Delegate

- (void)MobFoxTagInterstitialAdDidLoad:(MobFoxTagInterstitialAd *)interstitial {
    
    NSLog(@"MobFoxTagInterstitialAdDidLoad:");
    if(interstitial.ready) {
        [self.mobFoxTagInterstitialAd show];
    }
    
    
}

- (void)MobFoxTagInterstitialAdDidFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"MobFoxTagInterstitialAdDidFailToReceiveAdWithError: %@", error);
    
}

- (void)MobFoxTagInterstitialAdClicked {
    
    NSLog(@"MobFoxTagInterstitialAdClicked");
    
}

- (void)MobFoxTagInterstitialAdClose {
    
    NSLog(@"MobFoxTagInterstitialAdClose");
    
}

#pragma mark MobFox Ad Delegate

//called when ad is displayed
- (void)MobFoxAdDidLoad:(MobFoxAd *)banner {
    
    NSLog(@"MobFoxAdDidLoad:");
}

//called when an ad cannot be displayed
- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"MobFoxAdDidFailToReceiveAdWithError: %@", [error description]);
    
    [self popUpWithTitle:@"Error" message:[error description]];

}

//called when ad is closed/skipped
- (void)MobFoxAdClosed {
    NSLog(@"MobFoxAdClosed:");

}

//called when ad is clicked

- (void)MobFoxAdClicked {
    NSLog(@"MobFoxAdClicked:");

}

- (void)MobFoxAdFinished {
    NSLog(@"MobFoxAdFinished:");
    
}

#pragma mark MobFox Interstitial Ad Delegate

//best to show after delegate informs an ad was loaded
- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial {
    
    NSLog(@"MobFoxInterstitialAdDidLoad:");
        
    if(interstitial.ready){
        
        if (self.mobfoxInterAd.ready) {
            [self.mobfoxInterAd show];

        }
        
        else if (self.mobfoxVideoInterstitial.ready) {
            [self.mobfoxVideoInterstitial show];

        }
        
        
    }

}

- (void)dismissIntAd {
    [self.mobfoxInterAd dismissAd];

}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"MobFoxInterstitialAdDidFailToReceiveAdWithError: %@", [error description]);
    
    [self popUpWithTitle:@"Error" message:[error description]];

    
}

- (void)MobFoxInterstitialAdClosed {
    
    NSLog(@"MobFoxInterstitialAdClosed");
    
}

- (void)MobFoxInterstitialAdClicked {
    
    NSLog(@"MobFoxInterstitialAdClicked");
    
}

- (void)MobFoxInterstitialAdFinished {
    
    NSLog(@"MobFoxInterstitialAdFinished");
    
}

#pragma mark MobFox Native Ad Delegate

//called when ad response is returned
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd *)ad withAdData:(MobFoxNativeData *)adData {
    
    self.nativeAdIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:adData.main.url]];
    self.nativeAdTitle.text = adData.assetHeadline;
    self.nativeAdDescription.text = adData.assetDescription;
    self.clickURL = [adData.clickURL absoluteURL];
    self.mobFoxNativeData = adData;
    
    //adData.callToActionText
    NSLog(@"adData.assetHeadline: %@", adData.assetHeadline);
    NSLog(@"adData.assetDescription: %@", adData.assetDescription);
    NSLog(@"adData.callToActionText: %@", adData.callToActionText);
    
    [ad fireTrackers];
    
}

- (void)MobFoxNativeAdClicked {
    
}

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error {
    
    NSLog(@"MobFoxNativeAdDidFailToReceiveAdWithError: %@", [error description]);
    
    [self popUpWithTitle:@"Error" message:[error description]];
    
}


#pragma mark Private Methods

- (void)popUpWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   // Handle your OK button action here
                               }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [alert addAction:okButton];
    
}

- (void)hideAds:(NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
            
        case MFAdTypeBanner:
            self.mobfoxAd.hidden= NO;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            break;
            
        case MFAdTypeInterstitial:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFAdTypeNative:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = NO;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFAdTypeVideoBanner:

            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = NO;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFAdTypeVideoInterstitial:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFTestWaterfall:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFTestScrolView:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFTestGenericAdapter:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFTestAdapters:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
            break;
            
        case MFTagBanner:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = NO;
            
            break;
            
        case MFTagInterstitial:
            self.mobfoxAd.hidden= YES;
            self.nativeAdView.hidden = YES;
            self.mobfoxVideoAd.hidden = YES;
            self.mobFoxTagAd.hidden = YES;

            
        default:
            break;
    }
    
}

- (NSString *)adTitle:(NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
        case MFAdTypeBanner:
            return @"Banner";
            break;
        case MFAdTypeInterstitial:
            return @"Interstitial";
            break;
        case MFAdTypeNative:
            return @"Native";
            break;
        case MFAdTypeVideoBanner:
            return @"Video(Bnr)";
            break;
        case MFAdTypeVideoInterstitial:
            return @"Video(Int)";
            break;
        case MFTestWaterfall:
            return @"Waterfall";
            break;
        case MFTestScrolView:
            return @"ScrollView";
            break;
        case MFTestGenericAdapter:
            return @"G-Adapter";
            break;
        case MFTestAdapters:
            return @"Adapters";
            break;
        case MFTagBanner:
            return @"TagBanner";
            break;
        case MFTagInterstitial:
            return @"TagInterstitial";
            break;
            
            
        default:
            return @"";
            break;
    }
}

- (UIImage *)adImage:(NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
        case MFAdTypeBanner:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
        case MFAdTypeInterstitial:
            return [UIImage imageNamed:@"test_interstitial.png"];
            break;
        case MFAdTypeNative:
            return [UIImage imageNamed:@"test_native.png"];
            break;
        case MFAdTypeVideoBanner:
            return [UIImage imageNamed:@"test_video.png"];
            break;
        case MFAdTypeVideoInterstitial:
            return [UIImage imageNamed:@"test_video.png"];
            break;
        case MFTestWaterfall:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
        case MFTestScrolView:
            return [UIImage imageNamed:@"test_interstitial.png"];
            break;
        case MFTestGenericAdapter:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
        case MFTestAdapters:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
        case MFTagBanner:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
        case MFTagInterstitial:
            return [UIImage imageNamed:@"test_interstitial.png"];
            break;

            
        default:
            return nil;
            break;
    }
}

- (void)presentViewController {
    
    NativeAdViewController *nativeVC = [[NativeAdViewController alloc] init];
    [self presentViewController:nativeVC animated:YES completion:nil];
    
}

#pragma mark Mopub Ad Delegate

- (void)adViewDidLoadAd:(MPAdView *)view
{
    NSLog(@"Mopub -- adViewDidLoadAd");
}

#pragma mark Mopub Interstitial Delegate

- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    
    NSLog(@"Mopub -- interstitialDidLoadAd");
    
    if(interstitial.ready) {
        
        [interstitial showFromViewController:self];

    }

}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial {
    
    NSLog(@"Mopub -- interstitialDidFailToLoadAd ");

}

#pragma mark Mopub Native Delegate

- (void)willPresentModalForNativeAd:(MPNativeAd *)nativeAd {
    
    NSLog(@"nativeAd.properties: %@", nativeAd.properties);
    
}

#pragma mark Mopub Nativew Ad Delegate

-(void)nativeAdWillPresentModalForCollectionViewAdPlacer:(MPCollectionViewAdPlacer *)placer{
    NSLog(@">> first");
}

-(void)nativeAdDidDismissModalForCollectionViewAdPlacer:(MPCollectionViewAdPlacer *)placer{
    NSLog(@">> second");
}

-(void)nativeAdWillLeaveApplicationFromCollectionViewAdPlacer:(MPCollectionViewAdPlacer *)placer{
    NSLog(@">> third");
}


#pragma mark AdMob Ad Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    
    NSLog(@"adViewDidReceiveAd");
    
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"didFailToReceiveAdWithError: %@", error);

}

#pragma mark Click-Time Lifecycle Notifications

/// Tells the delegate that a full screen view will be presented in response to the user clicking on
/// an ad. The delegate may want to pause animations and time sensitive interactions.
- (void)adViewWillPresentScreen:(GADBannerView *)bannerView {
    
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView {
    
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView {
    
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView {
    
}


#pragma mark AdMob interstitial Ad Delegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    
    NSLog(@"interstitialDidReceiveAd");
    
    if(ad.isReady) {
        
        if(self.gadInterstitial) {
            [self.gadInterstitial presentFromRootViewController:self];
        }
        else {
            [self.dfpInterstitial presentFromRootViewController:self];
        }
    }
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error description]);
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen:");
    
}

/// Called when |ad| fails to present.
- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidFailToPresentScreen:");
    
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen:");

}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen:");

}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication:");
}

#pragma mark Smaato Banner Ad Delegate

- (UIViewController*)somaRootViewController{
    NSLog(@"somaRootViewController:");
    return self;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView *)adview{
    // Here make sure that the adview or its parent is currently positioned inside the viweable area. If ad is covered, it will not show.
    NSLog(@"somaAdViewWillLoadAd:");

}

#pragma mark Smaato Interstitial Ad Delegate

- (void)somaAdViewDidLoadAd:(SOMAAdView *)adview{
    // called when the Ad is ready to be shown. Banners are automatically shown but you have to explicitly show the interstitial ads.
    NSLog(@"somaAdViewDidLoadAd:");
    [self.somaInterstitial show];

}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error{
    // if failed to load ad or if ad is covered or partially obstruted or load is called too frequently or there is already loaded but not yet shown.
    NSLog(@"somaAdView:didFailToReceiveAdWithError:");
}

- (void)somaAdViewWillEnterFullscreen:(SOMAAdView *)adview{
    // it is called before going into expanded state.
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview{
    // called when expanded fullscreen ad is closed.
}

- (void)somaAdViewWillHide:(SOMAAdView *)adview{
    // called when the ad is hidden by SDK for some reason.
}

- (void)somaAdViewApplicationWillGoBackground:(SOMAAdView *)adview {
// is called when some redirect in the app leads over to another app (i.e. minimizes the current app)
}

#pragma mark Smaato Native Ad Delegate

- (void)somaNativeAdDidLoad:(SOMANativeAd*)nativeAd {
    NSLog(@"somaNativeAdDidLoad");
    
}

- (void)somaNativeAdDidFailed:(SOMANativeAd*)nativeAd withError:(NSError*)error {
    NSLog(@"somaNativeAdDidFailed Error: %@",[error description]);
    
}

- (BOOL)somaNativeAdShouldEnterFullScreen:(SOMANativeAd *)nativeAd {
    NSLog(@"somaNativeAdShouldEnterFullScreen");
    return NO;
}

#pragma mark MFTestAdapterBase Delegate

// banner
- (void)MFTestAdapterBaseAdDidLoad:(UIView *)ad {
    NSLog(@"MFTestAdapterBaseAdDidLoad");
    ad.frame = CGRectMake( (SCREEN_WIDTH - ad.frame.size.width)/2, SCREEN_HEIGHT - ad.frame.size.height, ad.frame.size.width, ad.frame.size.height ); // set new
   [self.view addSubview:ad];
 
}

- (void)MFTestAdapterBaseAdDidFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"MFTestAdapterBaseAdDidFailToReceiveAdWithError");
    
}

// tag banner
- (void)MFTestAdapterBaseTagAdDidLoad:(UIView *)ad {
    
}
- (void)MFTestAdapterBaseTagAdDidFailToReceiveAdWithError:(NSError *)error {
    
}


// Interstital
- (void)MFTestAdapterInterstitialAdapterBaseAdDidLoad:(UIView *)ad {
    
}
- (void)MFTestAdapterInterstitialAdapterBaseAdDidFailToReceiveAdWithError:(NSError *)error {
    
}

// native
- (void)MFTestAdapterNativeAdapterBaseAdDidLoad:(MobFoxNativeData *)adData {
    
}
- (void)MFTestAdapterNativeAdapterBaseAdDidFailToReceiveAdWithError:(NSError *)error {
    
}




@end




