//
//  NSObject+PropertyRuntime.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/6/23.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "NSObject+PropertyRuntime.h"
#import <objc/runtime.h>

#import <CoreData/CoreData.h>

@implementation NSObject (PropertyRuntime)
-(instancetype)wq_copyInstance{
    NSObject *obj = [[self class] new];
    NSDictionary *typesDic =  [[self class] wq_propertyEnumTypesDic];
    [typesDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        WQVarType varType = [obj integerValue];
        if(varType != WQVarStruct){
            id value = [self valueForKey:key];
            if(varType == WQVarCustomObject){
                [obj setValue:[value wq_copyInstance] forKey:key];
            }else{
                [obj setValue:value forKey:key];
            }
        }
    }];
    return obj ;
}
//TODO: 比较两个对象的具体值
-(BOOL)isEualToInstance:(id)anInstance{
    if([self class] != [anInstance class]) return NO;
    __block BOOL isEqual = YES;
   [[[self class] wq_propertyTypesDic] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
       id selfValue = [self valueForKey:key];
       id instanceValue = [anInstance valueForKey:key];
       if (![NSObject isClassFromFoundation:[selfValue class]]){
           isEqual = [selfValue isEualToInstance:instanceValue];
           if(!isEqual){
               *stop = YES;
           }
       }else {
           if([selfValue isKindOfClass:[NSString class]] ){
               isEqual = [selfValue isEqualToString:instanceValue];
               if(!isEqual){
                   *stop = YES;
               }
           }else if([selfValue isKindOfClass:[NSArray class]]){
               [selfValue enumerateObjectsUsingBlock:^(id  _Nonnull arrObj, NSUInteger idx, BOOL * _Nonnull arrStop) {
                   isEqual = [arrObj isEualToInstance:[instanceValue objectAtIndex:idx]];
                   if(!isEqual){
                       *arrStop = YES;
                   }
               }];
               if(!isEqual){
                   *stop = YES;
               }
           }else if([selfValue isKindOfClass:[NSDictionary class]]){
               [selfValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull dicKey, id  _Nonnull dicObj, BOOL * _Nonnull dicStop) {
                   isEqual = [dicObj isEualToInstance:[instanceValue objectForKey:dicKey]];
                   if(!isEqual){
                       *dicStop = YES;
                   }
               }];
               if(!isEqual){
                   *stop = YES;
               }
           }else if([selfValue isKindOfClass:[NSNumber class]]){
               if([selfValue doubleValue] != [instanceValue doubleValue]){
                   isEqual = NO;
                   *stop = YES;
               }
           }else{
               if([selfValue isEqual:instanceValue]){
                   isEqual = NO;
                   *stop = YES;
               }
           }
               
        }
   }];
    return isEqual;
}
//TODO: 将模型转为字典
-(NSDictionary *)wq_keyValues{
    NSDictionary *typesDic =  [[self class] wq_propertyEnumTypesDic];
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
    [typesDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSNumber *  _Nonnull obj, BOOL * _Nonnull stop) {
        WQVarType varType = [obj integerValue];
        if(varType != WQVarStruct){
            id value = [self valueForKey:key];
            if(varType == WQVarCustomObject){
                [keyValues setValue:[value wq_keyValues] forKey:key];
            }else{
                [keyValues setValue:value forKey:key];
            }
        }
    }];
    return [keyValues copy];
}
//TODO: 获取属性与枚举类型的映射表
+ (NSDictionary <NSString * , NSNumber *>*)wq_propertyEnumTypesDic{
    // 获取这个类, 里面, 所有的成员变量以及类型
    unsigned int outCount = 0;
    Ivar *varList = class_copyIvarList(self, &outCount);
    NSMutableDictionary *nameTypeDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = varList[i];
        // 1. 获取成员变量名称
        NSString *ivarName = getVarName(ivar);
        // 2. 获取成员变量类型
        [nameTypeDic setValue:@([self getVarEnumType:ivar]) forKey:ivarName];
    }
     free(varList);
    return [nameTypeDic copy];
}
//TODO: 获取属性与原始类型的映射表
+ (NSDictionary <NSString *,NSString *> *)wq_propertyTypesDic{
    //属性为key 类型为value
    
    // 获取这个类, 里面, 所有的成员变量以及类型
    unsigned int outCount = 0;
    Ivar *varList = class_copyIvarList(self, &outCount);
    NSMutableDictionary *nameTypeDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = varList[i];
        // 1. 获取成员变量名称
        NSString *ivarName = getVarName(ivar);
        // 2. 获取成员变量类型
        NSString *type = getVarType(ivar);
        [nameTypeDic setValue:type forKey:ivarName];
    }
     free(varList);
    return [nameTypeDic copy];
    
}
//TODO: 所有的属性名称
+ (NSArray <NSString *>*)wq_properties{
    NSMutableArray<NSString *> *properties = [NSMutableArray array];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        [properties addObject:getVarName(ivar)];
    }
    free(ivars);
    return properties;
}

