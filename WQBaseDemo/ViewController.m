//
//  ViewController.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/5/22.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "ViewController.h"
#import "CoderObject.h"
#import "NSObject+PropertyRuntime.h"
#import "Student.h"
#import "SubCoderObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SubCoderObject *oneObject = [[SubCoderObject alloc] init];
    oneObject.rect = CGRectMake(10, 20, 30, 40);
    oneObject.wqPoint = WQPointMake(20, 40);
    
//  
//      NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    
//    [NSKeyedArchiver archiveRootObject:oneObject toFile:[cacheDirectory stringByAppendingPathComponent:@"test"]];
//      SubCoderObject *copyObject = [NSKeyedUnarchiver unarchiveObjectWithFile:[cacheDirectory stringByAppendingPathComponent:@"test"]];
    SubCoderObject *copyObject = [oneObject wq_copyInstance];
    
    NSLog(@"%f",copyObject.wqPoint.x);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
