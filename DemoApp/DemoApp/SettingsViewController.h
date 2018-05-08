//
//  SettingsViewController.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/3/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#ifdef  DemoAppDynamicTarget
#import <MobFoxSDKCoreDynamic/MobFoxSDKCoreDynamic.h>
#else
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#endif

@interface SettingsViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate, MobFoxInterstitialAdDelegate>

@end
