//
//  LoginViewController.h
//  smallCourse
//
//  Created by MAC on 16/1/5.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (addition)

+ (UIColor *)randomColor;

//主色调
+ (UIColor *)appColor;//用于重要元素背景色#f4682d
//主题色颜色加深
+ (UIColor *)appTowColor;//深色 用于重要元素背景色#ef510e
//渐变色
//大板块色彩衬底#ff8401/#f4682d
+ (UIColor *)appChangeOneColor;
+ (UIColor *)appChangeTowColor;

//字体颜色
+ (UIColor *)textOneColor;//#333333
+ (UIColor *)textTowColor;//#666666
+ (UIColor *)textThreeColor;//#999999
+ (UIColor *)textFourColor;//#bcbecf

//背景色
+ (UIColor *)backGroundColor;//页面背景衬底#f3f3f3
+ (UIColor *)backGroundWriteColor;//页面背景衬底#ffffff

+ (UIColor *)lineViewColor;//分割线颜色#e6e6e6

+ (UIColor *)app1Color;//#aaaaaa
+ (UIColor *)app2Color;//#333333
+ (UIColor *)app3Color;//#666666
+ (UIColor *)app4Color;//#888888
+ (UIColor *)app5Color;//#999999
+ (UIColor *)app6Color;//#cccccc
+ (UIColor *)rensonColor;
+ (UIColor *)appGrayColor;//#808080


//
+ (UIColor *)appBtnBGColor;//#4d8af0
+ (UIColor *)appTextColor;
+ (UIColor*)appBtnBG2Color;
+ (UIColor*)appTextDarkColor;
+ (UIColor*)appTableBGColor;
+ (UIColor*)appLineBGColor;
@end
