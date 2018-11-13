//
//  CoreLocation.m
//  GPS
//
//  Created by Moshe on 10/10/17.
//  Copyright © 2017 Moshe. All rights reserved.
//

#import "CoreLocation.h"

#define NSLog //

@interface CoreLocation ()
@property (nonatomic,retain) CLLocationManager *locationManager;
@end

@implementation CoreLocation

@synthesize locationManager;
@synthesize authorizationStatus;
@synthesize zoomLocation,altitude,userSpeed,userHeading,hCLLocationAccuracy,vCLLocationAccuracy,locationText;


// we’ll use in converting metrics to feet and miles., i.e location.altitude*METERS_FEET
#define METERS_MILE 1609.344
#define METERS_FEET 3.28084


+ (id)sharedManager {
    static CoreLocation *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void) clearLocationData {
    zoomLocation.latitude = 0;
    zoomLocation.longitude = 0;
    altitude = 0;
    userSpeed = 0;
    userHeading = 0;
    hCLLocationAccuracy = 0;
    vCLLocationAccuracy = 0;
    locationText = @"---";
}

- (id)init {
    if (self = [super init]) {
    //    someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        authorizationStatus=CLLocationManager.authorizationStatus;
        
        [self clearLocationData];
        [self configureLocationServices];
        
    }
    return self;
}

-(void) configureLocationServices {
    
    authorizationStatus=CLLocationManager.authorizationStatus;

    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        //[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //locationManager.distanceFilter=kCLDistanceFilterNone;
        //[locationManager requestWhenInUseAuthorization];
        [self clearLocationData];
    } else if (authorizationStatus == kCLAuthorizationStatusDenied) {
        [self clearLocationData];
    } else {
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager requestWhenInUseAuthorization];
        [locationManager startMonitoringSignificantLocationChanges];
        locationManager.distanceFilter=2;//kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

    authorizationStatus=CLLocationManager.authorizationStatus;

    if (status == kCLAuthorizationStatusDenied) {
        // The user denied authorization
        //[locationManager requestWhenInUseAuthorization];
        [self clearLocationData];

    } else if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        //[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //locationManager.distanceFilter=kCLDistanceFilterNone;
        [locationManager requestWhenInUseAuthorization];
        [self clearLocationData];
    } else {
        // The user accepted authorization
        //[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //[locationManager requestWhenInUseAuthorization];
        //[locationManager startMonitoringSignificantLocationChanges];
        //[locationManager startUpdatingLocation];

        [self configureLocationServices];
        
        // Start heading updates.
        if ([CLLocationManager headingAvailable]) {
            locationManager.headingFilter = 5;
            [locationManager startUpdatingHeading];
        }

    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"LocationUpdateNotification"
     object:self];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    zoomLocation.latitude = location.coordinate.latitude;
    zoomLocation.longitude= location.coordinate.longitude;
    altitude=location.altitude;
    userSpeed=location.speed;
    hCLLocationAccuracy=location.horizontalAccuracy;
    vCLLocationAccuracy=location.verticalAccuracy;
    
    //NSLog(@"Lat: %f, Lon: %f",location.coordinate.latitude,location.coordinate.longitude);
    
    [self getAddressFromLocation:location];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"LocationUpdateNotification"
     object:self];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    userHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);

}
int first=0;

-(void) getAddressFromLocation:(CLLocation *)location {
    
    //if (first) return;
    //first =1;
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder cancelGeocode];
    [geocoder reverseGeocodeLocation:locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             
             NSString *s1 = [placemark subThoroughfare];
             NSString *s2 = [placemark thoroughfare];
             NSString *s3 = [placemark locality];
             NSString *s4 = [placemark administrativeArea];

             locationText = @"";
             
             if (!s1) s1=@"";
             if (!s2) s2=@"";
             if (!s3) s3=@"";
             if (!s4) s4=@"";

             locationText = [NSString stringWithFormat:@"%@ %@,%@ %@", s1,s2,s3,s4];
             
            // NSLog(@"%@",address);
             
             [[NSNotificationCenter defaultCenter]
              postNotificationName:@"LocationUpdateNotification"
              object:self];

         }
         
     }];
}

@end
