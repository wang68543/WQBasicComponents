//
//  NSDate+WQHelp.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kOneMinuteAtSeconds  60.0
#define kOneHourAtSeconds 3600.0
#define kOneDayAtSeconds 86400
#define kOneWeekAtSeconds 604800
#define KOneYearAtSeconds 31556926
@interface NSDate (WQHelp)
/**
 返回一个起始时间跟结束时间
 
 @param unit 日期单元
 @return 数组 起始日期和结束日期组成
 */
-(NSArray *)dateAtBeginAndEndWithUnit:(NSCalendarUnit)unit;
/** 获取当前时间所在月份内的秒数 */
- (NSTimeInterval)timeIntervalInMonth;
/** 获取当前日期所在月的第一条和最后一天 */
-(NSArray *)getFirstAndLastOnThisMonth;
/** 是否在同一个半小时之内 */
-(BOOL)isSameHalfHourAsDate:(NSDate *)aDate;


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
