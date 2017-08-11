//
//  NSObject+PropertyRuntime.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/6/23.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQProperty.h"

@interface NSObject (PropertyRuntime)
/** 将模型转为字典 */
-(NSDictionary *)wq_keyValues;
/**
 将模型转为字典
 @param ingnoreKeys 忽略的键
 */
-(NSDictionary *)wq_ingnoreKeyValues:(NSArray *)ingnoreKeys;
/**
 *  深拷贝(拷贝所有的属性值)
 */
-(instancetype)wq_copyInstance;

/**
 对比两个对象的各个属性是否相等
 
 @param anInstance 对比的对象
 */
-(BOOL)isEualToInstance:(id)anInstance;

/**  所有的属性 */
+ (NSArray <WQProperty *>*)wq_properties;

/** 所有属性名 */
+ (NSArray <NSString *>*)wq_propertyNames;
@end
