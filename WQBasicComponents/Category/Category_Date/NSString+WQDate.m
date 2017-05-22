//
//  NSString+Date.m
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSString+WQDate.h"
#import "WQDateFormater.h"

@implementation NSString (WQDate)
-(NSDate *)formatMillionSecondsToDate{
    NSString *timeSeconds = [self substringToIndex:self.length - 3];
    return [NSDate dateWithTimeIntervalSince1970:timeSeconds.floatValue];
}
//MARK: -- yyyyMMddHHmmss
-(NSDate *)formatyyyyMMddHHmmssToDate{
   return [self dateWithFormatString:@"yyyyMMddHHmmss"];
}
//MARK: -- yyyyMMddHHmm
-(NSDate *)formatyyyyMMddHHmmToDate{
    return [self dateWithFormatString:@"yyyyMMddHHmm"];
}
//MARK: -- yyyy-MM-dd HH:mm:ss
-(NSDate *)formatyyyy_MM_dd00HH3mm3ssToDate{
    return [self dateWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
}
//MARK: -- yyyy-MM-dd HH:mm
-(NSDate *)formatyyyy_MM_dd00HH3mmToDate{
    return [self dateWithFormatString:@"yyyy-MM-dd HH:mm"];
}
//MARK: -- yyyy-MM-dd
-(NSDate *)formatyyyy_MM_ddToDate{
    return [self dateWithFormatString:@"yyyy-MM-dd"];
}

//MARK: --  HH:mm
-(NSDate *)formatHH3mmToDate{
    return [self dateWithFormatString:@"HH:mm"];
}
-(NSDate *)dateWithFormatString:(NSString *)formatString{
    //频繁创建 NSDateFormatter 比较好性能
    //    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    if(formatString.length > self.length) return [NSDate date];
    [WQDateFormater manager].dateFormat = formatString;
    return  [[WQDateFormater manager] dateFromString:self];
}
@end
