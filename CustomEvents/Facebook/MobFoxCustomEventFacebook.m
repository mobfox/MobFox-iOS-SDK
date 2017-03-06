//
//  MobFoxCustomEventFacebook.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 11/1/16.
//  Copyright © 2015 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxCustomEventFacebook.h"

@interface MobFoxCustomEventFacebook ()

@property(nonatomic, strong) FBAdView *adView;

@end

@implementation MobFoxCustomEventFacebook

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info {
    
    FBAdSize fBAdSize;
    
    self.parentViewController = [info objectForKey:@"viewcontroller_parent"];
    
    if(CGSizeEqualToSize(kFBAdSize320x50.size, size)) {
        
        fBAdSize = kFBAdSize320x50;
        
    } else if (kFBAdSizeHeight50Banner.size.height == size.height) {
        
        fBAdSize = kFBAdSizeHeight50Banner;
        
    } else if (kFBAdSizeHeight90Banner.size.height == size.height) {
        
        fBAdSize = kFBAdSizeHeight90Banner;
        
    } else if (kFBAdSizeHeight250Rectangle.size.height == size.height) {
        
        fBAdSize = kFBAdSizeHeight250Rectangle;
        
    } else {
        
        NSLog(@"Banner height is invalid. it has to be equal to 50pt, 90pt or 250pt");
        NSString *errorDomain = @"";
        NSInteger errorCode = 0;
        NSString *localizedDescription = @"Banner height is invalid. it has to be equal to 50pt, 90pt or 250pt";
        NSDictionary *errorUserInfo = [[NSDictionary alloc] initWithObjectsAndKeys:localizedDescription, NSLocalizedDescriptionKey, nil];
        NSError *error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:errorUserInfo];
        NSLog(@"error description: %@", [error localizedDescription]) ;
        
        self.adView.hidden = YES;
        [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
        return;
    }
    
    self.adView = [[FBAdView alloc] initWithPlacementID:nid adSize:fBAdSize rootViewController:self.parentViewController];
    self.adView.delegate = self;
    [self.adView loadAd];
        
}

#pragma mark FB Ad View Delegate

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error;
{
    NSLog(@"FB Ad failed to load");
    
    self.adView.hidden = YES;
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];

}

- (void)adViewDidLoad:(FBAdView *)adView;
{
    NSLog(@"Ad was loaded and ready to be displayed");
    
    self.adView.hidden = NO;
    [self.delegate MFCustomEventAd:self didLoad:adView];
    
}

- (void)adViewDidClick:(FBAdView *)adView
{
    NSLog(@"The user clicked on the ad and will be taken to its destination.");
    [self.delegate MFCustomEventMobFoxAdClicked];

}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView
{
    NSLog(@"The user finished to interact with the ad.");
}



@end
