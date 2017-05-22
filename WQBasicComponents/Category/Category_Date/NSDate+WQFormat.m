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
// MARK:-- yyyy-MM-dd HH:mm:ss
-(NSString *)TOyyyy_MM_dd00HH3mm3ss{
    return [self formatDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
// MARK:-- yyyy-MM-dd 00:00:00
-(NSString *)TOyyyy_MM_ddClear00HH3mm3ss{
    return [self formatDateWithFormat:@"yyyy-MM-dd 00:00:00"];
}
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
// MARK:-- MM月dd日
-(NSString *)TOMM2dd2{
    return [self formatDateWithFormat:@"MM月dd日"];
}
// MARK:-- HH:mm
-(NSString *)TOHH3mm{
    return [self formatDateWithFormat:@"HH:mm"];
}
-(NSString *)formatDateWithFormat:(NSString *)format{
    [WQDateFormater manager].dateFormat = format;
    return [[WQDateFormater manager] stringFromDate:self];
}
@end
