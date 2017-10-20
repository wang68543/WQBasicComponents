//
//  NSString+WQRegxKit.h
//  WQBaseDemo
//
//  Created by hejinyin on 2017/10/20.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WQRegxKit)
/** 中国手机号码校验 */
+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum;

/** 检验密码是否是6-20位字母或数字组成的*/
+ (BOOL)checkPassword:(NSString *)pwd;
@end
