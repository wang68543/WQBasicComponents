#
#  Be sure to run `pod spec lint WQBasicComponents.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "WQBasicComponents"
  s.version      = "0.0.2"
  s.summary      = "基础组件"

  s.description  = <<-DESC
                      将之前的组件进行细致拆分
                      DESC
              

  s.homepage     = "https://github.com/wang68543/WQBasicComponents"


  s.license      = "MIT"


  s.author             = { "王强" => "wang68543@163.com" }
 

  s.source       = { :git => "https://github.com/wang68543/WQBasicComponents.git", :tag => "#{s.version}" }


  s.platform     = :ios, "8.0"

  s.requires_arc = true

  s.prefix_header_contents = '#import <UIKit/UIKit.h>', '#import <Foundation/Foundation.h>'
  s.source_files  = "WQBasicComponents/WQBasicComponents.h"
  s.user_target_xcconfig =  { "HEADER_SEARCH_PATHS" => '"$(SRCROOT)/WQBasicComponents/PaySDK"' }
  s.subspec 'Category' do |ss|
    ss.subspec 'Category_Vendor' do |sss|
      sss.source_files = 'WQBasicComponents/Category/Category_Vendor/*.{h,m}'
    end 
    ss.subspec 'Category_Foundation' do |sss|
      sss.source_files = 'WQBasicComponents/Category/Category_Foundation/*.{h,m}'
    end 
    ss.subspec 'Category_UIKit' do |sss|
      sss.source_files = 'WQBasicComponents/Category/Category_UIKit/*.{h,m}'
    end  
    ss.subspec 'Category_Date' do |sss|
      sss.dependency 'WQBasicComponents/Category/Category_Vendor'
      sss.source_files = 'WQBasicComponents/Category/Category_Date/*.{h,m}'
    end 
  end

  s.subspec 'WQPaySDK' do |ss|
   ss.vendored_libraries = "WQBasicComponents/PaySDK/WeiXinSdk/libWeChatSDK.a" ,"WQBasicComponents/PaySDK/alipaySdk/libcrypto.a","WQBasicComponents/PaySDK/alipaySdk/libssl.a"
   ss.source_files ="WQBasicComponents/PaySDK/**/*.{h,m}"
   ss.vendored_frameworks = 'WQBasicComponents/PaySDK/alipaySdk/AlipaySDK.framework'
   ss.frameworks = 'SystemConfiguration','CoreTelephony','QuartzCore','CoreText','CoreGraphics','CFNetwork','CoreMotion'
   ss.libraries = "c++", "z","sqlite3",
   # ss.vendored_libraries = "WQBasicComponents/PaySDK/**/*.a"
   # ss.vendored_libraries = "WQBasicComponents/PaySDK/WeiXinSdk/libWeChatSDK.a" ,"WQBasicComponents/PaySDK/alipaySdk/libcrypto.a","WQBasicComponents/PaySDK/alipaySdk/libssl.a"
   ss.resource = 'WQBasicComponents/PaySDK/alipaySdk/AlipaySDK.bundle'
   # ss.xcconfig = { "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/WQBasicComponents/PaySDK" }
   # ss.pod_target_xcconfig =  { "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/WQBasicComponents/PaySDK" }
   end


   non_arc_files = 'WQBasicComponents/Tool/VoiceTool/amrwapper/*.{h,m}'
   s.requires_arc = true
   s.exclude_files = non_arc_files
   s.subspec 'WavAmrHelp' do |sna|
   sna.requires_arc = false
   sna.source_files = non_arc_files
   sna.vendored_libraries = "WQBasicComponents/Tool/VoiceTool/amrwapper/libopencore-amrnb.a","WQBasicComponents/Tool/VoiceTool/amrwapper/libopencore-amrwb.a"
   end


  s.subspec 'Tool' do |ss|
    ss.subspec 'BasicFoundation' do |sss|
      sss.source_files = 'WQBasicComponents/Tool/BasicFoundation/*.{h,m}'
    end 
    ss.subspec 'BasicHelp' do |sss|
      sss.dependency 'WQBasicComponents/Category/Category_Foundation'
      sss.source_files = 'WQBasicComponents/Tool/BasicHelp/*.{h,m}'
    end
    ss.subspec 'FunctionHelp' do |sss|
      sss.source_files = 'WQBasicComponents/Tool/FunctionHelp/*.{h,m}'
    end
    ss.subspec 'NetWorkTool' do |sss|
      sss.dependency 'WQBasicComponents/Tool/BasicHelp'
      sss.dependency 'WQBasicComponents/Category/Category_UIKit'
      sss.source_files = 'WQBasicComponents/Tool/NetWorkTool/*.{h,m}'
    end
    ss.subspec 'VoiceTool' do |sss|
      sss.dependency 'WQBasicComponents/Tool/NetWorkTool'
      # sss.dependency 'WQBasicComponents/WavAmrHelp'
      sss.dependency 'WQBasicComponents/Tool/BasicHelp'
      sss.source_files = 'WQBasicComponents/Tool/VoiceTool/*.{h,m}'
    end
    ss.subspec 'PayTool' do |sss|
      # sss.dependency  'WQBasicComponents/WQPaySDK'  
      sss.source_files = 'WQBasicComponents/Tool/PayTool/*.{h,m}'
    end
  end

  s.subspec 'UICustom' do |ss|
    ss.subspec 'ViewCustom' do |sss|
      sss.source_files = 'WQBasicComponents/UICustom/ViewCustom/*.{h,m}'
    end 
     ss.subspec 'StarView' do |sss|
      sss.source_files = 'WQBasicComponents/UICustom/StarView/*.{h,m}'
    end 
  end
  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'SDWebImage', '~>3.8'

end
