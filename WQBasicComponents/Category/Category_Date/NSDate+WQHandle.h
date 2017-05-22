//
//  NSDate+Handle.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WQHandle)


/** 获取当前时区的时间 */
+(NSDate *)currentTimeZoneDate;
/** 修正日期为当前时区的日期 */
-(NSDate *)modifyDate;
/**
 *  当前日期所处月份的天数
 */
-(NSInteger)numberOfDays;

/** 处理成聊天时间 不做时区处理(即认为date为正确的时区时间) */
-(NSString *)handleToChatTime;
/** 根据出生日期算年龄 */
- (NSInteger)ageWithBirthday;
/** 将日期转为毫秒时间戳 */
- (long long int)millisecond;
@end
