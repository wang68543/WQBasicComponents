//
//  NSDate+WQHelp.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSDate+WQHelp.h"

@implementation NSDate (WQHelp)
//TODO: ===================日期几个基本函数的用法===================
/**
 获取一个小的单位在一个大的单位里面的序数 (比如今天在今年里面是处于第多少天)
 
 @param smaller 小单元时间
 @param larger 大单元时间
 @param date 当前日期
 @return 小单元数量
 ***
     - (NSUInteger)ordinalityOfUnit:(NSCalendarUnit)smaller inUnit:(NSCalendarUnit)larger forDate:(NSDate *)date;
 ***
 */

/**
   1、根据当前日期计算一个大单元时间最小小单元数量和最大小单元数(例如说一个月有多少天)
   2、大单元与小单元之间只能相差一级  相差多级的话 就会以小单元为准默认为小单元的上一级单元来计算
   param smaller 小单元时间
   param larger 大单元时间
   param date 当前日期
   return 最小小单元数量到最大小单元数量
 ***
    - (NSRange)rangeOfUnit:(NSCalendarUnit)smaller inUnit:(NSCalendarUnit)larger forDate:(NSDate *)date;
 ***
 */
//TODO: ===================日期End===================


static NSInteger const kUnit = NSCalendarUnitDay | NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute|NSCalendarUnitSecond | NSCalendarUnitWeekday;



- (NSCalendar *)dateCalender{
    return [NSCalendar currentCalendar];
}
//MARK: =========== 获取日期的组成部分 ===========
- (NSDateComponents *)dateComponentsWithUnits:(NSCalendarUnit)units{
    return [[self dateCalender] components:units fromDate:self];
}
-(NSDateComponents *)dateComponents{
    return [self dateComponentsWithUnits:kUnit];
}
-(NSDate *)dateFromComponents:(NSDateComponents *)components{
    return  [[self dateCalender] dateFromComponents:components];
}
//TODO:-- - 获取当前日期所在月的第一条和最后一天
-(NSArray *)getFirstAndLastOnThisMonth{
    return [self dateAtBeginAndEndWithUnit:NSCalendarUnitMonth];
}
-(NSDate *)lastYearFisrtDay{
    NSDateComponents *cmps = [self dateComponents];
    cmps.year -= 1;cmps.month = 1;cmps.day = 1;
    cmps.hour = 0;cmps.second = 10;
    return  [self dateFromComponents:cmps];
}
-(NSDate *)lastYearLastDay{
    NSDateComponents *cmps = [self dateComponents];
    cmps.year -= 1;cmps.month = 12;cmps.day = 31;
    cmps.hour = 23;cmps.minute = 59;cmps.second = 10;
    return [self dateFromComponents:cmps];
}
-(NSDate *)lastFirstMonth{
    NSDateComponents *cmps = [self dateComponents];
    cmps.month -= 1;cmps.day = 1;cmps.hour = 0;
    cmps.minute = 0;cmps.second = 10;
    return [self dateFromComponents:cmps];
}

-(NSDate *)lastLastMonth{
    NSDateComponents *cmps = [self dateComponents];
    if (cmps.month != 2) {
        cmps.day = 30;
    }else{
        cmps.day = 28;
    }
    cmps.month -= 1;
    cmps.hour = 23;cmps.minute = 59;cmps.second = 10;
    return [self dateFromComponents:cmps];
}

