//
//  NSDate+WQHelp.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSDate+WQHelp.h"

@implementation NSDate (WQHelp)
static NSInteger const kUnit = NSCalendarUnitDay | NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute|NSCalendarUnitSecond | NSCalendarUnitWeekday;
- (NSCalendar *)dateCalender{
    return [NSCalendar currentCalendar];
}
-(NSDateComponents *)dateComponents{
    return [[self dateCalender] components:kUnit fromDate:self];
}
-(NSDate *)dateFromComponents:(NSDateComponents *)components{
    return  [[self dateCalender] dateFromComponents:components];
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
    return   [self dateByAddingTimeInterval:-kOneDay];
}
-(NSDate *)lastWeekFirstDay{
    NSDateComponents *cmps = [self dateComponents];
    cmps.day -= cmps.weekday;
    NSDate *returenDate = [NSDate dateWithTimeIntervalSinceNow: -cmps.hour*kOneHour - cmps.weekday *kOneDay - kOneWeek];
    return returenDate;
}
-(NSDate *)lastWeekLastDay{
    NSDateComponents *cmps = [self dateComponents];
    NSDate *returenDate = [NSDate dateWithTimeIntervalSinceNow: -cmps.hour*kOneHour - cmps.weekday *kOneDay];
    return returenDate;
}
-(NSArray *)dateBeginAndEnd:(NSDate *)myDate unit:(NSCalendarUnit)unit{
    NSDate *newDate = myDate;
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [self dateCalender];
    BOOL ok = [calendar rangeOfUnit:unit startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
        return @[beginDate,endDate];
    }else {
        return [NSArray array];
    }
}
/**
 *  当前日期所处的周一和周日
 */
-(NSArray *)dateWeekFirstAndLast{
    return [self dateWithFirstAndLast:NSCalendarUnitWeekOfMonth];
}
-(NSArray *)dateWithFirstAndLast:(NSCalendarUnit)unit{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [self dateCalender];
    //    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:unit startDate:&beginDate interval:&interval forDate:self];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
        return @[beginDate,endDate];
    }else {
        return [NSArray array];
    }
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
    return [self dateBeginAndEnd:newdate unit:NSCalendarUnitYear];
}
-(NSArray *)dateDayFirstAndEnd{
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:-1];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [[self dateCalender] dateByAddingComponents:adcomps toDate:self options:0];
    return [self dateBeginAndEnd:newdate unit:NSCalendarUnitDay];
}
-(NSDate *)dateDeltByDateComponent:(NSDateComponents *)dateCom{
    return  [[self dateCalender] dateByAddingComponents:dateCom toDate:self options:0];
}
-(NSArray *)lastMonthFirstAndLastDay{;
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-1];
    [adcomps setDay:0];
    NSDate *newdate = [[self dateCalender] dateByAddingComponents:adcomps toDate:self options:0];
    
    return [self dateBeginAndEnd:newdate unit:NSCalendarUnitMonth];
}
@end
