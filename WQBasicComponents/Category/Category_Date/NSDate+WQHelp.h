//
//  NSDate+WQHelp.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//  此日期分类处理的时间默认为UTC时间[即格林威治(0时区)时间]

#import <Foundation/Foundation.h>
#define kOneMinuteAtSeconds  60.0
#define kOneHourAtSeconds 3600.0
#define kOneDayAtSeconds 86400.0
#define kOneWeekAtSeconds 604800.0
#define KOneYearAtSeconds 31556926.0
@interface NSDate (WQHelp)


/**
 根据年和第几周计算出这周的起始日期
 */
+ (NSDate *)dateAtBeginForWeek:(NSInteger)week inYear:(NSInteger)year;
/**
 返回一个起始时间跟结束时间
 
 @param unit 日期单元
 @return 数组 起始日期和结束日期组成
 */
-(NSArray *)dateAtBeginAndEndWithUnit:(NSCalendarUnit)unit;

/** 获取当前日期所在月的第一条和最后一天 */
-(NSArray *)getFirstAndLastOnThisMonth;

/** 获取日期的组成部分 */
- (NSDateComponents *)dateComponentsWithUnits:(NSCalendarUnit)units;

/** 日期天的中午时刻 */
- (NSDate *)dateAtMiddleOfDay;
/** 星期的第一天 */
- (NSDate *)dateAtStartOfWeek;
/** 星期的最后一天 */
- (NSDate *)dateAtEndOfWeek;
/** 月份的第一天 */
- (NSDate *)dateAtStartOfMonth;
/** 月份的15号的中午12点 */
- (NSDate *)dateAtMiddleOfMonth;
/** 月份的最后一天 */
- (NSDate *)dateAtEndOfMonth;
/** 年份的第一天 */
- (NSDate *)dateAtStartOfYear;
/** 年份的最后一天 */
- (NSDate *)dateAtEndOfYear;


/** 计算两个日期之间相隔的天数  */
-(NSInteger)timeIntervalDaysSinceDate:(NSDate *)otherDate;
/** 计算两个日期之间相隔的月数  */
-(NSInteger)timeIntervalMonthsSinceDate:(NSDate *)otherDate;
/** 计算两个日期之间相隔的年数  */
-(NSInteger)timeIntervalYearsSinceDate:(NSDate *)otherDate;
/** 获取当前时间所在月份内的秒数 */
- (NSTimeInterval)timeIntervalInMonth;



/** 是否是同一天 */
- (BOOL)isSameDayAsDate:(NSDate *)aDate;
/** 是否在同一个半小时之内 */
-(BOOL)isSameHalfHourAsDate:(NSDate *)aDate;




//命名不规范API 将要废弃
-(NSDate *)lastYearFisrtDay;
-(NSDate *)lastYearLastDay;
-(NSDate *)lastFirstMonth;
-(NSDate *)lastLastMonth;
-(NSDate *)lastWeekFirstDay;
-(NSDate *)lastWeekLastDay;

-(NSArray *)lastDayFirstAndLastDay;
-(NSArray *)lastWeekFirstAndLastDay;
-(NSArray *)lastMonthFirstAndLastDay;
-(NSArray *)lastYearFirstAndLastDay;
-(NSArray *)dateDayFirstAndEnd;


@end
