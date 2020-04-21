//
//  NSString+Trim.h
//  smallCourse
//
//  Created by MAC on 16/3/1.
//  Copyright © 2016年 明达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;
+ (NSString *)trimWhitespace:(NSString *)val;
+ (NSString *)trimNewline:(NSString *)val;
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;

@end
