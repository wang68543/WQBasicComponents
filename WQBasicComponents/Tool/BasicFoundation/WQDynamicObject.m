//
//  WQDynamicObject.m
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
+(NSDictionary *)recursiveInDict{
    return [NSDictionary dictionary];
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

+(NSArray *)classesWithArray:(NSArray *)array recursiveInDict:(NSDictionary *)inDictModels{
    if(![array isKindOfClass:[NSArray class]] || array.count <= 0) return [NSArray array];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        WQDynamicObject *obj = [self classWithDict:dic recursiveInDict:inDictModels];
        if(obj){
            [items addObject:obj];
        }
    }
    return items;
}
+(instancetype)classWithDict:(NSDictionary *)dict recursiveInDict:(NSDictionary *)inDictModels{
    if(![dict isKindOfClass:[NSDictionary class]]){
        return [[self alloc] init];
    }else{
      return [[self alloc] initWithDict:dict recursiveInDict:inDictModels ];
    }
}


-(instancetype)initWithDict:(NSDictionary *)dict recursiveInDict:(NSDictionary *)inDictModels{
    
    if(self = [super init]){
        __weak typeof(self) weakSelf = self;
        NSArray *properties = [[self class] wq_propertyNames];
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([properties containsObject:key]){
                //TODO: - NSClassFromString(clsString),clsString 必须 有implementation
             Class modelClass = NSClassFromString([inDictModels valueForKey:key]);
                if(modelClass){
                    if([obj isKindOfClass:[NSDictionary class]]){
                        [weakSelf setValue:[modelClass classWithDict:obj] forKey:key];
                    }else if([obj isKindOfClass:[NSArray class]]){
                        [weakSelf setValue:[modelClass classesWithArray:obj] forKey:key];
                    }else{
                       [weakSelf setValue:obj forKey:key];
                    }
                }else{
                     [weakSelf setValue:obj forKey:key];
                }
            }else{
                [weakSelf setValue:obj forUndefinedKey:key];
            }
            
//            if([obj isKindOfClass:[NSDictionary class]]){
//                if([properties containsObject:key]){
//                    Class modelClass = NSClassFromString([inDictModels valueForKey:key]);
//                    if(modelClass){
//                        [weakSelf setValue:[modelClass classWithDict:obj] forKey:key];
//                    }else{
//                        [weakSelf setValue:obj forUndefinedKey:key];
//                    }
//                }else{
//                    [weakSelf setValue:obj forUndefinedKey:key];
//                }
//            }else if([obj isKindOfClass:[NSArray class]]){
//                //
//                if([properties containsObject:key]){
//                    Class modelClass = NSClassFromString([inDictModels valueForKey:key]);
//                    if(modelClass){
//                        [weakSelf setValue:[modelClass classesWithArray:obj] forKey:key];
//                    }else{
//                        [weakSelf setValue:obj forUndefinedKey:key];
//                    }
//                    
//                }else{
//                    [weakSelf setValue:obj forUndefinedKey:key];
//                }
//            }else if([properties containsObject:key] ){
//                [weakSelf setValue:obj forKey:key];
//            }else{
//                [weakSelf setValue:obj forUndefinedKey:key];
//            }
        }];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
        // 归档
    NSArray<WQProperty *> *ocEnumTypes = [[self class] wq_properties];
    [ocEnumTypes enumerateObjectsUsingBlock:^(WQProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WQVarType varType = obj.varType;
        NSString *key = obj.popertyName;
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
            case WQVarCustomObject:
                [encoder encodeObject:value forKey:key];
                break;
            case WQVarFoundationObject:
//                if ([value isKindOfClass:[NSArray class]] && [value count] > 0 && [[value firstObject] isKindOfClass:[NSDictionary class]]) {
//                    NSDictionary *modelDict = [[self class] recursiveInDict];
//                    Class modelCls = NSClassFromString([modelDict objectForKey:key]);
//                    if (modelCls) {
//                        NSMutableArray *values = [NSMutableArray array];
//                        for (NSDictionary *dic in value) {
//                           id model = [modelCls classWithDict:dic];
//                            if (model) {
//                                [values addObject:model];
//                            }
//                        }
//                        [encoder encodeObject:<#(nullable id)#> forKey:<#(nonnull NSString *)#>]
//                    } else {
//                        [encoder encodeObject:value forKey:key];
//                    }
//                } else {
                   [encoder encodeObject:value forKey:key];
//                }
                break;
            case WQVarStruct:
                //FIXME: 结构体无法encodeObject
            default://剩下的一些类型暂时不处理
                break;
        }

    }];

}

- (instancetype)initWithCoder:(NSCoder *)decoder

{
    if (self = [super init]) {
        // 归档
        NSArray<WQProperty *> *ocEnumTypes = [[self class] wq_properties];
        [ocEnumTypes enumerateObjectsUsingBlock:^(WQProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WQVarType varType = obj.varType;
            NSString *key = obj.popertyName;
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
              
                case WQVarCustomObject:
                    [self setValue:[decoder decodeObjectForKey:key] forKey:key];
                    break;
                case WQVarFoundationObject:
                {
                    id value = [decoder decodeObjectForKey:key];
                    if ([value isKindOfClass:[NSArray class]] && [value count] > 0 && [[value firstObject] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *modelDict = [[self class] recursiveInDict];
                        Class modelCls = NSClassFromString([modelDict objectForKey:key]);
                        if (modelCls) {
                            NSMutableArray *values = [NSMutableArray array];
                            for (NSDictionary *dic in value) {
                                id model = [modelCls classWithDict:dic];
                                if (model) {
                                    [values addObject:model];
                                }
                            }
                            [self setValue:[values copy] forKey:key];
                        } else {
                            [self setValue:value forKey:key];
                        }
                    }else {
                        [self setValue:value forKey:key];
                    }
                }
                    break;
                case WQVarStruct:
                    //FIXME: 结构体无法decode
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

//-(void)dealloc{
//    NSLog(@"%@", [NSString stringWithFormat:@"%@ 销毁了",NSStringFromClass([self class])]);
//}
@end
