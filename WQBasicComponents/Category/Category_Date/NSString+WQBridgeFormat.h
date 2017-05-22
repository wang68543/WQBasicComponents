//
//  NSString+WQBridgeFormat.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/5/19.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WQBridgeFormat)
/** yyyy-MM-dd HH:mm:ss 转 yyyy-MM-dd HH:mm*/
-(NSString *)bridgeFormatyyyy_MM_dd00HH3mm3ssTOyyyy_MM_dd00HH3mm;
@end
