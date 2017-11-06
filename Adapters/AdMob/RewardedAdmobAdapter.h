//
//  RewardedAdmobAdapter.h
//  
//
//  Created by Shahaf Shmuel on 7/17/17.
//
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>

@import Foundation;
@import GoogleMobileAds;



@interface RewardedAdmobAdapter : NSObject<GADMRewardBasedVideoAdNetworkAdapter,MobFoxInterstitialAdDelegate, MobFoxTagInterstitialAdDelegate>



@end
