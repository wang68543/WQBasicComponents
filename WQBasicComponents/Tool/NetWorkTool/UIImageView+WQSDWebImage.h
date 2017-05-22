//
//  UIImageView+SDWebImage.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WQSDWebImage)

/**
 设置图片

 @param url 图片路径(不含主机地址)
 @param imageName 占位图片
 */
- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName;

/**
 下载用户头像图片(含默认占位图)

 @param url 头像路径(不含主机地址)
 */
- (void)downloadHeadImage:(NSString *)url;
@end
