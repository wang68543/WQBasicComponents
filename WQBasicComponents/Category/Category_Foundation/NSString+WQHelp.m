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

-(NSString *)md5String{
    const char *data = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5 @"XXXXXXXXXXXXXXXX"
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
    
}
@end
