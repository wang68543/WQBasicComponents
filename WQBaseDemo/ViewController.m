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
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"gjkf ggheyeahtty?g" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *text =  @" gjkf ggheyeahtty?g ";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor blackColor]}];
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowBlurRadius = 6;
//    shadow.shadowOffset = CGSizeMake(-3, 0);
//    shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//     [attrStr addAttributes:@{NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.4], NSBackgroundColorAttributeName: [[UIColor whiteColor]  colorWithAlphaComponent:0.8] , NSShadowAttributeName: shadow} range:NSMakeRange(0, text.length)];
    [regex enumerateMatchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result.range.location != NSNotFound) {
            NSShadow *shadow = [[NSShadow alloc] init];
            shadow.shadowBlurRadius = 6;
            shadow.shadowOffset = CGSizeMake(-3, 0);
            shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
            // 设置字体颜色和背景相同，隐藏文本本身
            [attrStr addAttributes:@{NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.4], NSBackgroundColorAttributeName: [[UIColor whiteColor]  colorWithAlphaComponent:0.8] , NSShadowAttributeName: shadow} range:result.range];
        }
    }];
//    NSString *text =  @"测试12343驱蚊器翁";
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor blackColor]}];
//    [regex enumerateMatchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        if (result.range.location != NSNotFound) {
//            NSShadow *shadow = [[NSShadow alloc] init];
//            shadow.shadowBlurRadius = 6;
//            shadow.shadowOffset = CGSizeMake(-3, 0);
//            shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//            // 设置字体颜色和背景相同，隐藏文本本身
//            [attrStr addAttributes:@{NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.4], NSBackgroundColorAttributeName: [[UIColor whiteColor]  colorWithAlphaComponent:0.8] , NSShadowAttributeName: shadow} range:result.range];
//        }
//    }];
    
    
//    SubCoderObject *oneObject = [[SubCoderObject alloc] init];
//    oneObject.rect = CGRectMake(10, 20, 30, 40);
//    oneObject.wqPoint = WQPointMake(20, 40);
    
    UILabel *label = [[UILabel alloc] init];
    label.clipsToBounds = NO;
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:@"私车公用（内测，未公开使用）" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor blackColor]}];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, @"（内测，未公开使用）".length)];
    label.attributedText = attrStr;
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
