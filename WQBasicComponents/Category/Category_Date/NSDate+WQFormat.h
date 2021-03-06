//
//  NSDate+Format.h
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//  此日期分类处理的时间默认为UTC时间[即格林威治(0时区)时间]

#import <Foundation/Foundation.h>

@interface NSDate (WQFormat)


/** 根据日期NSDate后面的时区自动转换为对应当前时区的时间字符串 */
-(NSString *)formatDateWithFormat:(NSString *)format;
/**
 一年中的第几周
 
 @return %d(数字)
 */
-(NSString *)TOw;
/**
 M
 @return 第几月(数字)
 */
-(NSString *)TOM;


/**
 日期本地格式化 (有单位 才有对应的日期格式化串)

 @param yearUnit 年单位
 @param monthUnit 月单位
 @param dayUnit 日单位
 @param hourUnit 小时单位
 @param minuteUnit 分钟单位
 @param secondsUnit 秒单位
 */
-(NSString *)TOyyyy:(NSString *)yearUnit MM:(NSString *)monthUnit dd:(NSString *)dayUnit HH:(NSString *)hourUnit mm:(NSString *)minuteUnit ss:(NSString *)secondsUnit;


/**  下划线表示-   2表示汉字  3表示:   4表示斜杠/ 其余的使用日期本身的本地化 00表示空格 */
/** yyyy-MM-dd HH:mm */
-(NSString *)TOyyyy_MM_dd00HH3mm;
/** yyyyMMddHHmm */
-(NSString *)TOyyyyMMddHHmm;
/** yyyy-MM-dd HH:mm:ss */
-(NSString *)TOyyyy_MM_dd00HH3mm3ss;
/** MM-dd HH:mm */
-(NSString *)TOMM_dd00HH3mm;
/** MM月dd日 HH:mm */
-(NSString *)TOMM2dd2HH3mm;
/** yyyy-MM-dd */
-(NSString *)TOyyyy_MM_dd;
/** MM-dd */
-(NSString *)TOMM_dd;
/** yyyy年MM月dd日 */
-(NSString *)TOyyyy2MM2dd2;
/** yyyy年MM月 */
-(NSString *)TOyyyy2MM2;
/** yyyyMM */
-(NSString *)TOyyyyMM;
/** MM月dd日 */
-(NSString *)TOMM2dd2;
/** MM */
-(NSString *)TOMM;
/** dd */
-(NSString *)TOdd;
/** MM月 */
-(NSString *)TOMM2;
/** yyyy年 */
-(NSString *)TOyyyy2;
/** HH:mm */
-(NSString *)TOHH3mm;
/** HH:mm:ss */
-(NSString *)TOHH3mm3ss;
/** MM/dd */
-(NSString *)TOMM4dd;
@end
