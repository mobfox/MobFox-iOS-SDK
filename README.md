# MobFox-iOS-SDK-Core-Lib

# Installation

## CocoaPods

Add to your Podfile:

```
pod 'MobFoxSDKCoreLib', :git => 'https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib.git'
```
## Manual Installation

1. Download and unzip [MobFoxSDKCoreLib.zip](https://sdk.starbolt.io/MobFoxSDKCoreLib.zip) or clone this repository and extract the ```MobFoxSDKCore.embeddedframework```.

2. Add ```MobFoxSDKCore.embeddedframework``` to your project's **Build Phases** > **Link Binary With Libraries**.


## iOS 9+ Specific
One of the changes in iOS9 is a default setting that requires apps to make network connections only over SSL, this is known as App Transport Security. MobFox is facilitating the transition to support this change for each of our demand partners in order to ensure they are compliant. In the meantime, developers who want to release apps that support iOS9, will need to disable ATS in order to ensure MobFox continues to work as expected. To do so, developers should add the following to their plist:
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
Developers can also edit the plist directly by adding ```NSAppTransportSecurity``` key of dictionary type with a dictionary element of ```NSAllowsArbitraryLoads``` of boolean type set to ```Yes```.

In the future MobFox will provide an additional parameter for requesting only secure ads. We will inform our publishers via the [Control Panel](https://account.mobfox.com).

More information about this change can be found on Apple's website: https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html#//apple_ref/doc/uid/TP40016240

For further questions about iOS9 and ATS, please create a ticket at https://account.mobfox.com/www/cp/create_ticket.php

# Usage

