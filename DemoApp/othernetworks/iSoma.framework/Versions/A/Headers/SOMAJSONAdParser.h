//
//  SOMAJSONAdParser.h
//  iSoma
//
//  Created by Aman Shaikh on 16.06.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMAAdParser.h"

@class SOMAAdBuilder;
@interface SOMAJSONAdParser : NSObject<SOMAAdParser>
@property(nonatomic, strong) SOMAAdBuilder* adBuilder;
@property(nonatomic, strong) NSMutableDictionary* keyvalues;
@end
