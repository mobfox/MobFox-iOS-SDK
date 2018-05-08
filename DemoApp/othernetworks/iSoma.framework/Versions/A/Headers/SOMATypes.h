//
//  iSomaTypes.h
//  iSoma
//
//  Created by Aman Shaikh on 30/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#ifndef iSoma_iSomaTypes_h
#define iSoma_iSomaTypes_h


typedef NS_ENUM(NSInteger, SOMAValue){
	SOMAValueNotSet=0
};


#pragma mark -
#pragma mark - Ad Types
#pragma mark -

typedef NS_ENUM(NSInteger, SOMAAdType){
	SOMAAdTypeAll = 0,
	SOMAAdTypeText,
	SOMAAdTypeImage,
	SOMAAdTypeVideo,
	SOMAAdTypeRichMedia,
	SOMAAdTypeIFrame,
	SOMAAdTypeNative,
};


#pragma mark -
#pragma mark - Ad Dimensions
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAAdDimension) {
	SOMAAdDimensionDefault = 0,
	SOMAAdDimensionXXLARGE, /*320x50*/
	SOMAAdDimensionXLARGE, /*300x50*/
	SOMAAdDimensionMMA,
	SOMAAdDimensionMedRect,/*300x250*/
	SOMAAdDimensionLeader,
	SOMAAdDimensionSky, /*120x600*/
	SOMAAdDimensionWideSky, /*160x600*/
	SOMAAdDimensionInterstitialLandscapePhone,
	SOMAAdDimensionInterstitialPortraitPhone,
	SOMAAdDimensionInterstitialLandscapePad,
	SOMAAdDimensionInterstitialPortraitPad,
};

#pragma mark -
#pragma mark - Ad Sizes
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAAdSize){
	SOMAAdSizeDefault = 0,
};

#pragma mark -
#pragma mark - User Gender
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAUserGender){
	SOMAUserGenderUnknown=0,
	SOMAUserGenderMale,
	SOMAUserGenderFemale
};

#pragma mark -
#pragma mark - User Gender Interest
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAUserGenderInterest){
	SOMAUserGenderInterestUnknown = 0,
	SOMAUserGenderInterestBoth,
	SOMAUserGenderInterestMale,
	SOMAUserGenderInterestFemale
};

#pragma mark -
#pragma mark - User Income
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAUserYearlyIncome){
	SOMAUserYearlyIncomeUnknown=0,
	SOMAUserYearlyIncomeLessThan15K,
	SOMAUserYearlyIncome15to24K,
	SOMAUserYearlyIncome25to39K,
	SOMAUserYearlyIncome40to59K,
	SOMAUserYearlyIncome60to74K,
	SOMAUserYearlyIncome75to99K,
	SOMAUserYearlyIncome100kPlus
};

#pragma mark -
#pragma mark - User Ethnicity
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAUserEthnicity){
	SOMAUserEthnicityUnknown=0,
	SOMAUserEthnicityWhite,
	SOMAUserEthnicityMiddleEastern,
	SOMAUserEthnicityBlack,
	SOMAUserEthnicityLatino,
	SOMAUserEthnicitySouthAsian,
	SOMAUserEthnicityOriental,
	SOMAUserEthnicityOther
};

#pragma mark -
#pragma mark - User Education
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAUserEducation){
	SOMAUserEducationUnknown=0,
	SOMAUserEducationLessThanSecondary,
	SOMAUserEducationSecondary,
	SOMAUserEducationUniversity,
	SOMAUserEducationAdvanced
};

#pragma mark -
#pragma mark - User Marital status
#pragma mark -
typedef NS_ENUM(NSInteger, SOMAUserMaritalStatus){
	SOMAUserMaritalStatusUnknown=0,
	SOMAUserMaritalStatusSingle,
	SOMAUserMaritalStatusMarried,
	SOMAUserMaritalStatusDivorced
};


#pragma mark -
#pragma mark - Log Levels
#pragma mark -
typedef NS_ENUM(NSInteger, SOMALogLevel){
	/* All log muted */
	SOMALogLevelNone = 0,
	
	/* if something IS wrong,
	 before creating an NSError
	 or received error from server */
	SOMALogLevelError = 1,
	
	/* If something can be wrong */
	SOMALogLevelWarning =2,
	
	
	/* Dumps all server request and response data */
	SOMALogLevelDump =3,
	
	/* Normal verbose logs */
	SOMALogLevelInfo =4,

	/* all! */
	SOMALogLevelAll =100
				
};


#pragma mark -
#pragma mark - Log Options
#pragma mark -
typedef NS_OPTIONS(NSInteger, SOMALogOption){
	SOMALogOptionNone =0,
	SOMALogOptionAll = 0b111111,
	SOMALogOptionLineNumber = 1 << 1,
	SOMALogOptionPrettyFunction = 1 << 2,
};


#pragma mark -
#pragma mark - Device types
#pragma mark -

typedef NS_ENUM(NSInteger, SOMADeviceType){
	SOMADeviceTypeiPhone = 0,
	SOMADeviceTypeiPod,
	SOMADeviceTypeiPad,
	SOMADeviceTypeUnknown = NSIntegerMax
};


typedef struct{
	NSTimeInterval start;
	NSTimeInterval end;
	NSInteger max;
}SOMAAdValidity;

typedef NS_ENUM(NSInteger, SOMAAdActionType){
	SOMAAdActionTypeLink = 0,
};

typedef NS_ENUM(NSInteger, SOMAAdActionAccounting){
	SOMAAdActionAccountingServer = 0,
};


typedef struct{
	SOMAAdActionType type;
	char* target;
	SOMAAdActionAccounting accounting;
}SOMAAdAction;



#ifndef NI_FIX_CATEGORY_BUG
//#define NI_FIX_CATEGORY_BUG(name) @interface NI_FIX_CATEGORY_BUG_##name : NSObject @end \
//@implementation NI_FIX_CATEGORY_BUG_##name @end

#define NI_FIX_CATEGORY_BUG
// Example:
// NI_FIX_CATEGORY_BUG(NSMutableAttributedStringNimbusAttributedLabel)
// @implementation NSMutableAttributedString (NimbusAttributedLabel)

#endif

#endif
