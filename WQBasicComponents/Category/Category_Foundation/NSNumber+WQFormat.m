//
//  NSNumber+WQFormat.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/13.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "NSNumber+WQFormat.h"

@implementation NSNumber (WQFormat)
//MARK: -- 转换为整型字符串
-(NSString *)integerString{
    return [NSString stringWithFormat:@"%ld",(long)[self integerValue]];
}
//MARK: -- 将秒时间戳转换为日期
-(NSDate *)formatSecondsToDate{
    return [NSDate dateWithTimeIntervalSince1970:[self integerValue]];
}
//MARK: =========== 转换为当前时区的时间 ===========
//-(NSDate *)formatSecondsToLocalDate{
//   return [NSDate dateWithTimeIntervalSince1970:[self integerValue] + [[NSTimeZone systemTimeZone] secondsFromGMT]];
//}
@end
