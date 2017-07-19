//
//  SubCoderObject.h
//  WQBaseDemo
//
//  Created by WangQiang on 2017/7/12.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "CoderObject.h"
struct WQPoint {
    CGFloat x;
    CGFloat y;
};
typedef struct WQPoint WQPoint;

CG_INLINE WQPoint
WQPointMake(CGFloat x, CGFloat y)
{
    WQPoint point;
    point.x = x; point.y = y;
    return point;
}


@interface SubCoderObject : CoderObject

@property (copy ,nonatomic) NSString *subid;

@property (copy ,nonatomic) NSString *subItem;

@property (assign ,nonatomic) WQPoint wqPoint;
@end
