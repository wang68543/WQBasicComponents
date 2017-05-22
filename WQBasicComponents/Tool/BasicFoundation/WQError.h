//
//  WQError.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/1/4.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQError : NSError

+(instancetype)errorWithMsg:(NSString *)msg;
+(instancetype)errorWithCode:(NSInteger)code errorInfo:(NSString *)errorMsg;
+(instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code errorInfo:(NSString *)errorMsg;
@end
