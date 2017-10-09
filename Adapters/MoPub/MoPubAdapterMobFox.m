#import "MoPubAdapterMobFox.h"


@interface MoPubAdapterMobFox()

@property (strong, nonatomic) MobFoxTagAd* ad;

@end

@implementation MoPubAdapterMobFox



- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info{
    
  //  NSLog(@"MoPub >> MobFox >> invh: %@",[info valueForKey:@"invh"]);
    NSLog(@"MoPub >> MobFox >> custom event data: %@",[info description]);
    
    
    self.ad = [[MobFoxTagAd alloc] init:[info valueForKey:@"invh"] withFrame:CGRectMake(0, 0, size.width, size.height)];
    self.ad.delegate = self;
    [self.ad loadAd];

}
/*
- (BOOL)enableAutomaticImpressionAndClickTracking
{
    // Subclasses may override this method to return NO to perform impression and click tracking
    // manually.
    return NO;
}*/

#pragma mark MobFox Ad Delegate

- (void)MobFoxTagAdDidLoad:(MobFoxTagAd *)banner{
    
    NSLog(@"MoPub >> MobFox >> ad loaded");

   // [self.delegate trackImpression];
    [self.delegate bannerCustomEvent:self didLoadAd:banner];
    
}

- (void)MobFoxTagAdDidFailToReceiveAdWithError:(NSError *)error{
    
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)MobFoxTagAdClosed{
    
}

- (void)MobFoxTagAdClicked {
    
   // [self.delegate trackClick];
    [self.delegate bannerCustomEventWillLeaveApplication:self];
    
}

- (void)MobFoxTagAdFinished {
    
   [self.delegate bannerCustomEventDidFinishAction:self];
    
}

- (void)dealloc {
    self.ad.delegate    = nil;
    self.ad             = nil;
}


@end
