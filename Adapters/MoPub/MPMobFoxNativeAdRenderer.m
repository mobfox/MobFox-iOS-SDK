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
    /*** please add to arr array your mediation class names (as 'MoPubNativeAdapterMobFox') ***/
    config.supportedCustomEvents = arr;
    return config;
    
}

@end



