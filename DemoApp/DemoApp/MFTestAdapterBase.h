//
//  MFTestAdapterBase.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 12/20/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>


#ifndef MFTestAdapterBase_h
#define MFTestAdapterBase_h


@class MFTestAdapterBase;

@protocol MFTestAdapterBaseDelegate <NSObject>


// tag banner
- (void)MFTestAdapterBaseTagAdDidLoad:(UIView *)ad;
- (void)MFTestAdapterBaseTagAdDidFailToReceiveAdWithError:(NSError *)error;

// banner
- (void)MFTestAdapterBaseAdDidLoad:(UIView *)ad;
- (void)MFTestAdapterBaseAdDidFailToReceiveAdWithError:(NSError *)error;

// Interstital
- (void)MFTestAdapterInterstitialAdapterBaseAdDidLoad:(UIView *)ad;
- (void)MFTestAdapterInterstitialAdapterBaseAdDidFailToReceiveAdWithError:(NSError *)error;

// native
- (void)MFTestAdapterNativeAdapterBaseAdDidLoad:(MobFoxNativeData *)adData;
- (void)MFTestAdapterNativeAdapterBaseAdDidFailToReceiveAdWithError:(NSError *)error;

@optional

- (void)MFTestAdapterBaseAdClosed;

- (void)MFTestAdapterBaseAdClicked;

- (void)MFTestAdapterBaseAdFinished;

@end


@interface MFTestAdapterBase : NSObject

- (void)requestTagAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;
- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;
- (void)requestInterstitialAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;
- (void)requestNativeAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;


@property (nonatomic, weak) id<MFTestAdapterBaseDelegate> delegate;

@end

#endif /* MFTestAdapterBase_h */
