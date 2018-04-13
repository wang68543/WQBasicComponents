//
//  WQAppInfo.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQAppInfo.h"
//#import "WQCache.h"
#import <UIKit/UIKit.h>

@interface WQAppInfo()
@property (assign  ,nonatomic) CGFloat appWitdth;
@property (assign  ,nonatomic) CGFloat appHeight;

@property (assign  ,nonatomic) WQAppLanguage appLanguage;

@property (strong  ,nonatomic) NSDictionary *infoDictionary;
/** 只是每次启动app加载一次 */
@property (assign  ,nonatomic ,readonly) NSString *lastVersion;
@end
@implementation WQAppInfo
-(NSDictionary *)infoDictionary{
    if (!_infoDictionary) {
        _infoDictionary = [NSBundle mainBundle].infoDictionary;
    }
    return _infoDictionary;
}


-(CGFloat)appWitdth{
    if (!_appWitdth) {
        _appWitdth = [UIScreen mainScreen].bounds.size.width;
    }
    return _appWitdth;
}
-(CGFloat)appHeight{
    if (!_appHeight) {
        _appHeight = [UIScreen mainScreen].bounds.size.height;
    }
    return _appHeight;
}

-(WQAppLanguage)appLanguage{
    if (!_appLanguage) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSArray *languages = [defaults objectForKey : @"AppleLanguages"];
            // 获得当前iPhone使用的语言
            NSString* currentLanguage = [languages objectAtIndex:0];
            if([currentLanguage isEqualToString:@"en-US"]){
                _appLanguage = kLanguageEnglinsh;
            }else{
                _appLanguage = kLanguageSimpleChina;
            }
    }
    return _appLanguage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kLastVersion];
    }
    return self;
}


+(instancetype)sharedInstance{
    
    static id appInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appInfo = [[WQAppInfo alloc] init];
    });
    return appInfo;
}

+(CGFloat)app_Width{
    return [WQAppInfo sharedInstance].appWitdth;
}
+(CGFloat)app_Height{
    return [WQAppInfo sharedInstance].appHeight;
}

+(WQAppLanguage)appLanguage{
    return [WQAppInfo sharedInstance].appLanguage;
}

/**存储设备token的健*/
static NSString *kDeviceToken = @"DEVICE_TOKEN";

static NSString *kLastVersion = @"lastVersion";


+(NSString *)appInfoWithKey:(CFStringRef)key{
    return [[WQAppInfo sharedInstance] infoDictionary][(__bridge NSString *)key];
}

//MARK: App的唯一标识
+(NSString *)appBundle_Identifire{
    return [self appInfoWithKey:kCFBundleIdentifierKey];
}
//MARK: App版本号
+(NSString *)appVersion{
    return [self appInfoWithKey:(__bridge CFStringRef)@"CFBundleShortVersionString"];
}

//MARK: App构建版本号
+(NSString *)appBuild_Version{
    return [self appInfoWithKey:kCFBundleVersionKey];
}
//MARK: App名字
+(NSString *)appName{
    return [self appInfoWithKey:(__bridge CFStringRef)@"CFBundleDisplayName"];
}
//MARK: App配置文件里面的名字
+(NSString *)appDisplayName{
    return [self appInfoWithKey:(__bridge CFStringRef)@"CFBundleDisplayName"];
}

//MARK: App数字版本号
+(UInt32)appVersionNumber{
    return CFBundleGetVersionNumber(CFBundleGetMainBundle());
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
//MARK: 设备与时间组合的唯一标识
+(NSString *)appUUID_DateString{
    return [NSString stringWithFormat:@"%@%.0f",[self appUUIDWithoutLine],[[NSDate date] timeIntervalSince1970]];
}

//MARK: 通过后缀名组成一个唯一的名字
+(NSString *)appUUIDWithPathExtension:(NSString *)pathExtension{
    return [NSString stringWithFormat:@"%@.%@",[self appUUID_DateString],pathExtension];
}

//MARK :App之前存储的版本号
+(NSString *)appLastVersion{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLastVersion];
}
/** 判断当前app是否是新版本 是的话就存储当前版本号*/
+(BOOL)isNewVersion{
    NSString *appVersion = [self appVersion];
    if([appVersion compare:[WQAppInfo sharedInstance].lastVersion] == NSOrderedDescending){//是新版本
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:appVersion forKey:kLastVersion];
        [userDefaults synchronize];
        return YES;
    }
    return NO;
}
//MARK: - -- 是否是第一次安装app
+(BOOL)isFirstVersion{
    if ([WQAppInfo sharedInstance].lastVersion.length > 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[self appVersion] forKey:kLastVersion];
        [userDefaults synchronize];
        return YES;
    }else{
        return NO;
    }
}

//MARK: 设备令牌
+(NSString *)appDeviceToken{
   return  [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
}

//MARK: 动态保存信息
+(void)saveDeviceToken:(NSData *)deviceData{
   NSString *deviceToken = [deviceData description];
   deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(deviceToken.length > 0){
        [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:kDeviceToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+(void)saveCurrentVersion{
    [[NSUserDefaults standardUserDefaults] setObject:[self appVersion] forKey:kLastVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
