//
//  MobFoxNativeCustomEventFacebook.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 1/18/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <MobFoxSDKCore/MobFoxSDKCore.h>
@import FBAudienceNetwork;


@interface MobFoxNativeCustomEventFacebook : MobFoxNativeCustomEvent <FBNativeAdDelegate>

- (void)registerViewWithInteraction:(UIView *)view withViewController:(UIViewController *)viewController;
- (void)requestAdWithNetworkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@end
