//
//  AdsViewController.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 1/15/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import "AdsViewController.h"
#import "CollectionViewCell.h"
#import "MFDemoConstants.h"
#import "DeviceExtension.h"
#import "MFAdNetworkExtras.h"

typedef NS_ENUM(NSInteger, MFRandomStringPart) {
    MFAdTypeBanner = 0,
    MFAdTypeInterstitial,
    MFAdTypeNative,
    MFAdTypeVideoBanner,
    MFAdTypeVideoInterstitial,

};

#define ADS_TYPE_NUM 3



@interface AdsViewController ()

@property (nonatomic, strong) NSString *cellID;
@property (nonatomic) CGRect bannerAdRect;

@property (weak, nonatomic) IBOutlet UILabel *nativeAdTitle;
@property (weak, nonatomic) IBOutlet UIImageView *nativeAdImage;
@property (weak, nonatomic) IBOutlet UILabel *nativeAdDescription;
@property (weak, nonatomic) IBOutlet UIView *nativeAdView;
@property (weak, nonatomic) IBOutlet UIView *innerNativeAdView;


/*** AdMob ***/

@property (nonatomic, strong) GADBannerView *gadBannerView;
@property (nonatomic, strong) DFPBannerView *dfpBannerView;
@property (nonatomic, strong) GADInterstitial *gadInterstitial;
@property (nonatomic, strong) DFPInterstitial *dfpInterstitial;
@property (nonatomic, strong) GADNativeAd *gadNative;
@property (nonatomic, strong) GADAdLoader *adLoader;

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

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) UIView *mpNativeAdView;

@end

@implementation AdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cellID = @"cellID";
    _nativeAdView.hidden = true;
    _navItem.title = [NSString stringWithFormat:@"%@ - Ads", _sdkName];
    
    float bannerWidth = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 728.0 : 320.0;
    float bannerHeight = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 90.0 : 50.0;
    //float videoWidth = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 500.0 : 300.0;
    //float videoHeight = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? 450.0 : 250.0;
    
    _bannerAdRect = CGRectMake((SCREEN_WIDTH-bannerWidth)/2, SCREEN_HEIGHT - bannerHeight , bannerWidth, bannerHeight);

    if ([DeviceExtension isIphoneX]) {
        CGRect frame = self.collectionView.frame;
        
        frame.origin.y += 32;
        self.collectionView.frame = frame;
    }

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewDidAppear:true];
    _nativeAdView.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:true];
    _nativeAdView.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark load ad

// banner ad.
- (void)loadAdWithSDK:(NSString *)sdk {
    
    
    if([sdk isEqualToString:@"AdMob"] ) {
        
//        MFAdNetworkExtras *extras = [[MFAdNetworkExtras alloc] init];
//
//        extras.gdpr = YES;
//        extras.gdpr_consent = @"BannerTest";

        self.gadBannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, 320, 50)];
        //self.gadBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
        //self.gadBannerView.adUnitID = @"ca-app-pub-6224828323195096/5677489566";
        self.gadBannerView.adUnitID = ADMOB_HASH_GAD_TAG_BANNER;
        self.gadBannerView.rootViewController = self;
        self.gadBannerView.delegate = self;
        [self.view addSubview: self.gadBannerView];
        GADRequest *request = [[GADRequest alloc] init];
        
        
