#import "MPMobFoxNativeAdAdapter.h"

@implementation MPMobFoxNativeAdAdapter

- (instancetype)initWithMobFoxNativeAd:(MobFoxNativeData *)ad{
    self = [super init];
    
    NSLog(@"MoPub >> Adapter >> MobFox >> init");
    
    NSMutableDictionary *properties = @{}.mutableCopy;
    
    NSLog(@"ad.callToActionText %@", ad.callToActionText);
    
    if (ad.assetHeadline) [properties setObject:ad.assetHeadline forKey:@"title"];
    if (ad.assetDescription) [properties setObject:ad.assetDescription forKey:@"text"];
    if (ad.callToActionText) [properties setObject:ad.callToActionText forKey:@"ctatext"];
    if (ad.rating) [properties setObject:ad.rating forKey:@"starrating"];
    if (ad.icon.url.absoluteString) [properties setObject:ad.icon.url.absoluteString forKey:@"iconimage"];
    if (ad.main.url.absoluteString) [properties setObject:ad.main.url.absoluteString forKey:@"mainimage"];
    if (ad.clickURL.absoluteString) [properties setObject:ad.clickURL.absoluteString forKey:@"clk"];
    
    NSMutableArray *impressionURLs = [NSMutableArray array];
    
    for (MobFoxNativeTracker* tracker in ad.trackersArray) {
        if (tracker.url.absoluteString.length > 0)
            [impressionURLs addObject:tracker.url];
    }
    
    NSLog(@"impressionURLs %@", impressionURLs);
    
    if (impressionURLs.count) {
        [properties setValue:impressionURLs forKey:@"imptracker"];
    }
    
    _properties = properties;
    
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