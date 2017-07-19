//
//  NSString+WQSize.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/5.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "NSString+WQSize.h"

@implementation NSString (WQSize)

//TODO: @brief 计算文字的高度
- (CGFloat)wq_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    return [self wq_sizeWithFont:font constrainedToWidth:width].height;
}
//TODO:  @brief 计算文字的宽度
- (CGFloat)wq_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height{
    return [self wq_sizeWithFont:font constrainedToHeight:height].width;
}
//TODO: @brief  根据文字的字体和约束的宽度计算文字的尺寸
- (CGSize)wq_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    return [self wq_sizeWithFont:font constrainedToMaxSize:CGSizeMake(width, CGFLOAT_MAX)];
}
//TODO: @brief  根据文字的字体和约束的高度计算文字的尺寸
- (CGSize)wq_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height{
    return [self wq_sizeWithFont:font constrainedToMaxSize:CGSizeMake(CGFLOAT_MAX, height)];
}
//TODO: @brief  根据文字的字体和约束的尺寸计算文字的尺寸
-(CGSize)wq_sizeWithFont:(UIFont *)font constrainedToMaxSize:(CGSize)maxSize{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    return [self wq_sizeWithAttributes:attributes constrainedToMaxSize:maxSize];
}
//TODO: @brief  根据文字的属性计算文字的尺寸
-(CGSize)wq_sizeWithAttributes:(NSDictionary *)attr constrainedToMaxSize:(CGSize)maxSize{
   CGSize  textSize = [self boundingRectWithSize:maxSize
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attr
                                  context:nil].size;
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}
//TODO: @brief  反转字符串
+ (NSString *)wq_reverseString:(NSString *)strSrc{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [strSrc length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}

@end
