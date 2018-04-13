//
//  NSDate+Handle.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//  此日期分类处理的时间默认为UTC时间[即格林威治(0时区)时间]

#import <Foundation/Foundation.h>

@interface NSDate (WQHandle)

/** 当前时区与零时区相差的秒数 */
+(NSTimeInterval)offsetTimeFromZeroZone;

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

//MARK: =========== 根据NSDate返回的时间戳 都是零时区时间戳(就算不是零时区也会转成零时区) ===========
/** 将日期转为毫秒时间戳 (返回的是)*/
- (long long int)millisecond;
/** 返回时间戳对象 */
-(NSNumber *)secondsAtNumber;
/** 返回字符串形式的时间戳 */
-(NSString *)secondsAtString;
@end
