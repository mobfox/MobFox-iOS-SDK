//
//  SOMAUserProfile.h
//  iSoma
//
//  Created by Aman Shaikh on 17/06/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMATypes.h"

@interface SOMAUserProfile : NSObject<NSCopying>
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) SOMAUserGender gender;
@property(nonatomic, assign) NSString* dateOfBirthYYYYMMDD;
@property(nonatomic, assign) SOMAUserYearlyIncome yearlyIncome;
@property(nonatomic, assign) SOMAUserEthnicity ethnicity;
@property(nonatomic, assign) SOMAUserEducation education;
@property(nonatomic, assign) SOMAUserGenderInterest interestedIn;
@property(nonatomic, assign) SOMAUserMaritalStatus maritalStatus;
@property(nonatomic, strong) NSString* country;
@property(nonatomic, strong) NSString* countryCode;
@property(nonatomic, strong) NSString* region;
@property(nonatomic, strong) NSString* city;
@property(nonatomic, strong) NSString* zip;
@end
