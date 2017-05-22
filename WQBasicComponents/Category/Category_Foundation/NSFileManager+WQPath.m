//
//  NSFileManager+Path.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/1/6.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSFileManager+WQPath.h"

@implementation NSFileManager (WQPath)
+ (NSURL *)URLForDirectory:(NSSearchPathDirectory)directory{
    return [[[self defaultManager] URLsForDirectory:directory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)pathForDirectory:(NSSearchPathDirectory)directory{
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}

+ (NSURL *)documentsURL{
    return [self URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)documentsPath{
    return [self pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)libraryURL{
    return [self URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)libraryPath{
    return [self pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)cachesURL{
    return [self URLForDirectory:NSCachesDirectory];
}

+ (NSString *)cachesPath{
    return [self pathForDirectory:NSCachesDirectory];
}
+(NSString *)pathForCacheDirectory{
    NSString *path = [[self cachesPath] stringByAppendingPathComponent:@"WQCache"];
    NSError *error =  [self createPathIfNotExtist:path];
    if(error) return nil;
    return path;
}

+(NSString *)pathForDocDirectory{
    NSString *path = [[self documentsPath] stringByAppendingPathComponent:@"WQDocCache"];
    NSError *error =  [self createPathIfNotExtist:path];
    if(error) return nil;
    return path;
}

+(NSString *)pathForVoiceDirectory{
    return [self pathWithCustomDirectory:@"VoiceCache"];
}

/**自定义缓存文件夹*/
+(NSString *)pathWithCustomDirectory:(NSString *)customDir{
    NSString *path = [self pathForCacheDirectory];
    if(!path){
        return nil;
    }else{
        path  = [path stringByAppendingPathComponent:customDir];
    }
    NSError *error =  [self createPathIfNotExtist:path];
    if(error) return nil;
    return path;
}


/**如果路径不存在就创建*/
+(NSError *)createPathIfNotExtist:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path isDirectory:NULL]){
        return nil;
    }else{
        [self createPathIfNotExtist:[path stringByDeletingLastPathComponent]];
        NSError *error ;
        if(path.pathExtension.length <= 0){
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        }
        return error;
    }
}
@end
