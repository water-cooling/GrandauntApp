//
//  UILabel+addition.h
//  CCBDemo
//
//  Created by ccb－apple on 17/2/12.
//  Copyright © 2017年 mingda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (addition)

@property (nonatomic, assign) CGFloat myWight;

- (void)changeStr:(NSString *)str color:(UIColor *)color font:(UIFont *)font;
// align top
- (void)alignTop;
// align bottom
- (void)alignBottom;

- (CGFloat)getLabWight;

- (CGSize)boundingRectWithSize:(CGSize)size;

- (void)changeLineSpaceWithSpace:(float)space andStr:(NSString *)str color:(UIColor *)color font:(UIFont *)font;

/**
 *  改变行间距
 */
- (void)changeLineSpaceWithSpace:(float)space;
/**
 *  改变字间距
 */
- (void)changeWordSpaceWithSpace:(float)space;
/**
 *  改变行间距和字间距
 */
- (void)changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

//文字自动左上角对齐
- (void) textLeftTopAlign;

@end
