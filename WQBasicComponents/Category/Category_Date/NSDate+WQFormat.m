//
//  NSDate+Format.m
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSDate+WQFormat.h"
#import "WQDateFormater.h"
@implementation NSDate (WQFormat)

/**
 一年中的第几周
 */
-(NSString *)TOw{
    return [self formatDateWithFormat:@"w"];
}
-(NSString *)TOM{
    return [self formatDateWithFormat:@"M"];
}


// MARK:-- yyyy-MM-dd
-(NSString *)TOyyyy_MM_dd{
    return [self formatDateWithFormat:@"yyyy-MM-dd"];
}
// MARK:-- MM/dd
-(NSString *)TOMM4dd{
    return [self formatDateWithFormat:@"MM/dd"];
}
-(NSString *)TOyyyy_MM_dd00HH3mm{
    return [self formatDateWithFormat:@"yyyy-MM-dd HH:mm"];
}
//MARK: =========== yyyyMMddHHmm ===========
-(NSString *)TOyyyyMMddHHmm{
    return [self formatDateWithFormat:@"yyyyMMddHHmm"];
}
//MARK: - -- MM-dd HH:mm
-(NSString *)TOMM_dd00HH3mm{
    return [self formatDateWithFormat:@"MM-dd HH:mm"];
}
//MARK: - -- yyyy-MM-dd HH:mm:ss
-(NSString *)TOyyyy_MM_dd00HH3mm3ss{
    return [self formatDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
//// MARK:-- yyyy-MM-dd 00:00:00
//-(NSString *)TOyyyy_MM_dd0000300300{
//    return [self formatDateWithFormat:@"yyyy-MM-dd 00:00:00"];
//}
///** yyyy-MM-dd 24:00:00 */
//-(NSString *)TOyyyy_MM_dd0024300300{
//    return [self formatDateWithFormat:@"yyyy-MM-dd 24:00:00"];
//}
// MARK:-- MM月dd日HH:mm
-(NSString *)TOMM2dd2HH3mm{
    return [self formatDateWithFormat:@"MM月dd日HH:mm"];
}
// MARK:-- yyyy年MM月dd日
-(NSString *)TOyyyy2MM2dd2{
    return [self formatDateWithFormat:@"yyyy年MM月dd日"];
}
// MARK:-- yyyy年MM月
-(NSString *)TOyyyy2MM2{
    return [self formatDateWithFormat:@"yyyy年MM月"];
}
// MARK:-- yyyyMM
-(NSString *)TOyyyyMM{
    return [self formatDateWithFormat:@"yyyyMM"];
}
// MARK:-- MM月dd日
-(NSString *)TOMM2dd2{
    return [self formatDateWithFormat:@"MM月dd日"];
}
// MARK:-- MM
-(NSString *)TOMM{
    return [self formatDateWithFormat:@"MM"];
}
// MARK:-- MM月
-(NSString *)TOMM2{
    return [self formatDateWithFormat:@"MM月"];
}
// MARK:-- yyyy年 
-(NSString *)TOyyyy2{
    return [self formatDateWithFormat:@"yyyy年"];
}
// MARK:-- MM-dd
-(NSString *)TOMM_dd{
    return [self formatDateWithFormat:@"MM-dd"];
}
// MARK:-- HH:mm
-(NSString *)TOHH3mm{
    return [self formatDateWithFormat:@"HH:mm"];
}

// MARK:-- HH:mm:ss
-(NSString *)TOHH3mm3ss{
    return [self formatDateWithFormat:@"HH:mm:ss"];
}

//MARK: - -- 日期本地化
-(NSString *)TOyyyy:(NSString *)yearUnit MM:(NSString *)monthUnit dd:(NSString *)dayUnit HH:(NSString *)hourUnit mm:(NSString *)minuteUnit ss:(NSString *)secondsUnit{
    NSMutableString *formatString = [NSMutableString string];
    if (yearUnit.length > 0) {
        [formatString appendFormat:@"yyyy%@",yearUnit];
    }
    if (monthUnit.length > 0) {
        [formatString appendFormat:@"MM%@",monthUnit];
    }
    if (dayUnit.length > 0) {
        [formatString appendFormat:@"dd%@",dayUnit];
    }
    if (hourUnit.length > 0) {
        [formatString appendFormat:@"HH%@",hourUnit];
    }
    if (minuteUnit.length > 0) {
        [formatString appendFormat:@"mm%@",minuteUnit];
    }
    if (secondsUnit.length > 0) {
        [formatString appendFormat:@"ss%@",secondsUnit];
    }
    return [self formatDateWithFormat:formatString];
}
-(NSString *)formatDateWithFormat:(NSString *)format{
    [WQDateFormater manager].dateFormat = format;
    return [[WQDateFormater manager] stringFromDate:self];
}
@end