//       [request registerAdNetworkExtras:extras];

        
        //request.testDevices = @[ kGADSimulatorID ];
        //request.testDevices = @[ @"b94fb34e17824e61ad7e612ebc278a31" ];
        [self.gadBannerView loadRequest:request];
        
        // DFP ad.
        /*
        self.dfpBannerView = [[DFPBannerView alloc] initWithFrame:CGRectMake(0, 330, 320, 50)];
        self.dfpBannerView.adUnitID = @"ca-app-pub-6224828323195096/5240875564";
        self.dfpBannerView.rootViewController = self;
        [self.dfpBannerView loadRequest:[DFPRequest request]];
        [self.view addSubview: self.dfpBannerView]; */
        
    } else if([sdk isEqualToString:@"Smaato"] ) {
        
        self.somaBanner = [SOMAAdView new];
        self.somaBanner.frame = CGRectMake(0, _bannerAdRect.origin.y, _bannerAdRect.size.width, _bannerAdRect.size.height);
        [self.view addSubview:self.somaBanner];
        self.somaBanner.adSettings.publisherId = SMAATO_PUBLISHER_ID_BANNER.integerValue;
        self.somaBanner.adSettings.adSpaceId = SMAATO_ADSPACE_ID_BANNER.integerValue;
        self.somaBanner.delegate = self;
        [self.somaBanner load];

        
    } else if([sdk isEqualToString:@"MoPub"] ) {
        
        NSLog(@"-- MoPub Banner --");
        
        self.mpAdView = [[MPAdView alloc] initWithAdUnitId:MOPUB_HASH_BANNER
                                                      size:MOPUB_BANNER_SIZE];
        self.mpAdView.delegate = self;
        self.mpAdView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                         self.view.bounds.size.height - MOPUB_BANNER_SIZE.height,
                                         MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
        [self.view addSubview:self.mpAdView];
        [self.mpAdView loadAd];
        
    }
    

}

// interstitial ad.
- (void)loadInterstitialAdWithSDK:(NSString *)sdk {
    
    
    if([sdk isEqualToString:@"AdMob"] ) {
        
//        MFAdNetworkExtras *extras = [[MFAdNetworkExtras alloc] init];
//
//        extras.gdpr = YES;
//        extras.gdpr_consent = @"InterTest";
        
        self.gadInterstitial = [[GADInterstitial alloc] initWithAdUnitID:ADMOB_HASH_GAD_INTER];
        GADRequest *request_interstitial = [GADRequest request];
        //Requests test ads on test devices.
        
//        [request_interstitial registerAdNetworkExtras:extras];
        
        request_interstitial.testDevices = @[ @"267d72ac3f77a3f447b32cf7ebf20673" ];
        self.gadInterstitial.delegate = self;
        [self.gadInterstitial loadRequest:request_interstitial];
        NSLog(@"%s", GoogleMobileAdsVersionString);
        
        
        /*
         // DFP Interstitial.
         self.dfpInterstitial = [[DFPInterstitial alloc] initWithAdUnitID:@"ca-app-pub-6224828323195096/7876284361"];
         GADRequest *dfp_request = [GADRequest request];
         self.dfpInterstitial.delegate = self;
         // Requests test ads on test devices.
         dfp_request.testDevices = @[ @"221e6c438e8184e0556942ea14bb214b" ];
         [self.dfpInterstitial loadRequest:dfp_request]; */
        
        
    } else if([sdk isEqualToString:@"Smaato"] ) {
        
        self.somaInterstitial = [[SOMAInterstitialAdView alloc] init];
        self.somaInterstitial.adSettings.publisherId = SMAATO_PUBLISHER_ID_INTER.integerValue;
        self.somaInterstitial.adSettings.adSpaceId = SMAATO_ADSPACE_ID_INTER.integerValue;
        self.somaInterstitial.delegate = self;
        [self.somaInterstitial load];
        
    } else if([sdk isEqualToString:@"MoPub"] ) {
        
        self.mpInterstitialAdController = [MPInterstitialAdController interstitialAdControllerForAdUnitId:MOPUB_HASH_INTER];
        self.mpInterstitialAdController.delegate = self;
        [self.mpInterstitialAdController loadAd];
        
    }
    
    
}

