//
//  MobFoxCustomEventMillennial.m
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxCustomEventMillennial.h"
#import <MMAdSDK/MMAdSDK.h>

#define MILLENNIAL_BANNER_AD_SIZE ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? MMInlineAdSizeLeaderboard : MMInlineAdSizeBanner)


@implementation MobFoxCustomEventMillennial

//========================================================================

- (UIViewController *)viewControllerForPresentingModalView
{
    return self.parentViewController;
}

/**
 * Callback indicating that an ad request has succeeded.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement which was successfully requested.
 */
-(void)inlineAdRequestDidSucceed:(MMInlineAd*)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdRequestDidSucceed <<<");
    
    [self.delegate MFCustomEventAd:self didLoad:ad.view];
}

/**
 * Callback indicating that ad content failed to load or render.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement for which the request failed.
 * @param error The error indicating the failure.
 */
-(void)inlineAd:(MMInlineAd*)ad requestDidFailWithError:(NSError*)error
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: requestDidFailWithError %@ <<<",error.description);
    
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
}

/**
 *  Callback indicating that the user has interacted with ad content.
 *
 * This callback should not be used to adjust the contents of your application -- it should
 * be used only for the purposes of reporting.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement which was tapped.
 */
-(void)inlineAdContentTapped:(MMInlineAd*)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdContentTapped <<<");
    
    [self.delegate MFCustomEventMobFoxAdClicked];
}

/**
 * Callback indicating that the ad is preparing to be resized.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 * @param frame The size and location of the ad placement.
 * @param isClosingResize This flag indicates the resize close button was tapped, causing a resize to the default/original size.
 */
-(void)inlineAd:(MMInlineAd*)ad willResizeTo:(CGRect)frame isClosing:(BOOL)isClosingResize
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: willResizeTo <<<");
}

/**
 * Callback indicating the ad has finished resizing.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 * @param frame The size and location of the ad placement.
 * @param isClosingResize This flag indicates the resize close button was tapped, causing a resize to the default/original size.
 */
-(void)inlineAd:(MMInlineAd*)ad didResizeTo:(CGRect)frame isClosing:(BOOL)isClosingResize
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: didResizeTo <<<");
}

/**
 * Callback indicating that the ad is preparing to present a modal view.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)inlineAdWillPresentModal:(MMInlineAd *)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdWillPresentModal <<<");
}

/**
 * Callback indicating that the ad has presented a modal view.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)inlineAdDidPresentModal:(MMInlineAd *)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdDidPresentModal <<<");
}

/**
 * Callback indicating that the ad is preparing to dismiss a modal view.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)inlineAdWillCloseModal:(MMInlineAd *)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdWillCloseModal <<<");
}

/**
 * Callback indicating that the ad has dismissed a modal view.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)inlineAdDidCloseModal:(MMInlineAd *)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdDidCloseModal <<<");
    
    [self.delegate MFCustomEventAdClosed];
}

/**
 * Callback invoked prior to the application going into the background due to a user interaction with an ad.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)inlineAdWillLeaveApplication:(MMInlineAd *)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdWillLeaveApplication <<<");
    
    [self.delegate MFCustomEventAdClosed];
}

/**
 * Callback invoked when an abort for an in-progress request successfully stops processing.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)inlineAdAbortDidSucceed:(MMInlineAd*)ad
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: inlineAdAbortDidSucceed <<<");
}

/**
 * Callback invoked when an abort for an in-progress request fails.
 *
 * Note that depending on the reason for abort failure, the relevant delegate callback
 * (inlineAdRequestDidSucceed: or inlineAd:requestDidFailWithError:) is invoked *before*
 * this method.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 * @param error Error indicating the manner in which the abort failed.
 */
-(void)inlineAd:(MMInlineAd*)ad abortDidFailWithError:(NSError*)error
{
    NSLog(@"dbg: ### MILLENNIAL: >>> BANNER MILLENNIAL: abortDidFailWithError <<<");
}

//========================================================================

- (void)requestAdWithSize:(CGSize)size
                networkID:(NSString*)networkId
          customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Millennial: loadAd ###");
    //NSLog(@"dbg: ### Millennial: params: %@",info);
    NSLog(@"dbg: ### Millennial: networkID: %@",networkId);
    
    self.parentViewController = [info objectForKey:@"viewcontroller_parent"];
    
    CGSize mInlineAdSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? CGSizeMake(728, 90): CGSizeMake(320, 50);
    
    if(CGSizeEqualToSize(mInlineAdSize, size)) {

        [[MMSDK sharedInstance] initializeWithSettings:nil withUserSettings:nil];
        
        self.mInlineAd = [[MMInlineAd alloc] initWithPlacementId:networkId adSize:MILLENNIAL_BANNER_AD_SIZE];
        self.mInlineAd.delegate = self;
        [self.mInlineAd request:nil];
        
    } else {
        
        NSError *error = [[NSError alloc] initWithDomain:@"ad request failed, ad size isn't supported" code:0 userInfo:nil];
        [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];

    }

}

-(void)dealloc{
    self.parentViewController = nil;
    self.mInlineAd.delegate = nil;
    self.mInlineAd = nil;
}

@end