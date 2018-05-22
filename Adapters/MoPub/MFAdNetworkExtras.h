//
//  MFAdNetworkExtras.h
//  
//
//  Created by Moshe Ne on 21/5/18.
//
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADAdNetworkExtras.h>

@interface MFAdNetworkExtras : NSObject <GADAdNetworkExtras>

@property (nonatomic, assign) BOOL      gdpr;
@property (nonatomic, assign) NSString* gdpr_consent;

@end
