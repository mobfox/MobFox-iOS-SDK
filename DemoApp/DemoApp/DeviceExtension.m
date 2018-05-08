//
//  DeviceExtention.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 3/16/16.
//  Copyright © 2016 Itamar Nabriski. All rights reserved.
//

#import "DeviceExtension.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#import <sys/utsname.h>

@implementation DeviceExtension

+ (BOOL)isIpad {
    
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (BOOL)isIphoneX {

    struct utsname systemInfo;
    
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    if (code == nil) return NO;
    
    if ([code isEqualToString:@"iPhone10,3"]) return YES;
    if ([code isEqualToString:@"iPhone10,6"]) return YES;
    
    return NO;
}

+ (BOOL)isIphone {
    
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isTV {
    
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomTV;
}

+ (NSString *)ipAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

@end
