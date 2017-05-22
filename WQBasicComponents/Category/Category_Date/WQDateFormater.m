//
//  WQDateFormater.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQDateFormater.h"

@implementation WQDateFormater
+(instancetype)manager{
    static WQDateFormater *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WQDateFormater alloc] init];
    });
    return _instance;
}
@end
