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
    return [NSString stringWithFormat:@"%@_%@",name,flag];
}
+(void)cacheObject:(id)object name:(NSString *)name flag:(NSString *)flag{
    [self cacheObject:object name:[self cacheName:name flag:flag]];
}
+(id)objectWithName:(NSString *)name flag:(NSString *)flag{
   return  [self objectWithName:[self cacheName:name flag:flag]];
}
+(void)cacheObject:(id)object name:(NSString *)name{
    [self cacheObject:object name:name cacheType:0];
}
+(id)objectWithName:(NSString *)name{
    return [self objectWithName:name cacheType:0];
}

+(void)cacheObject:(id)object name:(NSString *)name cacheType:(CacheDocumentType)doucumentType{
    NSString *path = [self pathWithName:name docType:doucumentType];
    if(!path)return;
    [self cache:object path:path];
}
+(id)objectWithName:(NSString *)name cacheType:(CacheDocumentType)doucumentType{
    NSString *path = [self pathWithName:name docType:doucumentType];
    if(!path){
        return nil;
    }
    return [self loadWithPath:path];
}
#pragma mark -- 私有方法

+(NSString *)pathWithName:(NSString *)name docType:(CacheDocumentType)doucumentType{
    return  [[self basicPathWith:doucumentType] stringByAppendingPathComponent:name];
}
+(NSString *)basicPathWith:(CacheDocumentType)cacheType{
    NSString *basicPath;
    switch (cacheType) {
        case CacheToDocDirectory:
            basicPath = [NSFileManager pathForDocDirectory];
            break;
        case CachePathVocie:
            basicPath = [NSFileManager pathForVoiceDirectory];
            break;
        case CacheToCachesDirectory:
             basicPath = [NSFileManager pathForCacheDirectory];
            break;
    }
    return basicPath;
}

+(void)cache:(id)object path:(NSString *)path{
    //最后一个路径可能不存在
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path] || !object) return;
    //必须声明实现NSCoding协议
    if([object conformsToProtocol:@protocol(NSCoding)])
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}
+(id)loadWithPath:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return nil;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

#pragma mark -- 删除 
+(void)removeObjectWithName:(NSString *)name{
    [self removeObjectWithName:name cacheType:0];
}
+(void)removeObjectWithName:(NSString *)name cacheType:(CacheDocumentType)doucumentType{
    [self removeObjectWithPath:[self pathWithName:name docType:doucumentType]];
}
/** 删除指定路径的文件 */
+(NSError *)removeObjectWithPath:(NSString *)path{
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    return error;
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
+(void)saveInteger:(NSInteger)intValue toUserDefault:(NSString *)key{
    [[self userDefaults] setInteger:intValue forKey:key];
    [[self userDefaults] synchronize];
}


#pragma mark - --LastRefreshDate---
/** 根据本地记录的刷新时间来判断是否需要刷新 */
+ (BOOL)needUpdate:(NSString *)name timeInterval:(NSUInteger)interval{
    NSDate *lastRefresh = [self lastRefreshDate:name];
    if(!lastRefresh) return YES;
    NSInteger time = [[NSDate date] timeIntervalSinceDate:lastRefresh];
    return (time > interval);
}

//TODO: 更新本地记录的某个缓存的刷新时间
+(void)updateLastRefreshDate:(NSString *)name{
    [self saveObject:[NSDate date] toUserDefault:[self lastRefreshDateStoreKey:name]];
}
//TODO:  某条记录的缓存时间
+(NSDate *)lastRefreshDate:(NSString *)name{
    return [self userDefaultObjectWithKey:[self lastRefreshDateStoreKey:name]];
}
//TODO: 清除某条记录的最后缓存时间
+(void)clearLastRefreshDate:(NSString *)name{
    [[self userDefaults] removeObjectForKey:[self lastRefreshDateStoreKey:name]];
    [[self userDefaults] synchronize];
    
}
//TODO:  清楚所有的缓存的刷新时间
+(void)clearAllLastRefreshDate{
    NSUserDefaults* defs = [self userDefaults];
    NSDictionary* dict = [defs dictionaryRepresentation];
    for(NSString *key in dict) {
        if ([key hasPrefix:kRefreshKeyPrefix]) {
            [defs removeObjectForKey:key];
        }
    }
    [defs synchronize];
}

#pragma mark --私有方法 --

static NSString *const kRefreshKeyPrefix = @"lastRefreshDate_";
//TODO: 最后刷新时间的存储key
+ (NSString *)lastRefreshDateStoreKey:(NSString *)name{
    return [kRefreshKeyPrefix stringByAppendingString:name];
}
@end
