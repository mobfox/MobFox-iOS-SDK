//
//  InnerViewController.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 1/4/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MFTestAdapter.h"

@interface GenericAdapterViewController : UIViewController <MFTestAdapterBaseDelegate, UICollectionViewDelegate, UICollectionViewDataSource, MobFoxAdDelegate>




@end
