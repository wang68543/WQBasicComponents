//
//  WQTipTextField.m
//  WQBaseDemo
//
//  Created by WangQiang on 2017/5/23.
//  Copyright © 2017年 WQMapKit. All rights reserved.
//

#import "WQTipTextField.h"

@implementation WQTipTextField
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self commonInit];
}
-(void)commonInit{
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.textAlignment = NSTextAlignmentRight;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    UIImage *image = [UIImage imageNamed:imageName];
    if(image){
        [_leftLabel removeFromSuperview];
        _tipText = nil;
        _leftLabel.text = nil;
        
       _leftImageView.image = image;
        self.leftView = _leftImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
       self.leftView = nil;
       self.leftViewMode = UITextFieldViewModeNever;
    }
    [self layoutIfNeeded];
}
-(void)setTipText:(NSString *)tipText{
    _tipText = tipText;
    if(_tipText.length > 0){
        [_leftImageView removeFromSuperview];
        _imageName = nil;
        _leftImageView.image = nil;
        
        _leftLabel.text = _tipText;
        [self.leftView addSubview:_leftImageView];
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        self.leftView = nil;
        self.leftViewMode = UITextFieldViewModeNever;
    }
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewH = CGRectGetHeight(self.frame);
    CGFloat contentW = self.leftViewWidth;
    if(self.tipText.length > 0){
        if(contentW > 0){
//            self.
        }
    }
}
@end
