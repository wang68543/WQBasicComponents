//
//  NSCoderObject.h
//  Guardian
//
//  Created by WangQiang on 16/7/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQDynamicObject : NSObject<NSCoding>

+(instancetype)classWithDict:(NSDictionary *)dict;
+(NSArray *)classesWithArray:(NSArray *)array;


/**
 模型中含有数组模型
 
 @param array         数组
 @param inArrayModels 模型中的模型对应的JSON中的键-模型的类型
 */
+(NSArray *)classesWithArray:(NSArray *)array classInArray:(NSDictionary *)inArrayModels;

+(instancetype)classWithDict:(NSDictionary *)dict classInDict:(NSDictionary *)inDictModels;

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