//TODO: -- 获取变量名
NSString *getVarName(Ivar ivar){
    NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
     if ([ivarName hasPrefix:@"_"]) {
        ivarName = [ivarName substringFromIndex:1];
    }
    return  ivarName;
}
//TODO: -- 获取变量的原始类型
NSString *getVarType(Ivar ivar){
    NSString *varType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
    //stringByTrimmingCharactersInSet 剔除字符串中首尾的一些字符
      varType = [varType stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
    if(varType.length <= 0){//id类型
        varType = @"id";
    }else if([varType rangeOfString:@"{"].location !=NSNotFound){//结构体 {CGRect="origin"{CGPoint="x"d"y"d}"size"{CGSize="width"d"height"d}}
        varType = [varType stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"{}"]];
        varType = [[varType componentsSeparatedByString:@"="] firstObject];
    }else if([varType rangeOfString:@"<"].location != NSNotFound){//Student<Aprotocol> 带有协议的
        varType = [[varType componentsSeparatedByString:@"<"] firstObject];
    }
    return  varType;
}
//MARK: -- 获取var变量的数据类型
+(WQVarType)getVarEnumType:(Ivar)ivar{
    NSString *type = getVarType(ivar);

    NSDictionary *enumTypeDic = [self ocTypeToEnumTypeDic];
    
    WQVarType dataType = [[enumTypeDic objectForKey:type] integerValue];
    if(dataType <= WQVarDefault){
        NSString *varType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        if([varType rangeOfString:@"{"].location != NSNotFound){
            dataType = WQVarStruct;
        }else{
            dataType = WQVarCustomObject;
        }
    }
    return dataType;
}

static NSDictionary * enumTypeDic_;
//TODO: 原始类型对应的自定义枚举类型
+ (NSDictionary *)ocTypeToEnumTypeDic {
    
    //下面对应的编码值可以在官方文档里面找到
    //编码值     含意
    //c     代表char类型
    //i     代表int类型
    //s     代表short类型
    //l     代表long类型，在64位处理器上也是按照32位处理
    //q     代表long long类型
    //C     代表unsigned char类型
    //I     代表unsigned int类型
    //S     代表unsigned short类型
    //L     代表unsigned long类型
    //Q     代表unsigned long long类型
    //f     代表float类型
    //d     代表double类型
    //B     代表C++中的bool或者C99中的_Bool
    //v     代表void类型
    //*     代表char *类型
    //@     代表对象类型
    //#     代表类对象 (Class)
    //:     代表方法selector (SEL)
    //[array type]     代表array
    //{name=type…}     代表结构体
    //(name=type…)     代表union
    if(enumTypeDic_ == nil){
        enumTypeDic_ = @{
                         @"d": @(WQVarDouble), // double
                         @"f": @(WQVarFloat), // float
                         
                         @"i": @(WQVarInteger),  // int
                         @"q": @(WQVarInteger), // long
                         @"Q": @(WQVarInteger), // long long
                         @"B": @(WQVarBOOL), // bool
                         @"?": @(WQVarBlock),
                         @"id": @(WQVarID),
                         
                         @"NSURL":@(WQVarFoundationObject),
                         @"NSDate":@(WQVarFoundationObject),
                         @"NSValue":@(WQVarFoundationObject),
                         @"NSData":@(WQVarFoundationObject),
                         @"NSError":@(WQVarFoundationObject),
                         @"NSArray":@(WQVarFoundationObject),
                         @"NSMutableArray":@(WQVarFoundationObject),
                         @"NSDictionary":@(WQVarFoundationObject),
                         @"NSMutableDictionary":@(WQVarFoundationObject),
                         @"NSString":@(WQVarFoundationObject),
                         @"NSMutableString":@(WQVarFoundationObject),
                         @"NSAttributedString":@(WQVarFoundationObject),
                         @"NSMutableAttributedString":@(WQVarFoundationObject),
                         @"NSManagedObject":@(WQVarFoundationObject),
                         };
    }
    return enumTypeDic_;
    
}
static NSSet *foundationClasses_;

+ (NSSet *)foundationClasses
{
    
    
    if (foundationClasses_ == nil) {
        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSError class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}
//TODO: 判断一个类型是是否是框架的基础类
+ (BOOL)isClassFromFoundation:(Class)cls
{
    if (cls == [NSObject class] || cls == [NSManagedObject class]) return YES;
    
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([cls isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

@end
