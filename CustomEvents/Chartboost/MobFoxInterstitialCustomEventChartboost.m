//
//  MobFoxInterstitialCustomEventChartboost.m
//  MobFox demo
//
//  Created by Shimon Shnitzer on 29/05/2016.
//  Copyright © 2016 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxInterstitialCustomEventChartboost.h"

@implementation MobFoxInterstitialCustomEventChartboost

static bool mChartboostInitialized = false;


//--------------------------------------

/*!
 @abstract
 Called after the SDK has been successfully initialized
 
 @param status The result of the initialization. YES if successful. NO if failed.
 
 @discussion Implement to be notified of when the initialization process has finished.
 */

- (void)didInitialize:(BOOL)status
{
    NSLog(@"Chartboost: ChartBoostInitialize %@",status?@"TRUE":@"FALSE");
    
    if (status)
    {
        mChartboostInitialized = true;
        [Chartboost showInterstitial:CBLocationHomeScreen];
    }
}

- (void)didDisplayInterstitial:(CBLocation)location
{
    NSLog(@"Chartboost: didDisplayInterstitial ###");
    
    [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

- (void)didFailToLoadInterstitial:(CBLocation)location
                        withError:(CBLoadError)numError
{
    NSLog(@"Chartboost: didFailToLoadInterstitial error: %lu",(unsigned long)numError);
    
    NSString *domain = @"Unknown";
    
    switch (numError)
    {
        case CBLoadErrorInternal:
            domain = @"Unknown internal error";
            break;
        case CBLoadErrorInternetUnavailable:
            domain = @"Network is currently unavailable";
            break;
        case CBLoadErrorTooManyConnections:
            domain = @"Too many requests are pending for that location";
            break;
        case CBLoadErrorWrongOrientation:
            domain = @"Interstitial loaded with wrong orientation";
            break;
        case CBLoadErrorFirstSessionInterstitialsDisabled:
            domain = @"Interstitial disabled, first session";
            break;
        case CBLoadErrorNetworkFailure:
            domain = @"Network request failed";
            break;
        case CBLoadErrorNoAdFound:
            domain = @"No ad received";
            break;
        case CBLoadErrorSessionNotStarted:
            domain = @"Session not started";
            break;
        case CBLoadErrorImpressionAlreadyVisible:
            domain = @"There is an impression already visible";
            break;
        case CBLoadErrorUserCancellation:
            domain = @"User manually cancelled the impression";
            break;
        case CBLoadErrorNoLocationFound:
            domain = @"No location detected";
            break;
        case CBLoadErrorAssetDownloadFailure:
            domain = @"Error downloading asset";
            break;
        case CBLoadErrorPrefetchingIncomplete:
            domain = @"Video Prefetching is not finished";
            break;
    }

    NSError *error = [[NSError alloc] initWithDomain:domain code:numError userInfo:nil];
    
    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void)didDismissInterstitial:(CBLocation)location
{
    NSLog(@"Chartboost: didDismissInterstitial ###");
    
    [self.delegate MFInterstitialCustomEventMobFoxAdFinished];
    
    [Chartboost closeImpression];
}

- (void)didCloseInterstitial:(CBLocation)location
{
    NSLog(@"Chartboost: didCloseInterstitial ###");
    
    [self.delegate MFInterstitialCustomEventAdClosed];
    
    [Chartboost closeImpression];
}

- (void)didClickInterstitial:(CBLocation)location
{
    NSLog(@"Chartboost: didClickInterstitial ###");
    
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

//============================================================================

-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"Chartboost: loadAd ###");
    NSLog(@"Chartboost: params: %@",info);
    NSLog(@"Chartboost: networkID: %@",networkId);
    
    NSString *appId  = @"574446edf6cd454f24f9d93b";
    NSString *appSig = @"62886b3169cb89ef136c5901e98b3f8227de3aba";
    
    if ((networkId!=nil) && ([networkId length]>0))
    {
        NSArray *parts = [networkId componentsSeparatedByString:@";"];
        
        if ([parts count]>=2)
        {
            appId  = [parts objectAtIndex:0];
            appSig = [parts objectAtIndex:1];
        }
    }
    NSLog(@"Chartboost: AppId=%@, sig=%@",appId,appSig);
    

    if (mChartboostInitialized)
    {
        [Chartboost showInterstitial:CBLocationHomeScreen];
    } else {
        // Initialize the Chartboost library
        [Chartboost startWithAppId:appId
                      appSignature:appSig
                          delegate:self];
    }
}

@end
