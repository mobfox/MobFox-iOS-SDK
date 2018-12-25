//
//  MobFoxMoPubCustomAdapter.h
//  DemoApp
//
//  Created by ofirkariv on 11/12/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoPub.h"
#import <MobFoxSDKCore/MobFoxSDKCore.h>


@interface MobFoxMoPubCustomAdapter : NSObject
@property (nonatomic, strong) NSMutableDictionary *localProperties;



- (instancetype)initWithAd:(MobFoxNativeData *)ad;


@end
