//
//  MobFoxCustomEventStartapp.m
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxCustomEventStartapp.h"


@implementation MobFoxCustomEventStartapp

//========================================================================

- (void) didDisplayBannerAd:(STABannerView*)banner
{
    NSLog(@"dbg: ### Startapp: >>> BANNER STARTAPP: didDisplayBannerAd <<<");
    
    [self.delegate MFCustomEventAd:self didLoad:banner];
}

- (void) failedLoadBannerAd:(STABannerView*)banner withError:(NSError *)error
{
    NSLog(@"dbg: ### Startapp: >>> BANNER STARTAPP: failedLoadBannerAd %@ <<<",error.description);
    
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
}

- (void) didClickBannerAd:(STABannerView*)banner
{
    NSLog(@"dbg: ### Startapp: >>> BANNER STARTAPP: didClickBannerAd <<<");
    
    [self.delegate MFCustomEventMobFoxAdClicked];
}

- (void) didCloseBannerInAppStore:(STABannerView*)banner
{
    NSLog(@"dbg: ### Startapp: >>> BANNER STARTAPP: didCloseBannerInAppStore <<<");
    
    [self.delegate MFCustomEventAdClosed];
}

//========================================================================

- (void)requestAdWithSize:(CGSize)size
                networkID:(NSString*)networkId
          customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Startapp: loadAd ###");
    NSLog(@"dbg: ### Startapp: networkID: %@",networkId);
    
    STABannerSize sTABannerSize;
    self.parentViewController = [info objectForKey:@"viewcontroller_parent"];
    
    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    sdk.appID = networkId;

    if (self.sTABannerView == nil) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if(CGSizeEqualToSize(STA_PortraitAdSize_768x90.size, size)) {
                sTABannerSize = STA_PortraitAdSize_768x90;
            } else if(CGSizeEqualToSize(STA_LandscapeAdSize_1024x90.size, size)) {
                sTABannerSize = STA_LandscapeAdSize_1024x90;
            }
        } else if(CGSizeEqualToSize(STA_PortraitAdSize_320x50.size, size)) {
            sTABannerSize = STA_PortraitAdSize_320x50;
        }
        
        if(!CGSizeEqualToSize(CGSizeZero, sTABannerSize.size)) {

        self.sTABannerView = [[STABannerView alloc] initWithSize:sTABannerSize
                                                   autoOrigin:STAAdOrigin_Bottom
                                                     withView:self.parentViewController.view
                                                 withDelegate:self];
        
        } else {
            
            NSError *error = [[NSError alloc] initWithDomain:@"ad request failed, ad size isn't supported" code:0 userInfo:nil];
            [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:error];
            
        }
    }
}

-(void)dealloc{
    self.parentViewController = nil;
    self.sTABannerView = nil;
}

@end