// native ad.
- (void)loadNativeAdWithSDK:(NSString *)sdk {
    
    
    if([sdk isEqualToString:@"AdMob"] ) {
        
        NSMutableArray *adTypes = [[NSMutableArray alloc] init];
        [adTypes addObject:kGADAdLoaderAdTypeNativeContent];
        
        self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:ADMOB_HASH_GAD_NATIVE
                                           rootViewController:self
                                                      adTypes:adTypes
                                                      options:nil];
        self.adLoader.delegate = self;
        GADRequest *request = [GADRequest request];
        
        
        //request.testDevices = @[ @"3bcc6b954745bc58d2c80a114c847835" ];
        //request.testDevices = @[ kGADSimulatorID ];
        
        [self.adLoader loadRequest:request];
        
        
    } else if([sdk isEqualToString:@"Smaato"] ) {
        
        self.somaNative = [[SOMANativeAd alloc] initWithPublisherId:SMAATO_PUBLISHER_ID_NATIVE adSpaceId:SMAATO_ADSPACE_ID_NATIVE];
        self.somaNative.delegate = self;
        self.somaNative.layout = SOMANativeAdLayoutNewsFeed; //Example; refer to minimum height values list below for all options
        [self.somaNative load];

        
    } else if([sdk isEqualToString:@"MoPub"] ) {
//
//        MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
//        settings.renderingViewClass = [_innerNativeAdView class];
//        MPNativeAdRendererConfiguration *config = [MPMobFoxNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
//        MPNativeAdRequest *adRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:MOPUB_HASH_NATIVE rendererConfigurations:@[config]];
//
//        MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
//        targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdCTATextKey, kAdIconImageKey, kAdMainImageKey, kAdStarRatingKey, nil];
//
//        targeting.keywords = @"marital:single,age:27";
//        targeting.location = [[CLLocation alloc] initWithLatitude:34.1212 longitude:32.1212];
//        adRequest.targeting = targeting;
//
//
//        [adRequest startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
//            if (error) {
//                // Handle error.
//                NSLog(@"mopub native error: %@", error);
//
//            } else {
//
//                //NSLog(@"mopub native reponse: %@", response);
//
//                _nativeAdView.hidden = false;
//
//                NSDictionary *propertiesDict = response.properties;
//
//                _nativeAdTitle.text = [propertiesDict objectForKey:kAdTitleKey];
//                _nativeAdDescription.text = [propertiesDict objectForKey:kAdTextKey];
//                _nativeAdImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[propertiesDict objectForKey:kAdIconImageKey]]]];
//
//                self.mpNativeAd = response;
//                self.mpNativeAd.delegate = self;
//
//                _mpNativeAdView = [response retrieveAdViewWithError:nil];
//                _mpNativeAdView.backgroundColor = [UIColor whiteColor];
//                _mpNativeAdView.frame = _innerNativeAdView.frame; //CGRectMake(0, 0, 400, 500);
//
//                [_mpNativeAdView addSubview:_nativeAdTitle];
//                [_mpNativeAdView addSubview:_nativeAdDescription];
//                [_mpNativeAdView addSubview:_nativeAdImage];
//
//                [_nativeAdView addSubview:_mpNativeAdView];
//
//
//            }
//        }];
//
    }
    
    
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
    
    
    CollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:_cellID forIndexPath:indexPath];
    cell.title.text = [self adTitle:indexPath];
    cell.image.image = [self adImage:indexPath];
    
    if (cell.selected) {
        cell.backgroundColor = [UIColor lightGrayColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor]; // Default color
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark Collection View Delegate



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    switch (indexPath.item) {
            
            case MFAdTypeBanner:
            
            [self loadAdWithSDK:_sdkName];
            _nativeAdView.hidden = true;
            
            break;
            
            case MFAdTypeInterstitial:
            
            [self loadInterstitialAdWithSDK:_sdkName];
            _nativeAdView.hidden = true;

            
            break;
            
            case MFAdTypeNative:
            
            [self loadNativeAdWithSDK:_sdkName];
            _nativeAdView.hidden = false;
            
            if([_sdkName isEqualToString:@"AdMob"] ) {
                
                self.gadBannerView.hidden = true;

            } else if([_sdkName isEqualToString:@"Smaato"] ) {
                
                self.somaBanner.hidden = true;

            } else if([_sdkName isEqualToString:@"MoPub"] ) {
                
                self.mpAdView.hidden = true;
                
            }
            
            break;
                        
            
        default:
            break;
    }
    
    
}

