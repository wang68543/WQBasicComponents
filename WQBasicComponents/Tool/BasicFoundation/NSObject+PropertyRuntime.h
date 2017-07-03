//
//  NSObject+PropertyRuntime.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/6/23.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger ,WQVarType) {
    WQVarDefault = 0,
    WQVarBOOL,
    WQVarFloat,
    WQVarInteger,
    WQVarDouble,
    WQVarBlock = 20,
    WQVarID = 30,
    WQVarFoundationObject = 40,//基础对象类型
    WQVarCustomObject = 50,//自定义对象类型
    WQVarStruct = 60,
};

@interface NSObject (PropertyRuntime)
/** 将模型转为字典 */
-(NSDictionary *)wq_keyValues;


/**
 *  深拷贝(拷贝所有的属性值)
 */
-(instancetype)wq_copyInstance;

/**
 对比两个对象的各个属性是否相等
 
 @param anInstance 对比的对象
 */
-(BOOL)isEualToInstance:(id)anInstance;

/**  所有的属性名称 */
+ (NSArray <NSString *>*)wq_properties;

/** 获取属性与原始类型的映射表 */
+ (NSDictionary <NSString *,NSString *> *)wq_propertyTypesDic;

/** 获取属性与枚举类型的映射表 */
+ (NSDictionary <NSString * , NSNumber *>*)wq_propertyEnumTypesDic;



/**  判断一个类型是是否是框架的基础类 */
+ (BOOL)isClassFromFoundation:(Class)cls;

@end
