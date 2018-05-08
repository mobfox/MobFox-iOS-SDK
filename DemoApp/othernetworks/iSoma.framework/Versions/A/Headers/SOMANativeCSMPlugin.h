//
//  SOMANativeCSMPlugin.h
//  iSoma
//
//  Created by Aman Shaikh on 06.05.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SOMAMediatedAd;
@class SOMANativeCSMPlugin;
@class SOMAMediatedNetworkConfiguration;
@class SOMANativeAdDTO;

@protocol SOMANativeCSMPluginDelegate <NSObject>
- (void)nativeCSMPluginDidLoad:(SOMANativeCSMPlugin*)plugin withDTO:(SOMANativeAdDTO*)dto;
- (void)nativeCSMPluginDidFail:(SOMANativeCSMPlugin*)plugin;
- (void)nativeCSMPluginLogImpresion:(SOMANativeCSMPlugin*)plugin;
- (void)nativeCSMPluginLogClick:(SOMANativeCSMPlugin*)plugin;


- (UILabel*)labelForTitle;
- (UILabel*)labelForDescription;
- (UIButton*)calltoActionButton;
- (UIView*)viewForMainImage;
- (UIImageView*)imageViewForIcon;
- (UIViewController*)rootViewController;
@end

@interface SOMANativeCSMPlugin : NSObject
@property(nonatomic, weak) id<SOMANativeCSMPluginDelegate> csmDelegate;
@property SOMAMediatedNetworkConfiguration* network;

- (instancetype)initWithConfiguration:(SOMAMediatedNetworkConfiguration*)network;
- (void)load;
- (void)registerViewForUserInteraction:(UIView*)view withRootViewController:(UIViewController*)rootViewController;
@end
