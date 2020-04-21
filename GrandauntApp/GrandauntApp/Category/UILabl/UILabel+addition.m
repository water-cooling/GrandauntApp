//
//  UILabel+addition.m
//  CCBDemo
//
//  Created by ccb－apple on 17/2/12.
//  Copyright © 2017年 mingda. All rights reserved.
//

@implementation UILabel (addition)

-(void)alignTop
{
    // 对应字号的字体一行显示所占宽高
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    // 多行所占 height*line
    double height = fontSize.height*self.numberOfLines;
    // 显示范围实际宽度
    double width = self.frame.size.width;
    // 对应字号的内容实际所占范围
    CGSize stringSize = [self.text boundingRectWithSize:CGSizeMake(width, height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:nil].size;
    // 剩余空行
    NSInteger line = (height - stringSize.height) / fontSize.height;
    // 用回车补齐
    for (int i = 0; i < line; i++) {
        
        self.text = [self.text stringByAppendingString:@"\n "];
    }
}
-(void)alignBottom
{
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double height = fontSize.height*self.numberOfLines;
    double width = self.frame.size.width;
    CGSize stringSize = [self.text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    NSInteger line = (height - stringSize.height) / fontSize.height;
    // 前面补齐换行符
    for (int i = 0; i < line; i++) {
        self.text = [NSString stringWithFormat:@" \n%@", self.text];
    }
}

- (void)changeStr:(NSString *)str color:(UIColor *)color font:(UIFont *)font {
    if (!str) {
        str = @"";
    }
    if (!font) {
        font = self.font;
    }
    NSRange range = [self.text rangeOfString:str];
    //设置颜色
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    [resultStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [resultStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = resultStr;
}

- (void)changeLineSpaceWithSpace:(float)space andStr:(NSString *)str color:(UIColor *)color font:(UIFont *)font {
    if (!str) {
        str = @"";
    }
    if (!font) {
        font = self.font;
    }
    NSRange range = [self.text rangeOfString:str];
    //设置颜色
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    [resultStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [resultStr addAttribute:NSFontAttributeName value:font range:range];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [resultStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = resultStr;
    [self sizeToFit];
}

- (CGFloat)getLabWight {
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
}

- (CGFloat)myWight {
    CGFloat wight = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
    return wight;
}
    
    - (void)setMyWight:(CGFloat)myWight {
    }

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

- (void)changeLineSpaceWithSpace:(float)space {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)changeWordSpaceWithSpace:(float)space {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void) textLeftTopAlign
{
    CGRect rect = [self.text boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    self.frame = CGRectMake(self.origin.x,self.origin.y, self.width, rect.size.height);
}

@end
