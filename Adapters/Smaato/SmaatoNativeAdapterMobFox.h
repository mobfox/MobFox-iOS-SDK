//
//  SmaatoNativeAdapterMobFox.h
//  Adapters
//
//  Created by Shimi Sheetrit on 11/16/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iSoma/iSoma.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>

@interface SmaatoNativeAdapterMobFox : SOMANativeCSMPlugin <MobFoxNativeAdDelegate>
@property (nonatomic, strong) MobFoxNativeAd* native;

@end
