//
//  UUTCache.m
//  UUTKe
//
//  Created by WangQiang on 2016/11/22.
//  Copyright © 2016年 唐景. All rights reserved.
//

#import "WQCache.h"

@implementation WQCache


+(NSString *)cacheName:(NSString *)name flag:(NSString *)flag{
    return [NSString stringWithFormat:@"%@-%@",name,flag];
}
+(void)cacheObject:(id)object name:(NSString *)name{
    [self cacheObject:object name:name cacheType:CacheToCachesDirectory];
}
+(id)objectWithName:(NSString *)name{
    return [self objectWithName:name cacheType:CacheToCachesDirectory];
}
+(void)cacheObject:(id)object name:(NSString *)name cacheType:(CacheDocumentType)doucumentType{
  NSString *path = [[self basicPathWith:doucumentType] stringByAppendingPathComponent:name];
    if(!path)return;
   [self cache:object path:path];
}
+(id)objectWithName:(NSString *)name cacheType:(CacheDocumentType)doucumentType{
    NSString *path = [[self basicPathWith:doucumentType] stringByAppendingPathComponent:name];
    if(!path){
        return nil;
    }
    return [self loadWithPath:path];
}

+(NSString *)basicPathWith:(CacheDocumentType)cacheType{
    NSString *basicPath;
    switch (cacheType) {
        case CacheToDocDirectory:
            basicPath = [NSFileManager pathForDocDirectory];
            break;
        case CachePathVocie:
            basicPath = [NSFileManager pathForVoiceDirectory];
        default:
            basicPath = [NSFileManager pathForCacheDirectory];
            break;
    }
    return basicPath;
}

+(void)cache:(id)object path:(NSString *)path{
    //最后一个路径可能不存在
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path] || !object) return;
    if([object conformsToProtocol:@protocol(NSCoding)])
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}
+(id)loadWithPath:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return nil;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}




#pragma mark -- userDefaults

+(NSUserDefaults *)userDefaults{
    return [NSUserDefaults standardUserDefaults];
}

+(id)userDefaultObjectWithKey:(NSString *)key{
    return [[self userDefaults] objectForKey:key];
}
+(BOOL)userDefaultBoolWithKey:(NSString *)key{
    return [[self userDefaults] boolForKey:key];
}
+(NSInteger)userDefaultIntegerWithKey:(NSString *)key{
    return [[self userDefaults] integerForKey:key];
}
+(void)saveObject:(id)object toUserDefault:(NSString *)key{
    [[self userDefaults] setObject:object forKey:key];
    [[self userDefaults] synchronize];
}
+(void)saveBool:(BOOL)boolValue toUserDefault:(NSString *)key{
    [[self userDefaults] setBool:boolValue forKey:key];
    [[self userDefaults] synchronize];
}
+(void)saveInteger:(BOOL)intValue toUserDefault:(NSString *)key{
    [[self userDefaults] setInteger:intValue forKey:key];
    [[self userDefaults] synchronize];
}

@end
