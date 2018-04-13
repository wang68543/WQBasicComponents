//
//  WQDynamicObject.h
//  Guardian
//
//  Created by WangQiang on 16/7/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQDynamicObject : NSObject<NSCoding>

+(instancetype)classWithDict:(NSDictionary *)dict;
+(NSArray *)classesWithArray:(NSArray *)array;



+(NSArray *)classesWithArray:(NSArray *)array recursiveInDict:(NSDictionary *)inDictModels;
/**
 模型中含有模型

 @param dict 最外层Json
 @param inDictModels 需转换成模型的(Json中的键 对应的模型的类名 )
 @return 模型
 */
+(instancetype)classWithDict:(NSDictionary *)dict recursiveInDict:(NSDictionary *)inDictModels;
/**
 *  深拷贝
 */
-(instancetype)copyItem;

/**
 对比两个对象的各个属性是否相等

 @param anItem 对比的对象
 */
-(BOOL)isEualToItem:(WQDynamicObject *)anItem;


@end