#pragma mark Private Methods

- (void)hideAds:(NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
            
            case MFAdTypeBanner:
            
            break;
            
            case MFAdTypeInterstitial:
            
            break;
            
            case MFAdTypeNative:
            
            [self hideBanner:_sdkName];
            
            break;
            
            case MFAdTypeVideoBanner:
            
            break;
            
            case MFAdTypeVideoInterstitial:
            
            break;
            
            
        default:
            break;
    }
}

- (void)hideBanner:(NSString *)sdk {
    
    if([sdk isEqualToString:@"AdMob"] ) {
        
        self.gadBannerView.hidden = true;
        
    } else if([sdk isEqualToString:@"Smaato"] ) {
        
        self.somaBanner.hidden = true;
        
    } else if([sdk isEqualToString:@"MoPub"] ) {
        
        self.mpAdView.hidden = true;
    }
}


- (NSString *)adTitle:(NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
            
            // TODO: add verificaton of which SDK type has been selected in the previous view controller.
            
            case MFAdTypeBanner:
            return @"Banner";
            break;
            case MFAdTypeInterstitial:
            return @"Interstitial";
            break;
            case MFAdTypeNative:
            return @"Native";
            break;
            /*
            case MFAdTypeVideoBanner:
            return @"Video(Bnr)";
            break;
            case MFAdTypeVideoInterstitial:
            return @"Video(Inl)";
            break; */
            
            
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
            return [UIImage imageNamed:@"test_banner.png"];
            break;
            case MFAdTypeNative:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
            /*
            case MFAdTypeVideoBanner:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
            case MFAdTypeVideoInterstitial:
            return [UIImage imageNamed:@"test_banner.png"];
            break;*/
            
            
        default:
            return nil;
            break;
    }
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

#pragma mark AdMob GADNativeContentAdLoader Delegate

- (void)adLoader:(GADAdLoader *)adLoader
didReceiveNativeContentAd:(GADNativeContentAd *)nativeContentAd {
    
    NSLog(@"adLoader:didReceiveNativeContentAd:");
    
}

#pragma mark AdMob GADAdLoader Delegate

- (void)adLoader:(nonnull GADAdLoader *)adLoader didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeZero;
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return NO;
}

- (void)updateFocusIfNeeded {
    
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
    
    _nativeAdTitle.text = nativeAd.labelForTitle.text;
    _nativeAdDescription.text = nativeAd.labelForDescription.text;
    _nativeAdImage.image = nativeAd.imageViewForIcon.image;
    
}

- (void)somaNativeAdDidFailed:(SOMANativeAd*)nativeAd withError:(NSError*)error {
    NSLog(@"somaNativeAdDidFailed Error: %@",[error description]);
    
}

- (BOOL)somaNativeAdShouldEnterFullScreen:(SOMANativeAd *)nativeAd {
    NSLog(@"somaNativeAdShouldEnterFullScreen");
    return NO;
}

#pragma mark Mopub Ad Delegate

- (void)adViewDidLoadAd:(MPAdView *)view
{
    NSLog(@"Mopub -- adViewDidLoadAd");
}

- (void)willLeaveApplicationFromAd:(MPAdView *)view{
    NSLog(@"Mopub -- click!");
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

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial{
    NSLog(@"Mopub -- disappeared!");
}



#pragma mark Mopub Native Delegate

- (void)willPresentModalForNativeAd:(MPNativeAd *)nativeAd {
    
    NSLog(@"nativeAd.properties: %@", nativeAd.properties);
    
}

- (UIViewController *)viewControllerForPresentingModalView {
    
    return self;
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

///////////rewarded delegate/////////

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
     reward.type,
     [reward.amount doubleValue]];
    NSLog(@"%@",rewardMessage);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
    
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}




@end