-(NSDate *)lastDay{
    return   [self dateByAddingTimeInterval:-kOneDayAtSeconds];
}
-(NSDate *)lastWeekFirstDay{
    NSDateComponents *cmps = [self dateComponents];
    cmps.day -= cmps.weekday;
    NSDate *returenDate = [NSDate dateWithTimeIntervalSinceNow: -cmps.hour*kOneHourAtSeconds - cmps.weekday *kOneDayAtSeconds - kOneWeekAtSeconds];
    return returenDate;
}
-(NSDate *)lastWeekLastDay{
    NSDateComponents *cmps = [self dateComponents];
    NSDate *returenDate = [NSDate dateWithTimeIntervalSinceNow: -cmps.hour*kOneHourAtSeconds - cmps.weekday *kOneDayAtSeconds];
    return returenDate;
}
/** 获取当前时间所在月份内的秒数 */
- (NSTimeInterval)timeIntervalInMonth{
    NSRange range = [[self dateCalender] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length * kOneDayAtSeconds;
}
//MARK: =========== 计算两个日期之间相隔的天数 ===========
-(NSInteger)timeIntervalDaysSinceDate:(NSDate *)otherDate{
    return (NSInteger)ceil([self timeIntervalSinceDate:otherDate]/kOneDayAtSeconds);
}
//MARK: =========== 计算两个日期之间相隔的月数 ===========
-(NSInteger)timeIntervalMonthsSinceDate:(NSDate *)otherDate{
    NSDateComponents *maxComponents = [self dateComponents];
    NSDateComponents *minComponents = [[self dateCalender] components:kUnit fromDate:otherDate];
    return (maxComponents.year - minComponents.year)*12 + (maxComponents.month - minComponents.month);
}
//MARK: =========== 计算两个日期之间相隔的年数 ===========
-(NSInteger)timeIntervalYearsSinceDate:(NSDate *)otherDate{
    NSDateComponents *maxComponents = [self dateComponents];
    NSDateComponents *minComponents = [[self dateCalender] components:kUnit fromDate:otherDate];
    return maxComponents.year - minComponents.year;
}
//TODO: -- -返回一个单元单位内的起始时间跟结束时间
-(NSArray *)dateAtBeginAndEndWithUnit:(NSCalendarUnit)unit{
    NSTimeInterval interval = 0;
    NSDate *beginDate;
    BOOL ok = [[self dateCalender] rangeOfUnit:unit startDate:&beginDate interval:&interval forDate:self];
    if (ok) {
        return @[beginDate,[beginDate dateByAddingTimeInterval:interval]];
    }else{
        return [NSArray array];
    }
}

//MARK: - -- 星期的第一天
- (NSDate *)dateAtStartOfWeek{
    return [[self dateAtBeginAndEndWithUnit:NSCalendarUnitWeekOfYear] firstObject];
}
////MARK: - --  星期的最后一天
- (NSDate *)dateAtEndOfWeek{
    return [[self dateAtBeginAndEndWithUnit:NSCalendarUnitWeekOfYear] lastObject];
}

/** 日期天的中午时刻 */
- (NSDate *)dateAtMiddleOfDay{
    NSDateComponents *components = [[self dateCalender] components:kUnit fromDate:self];
    components.hour = 12; // Thanks Aleksey Kononov
    components.minute = 0;
    components.second = 0;
    return [[self dateCalender] dateFromComponents:components];
}
/** 月份的15号的中午12点 */
- (NSDate *)dateAtMiddleOfMonth{
    NSDateComponents *components = [[self dateCalender] components:kUnit fromDate:self];
    components.day = 15;
    components.hour = 12; // Thanks Aleksey Kononov
    components.minute = 0;
    components.second = 0;
    return [[self dateCalender] dateFromComponents:components];
}
//MARK: ===========  月份的第一天 ===========
- (NSDate *)dateAtStartOfMonth{
    NSDateComponents *components = [[self dateCalender] components:kUnit fromDate:self];
    components.day = 1;
    components.hour = 0; // Thanks Aleksey Kononov
    components.minute = 0;
    components.second = 0;
    return [[self dateCalender] dateFromComponents:components];
}
//MARK: ===========  月份的最后一刻 ===========
- (NSDate *)dateAtEndOfMonth{
    return [[self dateAtStartOfMonth] dateByAddingTimeInterval:[self timeIntervalInMonth] -1];
}
//MARK: ===========  年份的第一天  ===========
- (NSDate *)dateAtStartOfYear{
    NSDateComponents *components = [[self dateCalender] components:kUnit fromDate:self];
    components.month = 1;
    components.day = 1;
    components.hour = 0; // Thanks Aleksey Kononov
    components.minute = 0;
    components.second = 0;
    return [[self dateCalender] dateFromComponents:components];
}
//MARK: ===========  年份的最后一刻 ===========
- (NSDate *)dateAtEndOfYear{
    NSDateComponents *components = [[self dateCalender] components:kUnit fromDate:self];
    components.month = 12;
    components.day = 31;
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[self dateCalender] dateFromComponents:components];
}
/**
 *  当前日期所处的周一和周日
 */
-(NSArray *)dateWeekFirstAndLast{
    return [self dateAtBeginAndEndWithUnit:NSCalendarUnitWeekOfMonth];
}
//MARK: =========== 是否是同一天  ===========
- (BOOL)isSameDayAsDate:(NSDate *)aDate{
    NSDateComponents *components1 = [[self dateCalender] components:kUnit fromDate:self];
    NSDateComponents *components2 = [[self dateCalender] components:kUnit fromDate:aDate];
    return ((components1.day == components2.day)&&(components1.month == components2.month) && (components1.year == components2.year));
}
//TODO: -- -是否在同一个半小时之内
-(BOOL)isSameHalfHourAsDate:(NSDate *)aDate{
    NSDateComponents *components1 = [[self dateCalender] components:kUnit fromDate:self];
    NSDateComponents *components2 = [[self dateCalender] components:kUnit fromDate:aDate];
    return (labs(components1.minute - components2.minute)<= 30 &&(components1.hour == components2.hour)&&(components1.day == components2.day)&&(components1.month == components2.month) && (components1.year == components2.year));
    
}
-(NSArray *)lastDateWith:(NSCalendarUnit)unit{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [self dateCalender];
    //    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:unit startDate:&beginDate interval:&interval forDate:self];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:-1];
        beginDate = [beginDate dateByAddingTimeInterval:-interval+1];
        return @[beginDate,endDate];
    }else {
        return [NSArray array];
    }
}
-(NSArray *)lastDayFirstAndLastDay{
    return [self lastDateWith:NSCalendarUnitDay];
}
-(NSArray *)lastWeekFirstAndLastDay{
    return [self lastDateWith:NSCalendarUnitWeekOfMonth];
}
-(NSArray *)lastYearFirstAndLastDay{
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:-1];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [[self dateCalender] dateByAddingComponents:adcomps toDate:self options:0];
    return [newdate dateAtBeginAndEndWithUnit:NSCalendarUnitYear];
}
-(NSArray *)dateDayFirstAndEnd{
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:-1];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [[self dateCalender] dateByAddingComponents:adcomps toDate:self options:0];
    return [newdate dateAtBeginAndEndWithUnit:NSCalendarUnitDay];
}
-(NSDate *)dateDeltByDateComponent:(NSDateComponents *)dateCom{
    return  [[self dateCalender] dateByAddingComponents:dateCom toDate:self options:0];
}
-(NSArray *)lastMonthFirstAndLastDay{
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-1];
    [adcomps setDay:0];
    NSDate *newdate = [[self dateCalender] dateByAddingComponents:adcomps toDate:self options:0];
    
    return [newdate dateAtBeginAndEndWithUnit:NSCalendarUnitMonth];
}
@end
