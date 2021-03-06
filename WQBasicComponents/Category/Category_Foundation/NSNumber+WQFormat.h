//
//  NSNumber+WQFormat.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/13.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (WQFormat)
/** 转换为整型字符串 */
-(NSString *)integerString;

/** 将秒时间戳转换为日期 (0时区的时间)*/
-(NSDate *)formatSecondsToDate;

/** 将分钟转为 dd:HH:mm*/
-(NSString *)timeDuration;
@end
