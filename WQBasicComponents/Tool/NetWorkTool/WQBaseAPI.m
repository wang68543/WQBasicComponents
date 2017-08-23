//
//  WQBaseAPI.m
//  SomeUIKit
//
//  Created by WangQiang on 2017/3/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//

#import "WQBaseAPI.h"
#import "WQHttpTool.h"
#import "WQAppInfo.h"

@implementation WQBaseAPI
+(void)POST:(NSString *)url params:(NSDictionary *)params response:(WQResponse)res{
    
    [WQHttpTool postWithPath:url params:params success:^(NSURLResponse *reponse, id json) {
        !res?:res(nil,json);
    } failure:^(NSURLResponse *reponse, NSError *error) {
        !res?:res(error,nil);
    }];
}
+(void)GET:(NSString *)url params:(NSDictionary *)params response:(WQResponse)res{
    [WQHttpTool getWithPath:url params:params success:^(NSURLResponse *reponse, id json) {
        !res?:res(nil,json);
    } failure:^(NSURLResponse *reponse, NSError *error) {
        !res?:res(error,nil);
    }];
}

+(void)uploadImage:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image response:(WQResponse)res{
    NSDictionary *fileParams = @{kName:@"uploadFile",kFileName:[WQAppInfo appUUID_DateString],kMimeType:@"image/png"};
    [WQHttpTool postDataWithURL:url params:params fileParams:fileParams fileData:UIImagePNGRepresentation(image) progress:NULL success:^(NSURLResponse *reponse, id json) {
        !res?:res(nil,json);
    } failure:^(NSURLResponse *reponse, NSError *error) {
        !res?:res(error,nil);
    }];
}
@end
