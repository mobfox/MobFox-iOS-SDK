//
//  MobFoxUnityPlugin.h
//  MobFoxUnityPlugin
//
//  Created by Itamar Nabriski on 11/17/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>

@interface MobFoxUnityPlugin : NSObject<MobFoxAdDelegate,MobFoxInterstitialAdDelegate>

-(void) setUseLocation:(bool)useLocation;

-(int) createBanner:(NSString*)invh 
			originX:(CGFloat)originX 
			originY:(CGFloat)originY
          sizeWidth:(CGFloat)sizeWidth
         sizeHeight:(CGFloat)sizeHeight;

-(void) createInterstitial:(NSString*)invh;
-(void) showInterstitial;

@end
