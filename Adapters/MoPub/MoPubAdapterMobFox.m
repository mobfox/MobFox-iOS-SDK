#import "MoPubAdapterMobFox.h"


@implementation MoPubAdapterMobFox

- (id)init {
    
    NSLog(@"MoPub >> MobFox >> init");

    self = [super init];
    if (self)
    {
        //self.ad = [[MobFoxAd alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        //self.ad.delegate = self;
    }
    return self;
}

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    
     NSLog(@"MoPub >> MobFox >> data: %@",[info description]);
    
    self.ad = [[MobFoxAd alloc] init:[info valueForKey:@"invh"] withFrame:CGRectMake(0, 0, size.width, size.height)];
    self.ad.delegate = self;
    //[self.ad _setSize:size withContainer:size];
    self.ad.invh = @"fe96717d9875b9da4339ea5367eff1ec"; //[info valueForKey:@"invh"];
    NSLog(@"MoPub >> MobFox >> invh: %@",@"fe96717d9875b9da4339ea5367eff1ec" );
    [self.ad loadAd];
    
}

-(BOOL)enableAutomaticImpressionAndClickTracking {
    
    return NO;
}

#pragma mark -
#pragma mark MobFoxAdDelegate methods


- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    NSLog(@"MoPub >> MobFox >> Loaded");
    [self.delegate trackImpression];
    [self.delegate bannerCustomEvent:self didLoadAd:banner];

}

- (void)MobFoxAdClicked{
    NSLog(@"MoPub >> MobFox >> MobFoxAdClicked");
    [self.delegate trackClick];
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
     NSLog(@"MoPub >> MobFox >> error : %@",[error description]);
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)MobFoxAdClosed{
    NSLog(@"MoPub >> MobFox >> MobFoxAdClosed");
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)MobFoxAdFinished{
    NSLog(@"MoPub >> MobFox >> MobFoxAdFinished");
    [self.delegate bannerCustomEventDidFinishAction:self];
}

- (void)dealloc {
    
    self.ad.bridge = nil;
    self.ad        = nil;
}


@end
