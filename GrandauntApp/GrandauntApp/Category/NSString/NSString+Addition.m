//
//  NSString+Addition.m
//  AddressBook0914
//
//  Created by mac on 15/9/15.
//  Copyright (c) 2015年 mingda. All rights reserved.
//


#import "GTMBase64.h"
#import "PublicKeyEncryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Addition)

#pragma mark ~~ 动态计算宽度
- (CGFloat)wightForLabelWithTextFont: (UIFont *)textFont {
    return [self sizeWithAttributes:@{NSFontAttributeName:textFont}].width;
}

- (CGSize)wightForLabelWithTextSize: (CGFloat)textSize {
    return [self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textSize]}];
}

#pragma mark ~~ 动态计算高度
- (CGFloat)heightForLabelWithWight: (CGFloat)labWight TextSize: (CGFloat)textSize {
    CGSize size = CGSizeMake(labWight, 1000000);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *font = @{NSFontAttributeName: [UIFont systemFontOfSize:textSize],NSParagraphStyleAttributeName: style};
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:font context:nil].size.height;
}

//下划线
- (NSMutableAttributedString *)returnUnderlineAttributedStrfont: (UIFont *)font color: (UIColor *)corlor {
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName: font,NSForegroundColorAttributeName: corlor};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;
}
//中划线
- (NSMutableAttributedString *)returnStrikethroughAttributedStr {
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;
}

- (NSMutableAttributedString *)changeTextColorWithStr: (NSString *)str color: (UIColor *)corlor font: (UIFont *)font {
    if (!str) {
        str = @"";
    }
    NSRange range = [self rangeOfString:str];
    //设置颜色
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] initWithString:self];
    [resultStr addAttribute:NSForegroundColorAttributeName value:corlor range:range];
    [resultStr addAttribute:NSFontAttributeName value:font range:range];
    
    return resultStr;
}

//图片转字符串
+ (NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

//字符串转图片
+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
{
    NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:_encodedImageStr options:0];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

//sha256加密方式
+ (NSString*)sha256:(NSString *)stringpass
{
    const char *cstr = [stringpass UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:stringpass.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (int)data.length, digest);
    
    NSData *da=[[NSData alloc]initWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    
    NSData *str=[GTMBase64 encodeData:da];
    NSString *output=[[NSString alloc]initWithData:str  encoding:NSUTF8StringEncoding];
    return output;
}

+ (NSString *)getSha256String:(NSString *)srcString {
//    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    NSData *data = [srcString dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (int)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//md5加密
+ (NSString *)encryptionByMD5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString stringWithCapacity:1];
    for (int i = 0; i <  CC_MD5_DIGEST_LENGTH; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

//SHA256
+ (NSString *)getSHA512String:(NSString *)s
{
    const char *cstr = [s cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:s.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

- (NSString *)publicKeyEncryption {
    PublicKeyEncryption *pub = [[PublicKeyEncryption alloc] init];
    NSString *result = [pub RSAEncrypotoTheData:self];
    return result;
}


-(NSString *)base64EncodeString
{
    //1.先转换为二进制数据
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.对二进制数据进行base64编码,完成之后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    if ([self length] > 0) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedLabelSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    }
    
    return expectedLabelSize;
}

@end
