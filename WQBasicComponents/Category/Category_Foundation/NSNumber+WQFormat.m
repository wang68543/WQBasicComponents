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
    return [NSString stringWithFormat:@"%ld",[self integerValue]];
}
@end
