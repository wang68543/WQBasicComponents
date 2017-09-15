//
//  WQDateFormater.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSDate 打印输出结果: 2016-12-07 03:44:24 +0000

//TODO: 每个NSDate日期必定带有时区信息并且 其时间部分表示的是零时区时间 ,所有NSDate对象都必定会有时区
// 因此 [NSDate date]  获取的是当前时间的零时区时间 加当前时区

//NSDateFormatter : NSDate——》NSString formater对象会自动转成当前时区的字符串时间
//                : NSString——》NSDate 如果NSString不含时区就默认为0时区,否则根据NSString中的时区转化

 //TODO: 从字符串转为日期的(如果字符串中不含时区 则默认会当前时区(即UTC时区)) 将会转换为零时区的日期NSDate(自动调整NSDate(零时区)与当前时区的时间差)-->NSDateFormatter 会做的事

@interface WQDateFormater : NSDateFormatter
+(instancetype)manager;
@end
