#import "MoPubAdapterMobFox.h"

@implementation MoPubAdapterMobFox


- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info{
     NSLog(@"MoPub >> MobFox >> init");
     NSLog(@"MoPub >> MobFox >> data: %@",[info description]);
    self.ad = [[MobFoxAd alloc] init:[info valueForKey:@"invh"] withFrame:CGRectMake(0, 0, size.width, size.height)];
    self.ad.delegate = self;
    [self.ad loadAd];
}

- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    NSLog(@"MoPub >> MobFox >> Loaded");
    [self.delegate bannerCustomEvent:self didLoadAd:banner];
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
     NSLog(@"MoPub >> MobFox >> error : %@",[error description]);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)MobFoxAdClosed{
    
}

- (void)MobFoxAdClicked{
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

- (void)MobFoxAdFinished{
    [self.delegate bannerCustomEventDidFinishAction:self];
}


@end