//
//  NSString+Help.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/2.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (WQHash)
/** 89423e98 */
/** DES加密 */
-(NSString *)encryptUseDESInkey:(NSString *)key;
/** DES解密 */
- (NSString *)decryptUseDESInkey:(NSString*)key;
/** md5加密 */
-(NSString *)md5String;

@end
