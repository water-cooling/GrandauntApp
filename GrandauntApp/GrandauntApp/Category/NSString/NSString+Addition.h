//
//  NSString+Addition.h
//  AddressBook0914
//
//  Created by mac on 15/9/15.
//  Copyright (c) 2015年 mingda. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Addition)

#pragma mark ~~ 动态计算高度
- (CGFloat)heightForLabelWithWight: (CGFloat)labWight TextSize: (CGFloat)textSize;

#pragma mark ~~ 动态计算宽度
- (CGSize)wightForLabelWithTextSize: (CGFloat)textSize;
- (CGFloat)wightForLabelWithTextFont: (UIFont *)textFont;

//下划线
- (NSMutableAttributedString *)returnUnderlineAttributedStrfont: (UIFont *)font color: (UIColor *)corlor;
//中划线
- (NSMutableAttributedString *)returnStrikethroughAttributedStr;
//改变选中文字颜色和大小
- (NSMutableAttributedString *)changeTextColorWithStr: (NSString *)str color: (UIColor *)corlor font: (UIFont *)font;
//图片转字符串
+ (NSString *)UIImageToBase64Str:(UIImage *) image;
//字符串转图片
+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

//sha256加密方式
+ (NSString*)sha256:(NSString *)stringpass;

+ (NSString *)getSha256String:(NSString *)srcString;

//SHA256
+ (NSString *)getSHA512String:(NSString *)s;

//md5加密
+ (NSString *)encryptionByMD5:(NSString *)str;

//公钥加密
- (NSString *)publicKeyEncryption;


//字符串进行base64编码
-(NSString *)base64EncodeString;

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;
@end
