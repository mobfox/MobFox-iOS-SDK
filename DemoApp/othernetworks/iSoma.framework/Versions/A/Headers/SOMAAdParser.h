//
//  SOMAAdRequestParser.h
//  iSoma
//
//  Created by Aman Shaikh on 23/06/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOMAAd;

@protocol SOMAAdParser <NSObject>
-(SOMAAd*)parseAd:(NSData*)data parsingError:(NSError**)error;
@end
