//
//  SettingsViewController.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/3/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "SettingsViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

#define MOBFOX_HASH_INTER @"267d72ac3f77a3f447b32cf7ebf20673"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *hashTextField;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButtonItem;

@property (nonatomic) BOOL isScannerReading;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) MobFoxInterstitialAd *mobfoxInterAd;


@end

@implementation SettingsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isScannerReading = NO;
    self.captureSession = nil;
    
    self.startButton.layer.cornerRadius = 4.0;
    [self.statusLabel setText:@"QR Code Reader is not yet running..."];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
    
 

}

-(void)dismissKeyboard {
    [_hashTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"SettingsToMain"]) {
        
        if (self.hashTextField.text.length > 0) {
            
            MainViewController *vc = [segue destinationViewController];
            vc.invh = self.hashTextField.text;
        }
    }
    
}

- (IBAction)startStopReading:(id)sender {
    
    NSLog(@"startStopReading");
    
    if (!self.isScannerReading) {
        if ([self startReading]) {
            [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
            [self.statusLabel setText:@"Scanning for QR Code..."];
        }
    }
    else{
        [self stopReading];
        [self.startButton setTitle:@"Start!" forState:UIControlStateNormal];
        [self.statusLabel setText:@"QR Code Reader is not running..."];
    }
    
    self.isScannerReading = !self.isScannerReading;
    
}

- (BOOL)startReading {
    
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.viewPreview.layer.bounds];
    [self.viewPreview.layer addSublayer:self.videoPreviewLayer];
    
    [self.captureSession startRunning];
    
    return YES;
}

-(void)stopReading{
    
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [self.videoPreviewLayer removeFromSuperlayer];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            [_statusLabel performSelectorOnMainThread:@selector(setText:) withObject:@"QR Code Reader is not running..." waitUntilDone:NO];
                        
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.startButton setTitle:@"Start!" forState:UIControlStateNormal];
                self.hashTextField.text = [metadataObj stringValue];

            });

            self.isScannerReading = NO;
        }
    }
}

#pragma mark MobFox Interstitial Ad Delegate

//best to show after delegate informs an ad was loaded
- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial {
    
    NSLog(@"MobFoxInterstitialAdDidLoad:");
    
    if(self.mobfoxInterAd.ready){
        [self.mobfoxInterAd show];
    }
}


@end
