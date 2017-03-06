//
//  MobFoxCustomEventSmaato.m
//  MobFoxCoreDemo
//
//  Created by Shimon Shnitzer on 17/5/16.
//  Copyright © 2015 Shimon Shnitzer. All rights reserved.
//

#import "MobFoxNativeCustomEventSmaato.h"


@implementation MobFoxNativeCustomEventSmaato

//========================================================================

- (void)somaNativeAdDidLoad:(SOMANativeAd*)nativeAd
{
    NSLog(@"dbg: ### Smaato: >>> NATIVE SMAATO: somaNativeAdDidLoad <<<");
    
    // init data object to return to MobFox:
    MobFoxNativeData *data = [[MobFoxNativeData alloc] init];
    
    // icon image - save to a file, and send MobFox the file path as URL"
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    NSData   *iconData = UIImagePNGRepresentation(nativeAd.imageViewForIcon.image);
    NSString *iconPath = [documentsDirectoryPath stringByAppendingPathComponent:@"icon.png"];
    [iconData writeToFile:iconPath atomically:FALSE];
    
    NSNumber *wIcon = [NSNumber numberWithFloat:nativeAd.imageViewForIcon.image.size.width];
    NSNumber *hIcon = [NSNumber numberWithFloat:nativeAd.imageViewForIcon.image.size.height];
    
    data.icon = [[MobFoxNativeImage alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:iconPath]
                                                 width:wIcon
                                                height:hIcon];
    
    // main image - save to a file, and send MobFox the file path as URL"
    
    NSData   *mainData = UIImagePNGRepresentation(((UIImageView *)nativeAd.viewForMainImage).image);
    NSString *mainPath = [documentsDirectoryPath stringByAppendingPathComponent:@"main.png"];
    [mainData writeToFile:mainPath atomically:FALSE];
    
    NSNumber *wMain = [NSNumber numberWithFloat:((UIImageView *)nativeAd.viewForMainImage).image.size.width];
    NSNumber *hMain = [NSNumber numberWithFloat:((UIImageView *)nativeAd.viewForMainImage).image.size.height];
    
    data.main = [[MobFoxNativeImage alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:mainPath]
                                                 width:wMain
                                                height:hMain];
    
    // title and body:
    
    data.assetHeadline    = nativeAd.labelForTitle.text;
    data.assetDescription = nativeAd.labelForDescription.text;
    
    
    
    // get action URL:
    
    data.clickURL = nativeAd.clickURL;
    
    
    //NSURL* iconImageURL_ = [[NSOpenPanel URLs] objectAtIndex:0];

    
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    [keys addObject:@"ad"];
    NSDictionary *dict = [nativeAd dictionaryWithValuesForKeys:keys];
    if (dict!=nil)
    {
        NSObject *mmNativeLink = [dict objectForKey:@"ad"];
        if (mmNativeLink!=nil)
        {
            NSMutableArray *keys2 = [[NSMutableArray alloc] init];
            [keys2 addObject:@"iconImageURL"];
            [keys2 addObject:@"mainImageURL"];
            NSDictionary *dict2 = [mmNativeLink dictionaryWithValuesForKeys:keys2];
            if (dict2!=nil)
            {
                NSURL *iconImageURL = [dict2 objectForKey:@"iconImageURL"];
                if (iconImageURL!=nil)
                {
                    data.icon = [[MobFoxNativeImage alloc] initWithURL:iconImageURL
                                                                 width:wIcon
                                                                height:hIcon];
                }
                NSURL *mainImageURL = [dict2 objectForKey:@"mainImageURL"];
                if (mainImageURL!=nil)
                {
                    data.main = [[MobFoxNativeImage alloc] initWithURL:mainImageURL
                                                                 width:wMain
                                                                height:hMain];
                }
            }
        }
    }
    
    
    // send to MobFox:
    
    [self.delegate MFNativeCustomEventAd:self didLoad:data];
}

- (void)somaNativeAdDidFailed:(SOMANativeAd*)nativeAd withError:(NSError*)error
{
    NSLog(@"dbg: ### Smaato: >>> NATIVE SMAATO: didFailToReceiveAdWithError %@ <<<",error.description);
    
    [self.delegate MFNativeCustomEventAdDidFailToReceiveAdWithError:error];
}

- (BOOL)somaNativeAdShouldEnterFullScreen:(SOMANativeAd *)nativeAd
{
    NSLog(@"dbg: ### Smaato: >>> NATIVE SMAATO: somaAdViewWillEnterFullscreen <<<");
    return TRUE;
}

- (UIViewController*) somaRootViewController
{
    return self.parentViewController;
}

//========================================================================

- (void)registerViewWithInteraction:(UIView *)view withViewController:(UIViewController *)viewController
{
    NSLog(@"dbg: ### Smaato: registerViewWithInteraction:");
    
    [self.nativeAd registerViewForUserInteraction:view];
    
}

- (void)requestAdWithNetworkID:(NSString*)networkId customEventInfo:(NSDictionary *)info
{
    NSString *publisherId = nil;
    NSString *adSpaceId   = nil;
    
    self.parentViewController = [info objectForKey:@"viewcontroller_parent"];
    
    if ((networkId!=nil) && ([networkId length]>0))
    {
        NSArray *parts = [networkId componentsSeparatedByString:@";"];
        
        if ([parts count]>=2)
        {
            adSpaceId   = (NSString *)[parts objectAtIndex:0];
            publisherId = (NSString *)[parts objectAtIndex:1];
        }
    }
    NSLog(@"dbg: ### Smaato: pubId=%@, adId=%@",publisherId,adSpaceId);
    
    //@@@@ remove this when we manage to make our ad work
    if (([publisherId isEqualToString:@"1100021907"]) && ([adSpaceId isEqualToString:@"130200874"]))
    {
        publisherId = @"0";
        adSpaceId   = @"3075";
    }

    self.nativeAd = [[SOMANativeAd alloc] initWithPublisherId:publisherId adSpaceId:adSpaceId];
    self.nativeAd.delegate = self;

    /*self.nativeAd.layout = SOMANativeAdLayoutNewsFeed;*/
    
    [self.nativeAd load];
}

-(void)dealloc{
    self.nativeAd.delegate = nil;
    self.nativeAd = nil;
}

@end
