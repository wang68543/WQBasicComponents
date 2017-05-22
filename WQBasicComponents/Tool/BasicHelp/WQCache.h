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
    CacheToDocDirectory,
    CacheToCachesDirectory,
    CachePathVocie,
    
};
@interface WQCache : NSObject

+(NSString *)cacheName:(NSString *)name flag:(NSString *)flag;
+(void)cacheObject:(id)object name:(NSString *)name;
+(id)objectWithName:(NSString *)name;

+(void)cacheObject:(id)object name:(NSString *)name cacheType:(CacheDocumentType)doucumentType;
+(id)objectWithName:(NSString *)name cacheType:(CacheDocumentType)doucumentType;


/** 存储到指定的路径 */
+(void)cache:(id)object path:(NSString *)path;
/** 根据指定的路径获取对象 */
+(id)loadWithPath:(NSString *)path;


//MARK:  ======UserDefaults=====
+(id)userDefaultObjectWithKey:(NSString *)key;
+(BOOL)userDefaultBoolWithKey:(NSString *)key;
+(NSInteger)userDefaultIntegerWithKey:(NSString *)key;
+(void)saveObject:(id)object toUserDefault:(NSString *)key;
+(void)saveBool:(BOOL)boolValue toUserDefault:(NSString *)key;
+(void)saveInteger:(BOOL)intValue toUserDefault:(NSString *)key;

@end
