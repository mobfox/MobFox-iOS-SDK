//
//  InnerViewController.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 1/4/17.
//  Copyright © 2017 Matomy Media Group Ltd. All rights reserved.
//

#import "AdaptersViewController.h"
#import "CollectionViewCell.h"
#import "MFTestAdapter.h"
#import "AdsViewController.h"
#import "DeviceExtension.h"


#define ADAPTERS_NUM 3

typedef NS_ENUM(NSInteger, MFRandomStringPart) {
    MFAdapterAdMob = 0,
    MFAdapterSmaato,
    MFAdapterMoPub,
    
};

@interface AdaptersViewController()
    
@property (nonatomic, strong) NSString *cellID;
@property (nonatomic, strong) NSString *sdk_name_selected;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AdaptersViewController

static bool perform_segue_enabled;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([DeviceExtension isIphoneX]) {
        CGRect frame = self.collectionView.frame;
        
        frame.origin.y += 26;
        self.collectionView.frame = frame;
    } else {
        CGRect frame = self.collectionView.frame;
        
        frame.origin.y -= 4;
        self.collectionView.frame = frame;
    }
    self.cellID = @"cellID";

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:true];
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"AdaptersToAds"]) {
                
        if(perform_segue_enabled == true) {
            
            perform_segue_enabled = false;
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AdsViewController *adsVC = segue.destinationViewController;
    adsVC.sdkName = _sdk_name_selected;
}

    
#pragma mark Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return ADAPTERS_NUM;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
        
    CollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    cell.title.text = [self adTitle:indexPath];
    cell.image.image = [self adImage:indexPath];
    
    if (cell.selected) {
        cell.backgroundColor = [UIColor lightGrayColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor]; // Default color
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark Collection View Delegate



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    switch (indexPath.item) {
            case MFAdapterAdMob:
            _sdk_name_selected = @"AdMob";
            break;
            case MFAdapterSmaato:
            _sdk_name_selected = @"Smaato";
            break;
            case MFAdapterMoPub:
            _sdk_name_selected = @"MoPub";
            break;
            
        default:
            _sdk_name_selected= @"";
            break;
    }
    
    perform_segue_enabled = true;
    [self shouldPerformSegueWithIdentifier:@"AdaptersToAds" sender:nil];
    [self performSegueWithIdentifier:@"AdaptersToAds" sender:nil];
        
    
}
    
#pragma mark Private Methods


- (NSString *)adTitle:(NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
            
        case MFAdapterAdMob:
            return @"AdMob";
            break;
        case MFAdapterSmaato:
            return @"Smaato";
            break;
        case MFAdapterMoPub:
            return @"MoPub";
            break;
            
            
        default:
            return @"";
            break;
    }
}

- (UIImage *)adImage:(NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
        case MFAdapterAdMob:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
        case MFAdapterSmaato:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
        case MFAdapterMoPub:
            return [UIImage imageNamed:@"test_banner.png"];
            break;
            

        default:
            return nil;
            break;
    }
}



@end
