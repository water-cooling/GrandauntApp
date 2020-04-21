//
//  UIImage+Stretch.m
//  OneCommunity
//
//  Created by hubing on 16/2/16.
//  Copyright © 2016年 OneCommunity. All rights reserved.
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)


+(UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage * image = [UIImage imageNamed:name];
    
    CGFloat top = 5; // 顶端盖高度
    CGFloat bottom = 5; // 底端盖高度
    CGFloat left = 20; // 左端盖宽度
    CGFloat right = 20; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}
@end
