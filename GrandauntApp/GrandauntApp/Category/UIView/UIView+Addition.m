//
//  UIView+Addition.m
//  smallCourse
//
//  Created by MAC on 16/3/16.
//  Copyright © 2016年 明达. All rights reserved.
//

@implementation UIView (Addition)

- (void)addBoder:(CGFloat)addWH borderColor:(UIColor *)boderColor {
    self.layer.shadowColor = boderColor.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    
    CGPoint topLeft      = CGPointMake(x - addWH, y - addWH);
    CGPoint topMiddle = CGPointMake(x + (width / 2), y - addWH);
    CGPoint topRight     = CGPointMake(x + width + addWH, y - addWH);
    
    CGPoint rightMiddle = CGPointMake(x + width + addWH ,y + (height / 2));
    
    CGPoint bottomRight  = CGPointMake(x + width + addWH, y + height + addWH);
    CGPoint bottomMiddle = CGPointMake(x + (width / 2), y + height + addWH);
    CGPoint bottomLeft   = CGPointMake(x - addWH, y + height + addWH);
    
    
    CGPoint leftMiddle = CGPointMake(x - addWH, y + (height / 2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}

- (UIView *)roundCornerWithUIRectCorner:(UIRectCorner)corner andSize:(CGSize)radii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}

+ (void)showAddLabelViewWithStr: (NSString *)message {
    if (message.length > 0) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        UIView *showview =  [[UIView alloc]init];
        showview.backgroundColor = [UIColor blackColor];
        showview.alpha = 1.0f;
        showview.layer.cornerRadius = 5.0f;
        showview.layer.masksToBounds = YES;
        [window addSubview:showview];
        CGSize LabelSize =[message sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
        showview.frame = CGRectMake(0, 0, LabelSize.width+30, LabelSize.height+20);
        showview.center = CGPointMake(window.center.x, kHeight - 100);
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(15, 10, LabelSize.width, LabelSize.height);
        label.text = message;
        label.textColor = [UIColor whiteColor];
        if (LabelSize.width > kWight - 40) {
            showview.frame = CGRectMake(0, 0, kWight - 20, LabelSize.height+20);
            showview.center = CGPointMake(window.center.x, window.center.y);
            label.adjustsFontSizeToFitWidth = YES;
            label.frame = CGRectMake(10, 5, kWight - 40, LabelSize.height);
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15];
        [showview addSubview:label];
        
        [UIView animateWithDuration:3 animations:^{
            showview.alpha = 0;
        } completion:^(BOOL finished) {
            [showview removeFromSuperview];
        }];
    }
}

+ (void)showAddUPViewWithStr: (NSString *)message {
    if (message.length > 0) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        UIView *showview =  [[UIView alloc]init];
        showview.backgroundColor = [UIColor blackColor];
        showview.alpha = 1.0f;
        showview.layer.cornerRadius = 5.0f;
        showview.layer.masksToBounds = YES;
        [window addSubview:showview];
        CGSize LabelSize =[message sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
        showview.frame = CGRectMake(0, 0, LabelSize.width+30, LabelSize.height+20);
        showview.center = CGPointMake(window.center.x, window.center.y);
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(15, 10, LabelSize.width, LabelSize.height);
        label.text = message;
        label.textColor = [UIColor whiteColor];
        if (LabelSize.width > kWight - 40) {
            showview.frame = CGRectMake(0, 0, kWight - 20, LabelSize.height+20);
            showview.center = CGPointMake(window.center.x, window.center.y);
            label.adjustsFontSizeToFitWidth = YES;
            label.frame = CGRectMake(10, 5, kWight - 40, LabelSize.height);
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:15];
        [showview addSubview:label];
        
        [UIView animateWithDuration:3 animations:^{
            showview.alpha = 0;
        } completion:^(BOOL finished) {
            [showview removeFromSuperview];
        }];
    }
}

- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }

        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
