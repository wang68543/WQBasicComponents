//
//  WQProperty.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/6.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WQProperty;
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
@interface WQProperty : NSObject

/** 属性名 */
@property (copy ,nonatomic,readonly) NSString *popertyName;
/** 原始类型 */
@property (copy ,nonatomic,readonly) NSString *typeCode;
/** 经过处理后的类型 */
@property (copy ,nonatomic,readonly) NSString *propertyType;
/** 对应的类型映射 */
@property (assign ,nonatomic,readonly) WQVarType varType;

/** 成员来源于哪个类（可能是父类） */
@property (nonatomic, assign) Class srcClass;
/** 属性本身所属的类 */
@property (nonatomic, assign) Class propertyClass;

/** 是否是基本数据类型 (结构体、数据类型、bool类型) */
@property (nonatomic, readonly, getter = isBasicType) BOOL basicType;

/** 类型是否来自于Foundation框架，比如NSString、NSArray */
@property (nonatomic, readonly, getter = isFromFoundation) BOOL fromFoundation;
/** 类型是否不支持KVC */
@property (nonatomic, readonly, getter = isKVCDisabled) BOOL KVCDisabled;

///** 根据当前属性判断当前值是否为空 */
//-(BOOL)isEmptyWithValue:(id)value;

/** 根据当前类型返回一个空值 */
-(id)emptyValue;


//+(instancetype)propertyWithVar:(Ivar)var;

/** 获取类的所有属性 */
+(NSArray <WQProperty *> *)propertiesWithClass:(Class)cls;


/**  判断一个类型是是否是框架的基础类 */
+ (BOOL)isClassFromFoundation:(Class)cls;

@end
