//
//  MobFoxNativeCustomEventStartapp.m
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxNativeCustomEventStartapp.h"


@implementation MobFoxNativeCustomEventStartapp

//========================================================================

- (void) didLoadAd:(STAAbstractAd*)ad
{
    NSLog(@"dbg: ### Startapp: didLoadAd %lu ###",(unsigned long)[self.startAppNativeAd.adsDetails count]);
    
    STANativeAdDetails *adDetails;
    
    if (self.startAppNativeAd.adsDetails.count > 0) {
        adDetails = [self.startAppNativeAd.adsDetails objectAtIndex:0];

    } else {
        
        [self.delegate MFNativeCustomEventAd:self didLoad:nil];
        return;

    }
    
    
    MobFoxNativeData *data = [[MobFoxNativeData alloc] init];
    
    NSNumber *width  = [NSNumber numberWithFloat:0];
    NSNumber *height = [NSNumber numberWithFloat:0];
    
    data.icon = [[MobFoxNativeImage alloc] initWithURL:[NSURL URLWithString:adDetails.secondaryImageUrl]
                                                 width:width
                                                height:height];
    
    data.main = [[MobFoxNativeImage alloc] initWithURL:[NSURL URLWithString:adDetails.imageUrl]
                                                 width:width
                                                height:height];
    
    
    data.assetHeadline    = adDetails.title;
    data.assetDescription = adDetails.description;
    data.rating           = adDetails.rating;
    /*data.clickURL         = [NSURL URLWithString:adDetails.clickUrl];*/
    data.clickURL         = [NSURL URLWithString:adDetails.clickToInstall];
    
    //TODO: add click event to MobFoxNativeCustomEvent, and add the line [adDetails sendClick];
    
    //[adDetails sendClick];
    
    [adDetails sendImpression];
    
    [self.delegate MFNativeCustomEventAd:self didLoad:data];
}

- (void) failedLoadAd:(STAAbstractAd*)ad withError:(NSError *)error
{
    NSLog(@"dbg: ### Startapp: failedLoadAd(%@) ###",error);
    
    [self.delegate MFNativeCustomEventAdDidFailToReceiveAdWithError:error];
}

//========================================================================

- (void)registerViewWithInteraction:(UIView *)view withViewController:(UIViewController *)viewController
{
    NSLog(@"dbg: ### Startapp: registerViewWithInteraction:");
}

- (void)requestAdWithNetworkID:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Startapp: requestAd: %@",info);
    NSLog(@"dbg: ### Startapp: networkID: %@",networkId);
    
    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    sdk.appID = networkId;
    
    self.startAppNativeAd = [[STAStartAppNativeAd alloc] init];
    [self.startAppNativeAd loadAdWithDelegate:self];
    
}

-(void)dealloc{
    
    self.startAppNativeAd = nil;
}

@end
