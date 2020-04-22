//
//   LoginViewController.h
//   DoctorTools
//
//   Created by haibo li on 14/10/20.
//   Copyright (c) 2014年 happycloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPhoneRightPhoneAndPwdSingleton : NSObject

+(IPhoneRightPhoneAndPwdSingleton *)sharedInstance;

// 第一个是否为数字1
+ (BOOL)isFirstIsNumOne:(NSString *)tmpString;

// 是否以空格开头
+ (BOOL)isFirstIsNullOne:(NSString *)tmpString;

// 是否以空格结尾
+(BOOL)isLastIsNullOne:(NSString *)tmpString;

// 邮箱验证
+(BOOL)isValidateEmail:(NSString *)email;

// 身份证号码验证
+(BOOL)isValidateIdCard:(NSString *)idcard;
// 验证身份证 -1 为错误 10：男 11:女
+(BOOL)chk18PaperId:(NSString *) sPaperIdParam;

// 手机号码验证
+(BOOL) isValidateMobile:(NSString *)mobile;

// 判断是否是几种组合
+ (BOOL)isRightUserPassword:(NSString *)tmpString;

// 长度等于
+ (BOOL)isLengthEqualGivenLength:(NSString *)tmpString length:(int)length;

// 长度小于
+ (BOOL)isLengthUnderGivenLength:(NSString *)tmpString length:(int)length;

// 长度超过
+ (BOOL)isLengthOverGivenLength:(NSString *)tmpString length:(int)length;

// 长度大于、大于
+ (BOOL)isLengthAllGivenLength:(NSString *)tmpString maxlength:(int)maxlength minlength:(int)minlength;

+ (BOOL)isHaveCharacter:(NSString *)tmpString;

// 是否为空
+ (BOOL)isStringNull:(NSString *)tmpString;

// 有空格
+ (BOOL)isHaveSpace:(NSString *)tmpString;

// 有中文
+ (BOOL)isHaveChinese:(NSString *)tmpString;

// 连续相同字符
+ (BOOL)isAllSameChars:(NSString *)tmpString;

// 联系递增字符
+ (BOOL)hasAllIncreaseChars:(NSString *)tmpString;

// 连续递减字符
+ (BOOL)hasAllDecreaseChars:(NSString *)tmpString;

// 是否为纯数字
+ (BOOL)isNumText:(NSString *)str;

// 有数字
+ (BOOL)isHaveNum:(NSString *)tmpString;

// 有字母
+ (BOOL)isHaveWord:(NSString *)tmpString;

+(NSString *)getIPAddress:(BOOL)isIPv4;

+ (BOOL)isValidatePass:(NSString *)password;

// 身份证
+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber;

// 银行卡
+ (BOOL) IsBankCard:(NSString *)cardNum;

+(BOOL)CheakBankCard:(NSString *)cardNumber;

@end
