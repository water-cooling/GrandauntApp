//
//  UIButtonValid.m
//  HealthCloud
//
//  Created by lihaibo on 15/11/12.
//  Copyright © 2015年 bomei. All rights reserved.
//

#import "UIButtonValid.h"

@implementation UIButtonValid

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL res = [super pointInside:point withEvent:event];
    if (res) {
        //左侧
        if(self.type==0){
            UIBezierPath *bezierPath = UIBezierPath.bezierPath;
            [bezierPath moveToPoint:CGPointMake(0, 0)];
            [bezierPath addLineToPoint:CGPointMake(SCREENWIDTH, SCREENHEIGHT-50)];
            [bezierPath addLineToPoint:CGPointMake(0, SCREENHEIGHT-50)];
            [bezierPath addLineToPoint:CGPointMake(0, 0)];
            if ([bezierPath containsPoint:point]) {
                return YES;
            }
        }else if(self.type==1){
            //右侧
            UIBezierPath* bezierPath = UIBezierPath.bezierPath;
            [bezierPath moveToPoint:CGPointMake(0, 0)];
            [bezierPath addLineToPoint:CGPointMake(SCREENWIDTH, 0)];
            [bezierPath addLineToPoint:CGPointMake(SCREENWIDTH, SCREENHEIGHT-50)];
            [bezierPath addLineToPoint:CGPointMake(0, 0)];
            if ([bezierPath containsPoint:point]) {
                return YES;
            }
        }
        return NO;
    }
    return NO;
}

@end
