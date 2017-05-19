//
//  MobFoxInterstitialCustomEventSupersonic.m
//  MobFox demo
//
//  Created by Shimon Shnitzer on 24/05/2016.
//  Copyright © 2016 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxInterstitialCustomEventSupersonic.h"

static BOOL mfInitISSucceded;

@implementation MobFoxInterstitialCustomEventSupersonic


//--------------------------------------

/*!
 * @discussion Called when initiation stage fails, or if you have a problem in the integration.
 *
 *              You can learn about the reason by examining the 'error' value
 */
- (void)supersonicISInitFailedWithError:(NSError *)error
{
    NSLog(@"dbg: ### Supersonic: supersonicISInitFailedWithError error: %@",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

/*!
 * @discussion Called if showing the Interstitial for the user has failed.
 *
 *              You can learn about the reason by examining the ‘error’ value
 */
- (void)supersonicISShowFailWithError:(NSError *)error
{
    NSLog(@"dbg: ### Supersonic: supersonicISShowFailWithError error: %@",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

/*!
 * @discussion Called each time an ad is not available
 */
- (void)supersonicISFailed
{
    NSLog(@"dbg: ### Supersonic: supersonicISFailed ###");
    
    NSError *error = [[NSError alloc] initWithDomain:@"Ad is not available" code:0 userInfo:nil];
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

//-------------------------------------

/*!
 * @discussion Called when initiation process of the Interstitial ad unit has finished successfully.
 */
- (void)supersonicISInitSuccess
{
    NSLog(@"dbg: ### Supersonic: supersonicISInitSuccess");
    mfInitISSucceded = true;
    [[Supersonic sharedInstance] loadIS];
}

/*!
 * @discussion Called each time an ad is available
 */
- (void)supersonicISReady
{
    NSLog(@"dbg: ### Supersonic: supersonicISReady ###");
    
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

/*!
 * @discussion Called each time the Interstitial window is about to open
 */
- (void)supersonicISAdOpened
{
    NSLog(@"dbg: ### Supersonic: supersonicISAdOpened ###");
}

/*!
 * @discussion Called each time the Interstitial window is about to close
 */
- (void)supersonicISAdClosed
{
    NSLog(@"dbg: ### Supersonic: supersonicISAdClosed ###");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}

/*!
 * @discussion Called each time the Interstitial window has opened successfully.
 */
- (void)supersonicISShowSuccess
{
    NSLog(@"dbg: ### Supersonic: supersonicISShowSuccess ###");
}

/*!
 * @discussion Called each time the end user has clicked on the Interstitial ad.
 */
- (void)supersonicISAdClicked
{
    NSLog(@"dbg: ### Supersonic: supersonicISAdClicked ###");
    
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

//--------------------------------------

-(void)presentWithRootController:(UIViewController *)rootViewController {
    
    NSLog(@"dbg: ### Supersonic: >>> INTERSTITIAL: presentAd <<<");
    
    [[Supersonic sharedInstance] showISWithViewController:rootViewController];
}

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSMutableDictionary *)info
{
    
    NSLog(@"dbg: ### Supersonic: >>> INTERSTITIAL: loadAd <<<");
    //NSLog(@"dbg: ### Supersonic: params: %@",info);
    NSLog(@"dbg: ### Supersonic: networkID: %@",networkId);
    
    
    if (mfInitISSucceded) {
        [[Supersonic sharedInstance] loadIS];
    } else {
        NSString *appKey = networkId; //@"4ba4e24d";
        NSString *userId = [info objectForKey:@"o_iosadvid"];
        [[Supersonic sharedInstance] setISDelegate:self];
        [[Supersonic sharedInstance] initISWithAppKey:appKey withUserId:userId];
    }

}

@end
