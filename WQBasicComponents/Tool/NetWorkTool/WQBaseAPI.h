//
//  WQBaseAPI.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^WQResponse)(NSError *error,id results);


@interface WQBaseAPI : NSObject
+(void)POST:(NSString *)url
     params:(NSDictionary *)params
   response:(WQResponse)res;

+(void)GET:(NSString *)url
    params:(NSDictionary *)params
  response:(WQResponse)res;

/** 正常的上传方式 */
+(void)uploadImage:(NSString *)url
            params:(NSDictionary *)params
             image:(UIImage *)image response:(WQResponse)res;
@end
