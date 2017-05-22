//
//  NSString+WQBridgeFormat.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/19.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSString+WQBridgeFormat.h"
#import "NSDate+WQFormat.h"
#import "NSString+WQDate.h"


@implementation NSString (WQBridgeFormat)

-(NSString *)bridgeFormatyyyy_MM_dd00HH3mm3ssTOyyyy_MM_dd00HH3mm{
    return [self orignalFormat:@"yyyy-MM-dd HH:mm:ss" targetFormat:@"yyyy-MM-dd HH:mm"];
}
-(NSString *)orignalFormat:(NSString *)originalFormat targetFormat:(NSString *)targetFormat{
    return  [[self dateWithFormatString:originalFormat] formatDateWithFormat:targetFormat];
}
@end
