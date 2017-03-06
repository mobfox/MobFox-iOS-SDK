//
//  MobFoxCustomEventMoPub.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/12/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxCustomEventMoPub.h"


@implementation MobFoxCustomEventMoPub

{
    CGSize requstedSize;
}

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info{
   
    requstedSize = size;
    self.adView = [[MPAdView alloc] initWithAdUnitId:nid size:CGSizeMake(size.width, size.height)];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake(0,0,size.width, size.height);
    
    [self.adView loadAd];
    
}

- (UIViewController*) getUIViewController:(UIView*)view  {
    
    id nextResponder = [view nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [self getUIViewController:(UIView*)nextResponder];
    } else {
        return nil;
    }
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView{
    return [self getUIViewController:self.adView];
}

- (void)adViewDidLoadAd:(MPAdView *)view{
   
    CGSize actualSize = [view adContentViewSize];
    if(requstedSize.width < actualSize.width || requstedSize.height < actualSize.height){
        NSDictionary* ui = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"returned ad size different from requested size", @"message" ,nil];
        NSError* err = [NSError errorWithDomain:@"MoPubFailed"
                                           code:40402
                                       userInfo:ui];
        [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:err];
        return;
    }
    [self.delegate MFCustomEventAd:self didLoad:self.adView];
  
}

#pragma mark - <MPAdViewDelegate>
- (void)adViewDidFailToLoadAd:(MPAdView *)view{
    NSError* err = [NSError errorWithDomain:@"MoPubFailed"
                                       code:40401
                                   userInfo:nil];
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:err];
}

#pragma mark - <MPAdViewDelegate>
- (void)willLeaveApplicationFromAd:(MPAdView *)view{
    
}


@end

