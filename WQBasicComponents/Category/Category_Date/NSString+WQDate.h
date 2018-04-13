//
//  NSString+Date.h
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//  此日期分类处理的时间默认为UTC时间[即格林威治(0时区)时间]

#import <Foundation/Foundation.h>



@interface NSString (WQDate)

/**
 根据格式化格式将字符串转换为日期
 */
-(NSDate *)dateWithFormatString:(NSString *)formatString;
/**下划线表示- 2表示汉字 3表示:  4表示斜杠/ 其余的使用日期本身的本地化 00表示空格*/
/** 将豪秒时间戳转换为日期 --(0时区时间)--  */
-(NSDate *)formatMillionSecondsToDate;
/** 将秒时间戳转换为日期  --(0时区时间)-- */
-(NSDate *)formatSecondsToDate;

/** yyyyMMddHHmmss */
-(NSDate *)formatyyyyMMddHHmmssToDate;
/** yyyyMMddHHmm */
-(NSDate *)formatyyyyMMddHHmmToDate;
/** yyyyMMdd */
-(NSDate *)formatyyyyMMddToDate;
/** yyyy-MM-dd HH:mm:ss */
-(NSDate *)formatyyyy_MM_dd00HH3mm3ssToDate;
/** yyyy-MM-dd HH:mm */
-(NSDate *)formatyyyy_MM_dd00HH3mmToDate;
/** yyyy-MM-dd */
-(NSDate *)formatyyyy_MM_ddToDate;
/** HH:mm:ss */
-(NSDate *)formatHH3mm3ssToDate;

/** HH:mm */
-(NSDate *)formatHH3mmToDate;
@end
