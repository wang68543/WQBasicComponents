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
#import "NSDate+WQHelp.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webview;
    [webview stringByEvaluatingJavaScriptFromString:@"alert"];
    
//    SubCoderObject *oneObject = [[SubCoderObject alloc] init];
//    oneObject.rect = CGRectMake(10, 20, 30, 40);
//    oneObject.wqPoint = WQPointMake(20, 40);
    
    UILabel *label = [[UILabel alloc] init];
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:@"私车公用（内测，未公开使用）" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, @"（内测，未公开使用）".length)];
    label.attributedText = attr;
    label.frame = CGRectMake(50, 100, 200, 50);
    [self.view addSubview:label];
//  
//      NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    
//    [NSKeyedArchiver archiveRootObject:oneObject toFile:[cacheDirectory stringByAppendingPathComponent:@"test"]];
//      SubCoderObject *copyObject = [NSKeyedUnarchiver unarchiveObjectWithFile:[cacheDirectory stringByAppendingPathComponent:@"test"]];
//    SubCoderObject *copyObject = [oneObject wq_copyInstance];
    
//    NSLog(@"%f===%f",copyObject.wqPoint.x,kOneMinuteAtSeconds);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
