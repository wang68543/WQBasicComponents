//
//  NSNumber+WQFormat.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/13.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "NSNumber+WQFormat.h"

@implementation NSNumber (WQFormat)
//MARK: -- 转换为整型字符串
-(NSString *)integerString{
    return [NSString stringWithFormat:@"%ld",(long)[self integerValue]];
}
//MARK: -- 将秒时间戳转换为日期
-(NSDate *)formatSecondsToDate{
    return [NSDate dateWithTimeIntervalSince1970:[self integerValue]];
}
//MARK: =========== 将分钟转为时分 ===========
/** 将分钟转为 dd:HH:mm*/
-(NSString *)timeDuration{
    NSInteger minutes = [self integerValue];
    if (minutes <= 60) {
        return [NSString stringWithFormat:@"%zd分钟",minutes];
    }else if (minutes <= 60.0 *24.0){
        return [NSString stringWithFormat:@"%zd小时%ld分钟",minutes/60,minutes%60];
    }else{
        NSInteger day = minutes/(24*60);
        minutes = minutes%(24*60);
      return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟",day,minutes/60,minutes%60];
    }
}
//MARK: =========== 转换为当前时区的时间 ===========
//-(NSDate *)formatSecondsToLocalDate{
//   return [NSDate dateWithTimeIntervalSince1970:[self integerValue] + [[NSTimeZone systemTimeZone] secondsFromGMT]];
//}
@end
