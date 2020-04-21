//
//  NSString.m
//  HealthCloud
//
//  Created by lihaibo on 15/10/26.
//  Copyright © 2015年 bomei. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#define kOSSIMAGEBASEFILEURL                 [NSString stringWithFormat:@"http://%@.%@/",kOSSBULKETKEY,kOSSDOMAINURL]

@implementation NSString (Common)

- (BOOL)isContainedChinese{
    NSUInteger length = self.length;
    for (int i=0; i<length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char    *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isPureFloat{
    if ([self containsString:@"."]) {
        return YES;
    }
    return NO;

}

- (UIImage*)generateQRCodeImage
{
    // 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜默认属性，因为滤镜有可能保存了上一次的属性
    [filter setDefaults];
    // 将字符串转换成NSData
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    // 设置滤镜,传入Data，
    [filter setValue:data forKey:@"inputMessage"];
    // 生成二维码
    CIImage *qrCode = [filter outputImage];
    return [UIImage imageWithCIImage:qrCode];
}

-(NSString *)stringValue {
    return (self && !([self isKindOfClass:NSNull.class] || [self isEqual:[NSNull null]])) ?self:@"";
}

- (NSString *)md5{

    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  [output uppercaseString];
}

- (id)parseToArrayOrNSDictionary{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}

- (NSDate *)dateFromStringFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:format];
    NSDate *date= [dateFormatter dateFromString:self];
    return date;
}

- (NSDate *)dateFromSecondString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *date= [dateFormatter dateFromString:self];
    return date;
}

- (NSDate *)dateFromFullString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
    NSDate *date= [dateFormatter dateFromString:self];
    return date;
}

- (NSDate *)dateFromShortString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *date= [dateFormatter dateFromString:self];
    return date;
}

- (NSString *)validLength {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *) ossDateFormat {
    NSArray *aArray = [self componentsSeparatedByString:@"/"];
    
    return aArray[1];
}

//数据验证部分
- (NSString *)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimAllSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)whiteSpceText{
    NSInteger index = self.length / 4;
    if (self.length % 4 == 0) {
        index--;
    }
    NSMutableString *whiteSpceText = [self mutableCopy];
    for(int i = 1 ; i <= index ; i++){
        [whiteSpceText insertString:@" " atIndex: i * 5 - 1];
    }
    return whiteSpceText;
}

- (NSString *)nameText{
    if (self.length < 1) {
        return @"";
    }else{
        return [self stringByReplacingOccurrencesOfString:[self substringToIndex:1] withString:@"*"];
    }
}

-(BOOL)isIncludeSpecialCharact{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

- (NSString *)wy_stringByAppendingUrlPathComponent:(NSString *)str{
    return [[[self stringByAppendingPathComponent:str] stringByReplacingOccurrencesOfString:@"http://" withString:@"http:/"] stringByReplacingOccurrencesOfString:@"http:/" withString:@"http://"];
}

- (NSString *)wy_increaseString{
    NSInteger num = self.integerValue;
    return [NSString stringWithFormat:@"%ld",(long)(num + 1)];
}

- (NSString *)wy_displayMoneyAndUnit{
    return [NSString stringWithFormat:@"%@元",[self wy_displayMoney]];
}

- (NSString *)wy_displayMoney{
    return [NSString stringWithFormat:@"%.2f",self.floatValue];
}

- (BOOL)wy_true{
    return [self caseInsensitiveCompare:@"Y"] == NSOrderedSame;
}

- (NSString *)StringChange
{
    if (self){
        
        NSRange range = [self rangeOfString:@"."];//匹配得到的下标
        if (range.location == NSNotFound) {
            
            return [NSString stringWithFormat:@"%@%%",self];
        }
        return   [NSString stringWithFormat:@"%@%%",[self substringWithRange:NSMakeRange(0, range.location+range.length+2)]];
        
    }
    
    return @"";
    
}
- (NSString *)smallMD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
-(BOOL)judgePassWordLegal{
    
    BOOL result = false;
    if ([self length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self];
    }
    return result;

}

- (NSTimeInterval)compareLocationrDay
{
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
        NSDate * date = [NSDate date];
    
        NSString * NowdateStr = [dateFormatter stringFromDate:date];

    NSDate *dateA;
    NSDate *dateB;
    
        dateA = [dateFormatter dateFromString:NowdateStr];

        dateB= [dateFormatter dateFromString:self];

    NSTimeInterval time1 = [dateA timeIntervalSince1970];
    
    NSTimeInterval time2 = [dateB timeIntervalSince1970];
    
    return time2-time1;
        
}

//md5加密
+ (NSString *)encryptionByMD5:(NSString *)str {
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString stringWithCapacity:1];
    for (int i = 0; i <  CC_MD5_DIGEST_LENGTH; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

-(BOOL)validateEmail{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}
@end
