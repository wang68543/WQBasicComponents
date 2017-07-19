//
//  WQAppInfo.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQAppInfo.h"
#import "WQCache.h"
#import <UIKit/UIKit.h>
@implementation WQAppInfo
static CGFloat kAppWidth_;
static CGFloat kAppHeight_;
+(void)initialize{
    kAppWidth_ = [UIScreen mainScreen].bounds.size.width;
    kAppHeight_ = [UIScreen mainScreen].bounds.size.height;
}

+(CGFloat)app_Width{
    return kAppWidth_;
}
+(CGFloat)app_Height{
    return kAppHeight_;
}
static WQAppLanguage kLanguage_;
+(WQAppLanguage)appLanguage{
    if(!kLanguage_){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
        // 获得当前iPhone使用的语言
        NSString* currentLanguage = [languages objectAtIndex:0];
        if([currentLanguage isEqualToString:@"en-US"]){
            kLanguage_ = kLanguageEnglinsh;
        }else{
            kLanguage_ = kLanguageSimpleChina;
        }
    }
    return kLanguage_;
}

/**存储设备token的健*/
static NSString *kDeviceToken = @"DEVICE_TOKEN";

static NSString *kLastVersion = @"lastVersion";

+(NSDictionary *)infoDictionary{
    static NSDictionary *infoDictionary ;
    if(!infoDictionary) infoDictionary = [NSBundle mainBundle].infoDictionary;
    return infoDictionary;
}

+(NSString *)appInfoWithKey:(CFStringRef)key{
    return [self infoDictionary][(__bridge NSString *)key];
}


//MARK: App的唯一标识
+(NSString *)appBundle_Identifire{
    return [self appInfoWithKey:kCFBundleIdentifierKey];
}
//MARK: App版本号
+(NSString *)appVersion{
    return [self appInfoWithKey:(__bridge CFStringRef)@"CFBundleShortVersionString"];
}
//MARK :App之前存储的版本号
+(NSString *)appLastVersion{
    return [WQCache userDefaultObjectWithKey:kLastVersion];
}
/** 判断当前app是否是新版本 是的话就存储当前版本号*/
+(BOOL)isNewVersion{
    NSString *appVersion = [self appVersion];
    if([appVersion compare:[self appLastVersion]] == NSOrderedDescending){//是新版本
        [WQCache saveObject:appVersion toUserDefault:kLastVersion];
        return YES;
    }
    return NO;
}
//MARK: App数字版本号
+(UInt32)appVersionNumber{
    return CFBundleGetVersionNumber(CFBundleGetMainBundle());
}
//MARK: App构建版本号
+(NSString *)appBuild_Version{
    return [self appInfoWithKey:kCFBundleVersionKey];
}
//MARK: App名字
+(NSString *)appName{
    return [self appInfoWithKey:kCFBundleNameKey];
}
//MARK: App配置文件里面的名字
+(NSString *)appDisplayName{
    return [self appInfoWithKey:(__bridge CFStringRef)@"CFBundleDisplayName"];
}
//MARK: 设备的唯一标识
+(NSString *)appUUIDString{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}
//MARK: 去除唯一标识中的横线
+(NSString *)appUUIDWithoutLine{
    NSString *uuidStr = [self appUUIDString];
    return [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, uuidStr.length-1)];
}
//MARK: 设备令牌
+(NSString *)appDeviceToken{
   return  [WQCache userDefaultObjectWithKey:kLastVersion];
}
//MARK: 设备与时间组合的唯一标识
+(NSString *)appUUID_DateString{
    return [NSString stringWithFormat:@"%@%.0f",[self appUUIDWithoutLine],[[NSDate date] timeIntervalSince1970]];
}
//MARK: 通过后缀名组成一个唯一的名字
+(NSString *)appUUIDWithPathExtension:(NSString *)pathExtension{
    return [NSString stringWithFormat:@"%@.%@",[self appUUID_DateString],pathExtension];
}

//MARK: 动态保存信息
+(void)saveDeviceToken:(NSData *)deviceData{
   NSString *deviceToken = [deviceData description];
   deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [WQCache saveObject:deviceToken toUserDefault:kDeviceToken];
}
+(void)saveCurrentVersion{
    [WQCache saveObject:[self appVersion] toUserDefault:kLastVersion];
}
@end
