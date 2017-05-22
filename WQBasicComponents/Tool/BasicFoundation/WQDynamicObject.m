//
//  NSCoderObject.m
//  Guardian
//
//  Created by WangQiang on 16/7/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQDynamicObject.h"
#import <objc/runtime.h>


typedef NS_ENUM(NSInteger ,VarDataType) {
    VarDataTypeBasic,
    VarDataTypeBOOL,
    VarDataTypeInt,
    VarDataTypeFloat,
    VarDataTypeInteger,
    VarDataTypeDouble,
    VarDataTypeObject,
    VarDataTypeCustomObject,
    VarDataTypeBlock,
    VarDataTypeId,
    VarDataTypeStruct,
};
@implementation WQDynamicObject
-(instancetype)initSelfWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)classWithDict:(NSDictionary *)dict{
    if(![dict isKindOfClass:[NSDictionary class]]) return nil;
    return [[self alloc] initSelfWithDict:dict];
}

+(NSArray *)classesWithArray:(NSArray *)array{
    if(![array isKindOfClass:[NSArray class]] || array.count <= 0) return [NSArray array];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        WQDynamicObject *obj = [self classWithDict:dic];
        if(obj){
            [items addObject:obj];
        }
    }
    return [items copy];
}

+(NSArray *)classesWithArray:(NSArray *)array classInArray:(NSDictionary *)inArrayModels{
    if(![array isKindOfClass:[NSArray class]]) return [NSArray array];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        WQDynamicObject *obj = [self classWithDict:dic classInDict:inArrayModels];
        if(obj){
            [items addObject:obj];
        }
    }
    return items;
}
+(instancetype)classWithDict:(NSDictionary *)dict classInDict:(NSDictionary *)inDictModels{
    if([dict isKindOfClass:[NSDictionary class]]){
        return [[self alloc] init];
    }else{
      return [[self alloc] initWithDict:dict classInDict:inDictModels];
    }
    
}
-(NSArray <NSString *>*)properties{
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

-(instancetype)initWithDict:(NSDictionary *)dict classInDict:(NSDictionary *)inDictModels{
    
    if(self = [super init]){
        __weak typeof(self) weakSelf = self;
        __weak  NSArray *properties = [self properties];
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[NSDictionary class]]){
                if([properties containsObject:key]){
                    Class modelClass = NSClassFromString([inDictModels valueForKey:key]);
                    if(modelClass){
                        [weakSelf setValue:[modelClass classWithDict:obj] forKey:key];
                    }else{
                        [weakSelf setValue:obj forUndefinedKey:key];
                    }
                }else{
                    [weakSelf setValue:obj forUndefinedKey:key];
                }
            }else if([obj isKindOfClass:[NSArray class]]){
                if([properties containsObject:key]){
                    Class modelClass = NSClassFromString([inDictModels valueForKey:key]);
                    if(modelClass){
                        [weakSelf setValue:[modelClass classesWithArray:obj] forKey:key];
                    }else{
                        [weakSelf setValue:obj forUndefinedKey:key];
                    }
                    
                }else{
                    [weakSelf setValue:obj forUndefinedKey:key];
                }
            }else if([properties containsObject:key] ){
                [weakSelf setValue:obj forKey:key];
            }else{
                [weakSelf setValue:obj forUndefinedKey:key];
            }
        }];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder

{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 归档
        NSString *key = getVarName(ivar);
        id value = [self valueForKey:key];
        switch (getVarDataType(ivar)) {
            case VarDataTypeObject:
                [encoder encodeObject:value forKey:key];
                break;
            case VarDataTypeBOOL:
                [encoder encodeBool:value forKey:key];
                break;
            case VarDataTypeInteger:
                [encoder encodeInteger:(NSInteger)value forKey:key];
                break;
                //TODO:不支持id转Float和Double
            case VarDataTypeFloat:
            case VarDataTypeDouble:
            case VarDataTypeInt:
                [encoder encodeInt:(int)value forKey:key];
                break;
            case VarDataTypeStruct:
                //FIXME:暂时不知道结构体怎么处理
                break;
            default://剩下的一些类型暂时不处理
                
                break;
        }
    }
    
    free(ivars);
    
    
}

- (instancetype)initWithCoder:(NSCoder *)decoder

{
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self  class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 归档
            NSString *key = getVarName(ivar);
            switch (getVarDataType(ivar)) {
                case VarDataTypeObject:
                    [self setValue:[decoder decodeObjectForKey:key] forKey:key];
                    break;
                case VarDataTypeBOOL:
                    [self setValue:@([decoder decodeBoolForKey:key]) forKey:key];
                    break;
                case VarDataTypeInteger:
                    [self setValue:@([decoder decodeIntegerForKey:key]) forKey:key];
                    break;
                case VarDataTypeFloat:
                case VarDataTypeDouble:
                case VarDataTypeInt:
                    [self setValue:@([decoder decodeIntForKey:key]) forKeyPath:key];
                    break;
                case VarDataTypeStruct:
                    //FIXME:暂时不知道结构体怎么处理
                    break;
                default://剩下的一些类型暂时不处理
                    
                    break;
            }
        }
        free(ivars);
        
    }
    return self;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//防止出错
