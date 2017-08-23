//
//  NSObject+PropertyRuntime.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/6/23.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "NSObject+PropertyRuntime.h"

@implementation NSObject (PropertyRuntime)
-(instancetype)wq_copyInstance{
    Class cls = [self class];
    NSObject *copyObj = [cls new];
     __weak typeof(self) weakSelf = self;
    NSArray<WQProperty *> *types =  [cls wq_properties];
    [types enumerateObjectsUsingBlock:^(WQProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WQVarType varType = obj.varType;
        NSString *key = obj.popertyName;
        id value = [weakSelf valueForKey:key];
        if(varType == WQVarCustomObject){
            [copyObj setValue:[value wq_copyInstance] forKey:key];
        }else{
            [copyObj setValue:value forKey:key];
        }

    }];
    return copyObj ;
}
//TODO: 比较两个对象的具体值
-(BOOL)isEualToInstance:(id)anInstance{
    if([self class] != [anInstance class]) return NO;
    __block BOOL isEqual = YES;
    [[[self class] wq_properties] enumerateObjectsUsingBlock:^(WQProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj.popertyName;
        id selfValue = [self valueForKey:key];
        id instanceValue = [anInstance valueForKey:key];
        if (!obj.isFromFoundation){
            isEqual = [selfValue isEualToInstance:instanceValue];
            if(!isEqual){
                *stop = !isEqual;
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
    return [self wq_ingnoreKeyValues:nil];
}


//TODO: 将模型转为字典(忽略的键)
-(NSDictionary *)wq_ingnoreKeyValues:(NSArray *)ingnoreKeys{
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
    for (WQProperty *property in [[self class] wq_properties]) {
        WQVarType varType = property.varType;
        NSString *key = property.popertyName;
        if([ingnoreKeys containsObject:key]) continue;
        id value = [self valueForKey:property.popertyName];
        if(!value){
            value = [property emptyValue];
        }
        if(varType == WQVarCustomObject){
            [keyValues setValue:[value wq_keyValues] forKey:key];
        }else{
            [keyValues setValue:value forKey:key];
        }
        
    }
    return [keyValues copy];
}
//TODO: 所有的属性名称
+ (NSArray <WQProperty *>*)wq_properties{
    return [WQProperty propertiesWithClass:[self class]];
}

//TODO: -- - 所有属性名
+ (NSArray <NSString *>*)wq_propertyNames{
    return [[self wq_properties] valueForKeyPath:@"popertyName"];
}
@end
