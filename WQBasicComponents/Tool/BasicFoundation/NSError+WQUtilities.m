//
//  NSError+WQInitialize.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/12.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "NSError+WQUtilities.h"

@implementation NSError (WQUtilities)
-(NSString *)errorDescription{
    return self.localizedDescription;
}
+(instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code errorInfo:(NSString *)errorMsg{
    return [self errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
}
+(instancetype)errorWithCode:(NSInteger)code errorInfo:(NSString *)errorMsg{
    return [self errorWithDomain:kDefaultLocalErrorDomain code:code errorInfo:errorMsg];
}
+(instancetype)errorWithMsg:(NSString *)msg{
    return [self errorWithCode:kDefaultErrorCode errorInfo:msg];
}
//TODO: 直接描述错误信息
//-(NSString *)description{
//
//}
@end
