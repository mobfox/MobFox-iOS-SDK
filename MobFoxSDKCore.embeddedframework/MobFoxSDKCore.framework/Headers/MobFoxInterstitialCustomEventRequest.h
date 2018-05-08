//
//  MobFoxInterstitialCustomEventRequest.h
//  MobFoxSDKCore
//
//  Created by Itamar Nabriski on 26/12/2017.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxInterstitialCustomEventRequest_h
#define MobFoxInterstitialCustomEventRequest_h

#import "MobFoxInterstitialCustomEvent.h"
#import "MobFoxJSContext.h"

typedef void (^ceRequestCB)(MobFoxInterstitialCustomEvent* ce, UIView* view, NSError *error);

@protocol MobFoxInterstitialCustomEventRequestDelegate <NSObject>

- (void)MFInterstitialCustomEventAdDidLoad:(MobFoxInterstitialCustomEvent *)event :(NSString *)pixel;

- (void)MFInterstitialCustomEventAdDidFailToReceiveAdWithError:(NSError *)error;

- (void)MFInterstitialCustomEventAdClosed;

- (void)MFInterstitialCustomEventMobFoxAdClicked;

- (void)MFInterstitialCustomEventMobFoxAdFinished;

@end

@interface MobFoxInterstitialCustomEventRequest : NSObject<MobFoxInterstitialCustomEventDelegate>

- (id) init;
-(void)requestCustomEvent:(NSString*)scriptURL withSize:(CGSize)size andWithEventList:(NSArray*)eventList andWithCustomEventInfo:(NSDictionary*)info andWithCB:(ceRequestCB)cb;
@property (nonatomic, weak) id<MobFoxInterstitialCustomEventRequestDelegate> delegate;

@end

#endif /* MobFoxInterstitialCustomEventRequest_h */
