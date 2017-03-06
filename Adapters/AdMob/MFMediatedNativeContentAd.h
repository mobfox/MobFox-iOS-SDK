//
//  MFMediatedNativeContentAd.h
//  Adapters
//
//  Created by Shimi Sheetrit on 1/1/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//


#import <GoogleMobileAds/GoogleMobileAds.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>

@interface MFMediatedNativeContentAd : NSObject <GADMediatedNativeContentAd>


    
- (instancetype)initWithMFNativeContentAd:(MobFoxNativeData*)mobFoxNativeData;
- (void)changeStataus;

@end
