//
//  MobFoxUnityPlugin.m
//  MobFoxUnityPlugin
//
//  Created by Itamar Nabriski on 11/17/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//


#import "MobFoxUnityPlugin.h"

extern "C"
{
    extern UIViewController* UnityGetGLViewController();
    extern void UnitySendMessage(const char *, const char *, const char *);
}

@interface MobFoxUnityPlugin()
    @property NSMutableDictionary* ads;
    @property int nextId;
    @property NSString* gameObject;
    @property (nonatomic,strong) MobFoxInterstitialAd* inter;

@end

@implementation MobFoxUnityPlugin

-(id) init{
    self = [super init];
    self.ads = [[NSMutableDictionary alloc] init];
    self.nextId = 1;
    self.gameObject = nil;
    return self;
}

-(int) createBanner:(NSString*)invh  withDimensions:(CGRect)placement{
    
    MobFoxAd* banner = [[MobFoxAd alloc] init:invh withFrame:placement];
    banner.delegate = self;
    NSString* key = [NSString stringWithFormat:@"key-%d",self.nextId];
    [self.ads setValue:banner forKey:key];
    int cur = self.nextId;
    self.nextId= self.nextId + 1;
    //banner.type = @"video";
    [banner loadAd];
    return cur;
}

-(void) showBanner:(int) bannerId{
    NSString* key = [NSString stringWithFormat:@"key-%d",bannerId];
    MobFoxAd* banner = [self.ads valueForKey:key];
    if(!banner){
        NSLog(@"MobFoxUnityPlugin >> showBanner >> banner with id %d was not found",bannerId);
        return;
    }
    banner.hidden = NO;
    NSLog(@"MobFoxUnityPlugin >> showBanner >> show banner %d",bannerId);

}

-(void) hideBanner:(int) bannerId{
     NSString* key = [NSString stringWithFormat:@"key-%d",bannerId];
     MobFoxAd* banner = [self.ads valueForKey:key];
     if(!banner){
        NSLog(@"MobFoxUnityPlugin >> hideBanner >> banner with id %d was not found",bannerId);
        return;
    }
   banner.hidden = YES;
    NSLog(@"MobFoxUnityPlugin >> hideBanner >> hiding banner %d",bannerId);
}

-(void) createInterstitial:(NSString*)invh{
    
    NSLog(@"MobFoxUnityPlugin >> createInterstitial");
    self.inter = [[MobFoxInterstitialAd alloc] init:invh];
    self.inter.delegate = self;
    [self.inter loadAd];
   }

-(void) showInterstitial{
   
    if(!self.inter){
        NSLog(@"MobFoxUnityPlugin >> showInterstitial >> inter not init");
        return;
    }
    
    if(self.inter.ready){
        [self.inter show];
    }
    
    NSLog(@"MobFoxUnityPlugin >> showInterstitial");
    
}

// MobFox Ad Delegate
- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    //show banner
    UIViewController* vc = UnityGetGLViewController();
    [vc.view addSubview:banner];
    
    NSLog(@"MobFoxUnityPlugin >> MobFoxAdDidLoad:");
    UnitySendMessage([self.gameObject UTF8String], "bannerReady", "MobFoxAdDidLoad msg");
    
}

- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
    UnitySendMessage([self.gameObject UTF8String], "bannerError", [[error description] UTF8String]);
    
}

- (void)MobFoxAdClosed{
    UnitySendMessage([self.gameObject UTF8String], "banneClosed", "MobFoxAdClosed msg");
}

- (void)MobFoxAdClicked{
    UnitySendMessage([self.gameObject UTF8String], "banneClicked", "MobFoxAdClicked msg");
}

- (void)MobFoxAdFinished{
    UnitySendMessage([self.gameObject UTF8String], "banneFinished", "MobFoxAdFinished msg");
}

// MobFox Interstitial Ad Delegate
- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
    
    NSLog(@"MobFoxUnityPlugin >> MobFoxInterstitialAdDidLoad >> inter loaded");
    
    interstitial.rootViewController = UnityGetGLViewController();
    UnitySendMessage([self.gameObject UTF8String], "interstitialReady", "MobFoxInterstitialAdDidLoad msg");
        
}

- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    UnitySendMessage([self.gameObject UTF8String], "interstitalError", [[error description] UTF8String]);
}

- (void)MobFoxInterstitialAdClosed{
    UnitySendMessage([self.gameObject UTF8String], "interstitialClosed", "MobFoxInterstitialAdClosed msg");
}


- (void)MobFoxInterstitialAdClicked{
    UnitySendMessage([self.gameObject UTF8String], "interstitialClicked", "MobFoxInterstitialAdClicked msg");
}


- (void)MobFoxInterstitialAdFinished{
    UnitySendMessage([self.gameObject UTF8String], "interstitialFinished", "MobFoxInterstitialAdFinished msg");
}

@end

extern "C"
{
    static MobFoxUnityPlugin* plugin = [[MobFoxUnityPlugin alloc] init];
    
    void _setGameObject(const char* gameObject){
        plugin.gameObject = [NSString stringWithUTF8String:gameObject];
    }
    
    int _createBanner(const char* invh, float x, float y, float width, float height){
        
        NSLog(@"rect width: %f", width);
        NSLog(@"rect height: %f", height);
        
        CGRect rect = CGRectMake(x, y, width, height);

        return [plugin createBanner:[NSString stringWithUTF8String:invh] withDimensions:rect];
        
    }
    void _showBanner(int bannerId){
        [plugin showBanner:bannerId];
    }
    void  _hideBanner(int bannerId){
        [plugin hideBanner:bannerId];
    }
    
    void _createInterstitial(const char* invh){
        [plugin createInterstitial:[NSString stringWithUTF8String:invh]];
    }
    
    void _showInterstitial(){
        [plugin showInterstitial];
    }
}
