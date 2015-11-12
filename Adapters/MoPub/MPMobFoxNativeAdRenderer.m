#import "MPMobFoxNativeAdRenderer.h"
#import "MPNativeAdRendererConfiguration.h"

@implementation MPMobFoxNativeAdRenderer

+ (MPNativeAdRendererConfiguration *)rendererConfigurationWithRendererSettings:(id<MPNativeAdRendererSettings>)rendererSettings
{
   
    MPNativeAdRendererConfiguration *config = [super rendererConfigurationWithRendererSettings:rendererSettings];
    
    
    NSArray* events = config.supportedCustomEvents;
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for(id e in events){
        [arr addObject:e];
    }
    [arr addObject:@"MoPubNativeAdapterMobFox"];
    config.supportedCustomEvents = arr;
    return config;
}

@end



