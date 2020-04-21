//
//  UIButton+EnLargeClickArea.m
//  YLTX
//
//  Created by 耿洋洋 on 2018/3/21.
//  Copyright © 2018年 huangpf. All rights reserved.
//

#import "UIButton+EnLargeClickArea.h"

@implementation UIButton (EnLargeClickArea)
static char topNameKey;
static char leftNameKey;
static char bottomNameKey;
static char rightNameKey;

-(void)setEnlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGRect)enlargeRect{
    NSNumber *top = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *left = objc_getAssociatedObject(self, &leftNameKey);
    NSNumber *bottom = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *right = objc_getAssociatedObject(self, &rightNameKey);
    
    if(top && left && bottom && right){
        return CGRectMake(self.bounds.origin.x - left.floatValue, self.bounds.origin.y - top.floatValue, self.bounds.size.width + left.floatValue + right.floatValue, self.bounds.size.height + top.floatValue + bottom.floatValue);
    }else{
        return self.bounds;
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargeRect];
    if(CGRectEqualToRect(rect, self.bounds)){
        return [super hitTest:point withEvent:event];
    }else{
        return CGRectContainsPoint(rect, point) ? self:nil;
    }
}

@end
