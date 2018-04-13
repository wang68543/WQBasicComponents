//
//  NSString+WQSize.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/5.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WQSize)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)wq_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)wq_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)wq_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)wq_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的尺寸
 *
 *  @param font   字体(默认为系统字体)
 *  @param maxSize 约束尺寸
 */
-(CGSize)wq_sizeWithFont:(UIFont *)font constrainedToMaxSize:(CGSize)maxSize;
/**
 计算文字的尺寸
 
 @param maxSize 约束尺寸
 @param attr 文字属性
 */
-(CGSize)wq_sizeWithAttributes:(NSDictionary *)attr constrainedToMaxSize:(CGSize)maxSize;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)wq_reverseString:(NSString *)strSrc;
@end
