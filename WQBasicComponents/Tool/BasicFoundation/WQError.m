//
//  WQError.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/1/4.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQError.h"

@implementation WQError
+(instancetype)errorWithDomain:(NSErrorDomain)domain code:(NSInteger)code userInfo:(NSDictionary *)dict{
    return [super errorWithDomain:domain code:code userInfo:dict];
}
+(instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code errorInfo:(NSString *)errorMsg{
   return [self errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
}
+(instancetype)errorWithCode:(NSInteger)code errorInfo:(NSString *)errorMsg{
    return [self errorWithDomain:nil code:code errorInfo:errorMsg];
}
+(instancetype)errorWithMsg:(NSString *)msg{
    return [self errorWithCode:-5000 errorInfo:msg];
}
@end
