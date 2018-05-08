//
//  SOMAAd.h
//  iSoma
//
//  Created by Aman Shaikh on 31/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMATypes.h"
#import <UIKit/UIKit.h>


@class  SOMAAdRenderer;
@class SOMAAdBuilder;

// This will be received from the server


@interface SOMAAd : NSObject<NSCopying>

@property(nonatomic, copy) NSString* userid;
@property(nonatomic, copy) NSString* passbackUrl;
@property(nonatomic, copy) NSString* ownid;
@property(nonatomic, copy) NSString* adid;
@property(nonatomic, copy) NSString* logid;
@property(nonatomic, copy) NSString* mediaCode;
@property(nonatomic, copy) NSString* text;
@property(nonatomic, copy) NSString* mediaData;
@property(nonatomic, copy) NSArray* descriptionLines;
@property(nonatomic, strong) NSArray* beacons;
@property(nonatomic, strong) NSURL* link;
@property(nonatomic, assign) SOMAAdType type;
@property(nonatomic, assign) SOMAAdValidity validity;
@property(nonatomic, assign) NSInteger width;
@property(nonatomic, assign) NSInteger height;
@property(nonatomic, assign) SOMAAdAction action;
@property(nonatomic, strong) NSURL* target;
@property(nonatomic, strong) NSString* session;
@property(nonatomic, strong) NSURL* mediaFile;
@property(nonatomic, strong) NSURL* imageURL;


@property NSURL* wrapperAdTagURL;
- (void) mergeAd:(SOMAAd*)ad;
- (SOMAAdRenderer*)adRenderer;
-(instancetype)initWithBuilder:(SOMAAdBuilder*)builder;
+(SOMAAdBuilder*) builder;
//- (SOMARenderedAdView*)createRenderingView;


@end
