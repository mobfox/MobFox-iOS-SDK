//
//  MFMediatedNativeContentAd.m
//  Adapters
//
//  Created by Shimi Sheetrit on 1/1/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import "MFMediatedNativeContentAd.h"

@interface MFMediatedNativeContentAd()
 
@property (nonatomic) NSString *headline;
@property (nonatomic) NSString *body;
@property (nonatomic) NSString *callToAction;
@property (nonatomic) NSString *store;
@property (nonatomic) NSString *price;
@property (nonatomic) NSDictionary *extras;
@property (nonatomic) NSString *calltoAction;
@property (nonatomic) NSDecimalNumber *NSDecimalNumber;


@property (nonatomic) NSArray *mappedImages;
@property (nonatomic) GADNativeAdImage *mappedIcon;


@end


@implementation MFMediatedNativeContentAd

- (void)changeStataus {
    
    NSLog(@"");
    
}


- (instancetype)initWithMFNativeContentAd:(MobFoxNativeData*)mobFoxNativeData {
        
        if (mobFoxNativeData == nil) {
            return nil;
        }
    

        self = [super init];
        if (self) {
            
            //_sampleAd = sampleNativeAppInstallAd;
            //_extras = @{SampleCustomEventExtraKeyAwesomeness : _sampleAd.degreeOfAwesomeness};
            
            if (mobFoxNativeData.main) {
                //CIImage *image = [[CIImage alloc] initWithContentsOfURL:mobFoxNativeData.main.url];
                _mappedImages = @[ [[GADNativeAdImage alloc] initWithURL:mobFoxNativeData.main.url scale:0] ];
            }
            
            if (mobFoxNativeData.icon) {
                //UIImage *image = [[UIImage alloc] initWithContentsOfURL:mobFoxNativeData.icon.url];
                _mappedIcon = [[GADNativeAdImage alloc] initWithURL:mobFoxNativeData.icon.url scale:0];
            }

           
        }
        return self;
}


- (NSString *)headline {
    return self.headline;
}
    
- (NSArray *)images {
    return self.mappedImages;
}
    
- (NSString *)body {
    return self.body;
}
    
- (GADNativeAdImage *)icon {
    return self.mappedIcon;
}
    
- (NSString *)callToAction {
    return self.calltoAction;
}
    
- (NSDecimalNumber *)starRating {
    return self.starRating;
}
    
- (NSString *)store {
    return self.store;
}
    
- (NSString *)price {
    return self.price;
}
    
- (NSDictionary *)extraAssets {
    return self.extras;
}
    
- (id<GADMediatedNativeAdDelegate>)mediatedNativeAdDelegate {
    return self;
}
    
#pragma mark - GADMediatedNativeAdDelegate implementation
    
- (void)mediatedNativeAdDidRecordImpression:(id<GADMediatedNativeAd>)mediatedNativeAd {
    NSLog(@"mediatedNativeAdDidRecordImpression:");
  
}
    
- (void)mediatedNativeAd:(id<GADMediatedNativeAd>)mediatedNativeAd
didRecordClickOnAssetWithName:(NSString *)assetName
                    view:(UIView *)view
          viewController:(UIViewController *)viewController {
    NSLog(@"mediatedNativeAd:didRecordClickOnAssetWithName:view:viewController:");
    

}
    
@end
