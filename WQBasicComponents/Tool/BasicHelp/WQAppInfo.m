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
+(void)saveDeviceToken:(NSString *)deviceToken{
    [WQCache saveObject:deviceToken toUserDefault:kDeviceToken];
}
+(void)saveCurrentVersion{
    [WQCache saveObject:[self appVersion] toUserDefault:kLastVersion];
}
@end
