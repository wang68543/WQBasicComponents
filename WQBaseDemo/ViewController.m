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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[CoderObject propertyTypesDic]);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
