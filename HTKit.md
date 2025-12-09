# HTKit
iOS开发常用的swift工具和拓展

## 开发要求
1. swift5
2. 导入依赖库。需要在Podfile文件里增加以下配置：
```ruby
# use dynamic frameworks
use_frameworks!
# HTKit
pod 'SDWebImage', '5.18.7'
pod 'SVProgressHUD', '2.3.1'
pod 'CocoaLumberjack/Swift', '3.6.1'
```
然后在Podfile文件后面的最外层增加以下配置：
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      
      # no signing for pods bundle, after xcode 14
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
      
      # reset libs version
      deployment = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
#      if deployment.to_f < 12.0
#        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
#      end
      
      #在xcode14.3上，苹果认为项目都是最低iOS11的。
      #但是pod里的配置可能低于iOS11，会出现编译错误
      #File not found: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/arc/libarclite_iphoneos.a
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
      
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      
    end
  end
end
```
3. `build settings`里将`ENABLE_USER_SCRIPT_SANDBOXING`设置为`No`。否则会报错：
```ruby
rsync(30752): error: CocoaLumberjack.framework/_CodeSignature/: mkpathat: Operation not permitted
CocoaLumberjack.framework/
CocoaLumberjack.framework/CocoaLumberjack
rsync(30752): error: mkstempat: 'CocoaLumberjack.framework/.CocoaLumberjack.21ympux5np': Operation not permitted
CocoaLumberjack.framework/Info.plist
rsync(30752): error: CocoaLumberjack.framework/CocoaLumberjack: utimensat (2): No such file or directory
rsync(30752): error: rsync_set_metadata
rsync(30752): error: rsync_downloader
rsync(30752): error: rsync_receiver
CocoaLumberjack.framework/_CodeSignature/CodeResources
rsync(30751): error: unexpected end of file
rsync(30751): error: io_read_nonblocking
rsync(30751): error: io_read_blocking
rsync(30751): error: io_read_flush
rsync(30751): error: rsync_sender
```