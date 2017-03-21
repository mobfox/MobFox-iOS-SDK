#import "MoPubAdapterMobFox.h"


@interface MoPubAdapterMobFox()

@property (nonatomic, strong) MFEventsHandler *eventsHandler;

@end

@implementation MoPubAdapterMobFox


- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info{
    
    NSLog(@"MoPub >> MobFox >> invh: %@",[info valueForKey:@"invh"]);

    
    _eventsHandler = [[MFEventsHandler alloc] init];
    [_eventsHandler resetAdEventBlocker];
    
    
    [MFReport log:@"mopub" withInventoryHash:[info valueForKey:@"invh"] andWithMessage:@"request"];
    
     NSLog(@"MoPub >> MobFox >> init");
     NSLog(@"MoPub >> MobFox >> data: %@",[info description]);
    
    self.ad = [[MobFoxAd alloc] init:[info valueForKey:@"invh"] withFrame:CGRectMake(0, 0, size.width, size.height)];
    self.ad.delegate = self;
    [self.ad loadAd];
    

}

- (BOOL)enableAutomaticImpressionAndClickTracking
{
    // Subclasses may override this method to return NO to perform impression and click tracking
    // manually.
    return NO;
}

#pragma mark MobFox Ad Delegate

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    
    NSLog(@"MoPub >> MobFox >> ad loaded");

    
     __weak id weakself = self;
    
    [_eventsHandler invokeAdEventBlocker:^(BOOL isReported) {
       
        if (isReported) return;
        
        MoPubAdapterMobFox *strongself = weakself;
        if(strongself) {
            [strongself.delegate trackImpression];
            [strongself.delegate bannerCustomEvent:strongself didLoadAd:banner];
        }
        
        [MFReport log:@"mopub" withInventoryHash:banner.invh andWithMessage:@"impression"];
        
    }];
    
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
    
    __weak id weakself = self;
    
    [_eventsHandler invokeAdEventBlocker:^(BOOL isReported) {
        
        if (isReported) return;
        
        MoPubAdapterMobFox *strongself = weakself;
        if (strongself) {
            [strongself.delegate bannerCustomEvent:strongself didFailToLoadAdWithError:error];
        }
       
    }];
}

- (void)MobFoxAdClosed{
    
}

- (void)MobFoxAdClicked {
    
    [self.delegate trackClick];
    [self.delegate bannerCustomEventWillLeaveApplication:self];
    
}

- (void)MobFoxAdFinished {
    
   [self.delegate bannerCustomEventDidFinishAction:self];
    
}

- (void)dealloc {
    self.eventsHandler  = nil;
    self.ad.delegate    = nil;
    self.ad             = nil;
}


@end
