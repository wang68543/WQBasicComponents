//
//  UIColor+WQColor.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/5/24.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "UIColor+WQColor.h"

@implementation UIColor (WQColor)
+(instancetype)randomColor{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}
+(instancetype)textTitle1{
    return [UIColor colorWithR:12 G:12 B:13];
}
+(instancetype)textTitle2{
    return [UIColor colorWithR:86 G:86 B:89];
}
+(instancetype)textTitle3{
     return [UIColor colorWithR:157 G:160 B:166];
}
+(instancetype)textTitle4{
    return [UIColor colorWithR:195 G:197 B:204];
}
@end
