//
//  GADMNativeAdapterMobFox.h
//  Adapters
//
//  Created by Shimi Sheetrit on 12/7/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
//#import "GADMAdNetworkAdapterProtocol.h"

@interface GADMNativeAdapterMobFox : NSObject <GADMAdNetworkAdapter, MobFoxNativeAdDelegate, GADCustomEventNativeAd>

@property (nonatomic, strong) MobFoxNativeAd* native;
@property (nonatomic, weak) id <GADMAdNetworkConnector> connector;

@end
