//
//  NSString+Formatter.m
//  lcwr
//
//  Created by hubing on 2017/8/2.
//  Copyright © 2017年 XiTai. All rights reserved.
//

@implementation NSString (Formatter)

//字符串格式化Tool
-(NSString *)StringFormatterTool
{
    NSString * tempStr = self;
    if (tempStr.length > 0) {
        if ([[tempStr substringFromIndex:tempStr.length-1] isEqualToString:@"元"] && [[tempStr substringToIndex:tempStr.length-1] doubleValue] > 1) {
            tempStr = [tempStr substringToIndex:tempStr.length-1];
            tempStr = [tempStr StringNumberFormatter];
            tempStr = [tempStr stringByAppendingFormat:@"元"];
        }
    }
    return tempStr;
}

//数字的格式化(并保留小数)
-(NSString *)StringNumberFormatter
{
    NSString * returnStr = self;
    if ([returnStr doubleValue] > 1 &&[returnStr rangeOfString:@","].location ==NSNotFound) {
        NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
        [formatter setPositiveFormat:@",###.00;"];
        returnStr = [formatter stringFromNumber:[NSNumber numberWithDouble:[returnStr doubleValue]]];
    }
    return returnStr;
}

//数字的去格式化
-(NSString *)StringRemoverNumberFormatter
{
    return [self stringByReplacingOccurrencesOfString:@"," withString:@""];
}

@end
