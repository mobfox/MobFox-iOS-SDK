//
//  GADMAdapterMobFox.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 6/22/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#ifdef  DemoAppDynamicTarget
#import <MobFoxSDKCoreDynamic/MobFoxSDKCoreDynamic.h>
#else
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#endif

#import <GoogleMobileAds/GoogleMobileAds.h>
//#import "GADMAdNetworkAdapterProtocol.h"



@interface GADMAdapterMobFox : NSObject <GADMAdNetworkAdapter, MobFoxAdTagDelegate, MobFoxTagInterstitialAdDelegate>



@end
