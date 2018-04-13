//
//  NSDate+Handle.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSDate+WQHandle.h"
#import "NSDate+WQFormat.h"
#import "NSDate+Utilities.h"

@implementation NSDate (WQHandle)
+(NSDate *)currentTimeZoneDate{
    return [[NSDate date] modifyDate];
}
//MARK: =========== 当前时区与零时区相差的秒数 ===========
+(NSTimeInterval)offsetTimeFromZeroZone{
    return [[NSTimeZone systemTimeZone] secondsFromGMT];
}
-(NSDate *)modifyDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *localeDate = [self dateByAddingTimeInterval: interval];
    return localeDate;
}
-(NSInteger)numberOfDays{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}
-(NSString *)handleToChatTime{
    NSString *formatTime = @"";
    if(self.isThisYear){
        if(self.isThisMonth){
            if(self.isToday){
//               formatTime = [NSString stringWithFormat:@"今天 %@",self.TOHH3mm];
                formatTime = self.TOHH3mm;
            }else{
                formatTime = self.TOMM_dd00HH3mm;
            }
        }else{
           formatTime = self.TOMM_dd;
        }
    }else{
        formatTime = self.TOyyyy_MM_dd;
        
    }
    return formatTime;
}

-(NSInteger)ageWithBirthday{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}
//MARK: -- 将日期转为毫秒时间戳
- (long long int)millisecond{
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    long long int milliTime = timeInterval *1000;
    return milliTime;
}
//TODO: 返回时间戳对象
-(NSNumber *)secondsAtNumber{
    return [NSNumber numberWithUnsignedLong:[self timeIntervalSince1970]];
}
//TODO: 返回字符串形式的时间戳
-(NSString *)secondsAtString{
     return [NSString stringWithFormat:@"%.0f",self.timeIntervalSince1970];
}

@end
