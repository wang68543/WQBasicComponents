//
//  NSFileManager+Path.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/1/6.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (WQPath)

/** CacheToCachesDirectory */
+(NSString *)pathForCacheDirectory;
/** CacheToDocDirectory */
+(NSString *)pathForDocDirectory;
/** CachePathVocie */
+(NSString *)pathForVoiceDirectory;
/** 自定义缓存文件夹 */
+(NSString *)pathWithCustomDirectory:(NSString *)customDir;

/** 创建路径 */
+(NSError *)createPathIfNotExtist:(NSString *)path;
/**
 Get URL of Documents directory.
 
 @return Documents directory URL.
 */
+ (NSURL *)documentsURL;

/**
 Get path of Documents directory.
 
 @return Documents directory path.
 */
+ (NSString *)documentsPath;

/**
 Get URL of Library directory.
 
 @return Library directory URL.
 */
+ (NSURL *)libraryURL;

/**
 Get path of Library directory.
 
 @return Library directory path.
 */
+ (NSString *)libraryPath;

/**
 Get URL of Caches directory.
 
 @return Caches directory URL.
 */
+ (NSURL *)cachesURL;

/**
 Get path of Caches directory.
 
 @return Caches directory path.
 */
+ (NSString *)cachesPath;
@end
