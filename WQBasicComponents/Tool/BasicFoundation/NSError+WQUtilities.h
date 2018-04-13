//
//  NSError+WQInitialize.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/12.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger const kDefaultErrorCode = -5000;//默认的错误码
static NSString *const kDefaultLocalErrorDomain = @"LocalErrorDomain";//本地错误域
@interface NSError (WQUtilities)
-(NSString *)errorDescription;

+(instancetype)errorWithMsg:(NSString *)msg;
+(instancetype)errorWithCode:(NSInteger)code errorInfo:(NSString *)errorMsg;
+(instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code errorInfo:(NSString *)errorMsg;
@end