//    if([key isEqualToString:@"id"]){
//        
//    }
}

-(instancetype)copyItem{
    
    WQDynamicObject *obj = [[[self class] alloc] init];
    unsigned int count = 0;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *property = [NSString stringWithUTF8String:propertyName];
        [obj setValue:[self valueForKey:property] forKey:property];
    }
    return obj ;
}

//MARK: -- 获取变量名
NSString *getVarName(Ivar ivar){
    return  [NSString stringWithUTF8String:ivar_getName(ivar)];
}
//MARK: -- 获取变量的原始类型
NSString *getVarType(Ivar ivar){
   return  [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
}
//MARK: -- 获取var变量的数据类型
VarDataType getVarDataType(Ivar ivar){
    NSString *type = getVarType(ivar);
    
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
    
    VarDataType dataType ;
    if([type hasPrefix:@"@"]){
        NSArray *array = [type componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\"\""]];
        if(array.count == 1){
            if([type isEqualToString:@"@"]){//@ id类型
                dataType = VarDataTypeId;
            }else{//@? 表示是一个Block类型
                dataType = VarDataTypeBlock;
            }
        }else if(array.count >= 2){
            //区分有协议的类型 @"NSString<Aprotocol>"
           NSString *typeStr = [[array[1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] firstObject];
            if([typeStr hasPrefix:@"NS"]){
                dataType = VarDataTypeObject;
            }else{//前面没有NS的都是自定义对象类型
                 dataType = VarDataTypeCustomObject;
            }
        }
         dataType = VarDataTypeObject;
       
    }else if([type rangeOfString:@"{"].location != NSNotFound){
        dataType = VarDataTypeStruct;
    }else{
        if([type isEqualToString:@"B"]){//BOOL类型
            dataType = VarDataTypeBOOL;
        }else if([type compare:@"i"] == NSOrderedSame){
            dataType = VarDataTypeInt;
        }else if([type compare:@"f"] == NSOrderedSame){
            dataType = VarDataTypeFloat;
        }else if([type compare:@"d"] == NSOrderedSame){
            dataType = VarDataTypeDouble;
        }else if([type compare:@"q" options:NSCaseInsensitiveSearch] == NSOrderedSame){
            dataType = VarDataTypeInteger;
        }else{
            dataType = VarDataTypeBasic;
        }
    }
    return dataType;
}
//MARK: -- 获取变量的具体数据类型
NSString *getVarTypeStr(Ivar ivar){
    NSString *type = getVarType(ivar);
    NSString *typeStr;
    VarDataType dataType = getVarDataType(ivar);
    if(dataType == VarDataTypeBlock){
        typeStr = @"block";
    }else if(dataType == VarDataTypeId){
        typeStr = @"id";
    }else if(dataType == VarDataTypeObject || dataType == VarDataTypeCustomObject){//对象类型
        NSArray *array = [type componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\"\""]];
        if(array.count >= 2){
            //区分有协议的类型 @"NSString<Aprotocol>"
            typeStr = [[array[1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] firstObject];
        }
    }else if(dataType == VarDataTypeStruct){//结构体类型
        typeStr = [[[type componentsSeparatedByString:@"="] firstObject] substringFromIndex:1];
    }else if(dataType == VarDataTypeBOOL){
        typeStr = @"BOOL";
    }else if(dataType == VarDataTypeInt){
        typeStr = @"int";
    }else if(dataType == VarDataTypeFloat){
        typeStr = @"float";
    }else if(dataType == VarDataTypeDouble){
        typeStr = @"double";
    }else if(dataType == VarDataTypeInteger){
        if([type isEqualToString:@"q"]){
            typeStr = @"NSInteger";
        }else if([type isEqualToString:@"Q"]){
            typeStr = @"NSUInteger";
        }
    }else{//基本类型
       if([type isEqualToString:@"c"]){
            typeStr = @"char";
        }
    }
    return typeStr;
}
-(BOOL)isEualToItem:(WQDynamicObject *)anItem{
    if([NSStringFromClass([self class]) isEqualToString:NSStringFromClass([anItem class])]){
        __block BOOL isEqual = YES;
        [[self properties] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id value = [self valueForKey:obj];
            id anValue = [anItem valueForKey:obj];
            NSLog(@"%@====%@",value,anValue);
            if([value isKindOfClass:[NSObject class]]){
                if([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSValue class]]){
                    if([value doubleValue] != [anValue doubleValue]){
                        isEqual = NO;
                        *stop = YES;
                    }
                }else if([value isKindOfClass:[NSString class]]){
                    if(![value isEqualToString:anValue]){
                        isEqual = NO;
                        *stop = YES;
                    }
                }else if([value isKindOfClass:[WQDynamicObject class]]){
                    if(![value isEualToItem:anValue]){
                        isEqual = NO;
                        *stop = YES;
                    }
                }else{//非当前对象 默认为相等
//                    if(![value isEqual:anValue]){
//                        isEqual = NO;
//                        *stop = YES;
//                    }
                }
            }else{
                if(value != anValue){
                    isEqual = NO;
                    *stop = YES;
                }
            }
        }];
        return isEqual;
    }else{
        return NO;
    }
}

-(void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@ 销毁了",NSStringFromClass([self class])]);
}
@end
