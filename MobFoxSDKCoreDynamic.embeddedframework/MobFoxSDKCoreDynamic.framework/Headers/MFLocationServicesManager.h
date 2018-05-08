//
//  LocationManager.h
//  MobFoxSDKCore
//
//  Created by Shimi Sheetrit on 5/2/16.
//  Copyright © 2016 Itamar Nabriski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface MFLocationServicesManager : NSObject <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) double accuracy;
@property (nonatomic) double altitude;
@property (nonatomic) double userSpeed;
@property (nonatomic) double userHeading;
@property (nonatomic) double hCLLocationAccuracy;
@property (nonatomic) double vCLLocationAccuracy;

@property (nonatomic, strong) CLLocationManager *locationManager;

+ (instancetype)sharedInstance;
- (void)findLocation;
- (void)stopFindingLocation;
-(BOOL) isSupportLocation;

@end
