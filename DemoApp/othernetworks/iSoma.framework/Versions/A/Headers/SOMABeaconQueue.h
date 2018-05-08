//
//  SOMABeaconQueue.h
//  iSoma
//
//  Created by Aman Shaikh on 02/07/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BeaconCallback)(NSArray *beacons);

@class SOMAAd;

void SOMA_loadBeaconWithURLString(NSString* urlString);
void SOMA_loadBeaconWithURL(NSURL* url);

@interface SOMABeaconQueue : NSObject
@property (nonatomic, copy) BeaconCallback beaconCallback;

/// Calls all beacons from the ad and clears beacons array to avoid multiple call
- (int)queueAdForBeaconLoading:(SOMAAd*)ad;
+(instancetype)defaultQueue;
@end
