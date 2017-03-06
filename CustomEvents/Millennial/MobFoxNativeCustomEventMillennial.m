//
//  MobFoxNativeCustomEventMillennial.m
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxNativeCustomEventMillennial.h"
#import <MMAdSDK/MMAdSDK.h>

@implementation MobFoxNativeCustomEventMillennial

//========================================================================

/**
 * Callback fired when a native ad request succeeds, and all parameters are ready for access.
 *
 * This method is always called on the main thread.
 *
 * @param ad The native ad placement which was successfully requested.
 */
- (void)nativeAdRequestDidSucceed:(MMNativeAd *)nativeAd
{
    NSLog(@"dbg: ### Millennial: nativeAdRequestDidSucceed:");
    
    // init data object to return to MobFox:
    MobFoxNativeData *data = [[MobFoxNativeData alloc] init];
 
    // icon image - save to a file, and send MobFox the file path as URL"
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];

    NSData   *iconData = UIImagePNGRepresentation(nativeAd.iconImageView.image);
    NSString *iconPath = [documentsDirectoryPath stringByAppendingPathComponent:@"icon.png"];
    [iconData writeToFile:iconPath atomically:FALSE];
    
    NSNumber *width  = [NSNumber numberWithFloat:nativeAd.iconImageView.frame.size.width];
    NSNumber *height = [NSNumber numberWithFloat:nativeAd.iconImageView.frame.size.height];
    
    data.icon = [[MobFoxNativeImage alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:iconPath]
                                                              width:width
                                                             height:height];

    // main image - save to a file, and send MobFox the file path as URL"
    
    NSData   *mainData = UIImagePNGRepresentation(nativeAd.mainImageView.image);
    NSString *mainPath = [documentsDirectoryPath stringByAppendingPathComponent:@"main.png"];
    [mainData writeToFile:mainPath atomically:FALSE];
    
    width  = [NSNumber numberWithFloat:nativeAd.mainImageView.frame.size.width];
    height = [NSNumber numberWithFloat:nativeAd.mainImageView.frame.size.height];

    data.main = [[MobFoxNativeImage alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:mainPath]
                                                 width:width
                                                height:height];
    
    // title and body:
    
    data.assetHeadline    = nativeAd.title.text;
    data.assetDescription = nativeAd.body.text;

    // get action URL:
    
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    [keys addObject:@"defaultActionLink"];
    NSDictionary *dict = [nativeAd dictionaryWithValuesForKeys:keys];
    if (dict!=nil)
    {
        NSObject *mmNativeLink = [dict objectForKey:@"defaultActionLink"];
        if (mmNativeLink!=nil)
        {
            NSMutableArray *keys2 = [[NSMutableArray alloc] init];
            [keys2 addObject:@"url"];
            NSDictionary *dict2 = [mmNativeLink dictionaryWithValuesForKeys:keys2];
            if (dict2!=nil)
            {
                NSURL *newURL = [dict2 objectForKey:@"url"];
                if (newURL!=nil)
                {
                    data.clickURL = [[NSURL alloc] initWithString:[newURL absoluteString]];
                }
            }
        }
    }
    
    // send to MobFox:
    
    [self.delegate MFNativeCustomEventAd:self didLoad:data];
}



- (void)nativeAd:(MMNativeAd*)ad requestDidFailWithError:(NSError*)error
{
    NSLog(@"dbg: ### Millennial: requestDidFailWithError: %@",error);
    
    [self.delegate MFNativeCustomEventAdDidFailToReceiveAdWithError:error];
}

/**
 * Callback indicating that the user has interacted with ad content.
 *
 * This callback should not be used to adjust the contents of your application -- it should be used only for the purposes of reporting.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement which was tapped.
 * @param nativeAdComponent The MMNativeAdComponent which was tapped.
 * @param instance The instance of the component which was tapped.
 */
- (void)nativeAd:(MMNativeAd*)ad tappedComponent:(MMNativeAdComponent)nativeAdComponent
        instance:(NSInteger)instance
{
    NSLog(@"dbg: ### Millennial: tappedComponent:");
}

/**
 * Callback invoked prior to the application going into the background due to a user interaction with an ad.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement.
 */
-(void)nativeAdWillLeaveApplication:(MMNativeAd*)ad
{
    NSLog(@"dbg: ### Millennial: nativeAdWillLeaveApplication:");
}

/**
 * Callback fired when an ad expires.
 *
 * After receiving this message, your app should call -load before attempting to access
 * any components of the native ad.
 *
 * This method is always called on the main thread.
 *
 * @param ad The ad placement which expired.
 */
-(void)nativeAdDidExpire:(MMNativeAd*)ad
{
    NSLog(@"dbg: ### Millennial: nativeAdDidExpire:");
}

-(UIViewController*)viewControllerForPresentingModalView
{
    NSLog(@"dbg: ### Millennial: viewControllerForPresentingModalView:");
    return self.parentViewController;
}

- (void)displayContentForURL:(NSURL *)URL rootViewController:(UIViewController *)controller{
    [[UIApplication sharedApplication] openURL:URL];
}

//========================================================================

- (void)registerViewWithInteraction:(UIView *)view withViewController:(UIViewController *)viewController
{
    NSLog(@"dbg: ### Millennial: registerViewWithInteraction:");
}

- (void)requestAdWithNetworkID:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSLog(@"dbg: ### Millennial: requestAd: %@",info);
    NSLog(@"dbg: ### Millennial: networkID: %@",networkId);
    
    self.parentViewController = [info objectForKey:@"viewcontroller_parent"];
    
    [[MMSDK sharedInstance] initializeWithSettings:nil withUserSettings:nil];
    
    self.nativeAd = [[MMNativeAd alloc] initWithPlacementId:networkId
                                             supportedTypes:@[MMNativeAdTypeInline]];
    self.nativeAd.delegate = self;
    [self.nativeAd load:nil];
}

-(void)dealloc{
    _nativeAd.delegate = nil;
    _nativeAd = nil;
}

@end
