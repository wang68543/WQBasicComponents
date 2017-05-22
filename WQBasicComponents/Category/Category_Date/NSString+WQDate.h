//
//  NSString+Date.h
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WQDate)

/**
 根据格式化格式将字符串转换为日期
 */
-(NSDate *)dateWithFormatString:(NSString *)formatString;
 //TODO: 从字符串转为日期的(如果字符串中不含时区 则默认会当前时区) 将会转换为零时区的日期NSDate(自动调整NSDate(零时区)与当前时区的时间差)-->NSDateFormatter 会做的事
/**下划线表示- 2表示汉字 3表示:  4表示斜杠/ 其余的使用日期本身的本地化 00表示空格*/
-(NSDate *)formatMillionSecondsToDate;
/** yyyyMMddHHmmss */
-(NSDate *)formatyyyyMMddHHmmssToDate;
/** yyyyMMddHHmm */
-(NSDate *)formatyyyyMMddHHmmToDate;
/** yyyy-MM-dd HH:mm:ss */
-(NSDate *)formatyyyy_MM_dd00HH3mm3ssToDate;
/** yyyy-MM-dd HH:mm */
-(NSDate *)formatyyyy_MM_dd00HH3mmToDate;
/** yyyy-MM-dd */
-(NSDate *)formatyyyy_MM_ddToDate;
/** HH:mm */
-(NSDate *)formatHH3mmToDate;
@end
