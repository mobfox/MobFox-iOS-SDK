//
//  SOMANativeAdLayouter.h
//  iSoma
//
//  Created by Aman Shaikh on 09.12.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOMANativeAdTemplateView;
@protocol SOMANativeAdLayouter <NSObject>
- (void)layout:(SOMANativeAdTemplateView*)view;
@end
