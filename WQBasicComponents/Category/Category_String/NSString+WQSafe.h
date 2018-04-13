//
//  NSString+WQSafe.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/5.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WQSafe)

/**
 字符串为空的时候返回placeholder

 @param placeholder 占位值
 */
- (NSString *)emptyPlaceholder:(NSString *)placeholder;
@end
