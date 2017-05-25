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
  s.version      = "0.0.7"
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
  
  s.subspec 'WQPublicHelp' do |ss|
    # ss.subspec 'WQBasicInherit' do |sss|
    #   sss.source_files = 'WQBasicComponents/WQPublicHelp/WQBasicInherit/*.{h,m}'
    # end 
    ss.subspec 'WQBasicHelp' do |sss|
      sss.source_files = 'WQBasicComponents/WQPublicHelp/WQBasicHelp/*.{h,m}'
    end 
  end


  s.subspec 'Category' do |ss|
    ss.subspec 'Category_Vendor' do |sss|
      sss.source_files = 'WQBasicComponents/Category/Category_Vendor/*.{h,m}'
    end 
    ss.subspec 'Category_Foundation' do |sss|
      sss.source_files = 'WQBasicComponents/Category/Category_Foundation/*.{h,m}'
    end 
    ss.subspec 'Category_UIKit' do |sss|
      sss.dependency 'WQBasicComponents/Category/Category_Vendor'
      sss.source_files = 'WQBasicComponents/Category/Category_UIKit/*.{h,m}'
    end  
    ss.subspec 'Category_Date' do |sss|
      sss.dependency 'WQBasicComponents/Category/Category_Vendor'
      sss.source_files = 'WQBasicComponents/Category/Category_Date/*.{h,m}'
    end 
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
  end

  s.subspec 'UICustom' do |ss|
    ss.subspec 'ViewCustom' do |sss|
      sss.source_files = 'WQBasicComponents/UICustom/ViewCustom/*.{h,m}'
    end 
     ss.subspec 'StarView' do |sss|
      sss.source_files = 'WQBasicComponents/UICustom/StarView/*.{h,m}'
    end 
  end
  s.dependency 'AFNetworking'
  s.dependency 'SDWebImage'

end
