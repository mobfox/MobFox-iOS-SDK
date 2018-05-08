//
//  SOMANativeAdLayout.h
//  iSoma
//
//  Created by Aman Shaikh on 09.12.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOMANativeAdLayouter.h"

@class SOMAStarView;
@class SOMANativeAdDTO;

@interface SOMANativeAdTemplateView : UIView
@property UIImageView* mainImage;
@property UIImageView* icon;
@property UILabel* title;
@property UILabel* details;
@property UIButton* callToAction;
@property SOMAStarView* ratingView;
@property UILabel* sponsored;
@property UICollectionView* carousel;


@property UIView* catContainer;
@property SOMANativeAdDTO* dto;
@property id<SOMANativeAdLayouter> layouter;
- (instancetype)initWithLayouter:(id<SOMANativeAdLayouter>)layouter;

@end
