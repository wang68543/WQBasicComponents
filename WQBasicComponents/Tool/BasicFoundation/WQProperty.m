//
//  WQProperty.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/6.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "WQProperty.h"
#import <objc/runtime.h>
#import <CoreData/CoreData.h>
@interface WQProperty()
@property (assign ,nonatomic,readonly) Ivar ivar;
@end
@implementation WQProperty
//TODO: 获取类的所有属性
+(NSArray <WQProperty *> *)propertiesWithClass:(Class)cls{
    NSMutableArray<WQProperty *> *properties = [NSMutableArray array];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(cls, &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        WQProperty *property = [WQProperty propertyWithVar:ivar];
        property.srcClass = cls;
        [properties addObject:property];
    }
    free(ivars);
    Class superCls = [cls superclass];
    if(![self isClassFromFoundation: superCls]){
        [properties addObjectsFromArray:[self propertiesWithClass:superCls]];
    }
    return properties;
}

+(instancetype)propertyWithVar:(Ivar)var{
    return [[self alloc] initPropertyWithVar:var];
}
-(instancetype)initPropertyWithVar:(Ivar)var{
    if(self = [super init]){
        [self setIvar:var];
    }
    return self;
}
-(void)setIvar:(Ivar)ivar{
    _ivar = ivar;
    _popertyName = [self getVarNameWithVar:ivar];
    _typeCode = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
    _propertyType = [self getIvarPropertyType:_typeCode];
    _varType = [self getVarEnumType:_propertyType];
    if(_varType < WQVarBlock && _varType == WQVarStruct ){
        _propertyClass = nil;
        _basicType = YES;
    }else{
        _propertyClass = NSClassFromString(_propertyType);
        _basicType = NO;
    }
    
    _fromFoundation = (_varType != WQVarCustomObject);
    
}
-(id)emptyValue{
    id value = nil;
    switch (self.varType) {
        case WQVarCustomObject:
        case WQVarFoundationObject:
            if(_propertyClass == [NSNumber class]){
                //NSNumber new之后 还是空的 
                value = [NSNumber numberWithInt:0];
            }else{
               value = [_propertyClass new];
            }
            break;
        case WQVarStruct://结构体值不为空 都有值
            break;
        case WQVarBlock:
            value = @"";
            break;
        default:
            break;
    }
    return value;
}
//TODO: -- 获取变量名
-(NSString *)getVarNameWithVar:(Ivar)ivar{
    NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
    if ([ivarName hasPrefix:@"_"]) {
        ivarName = [ivarName substringFromIndex:1];
    }
    return  ivarName;
}

//TODO: -- 获取变量的原始类型
-(NSString *)getIvarPropertyType:(NSString *)typdeCode{
    NSString *varType = typdeCode;
    varType = [varType stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];    
    if(varType.length <= 0){//id类型
        varType = @"id";
    }else if([varType rangeOfString:@"{"].location !=NSNotFound){//结构体 {CGRect="origin"{CGPoint="x"d"y"d}"size"{CGSize="width"d"height"d}}
        varType = [varType stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"{}"]];
        varType = [[varType componentsSeparatedByString:@"="] firstObject];
    }else if([varType rangeOfString:@"<"].location != NSNotFound){//Student<Aprotocol> 带有协议的
        varType = [[varType componentsSeparatedByString:@"<"] firstObject];
    }
    return varType;
}

//MARK: -- 获取var变量的数据类型
- (WQVarType)getVarEnumType:(NSString *)propertyType{
    NSDictionary *enumTypeDic = [[self class] ocTypeToEnumTypeDic];
    WQVarType dataType = [[enumTypeDic objectForKey:propertyType] integerValue];
    if(dataType <= WQVarDefault){
        if([_typeCode rangeOfString:@"{"].location != NSNotFound){
            //结构体支持KVC 但是不支持NSCoding
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
                         @"NSNumber":@(WQVarFoundationObject),
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
                              [NSAttributedString class],
                              [NSNumber class], nil];
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
