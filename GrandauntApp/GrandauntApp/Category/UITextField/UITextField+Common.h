//
//  UITextField+Common.h
//  FuelTreasureProject
//
//  Created by 吴仕海 on 4/13/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Common)

- (BOOL)commonValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;//普通字符的验证
- (BOOL)nameValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;//姓名验证
- (BOOL)passwordValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;//密码中字符的验证
- (BOOL)phoneValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;
- (BOOL)numberValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;
- (BOOL)emailValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;
- (BOOL)codeValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;
- (BOOL)commonAndPasswordValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage;
- (BOOL)commonLengthValidate:(NSString **)errorMessage prefixErrorMessage:(NSString *)prefixErrorMessage minLength:(int) minLength maxLenth:(int) maxLength;//长度验证
- (BOOL)IdcardValidate:(NSString *)value;//身份证验证

//银行卡验证
- (BOOL) IsBankCardNumber;

@end
