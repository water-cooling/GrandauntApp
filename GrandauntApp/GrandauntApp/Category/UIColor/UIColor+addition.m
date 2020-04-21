//
//  LoginViewController.h
//  smallCourse
//
//  Created by MAC on 16/1/5.
//  Copyright © 2016年 MAC. All rights reserved.
//

@implementation UIColor (addition)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random()%255 / 256.0 green:arc4random()%255 /256.0 blue:arc4random()%255 / 256.0 alpha:1.0];
}

//主色调
+ (UIColor *)appColor {
    return [UIColor colorWithHexString:@"#f4682d"];
}//用于重要元素背景色#f4682d
//主题色颜色加深
+ (UIColor *)appTowColor {
    return [UIColor colorWithHexString:@"#ef510e"];
}//深色 用于重要元素背景色#ef510e


//渐变色
//大板块色彩衬底#ff8401/#f4682d
+ (UIColor *)appChangeOneColor {
    return [UIColor colorWithHexString:@"#F76B1C"];
}
+ (UIColor *)appChangeTowColor {
    return [UIColor colorWithHexString:@"#FBDA61"];
}

//字体颜色
+ (UIColor *)textOneColor {
    return [UIColor colorWithHexString:@"#333333"];
}//#333333
+ (UIColor *)textTowColor {
    return [UIColor colorWithHexString:@"#666666"];
}//#666666
+ (UIColor *)textThreeColor {
    return [UIColor colorWithHexString:@"#999999"];
}//#999999
+ (UIColor *)textFourColor {
    return [UIColor colorWithHexString:@"#bcbecf"];
}//#bcbecf

//背景色
+ (UIColor *)backGroundColor {
    return [UIColor colorWithHexString:@"#f3f3f3"];
}//页面背景衬底#f3f3f3
+ (UIColor *)backGroundWriteColor {
    return [UIColor colorWithHexString:@"#ffffff"];
}//页面背景衬底#ffffff

+ (UIColor *)lineViewColor {
    return [UIColor colorWithHexString:@"#e6e6e6"];
}//分割线颜色#e6e6e6

//赎回颜色值
+ (UIColor *)rensonColor {
    return [UIColor colorWithHexString:@"#56ae4d"];
}

+ (UIColor *)app1Color {
    return [UIColor colorWithHexString:@"#aaaaaa"];
}//#aaaaaa
+ (UIColor *)app2Color {
    return [UIColor colorWithHexString:@"#333333"];
}//#333333
+ (UIColor *)app3Color {
    return [UIColor colorWithHexString:@"#666666"];
}//#666666
+ (UIColor *)app4Color {
    return [UIColor colorWithHexString:@"#888888"];
}//#888888
+ (UIColor *)app5Color {
    return [UIColor colorWithHexString:@"#999999"];
}//#999999
+ (UIColor *)app6Color {
    return [UIColor colorWithHexString:@"#cccccc"];
}//#cccccc

+ (UIColor *)appGrayColor{
     return [UIColor colorWithHexString:@"#808080"];
}

//MBS

+ (UIColor*)appBtnBGColor{
    return [UIColor colorWithHexString:@"#508cee"];
}

+ (UIColor*)appTextColor{
    return [UIColor colorWithHexString:@"#868686"];
}

+ (UIColor*)appBtnBG2Color{
    return [UIColor colorWithHexString:@"#e6eefa"];
}

+ (UIColor*)appTextDarkColor{
    return [UIColor colorWithHexString:@"#212121"];
}

+ (UIColor*)appTableBGColor{
    return [UIColor colorWithHexString:@"#f5f6f7"];
}

+ (UIColor*)appLineBGColor{
    return [UIColor colorWithHexString:@"#999999"];
}

@end
