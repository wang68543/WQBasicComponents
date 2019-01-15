//
//  NSString+WQRegxKit.h
//  WQBaseDemo
//
//  Created by hejinyin on 2017/10/20.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WQRegxKit)

/** 是否是11位纯数字 */
+ (BOOL)isChinaPhoneLengthPureInt:(NSString *)phoneNum;

/** 中国手机号码校验 */
+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum;
/**第二代居民身份证号码校验*/
+ (BOOL)validateUserCardID:(NSString *)userID;

/** 检验密码是否是6-20位字母或数字组成的*/
+ (BOOL)checkPassword:(NSString *)pwd;



/*整型验证 MODIFIED BY HUANGHAO*/
+ (BOOL)isPureInt:(NSString *)pureString;
/* 邮箱验证 **/
-(BOOL)validateEmail;

@end
