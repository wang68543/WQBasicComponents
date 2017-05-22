//
//  WQHttpTool.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQHttpTool.h"
#import "WQAppInfo.h"
#import "UIImage+WQHelp.h"

#import "AFNetworking.h"

//static NSString * kBaseUrl = @"http://120.77.174.130:8080/jingtong/appapi/appapi.htmls";
static NSString * kBaseUrl = @"";
@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 15;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
}

@end

@implementation WQHttpTool
NSString *const kFileName = @"kUploadFileName";
NSString *const kName = @"kUploadName";
NSString *const kMimeType = @"kUploadMimeType";

+(void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success?:success(task.response,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure?:failure(task.response,error);
    }];
    
}
+(void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success?:success(task.response,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure?:failure(task.response,error);
    }];
}
#pragma mark -- 图片上传
+(void)postImage:(UIImage *)image
            path:(NSString *)urlString
          params:(NSDictionary *)params
        progress:(HttpUploadProgressBlock)progress
         success:(HttpSuccessBlock)success
         failure:(HttpFailureBlock)failure{
    [self postImageData:[image compressImageToKb:100] path:urlString params:params progress:progress success:success failure:failure];
}
/**图片上传*/
+(void)postImageData:(NSData *)imageData
                path:(NSString *)urlString
              params:(NSDictionary *)params
            progress:(HttpUploadProgressBlock)progress
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure{
    NSDictionary *fileParams = @{kFileName:[WQAppInfo appUUIDWithPathExtension:@"jpg"],kName:@"uploadfile",kMimeType:@"image/jpeg"};
    [self postDataWithURL:urlString params:params fileParams:fileParams fileData:imageData progress:progress success:success failure:failure];
}
#pragma mark -- 语音上传
+(void)postAudio:(NSString *)audioPath
            path:(NSString *)urlString
          params:(NSDictionary *)params
        progress:(HttpUploadProgressBlock)progress
         success:(HttpSuccessBlock)success
         failure:(HttpFailureBlock)failure{
    [self postAudioData:[NSData dataWithContentsOfFile:audioPath] path:urlString params:params progress:progress success:success failure:failure];
}
/**语音上传*/
+(void)postAudioData:(NSData *)audioData
                path:(NSString *)urlString
              params:(NSDictionary *)params
            progress:(HttpUploadProgressBlock)progress
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure{
    NSDictionary *fileParams = @{kFileName:[WQAppInfo appUUIDWithPathExtension:@"amr"],kName:@"uploadfile",kMimeType:@"audio/mp3"};
    [self postDataWithURL:urlString params:params fileParams:fileParams fileData:audioData progress:progress success:success failure:failure];
}

#pragma mark -- -文件上传
+(void)postFileWithURL:(NSString *)urlString
                params:(NSDictionary *)params
            fileParams:(NSDictionary *)fileParams
              filePath:(NSString *)filePath
              progress:(HttpUploadProgressBlock)progress
               success:(HttpSuccessBlock)success
               failure:(HttpFailureBlock)failure{
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [self postDataWithURL:urlString params:params fileParams:fileParams fileData:data progress:progress success:success failure:failure];
}
+(void)postDataWithURL:(NSString *)urlString
                params:(NSDictionary *)params
            fileParams:(NSDictionary *)fileParams
              fileData:(NSData *)data
              progress:(HttpUploadProgressBlock)progress
               success:(HttpSuccessBlock)success
               failure:(HttpFailureBlock)failure{
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:urlString];
    NSString *fileName = [fileParams objectForKey:kFileName];
    NSString *name = [fileParams objectForKey:kName];
    NSString *mineType = [fileParams objectForKey:kMimeType];
    
    NSAssert(fileName, @"上传文件名不能为空");
    NSAssert(name, @"服务器接收字段不能为空");
    NSAssert(mineType, @"文件mineType名不能为空");
    [[AFHttpClient sharedClient] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mineType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        !success?:success(task.response, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure?:failure(task.response ,error);
        
    }];

}
+(void)downloadFileWithPath:(NSString *)path
                     params:(NSDictionary *)params
                   progress:(HttpDownloadProgressBlock)progress
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure{
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(response,error);
        } else {
            success(response,filePath.path);
        }
        
    }];
    
    [downloadTask resume];
    
}
@end
