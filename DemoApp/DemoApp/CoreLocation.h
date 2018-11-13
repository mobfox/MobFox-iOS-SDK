//
//  CoreLocation.h
//  GPS
//
//  Created by Moshe on 10/10/17.
//  Copyright © 2017 Moshe. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CoreLocation : NSObject <CLLocationManagerDelegate>
+ (id)sharedManager;


@property (nonatomic) CLAuthorizationStatus  authorizationStatus;
@property (nonatomic,readonly) CLLocationCoordinate2D zoomLocation;
@property (nonatomic,readonly) CLLocationDistance altitude;
@property (nonatomic,readonly) CLLocationSpeed userSpeed;
@property (nonatomic,readonly) CLLocationDirection userHeading;
@property (nonatomic,readonly) CLLocationAccuracy hCLLocationAccuracy;
@property (nonatomic,readonly) CLLocationAccuracy vCLLocationAccuracy;
@property (nonatomic,readonly) NSString *locationText;



@end

