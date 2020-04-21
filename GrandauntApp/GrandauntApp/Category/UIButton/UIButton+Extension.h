//
//  UIButton+Extension.h
//  OneCommunity
//
//  Created by lihaibo on 16/1/21.
//  Copyright © 2016年 OneCommunity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

//创建一个按钮,传入按钮的标题，标题颜色，字体，对齐方式，位置，背景颜色，位置，点击状态
+ (UIButton *)buttonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont image:(UIImage *)image backgroundImage:(UIImage *)image bgColor:(UIColor *)bgColor rect:(CGRect)rect state:(UIControlState)state target:(id)target action:(SEL)action;

@end
