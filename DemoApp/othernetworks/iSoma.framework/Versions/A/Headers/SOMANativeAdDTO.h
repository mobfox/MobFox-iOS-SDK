//
//  SOMANativeAdDTO.h
//  iSoma
//
//  Created by Aman Shaikh on 17/12/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SOMAAd.h"

@interface SOMANativeAdDTO : SOMAAd
@property UIView* mediaView;
@property UIView* iconView;
@property float starrating;
@property NSString* title;
@property NSString* callToAction;
@property NSURL* iconImageURL;
@property NSURL* mainImageURL;
@property NSArray* images;

@end
