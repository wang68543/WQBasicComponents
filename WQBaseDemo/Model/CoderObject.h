//
//  CoderObject.h
//  SomeUIKit
//
//  Created by WangQiang on 2017/4/10.
//  Copyright © 2017年 WangQiang. All rights reserved.
//


#import "Student.h"
#import <UIKit/UIKit.h>
#import "WQDynamicObject.h"
typedef void(^TestBlock)(int age);
@protocol Aprotocol <NSObject>


@end
@interface CoderObject : WQDynamicObject

@property(nonatomic, copy)NSString<Aprotocol> *name ;
@property(nonatomic, assign)int score;
@property(nonatomic,assign)CGFloat cgfloat ;
@property(nonatomic, strong)NSArray *arr;
@property(nonatomic, strong)NSNumber *number;
@property(nonatomic, assign)float   afloat;
@property(nonatomic, assign)NSInteger ainteger;
@property(nonatomic, assign)NSUInteger auinteger;
@property(nonatomic, weak)id   anId;
@property(           strong)Student<Aprotocol> *stu;
@property(nonatomic, copy)TestBlock   thisBlock;
@property BOOL aBool;  //TB,V_aBool
@property char charDefault;
@property(retain)id idRetain;
@property (strong ,nonatomic) NSDictionary *dic;
@property (assign ,nonatomic) BOOL boolValue;
@property(nonatomic, assign) CGRect rect ;

@property(nonatomic, assign) CGPoint point ;

@end
