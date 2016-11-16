//
//  SmatooAdapterMobFox.m
//  Adapters
//
//  Created by Shimi Sheetrit on 11/14/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "SmaatoAdapterMobFox.h"

@implementation SmaatoAdapterMobFox


- (void)loadBanner {
    
    NSLog(@"MobFox >> Smaato banner >> loadBanner");
    
    NSData *data = [self.network.customClassData dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *inv_h = [json objectForKey:@"AD_UNIT_ID"];
    NSLog(@"loadBanner invh: %@", inv_h);
    
    if (inv_h == nil) {
        [self adLoadFailedWithMessage:@"AdUnit value should be a JSON objet e.g. {\"adunitid\": \"ca-app-pub-3940256099942544/6300978111\"}"];
        return;
    }
    
    if (self.isInterstitial) {
        [self loadInterstitial];
        return;
    }
    
    self.banner = [[MobFoxAd alloc] init:inv_h withFrame:CGRectMake(0, 0, self.network.width, self.network.height)];
    self.banner.delegate = self;
    [self.banner loadAd];
    
    
}

- (void)loadInterstitial {
    
    NSLog(@"MobFox >> Smaato interstitial >> loadInterstitial");
    
    NSData *data = [self.network.customClassData dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *inv_h = [json objectForKey:@"AD_UNIT_ID"];
    NSLog(@"loadInterstitial invh: %@", inv_h);
    
    if (inv_h == nil) {
        [self adLoadFailedWithMessage:@"AdUnit value should be a JSON objet e.g. {\"adunitid\": \"ca-app-pub-3940256099942544/6300978111\"}"];
        return;
    }
    
    self.interstitial = [[MobFoxInterstitialAd alloc] init:inv_h];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
    
}

- (void)presentInterstitial {
    
    NSLog(@"MobFox >> Smaato interstitial >> presentInterstitial");
    if(self.interstitial.ready) {
        self.interstitial.rootViewController = [self rootViewController];
        [self.interstitial show];
    }
}

#pragma mark MobFox Ad Delegate

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    NSLog(@"MobFox >> SmaatoAdapterMobFox >> Got Ad");
    [self adLoadedWithView:banner];
    
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"MobFox >> SmaatoAdapterMobFox >> Error: %@",[error description]);
    [self adLoadFailedWithError:error];
    
}

- (void)MobFoxAdClicked {
    NSLog(@"MobFox >> SmaatoAdapterMobFox >> MobFoxAdClicked");
    [self adWillLeaveApplication];
    
}

- (void)MobFoxAdClosed {
    NSLog(@"MobFox >> SmaatoAdapterMobFox >> MobFoxAdClosed");
    [self adDidDismissFullscreen];
    
}

- (void)MobFoxAdFinished {
}

#pragma mark MobFox Interstitial Ad Delegate

//called when ad is displayed
- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial {
    NSLog(@"MobFox Interstitial >> SmaatoAdapterMobFox >> Got Ad");
    [self adLoadedWithView:nil];
}

//called when an ad cannot be displayed
- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"MobFox Interstitial >> SmaatoAdapterMobFox >> Error: %@",[error description]);
    [self adLoadFailedWithError:error];
    
}

//called when ad is closed/skipped
- (void)MobFoxInterstitialAdClosed {
    NSLog(@"MobFox Interstitial >> SmaatoAdapterMobFox >> MobFoxAdClosed");
    [self adDidDismissFullscreen];
    
}

//called w mobfoxInterAd.delegate = self;hen ad is clicked
- (void)MobFoxInterstitialAdClicked {
    NSLog(@"MobFox Interstitial >> SmaatoAdapterMobFox >> MobFoxAdClicked");
    [self.delegate mediationPluginClicked:self];
    [self adWillLeaveApplication];
}

//called when if the ad is a video ad and it has finished playing
- (void)MobFoxInterstitialAdFinished {
    
}


- (void)dealloc{
    self.banner.delegate = nil;
    self.interstitial.delegate = nil;
    self.banner = nil;
    self.interstitial = nil;
}


@end

