//
//  NSString+Help.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "NSString+WQHelp.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (WQHelp)
-(CGSize)sizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",    // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5 @"XXXXXXXXXXXXXXXX"
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
