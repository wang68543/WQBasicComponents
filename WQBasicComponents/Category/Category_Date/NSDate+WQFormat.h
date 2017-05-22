//
//  NSDate+Format.h
//  WeiDa
//
//  Created by WangQiang on 2017/2/25.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WQFormat)
//TODO: 每个NSDate日期都带有时区信息
/** 根据日期NSDate后面的时区自动转换为对应当前时区的时间字符串 */
-(NSString *)formatDateWithFormat:(NSString *)format;
/**
 一年中的第几周
 
 @return %d(数字)
 */
-(NSString *)TOw;
/**
 M
 @return 第几月(数字)
 */
-(NSString *)TOM;


/** 下划线表示-  2表示汉字  3表示:   4表示斜杠/ 其余的使用日期本身的本地化 00表示空格*/
/** yyyy-MM-dd HH:mm */
-(NSString *)TOyyyy_MM_dd00HH3mm;
/** yyyy-MM-dd HH:mm:ss */
-(NSString *)TOyyyy_MM_dd00HH3mm3ss;
/** yyyy-MM-dd 00:00:00 */
-(NSString *)TOyyyy_MM_ddClear00HH3mm3ss;
/** MM月dd日 HH:mm */
-(NSString *)TOMM2dd2HH3mm;
/** yyyy-MM-dd */
-(NSString *)TOyyyy_MM_dd;
/** yyyy年MM月dd日 */
-(NSString *)TOyyyy2MM2dd2;
/** yyyy年MM月 */
-(NSString *)TOyyyy2MM2;
/** MM月dd日 */
-(NSString *)TOMM2dd2;
/** HH:mm */
-(NSString *)TOHH3mm;
/** MM/dd */
-(NSString *)TOMM4dd;

@end
