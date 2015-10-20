//
//  MobFoxInterstitialVideo.h
//  MobFoxSDKSource
//
//  Created by Itamar Nabriski on 8/12/15.
//
//

#ifndef MobFoxSDKSource_MobFoxInterstitialVideo_h
#define MobFoxSDKSource_MobFoxInterstitialVideo_h

#include "MobFoxAd.h"
#import "MobFoxInterstitialCustomEvent.h"

@class MobFoxInterstitialAd;

@protocol MobFoxInterstitialAdDelegate <NSObject>

@optional

- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial;

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MobFoxInterstitialAdClosed;

- (void)MobFoxInterstitialAdClicked;

- (void)MobFoxInterstitialAdFinished;

@end


@interface MobFoxInterstitialAd : NSObject<MobFoxAdDelegate,MobFoxInterstitialCustomEventDelegate>


@property (nonatomic, weak) id<MobFoxInterstitialAdDelegate> delegate;
@property MobFoxAd* ad;


-(id) init:(NSString*)invh withMainViewController:(UIViewController*)main;
-(void) loadAd;

//- (void)MFInterstitialCustomEventAd:(MobFoxInterstitialCustomEvent *)event didLoad:(id) ad;

//- (void)MFInterstitialCustomEventAdDidFailToReceiveAdWithError:(NSError *)error;


@end

#endif
