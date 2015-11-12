#import "MPMobFoxNativeAdAdapter.h"

@implementation MPMobFoxNativeAdAdapter

- (instancetype)initWithMobFoxNativeAd:(NSDictionary *)ad{
    self = [super init];
    
    NSDictionary* textAssets = [ad valueForKey:@"textassets"];
    [self.properties setValue:[textAssets valueForKey:@"headline"] forKey:@"kAdTitleKey"];
    [self.properties setValue:[textAssets valueForKey:@"description"] forKey:@"kAdTextKey"];
    [self.properties setValue:[textAssets valueForKey:@"cta"] forKey:@"kAdCTATextKey"];
    [self.properties setValue:[textAssets valueForKey:@"rating"] forKey:@"kAdStarRatingKey"];
    
    
    NSDictionary* imageAssets = [ad valueForKey:@"imageassets"];
    [self.properties setValue:[[imageAssets valueForKey:@"icon"] valueForKey:@"url"] forKey:@"kAdIconImageKey"];
    [self.properties setValue:[[imageAssets valueForKey:@"main"] valueForKey:@"url"] forKey:@"kAdMainImageKey"];

    
    [self.properties setValue:[ad valueForKey:@"click_url"] forKey:@"kDefaultActionURLKey"];
    
    NSArray* trackers = [ad valueForKey:@"trackers"];
    NSMutableArray *impressionURLs = [NSMutableArray array];
    
    for (NSDictionary* tracker in trackers) {
        NSString* type = [tracker valueForKey:@"type"];
        if([type isEqualToString:@"impression"]){
            [impressionURLs addObject:[tracker valueForKey:@"url"]];
        }
    }
    
    [self.properties setValue:impressionURLs forKey:@"kImpressionTrackerURLsKey"];
    
    return self;
}

/**
 * Tells the object to open the specified URL using an appropriate mechanism.
 *
 * @param URL The URL to be opened.
 * @param controller The view controller that should be used to present the modal view controller.
 *
 * Your implementation of this method should either forward the request to the underlying
 * third-party ad object (if it has built-in support for handling ad interactions), or open an
 * in-application modal web browser or a modal App Store controller.
 */
- (void)displayContentForURL:(NSURL *)URL rootViewController:(UIViewController *)controller{
    [[UIApplication sharedApplication] openURL:URL];
}

/**
 * Determines whether MPNativeAd should track clicks
 *
 * If not implemented, this will be assumed to return NO, and MPNativeAd will track clicks.
 * If this returns YES, then MPNativeAd will defer to the MPNativeAdAdapterDelegate callbacks to
 * track clicks.
 */
/*- (BOOL)enableThirdPartyClickTracking{

}*/

/**
 * Tracks a click for this ad.
 *
 * To avoid reporting discrepancies, you should only implement this method if the third-party ad
 * network requires clicks to be reported manually.
 */
//- (void)trackClick;


/** @name Responding to an Ad Being Attached to a View */

/**
 * This method will be called when your ad's content is about to be loaded into a view.
 *
 * @param view A view that will contain the ad content.
 *
 * You should implement this method if the underlying third-party ad object needs to be informed
 * of this event.
 */
//- (void)willAttachToView:(UIView *)view;

/**
 * This method will be called if your implementation provides a DAA icon through the properties dictionary
 * and the user has tapped the icon.
 */
//- (void)displayContentForDAAIconTap;

@end