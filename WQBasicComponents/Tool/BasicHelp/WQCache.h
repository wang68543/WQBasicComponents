//
//  UUTCache.h
//  UUTKe
//
//  Created by WangQiang on 2016/11/22.
//  Copyright © 2016年 唐景. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+WQPath.h"

typedef NS_ENUM(NSInteger,CacheDocumentType) {
    CacheToCachesDirectory = 0,//默认存储此文件夹
    CacheToDocDirectory,//会备份这个文件夹
    //Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
    CachePathVocie,
    //temp 存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
};
@interface WQCache : NSObject

//MARK:  =========== Cache To File ===========
+(NSString *)cacheName:(NSString *)name flag:(NSString *)flag;
+(void)cacheObject:(id)object name:(NSString *)name flag:(NSString *)flag;
+(id)objectWithName:(NSString *)name flag:(NSString *)flag;

+(void)cacheObject:(id)object name:(NSString *)name;
+(id)objectWithName:(NSString *)name;



+(void)cacheObject:(id)object name:(NSString *)name cacheType:(CacheDocumentType)doucumentType;
+(id)objectWithName:(NSString *)name cacheType:(CacheDocumentType)doucumentType;

/** 存储到指定的路径 */
+(void)cache:(id)object path:(NSString *)path;
/** 根据指定的路径获取对象 */
+(id)loadWithPath:(NSString *)path;

//TODO: 删除
+(void)removeObjectWithName:(NSString *)name;
+(void)removeObjectWithName:(NSString *)name cacheType:(CacheDocumentType)doucumentType;
/** 删除指定路径的文件 */
+(NSError *)removeObjectWithPath:(NSString *)path;

//MARK:  ======UserDefaults=====
+(id)userDefaultObjectWithKey:(NSString *)key;
+(BOOL)userDefaultBoolWithKey:(NSString *)key;
+(NSInteger)userDefaultIntegerWithKey:(NSString *)key;
+(void)saveObject:(id)object toUserDefault:(NSString *)key;
+(void)saveBool:(BOOL)boolValue toUserDefault:(NSString *)key;
+(void)saveInteger:(NSInteger)intValue toUserDefault:(NSString *)key;


//MARK: ======= Refresh Time =======
/** 根据本地记录的刷新时间来判断是否需要刷新 */
+ (BOOL)needUpdate:(NSString *)name timeInterval:(NSUInteger)interval;
/** 更新本地记录的某个缓存的刷新时间 */
+(void)updateLastRefreshDate:(NSString *)name;
/** 某条记录的缓存时间 */
+(NSDate *)lastRefreshDate:(NSString *)name;
/** 清除某条记录的最后缓存时间 */
+(void)clearLastRefreshDate:(NSString *)name;
/** 清楚所有的缓存的刷新时间 */
+(void)clearAllLastRefreshDate;
@end
