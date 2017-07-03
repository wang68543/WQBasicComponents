//
//  NSCoderObject.m
//  Guardian
//
//  Created by WangQiang on 16/7/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "WQDynamicObject.h"
#import "NSObject+PropertyRuntime.h"
#import <objc/runtime.h>

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


-(instancetype)initWithDict:(NSDictionary *)dict classInDict:(NSDictionary *)inDictModels{
    
    if(self = [super init]){
        __weak typeof(self) weakSelf = self;
        __weak  NSArray *properties = [[self class] wq_properties];
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
                //
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

- (void)encodeWithCoder:(NSCoder *)encoder{
        // 归档
        NSDictionary *ocEnumTypes = [[self class] wq_propertyEnumTypesDic];
        [ocEnumTypes enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
            WQVarType varType = [obj integerValue];
            id value = [self valueForKey:key];
            switch (varType) {
                case WQVarBOOL:
                    [encoder encodeBool:[value boolValue] forKey:key];
                    break;
                case WQVarFloat:
                    [encoder encodeFloat:[value floatValue] forKey:key];
                    break;
                case WQVarInteger:
                    [encoder encodeInteger:[value integerValue] forKey:key];
                    break;
                case WQVarDouble:
                    [encoder encodeDouble:[value doubleValue] forKey:key];
                    break;
                case WQVarBlock:
                case WQVarID:
                case WQVarFoundationObject:
                case WQVarCustomObject:
                    [encoder encodeObject:value forKey:key];
                    break;
                case WQVarStruct:
                    //FIXME:暂时不知道结构体怎么处理
                    break;
                default://剩下的一些类型暂时不处理
                    break;
            }
        }];

}

- (instancetype)initWithCoder:(NSCoder *)decoder

{
    if (self = [super init]) {
        // 归档
        NSDictionary *ocEnumTypes = [[self class] wq_propertyEnumTypesDic];
        [ocEnumTypes enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
            WQVarType varType = [obj integerValue];
            switch (varType) {
                case WQVarBOOL:
                    [self setValue:@([decoder decodeBoolForKey:key]) forKey:key];
                    break;
                case WQVarFloat:
                    [self setValue:@([decoder decodeFloatForKey:key]) forKey:key];
                    break;
                case WQVarInteger:
                    [self setValue:@([decoder decodeIntegerForKey:key]) forKey:key];
                    break;
                case WQVarDouble:
                    [self setValue:@([decoder decodeDoubleForKey:key]) forKey:key];
                    break;
                case WQVarBlock:
                case WQVarID:
                case WQVarFoundationObject:
                case WQVarCustomObject:
                    [self setValue:[decoder decodeObjectForKey:key] forKey:key];
                    break;
                case WQVarStruct:
                    //FIXME:暂时不知道结构体怎么处理
                    break;
                default://剩下的一些类型暂时不处理
                    break;
            }
        }];
        
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
    return [self wq_copyInstance];
}
-(BOOL)isEualToItem:(WQDynamicObject *)anItem{
    return [self isEualToInstance:anItem];
}

-(void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@ 销毁了",NSStringFromClass([self class])]);
}
@end
