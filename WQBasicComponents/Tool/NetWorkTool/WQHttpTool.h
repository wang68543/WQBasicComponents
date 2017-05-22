//
//  WQHttpTool.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HttpSuccessBlock)(NSURLResponse *reponse, id json);
typedef void (^HttpFailureBlock)(NSURLResponse *reponse ,NSError *error);
typedef void (^HttpDownloadProgressBlock)(CGFloat progress);
typedef void (^HttpUploadProgressBlock)(CGFloat progress);

@interface WQHttpTool : NSObject

+(void)getWithPath:(NSString *)path
            params:(NSDictionary *)params
           success:(HttpSuccessBlock)success
           failure:(HttpFailureBlock)failure;
+(void)postWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;





+(void)postAudio:(NSString *)audioPath
            path:(NSString *)urlString
          params:(NSDictionary *)params
        progress:(HttpUploadProgressBlock)progress
         success:(HttpSuccessBlock)success
         failure:(HttpFailureBlock)failure;
/**语音上传*/
+(void)postAudioData:(NSData *)audioData
                path:(NSString *)urlString
              params:(NSDictionary *)params
            progress:(HttpUploadProgressBlock)progress
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;
+(void)postImage:(UIImage *)image
            path:(NSString *)urlString
          params:(NSDictionary *)params
        progress:(HttpUploadProgressBlock)progress
         success:(HttpSuccessBlock)success
         failure:(HttpFailureBlock)failure;
/**图片上传*/
+(void)postImageData:(NSData *)imageData
                path:(NSString *)urlString
              params:(NSDictionary *)params
            progress:(HttpUploadProgressBlock)progress
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;
/**
 上传文件API

 @param urlString 接口路径
 @param params 接口参数
 @param fileParams 文件参数
 @param data 文件二进制
 @param progress 上传进度
 @param success 上传成功
 @param failure 上传失败
 */
+(void)postDataWithURL:(NSString *)urlString
                 params:(NSDictionary *)params
             fileParams:(NSDictionary *)fileParams
               fileData:(NSData *)data
               progress:(HttpUploadProgressBlock)progress
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure;
+(void)postFileWithURL:(NSString *)urlString
                 params:(NSDictionary *)params
             fileParams:(NSDictionary *)fileParams
               filePath:(NSString *)filePath
               progress:(HttpUploadProgressBlock)progress
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure;

/**
 下载文件

 @param path 接口地址
 @param params 接口参数
 @param progress 下载进度
 @param success 下载成功
 @param failure 下载失败
 */
+(void)downloadFileWithPath:(NSString *)path
                     params:(NSDictionary *)params
                   progress:(HttpDownloadProgressBlock)progress
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure;
UIKIT_EXTERN NSString *const kFileName ;
UIKIT_EXTERN NSString *const kName;
UIKIT_EXTERN NSString *const kMimeType;
@end
