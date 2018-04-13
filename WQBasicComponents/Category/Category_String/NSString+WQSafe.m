//
//  NSString+WQSafe.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/5.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "NSString+WQSafe.h"

@implementation NSString (WQSafe)
- (NSString *)emptyPlaceholder:(NSString *)placeholder{
    if(self.length > 0){
        return self;
    }else{
        return placeholder;
    }
}
@end
