//
//  MobFoxCustomEventMoPub.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/12/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxCustomEventMoPub.h"

@interface MobFoxCustomEventMoPub()
    @property (nonatomic)  CGSize requstedSize;
    @property (nonatomic,weak)  UIViewController* vc;
@end

@implementation MobFoxCustomEventMoPub


- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info{
   
    self.requstedSize   = size;
    self.vc             = [info objectForKey:@"viewcontroller"];
    self.adView         = [[MPAdView alloc] initWithAdUnitId:nid size:CGSizeMake(size.width, size.height)];
    //self.adView.testing = YES;
    NSMutableArray* keywordsArr = [NSMutableArray arrayWithCapacity:5];
    if(info[@"demo_gender"]){
        [keywordsArr addObject:[NSString stringWithFormat:@"m_gender:%@",[info[@"demo_gender"] lowercaseString]]];
    }
    if(info[@"demo_age"]){
        [keywordsArr addObject:[NSString stringWithFormat:@"m_age:%@",info[@"demo_age"]]];
    }
    
    if(keywordsArr.count > 0){
        self.adView.keywords = [keywordsArr componentsJoinedByString:@","];
    }
    
    self.adView.delegate = self;
    self.adView.frame = CGRectMake(0,0,size.width, size.height);
    UIView* parent = info[@"parent"];
    [parent addSubview:self.adView];
    
    [self.adView loadAd];
    
}

- (UIViewController *)viewControllerForPresentingModalView {
    //UIViewController* rootVC = [info objectForKey:@"viewcontroller"];
    return self.vc;
}

#pragma mark - <MPAdViewDelegate>

- (void)adViewDidLoadAd:(MPAdView *)view{
   
    CGSize actualSize = [view adContentViewSize];
    if(self.requstedSize.width < actualSize.width || self.requstedSize.height < actualSize.height){
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

- (void)adViewDidFailToLoadAd:(MPAdView *)view{
    NSError* err = [NSError errorWithDomain:@"MoPubFailed"
                                       code:40401
                                   userInfo:nil];
    [self.delegate MFCustomEventAdDidFailToReceiveAdWithError:err];
}

- (void)willLeaveApplicationFromAd:(MPAdView *)view{
    [self.delegate MFCustomEventMobFoxAdClicked];
}

- (void)willPresentModalViewForAd:(MPAdView *)view{
    [self.delegate MFCustomEventMobFoxAdClicked];
}


@end

