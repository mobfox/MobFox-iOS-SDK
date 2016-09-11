//
//  MobFoxCustomEventFacebook.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 11/1/16.
//  Copyright © 2015 Matomy Media Group Ltd. All rights reserved.
//

#ifndef MobFoxCustomEventFacebook_h
#define MobFoxCustomEventFacebook_h

#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>


@interface MobFoxCustomEventFacebook : MobFoxCustomEvent <FBAdViewDelegate>

@property (strong, nonatomic) UIViewController *parentViewController;

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info;

@end

#endif
