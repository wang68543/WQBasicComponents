//
//  NSDate+WQHelp.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSInteger const kOneMinute = 60;
static NSInteger const kOneHour = 60 * kOneMinute;
static NSInteger const kOneDay =  24 * kOneHour;
static NSInteger const kOneWeek =  7 * kOneDay;

@interface NSDate (WQHelp)

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
