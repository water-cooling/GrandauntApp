//
//  NSString+Formatter.h
//  lcwr
//
//  Created by hubing on 2017/8/2.
//  Copyright © 2017年 XiTai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Formatter)

///字符串格式化Tool
-(NSString *)StringFormatterTool;

//数字的格式化
-(NSString *)StringNumberFormatter;

//数字的去格式化
-(NSString *)StringRemoverNumberFormatter;

@end
