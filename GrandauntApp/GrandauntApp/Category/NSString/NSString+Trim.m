//
//  NSString+Trim.m
//  smallCourse
//
//  Created by MAC on 16/3/1.
//  Copyright © 2016年 明达. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet {
     NSString *returnVal = @"";
     if (val) {
         returnVal = [val stringByTrimmingCharactersInSet:characterSet];
     }
     return returnVal;
 }
+ (NSString *)trimWhitespace:(NSString *)val {
     return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉前后空格
 }
+ (NSString *)trimNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]]; //去掉前后回车符
 }
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去掉前后空格和回车符
}

@end
