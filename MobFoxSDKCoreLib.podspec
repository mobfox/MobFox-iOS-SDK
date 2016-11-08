
Pod::Spec.new do |s|

 
  s.name         = "MobFoxSDKCoreLib"
  s.version      = "2.4.1"
  s.summary      = "A short description of MobFoxSDKCoreLib."
  s.description  = "Description......."
  s.homepage     = "http://mobfox.com"

  s.license      = "MIT"
  s.author       = { "Shimi Sheetrit" => "shimi.s@matomy.com" }


  s.ios.deployment_target = "7.0"

  #s.source       = { :git => "https://github.com/mobfox/MobFox-iOS-SDK-Core-Lib", :tag => "v2.4.1" }
  #s.public_header_files = "MobFoxSDKCore.embeddedframework/MobFoxSDKCore.framework/Headers/*.h"
  s.resources = "MobFoxSDKCore.embeddedframework/MobFoxSDKCore.bundle"
  #s.preserve_paths = "MobFoxSDKCore.embeddedframework/MobFoxSDKCore.framework"

  s.source_files = "MobFoxSDKCore.embeddedframework/MobFoxSDKCore.framework"

  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }


 
  s.framework    = 'MobFoxSDKCore'



end

