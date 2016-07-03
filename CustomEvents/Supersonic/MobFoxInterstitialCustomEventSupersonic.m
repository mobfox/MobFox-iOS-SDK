//
//  MobFoxInterstitialCustomEventSupersonic.m
//  MobFox demo
//
//  Created by Shimon Shnitzer on 24/05/2016.
//  Copyright © 2016 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxInterstitialCustomEventSupersonic.h"

@implementation MobFoxInterstitialCustomEventSupersonic

static bool mSupersonicInitialized = false;

//--------------------------------------

/*!
 * @discussion Called when initiation stage fails, or if you have a problem in the integration.
 *
 *              You can learn about the reason by examining the 'error' value
 */
- (void)supersonicISInitFailedWithError:(NSError *)error
{
    NSLog(@"Supersonic: supersonicISInitFailedWithError error: %@",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

/*!
 * @discussion Called if showing the Interstitial for the user has failed.
 *
 *              You can learn about the reason by examining the ‘error’ value
 */
- (void)supersonicISShowFailWithError:(NSError *)error
{
    NSLog(@"Supersonic: supersonicISShowFailWithError error: %@",error.description);
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

/*!
 * @discussion Called each time an ad is not available
 */
- (void)supersonicISFailed
{
    NSLog(@"Supersonic: supersonicISFailed ###");
    
    NSError *error = [[NSError alloc] initWithDomain:@"No ad received" code:6 userInfo:nil];
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

//-------------------------------------

/*!
 * @discussion Called when initiation process of the Interstitial ad unit has finished successfully.
 */
- (void)supersonicISInitSuccess
{
    NSLog(@"Supersonic: supersonicISInitSuccess");
    
    mSupersonicInitialized = true;
    
    [[Supersonic sharedInstance] loadIS];
}

/*!
 * @discussion Called each time an ad is available
 */
- (void)supersonicISReady
{
    NSLog(@"Supersonic: supersonicISReady ###");
    
    UIViewController* rootVC = (UIViewController*)[[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
    
    [[Supersonic sharedInstance] showISWithViewController:rootVC];
}

/*!
 * @discussion Called each time the Interstitial window is about to open
 */
- (void)supersonicISAdOpened
{
    NSLog(@"Supersonic: supersonicISAdOpened ###");
}

/*!
 * @discussion Called each time the Interstitial window is about to close
 */
- (void)supersonicISAdClosed
{
    NSLog(@"Supersonic: supersonicISAdClosed ###");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
}

/*!
 * @discussion Called each time the Interstitial window has opened successfully.
 */
- (void)supersonicISShowSuccess
{
    NSLog(@"Supersonic: supersonicISShowSuccess ###");
    
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

/*!
 * @discussion Called each time the end user has clicked on the Interstitial ad.
 */
- (void)supersonicISAdClicked
{
    NSLog(@"Supersonic: supersonicISAdClicked ###");
    
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

//--------------------------------------

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"Supersonic: loadAd ###");
    NSLog(@"Supersonic: params: %@",info);
    NSLog(@"Supersonic: networkID: %@",networkId);
    
    NSString *mAppKey = @"4ba4e24d";
    NSString *mUserId = @"APPLICATION_USER_ID_HERE";
    if ((networkId!=nil) && ([networkId length]>0))
    {
        mAppKey = networkId;
    }
    NSLog(@"Supersonic: AppKey=%@",mAppKey);

    [[Supersonic sharedInstance] setISDelegate:self];
    
    if (mSupersonicInitialized)
    {
        [self supersonicISInitSuccess];
    } else {
        [[Supersonic sharedInstance] initISWithAppKey:mAppKey withUserId:mUserId];
    }
}

@end
