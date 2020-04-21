//
//  UILabel+textSize.m
//  CCBAPP
//
//  Created by ccb－apple on 17/2/13.
//  Copyright © 2017年 mingda. All rights reserved.
//

#import "UILabel+textSize.h"

@implementation UILabel (textSize)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize * kMulriple];
        }
    }
    return self;
}
@end
