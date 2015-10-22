//
//  MobFoxNativeCustomEventMoPub.h
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/14/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#ifndef MobFoxNativeCustomEventMoPub_h
#define MobFoxNativeCustomEventMoPub_h
#import <MobFoxSDKCore/MobFoxSDKCore.h>


@interface MobFoxNativeCustomEventMoPub : MobFoxNativeCustomEvent

- (void)requestAdWithNetworkID:(NSString*)nid customEventInfo:(NSDictionary *)info;


@end

#endif /* MobFoxNativeCustomEventMoPub_h */
