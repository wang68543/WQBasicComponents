//
//  WQConstans.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/5/24.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#ifndef WQConstans_h
#define WQConstans_h
//TODO: 屏幕宽高
#define APP_WIDTH [[UIScreen mainScreen] bounds].size.width
#define APP_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define ScaleByiPhone5 (APP_HEIGHT/568.0) //以iphone5的高度来缩放比例
//TODO: 字体
#define MYFont(a) [UIFont systemFontOfSize:(a)]
#define MYFontM(a) [UIFont boldSystemFontOfSize:(a)]


//TODO: 不同型号设备尺寸宏
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone Plus屏
#define iPhone_Plus [[UIScreen mainScreen] bounds].size.width >= 414.0f && [[UIScreen mainScreen] bounds].size.height >= 736.0f

//根据设备实际尺寸进行统一分类
#define is320_WIDTH [[UIScreen mainScreen] bounds].size.width == 320.0f


//TODO: 判断当前系统的版本
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define iOS10 @available(iOS 10.0, *)
#define iOS11 @available(iOS 11.0, *)

#endif /* WQConstans_h */
