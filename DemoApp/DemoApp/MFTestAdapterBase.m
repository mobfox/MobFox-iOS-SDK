//
//  MFTestAdapterBase.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 12/20/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "MFTestAdapterBase.h"

@implementation MFTestAdapterBase


- (void)requestTagAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info {
    
}

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info {
    
}

- (void)requestInterstitialAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info {
    
}

- (void)requestNativeAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info {
    
}

- (void) dealloc{
    self.delegate = nil;
}

@end
