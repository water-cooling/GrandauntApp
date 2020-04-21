//
//  UIView+Addition.h
//  smallCourse
//
//  Created by MAC on 16/3/16.
//  Copyright © 2016年 明达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

- (void)addBoder:(CGFloat)addWH borderColor:(UIColor *)boderColor;

+ (void)showAddLabelViewWithStr: (NSString *)message;

+ (void)showAddUPViewWithStr: (NSString *)message;

- (UIView *)roundCornerWithUIRectCorner:(UIRectCorner)corner andSize:(CGSize)radii;

- (UIView*)subViewOfClassName:(NSString*)className;

- (UIViewController*)viewController;
@end
