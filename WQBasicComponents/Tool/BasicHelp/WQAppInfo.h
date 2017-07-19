//
//  WQAppInfo.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,WQAppLanguage) {
    kLanguageSimpleChina,//缺省为中文
    kLanguageEnglinsh,
};

@interface WQAppInfo : NSObject

/** 屏幕高 */
+(CGFloat)app_Height;
/** 屏幕宽 */
+(CGFloat)app_Width;

+(WQAppLanguage)appLanguage;
/** App的唯一标识 */
+(NSString *)appBundle_Identifire;
/** App版本号 */
+(NSString *)appVersion;
/** 存储的上次的版本号 */
+(NSString *)appLastVersion;
/** 判断当前app是否是新版本 是的话就存储当前版本号*/
+(BOOL)isNewVersion;
/** App数字版本号 */
+(UInt32)appVersionNumber;
/** App构建版本号 */
+(NSString *)appBuild_Version;
/** App名字 */
+(NSString *)appName;
/** App配置文件里面的名字 */
+(NSString *)appDisplayName;
/** 设备的唯一标识 */
+(NSString *)appUUIDString;
/** 去除唯一标识中的横线 */
+(NSString *)appUUIDWithoutLine;
/** 设备与时间组合的唯一标识 */
+(NSString *)appUUID_DateString;
/** 通过后缀名组成一个唯一的名字 */
+(NSString *)appUUIDWithPathExtension:(NSString *)pathExtension;

/** 设备令牌 */
+(NSString *)appDeviceToken;
//MARK: 动态保存信息
+(void)saveDeviceToken:(NSData *)deviceData;
/** 保存当前的版本号(大多用于新特性) */
+(void)saveCurrentVersion;
@end
