#import "MoPubAdapterMobFox.h"
#import "MoPub.h"
#import "MPConsentManager.h"

@interface MoPubAdapterMobFox()

@property (strong, nonatomic) MobFoxAd* ad;
@property (nonatomic) CGRect bannerAdRect;

@end

@implementation MoPubAdapterMobFox



- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info{
    
  //  NSLog(@"MoPub >> MobFox >> invh: %@",[info valueForKey:@"invh"]);
    NSLog(@"MoPub >> MobFox >> custom event data: %@",[info description]);
    
    MPBool gdpr= [[MoPub sharedInstance] isGDPRApplicable];
    NSString *consentStatusStr;
    
    MPConsentStatus consentStatus= [[MoPub sharedInstance] currentConsentStatus];
    
    if (consentStatus == MPConsentStatusConsented) {
        consentStatusStr = @"1";
    }
    else {
        consentStatusStr = @"0";
    }
    
    self.bannerAdRect = CGRectMake(0,0, size.width, size.height);
    self.ad = [[MobFoxAd alloc] init:[info valueForKey:@"invh"] withFrame:self.bannerAdRect];
    
    self.ad.gdpr = gdpr;
    self.ad.gdpr_consent = consentStatusStr;
    
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

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    
    NSLog(@"MoPub >> MobFox >> ad loaded");

   // [self.delegate trackImpression];
    [self.delegate bannerCustomEvent:self didLoadAd:banner];
    
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
    
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)MobFoxAdClosed{
    
}

- (void)MobFoxAdClicked {
    
   // [self.delegate trackClick];
    [self.delegate bannerCustomEventWillLeaveApplication:self];
    
}

- (void)MobFoxAdFinished {
    
   [self.delegate bannerCustomEventDidFinishAction:self];
    
}

- (void)dealloc {
    self.ad.delegate    = nil;
    self.ad             = nil;
}


@end
