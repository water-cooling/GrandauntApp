//
//  SNRightPhoneAndPwdSingleton.m

//
//  Created by humin on 4/15/14.
//  Copyright (c) 2014 WuShiHai. All rights reserved.
//

#import "IPhoneRightPhoneAndPwdSingleton.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
@implementation IPhoneRightPhoneAndPwdSingleton

+ (IPhoneRightPhoneAndPwdSingleton *)sharedInstance{
    static IPhoneRightPhoneAndPwdSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(& onceToken,^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

#pragma mark - TextField Content
//是否为空
+ (BOOL)isStringNull:(NSString *)tmpString {
    BOOL bFlag = ( (tmpString == nil) || ([tmpString isEqualToString:@""]) );
    return  bFlag;
}
//有空格
+ (BOOL)isHaveSpace:(NSString *)tmpString {
    BOOL bFlag = [tmpString isMatchedByRegex:@"[\\s]+"];
    return  bFlag;
}
//有中文
+ (BOOL)isHaveChinese:(NSString *)tmpString {
    BOOL bFlag = [tmpString isMatchedByRegex:@"[\u2E80-\u9FFF]+"];
    return  bFlag;
}
//连续相同字符
+ (BOOL)isAllSameChars:(NSString *)tmpString {
    unichar fir = [tmpString characterAtIndex:0];
    for (int i = 1; i < tmpString.length; i++) {
        unichar c = [tmpString characterAtIndex:i];
        if (c != fir) {
            return NO;
        }
    }
    return YES;
}
//联系递增字符
+ (BOOL)hasAllIncreaseChars:(NSString *)tmpString {
    NSInteger l = tmpString.length;
    unichar top = [tmpString characterAtIndex:0];
    int j = 1;
    for (int i = 1; i < tmpString.length; i++) {
        unichar c = [tmpString characterAtIndex:i];
        if (c == top+1) {
            j++;
        } else {
            j = 1;
        }
        top = c;
    }
    if (j >= l) {
        return YES;
    } else {
        return NO;
    }
}
//连续递减字符
+ (BOOL)hasAllDecreaseChars:(NSString *)tmpString {
    NSInteger l = tmpString.length;
    unichar top = [tmpString characterAtIndex:0];
    int j = 1;
    for (int i = 1; i < tmpString.length; i++) {
        unichar c = [tmpString characterAtIndex:i];
        if (c == top-1) {
            j++;
        } else {
            j = 1;
        }
        top = c;
    }
    
    if (j >= l) {
        return YES;
    } else {
        return NO;
    }
}


//有数字
+ (BOOL)isHaveNum:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"[\\d]+"];
    return  bFlag;
}
//有字母
+ (BOOL)isHaveWord:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"[A-Za-z]+"];
    return  bFlag;
}
//有特殊符号
+ (BOOL)isHaveCharacter:(NSString *)tmpString
{
    // BOOL bFlag = [tmpString isMatchedByRegex:@"[:`'-,;.!@#$%^&*(){}+?></]+"];
    BOOL bFlag = [tmpString isMatchedByRegex:@"[';><\\/]+"];
    
    return  bFlag;
}
//长度等于
+ (BOOL)isLengthEqualGivenLength:(NSString *)tmpString length:(int)length
{
    BOOL bFlag=([tmpString length] == length);
    return bFlag;
}
//长度超过
+ (BOOL)isLengthOverGivenLength:(NSString *)tmpString length:(int)length
{
    BOOL bFlag = ([tmpString length] > length);
    return  bFlag;
}
//长度小于
+ (BOOL)isLengthUnderGivenLength:(NSString *)tmpString length:(int)length
{
    BOOL bFlag = ([tmpString length] < length);
    return  bFlag;
}
//长度大于等于、大于等于
+ (BOOL)isLengthAllGivenLength:(NSString *)tmpString maxlength:(int)maxlength minlength:(int)minlength
{
    BOOL minFlag = ([tmpString length] >= minlength);
    BOOL maxFlag = ([tmpString length] <= maxlength);
    
    return minFlag&&maxFlag;
}
#pragma UserName
//判断是否是几种组合
+ (BOOL)isRightUserPassword:(NSString *)tmpString
{
  //  int num = 0;
    
    return YES;
}
//是否为纯数字
+ (BOOL)isNumText:(NSString *)str{
    if(str.length==0)
    {
        return NO;
    }
    unichar c;
    for (int i=0; i<str.length; i++)
    {
        c=[str characterAtIndex:i];
        if (!isdigit(c))
            
            return NO;
    }
    return YES;
}

//第一个是否为数字1
+ (BOOL)isFirstIsNumOne:(NSString *)tmpString
{
    BOOL bFlag = [[tmpString substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
    return  bFlag;
}
//是否以空格开头
+ (BOOL)isFirstIsNullOne:(NSString *)tmpString{
    
    BOOL bFlag = [tmpString hasPrefix:@" "];
    return bFlag;
}
//是否以空格结尾
+(BOOL)isLastIsNullOne:(NSString *)tmpString{
    
    BOOL bFlag = [tmpString hasSuffix:@" "];
    return bFlag;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //2018年最新号段支持
    NSString *phoneRegex = @"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //NSLog(@"%d",[phoneTest evaluateWithObject:mobile]);
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

/*身份证号码验证*/
+(BOOL)isValidateIdCard:(NSString *)idcard
{
    return YES;
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
+(NSString *)getStringWithRange:(NSString *)str Value1:(int)value1 Value2:(int)value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    
    return YES;
}

/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
+ (BOOL) chk18PaperId:(NSString *) sPaperIdParam
{
    NSString *sPaperId = [sPaperIdParam uppercaseString];
    //判断位数
    if ([sPaperId length] != 15 && [sPaperId length] != 18)
    {
        return NO;
    }
    NSString *carid = sPaperId;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    
    //判断年月日是否有效
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil)
    {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if(18 != strlen(PaperId))
    {
        return NO;
    }
    //校验数字
    for (int i=0; i<18; i++)
    {
        if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    
    return YES;
}

#pragma Ip
+ (NSString *)getIPAddress:(BOOL)isIPv4
{
    NSArray *searchArray = isIPv4 ?
    @[IOS_WIFI @"/"IP_ADDR_IPv4, IOS_WIFI@"/" IP_ADDR_IPv6, IOS_CELLULAR@"/" IP_ADDR_IPv4, IOS_CELLULAR@"/" IP_ADDR_IPv6 ] :
    @[IOS_WIFI @"/"IP_ADDR_IPv6, IOS_WIFI@"/" IP_ADDR_IPv4, IOS_CELLULAR@"/" IP_ADDR_IPv6, IOS_CELLULAR@"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key,NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags &IFF_UP) || (interface->ifa_flags &IFF_LOOPBACK)) {
                continue;// deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf,sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family ==AF_INET ? IP_ADDR_IPv4 :IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        
        freeifaddrs(interfaces);
    }
    
    
    return [addresses count] ? addresses : nil;
}

+ (BOOL)isValidatePass:(NSString *)password

{
    
    NSString *passRegex = @"[a-zA-Z0-9]{6,18}";
    
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passRegex];;
    
    return [passwordTest evaluateWithObject:password];
    
}

//身份证
+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber

{
    
    if (IDCardNumber.length <= 0)
        
    {
        
        return NO;
        
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *identityCardPredicate = [NSPredicate
                                          
                                          predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
    
}



+(BOOL)IsBankCard:(NSString *)cardNumber{
    
    if(cardNumber.length==0){
    
        return NO;
     }
    NSString *digitsOnly = @"";
    char c;
   for (int i = 0; i < cardNumber.length; i++){
       c = [cardNumber characterAtIndex:i];
       if (isdigit(c)){
           digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
       }
   }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
                
            }
        }else {
            addend = digit;
            
        }
        sum += addend;
        timesTwo = !timesTwo;
        
    }
    int modulus = sum % 10;
    return modulus == 0;
}


+(BOOL)CheakBankCard:(NSString *)cardNumber{

    if (cardNumber.length <= 0)
    {
        return NO;
    }
    
    NSString *regex2 = @"^[0-9]{10,}$";
    
    NSPredicate *identityCardPredicate = [NSPredicate
                                          predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [identityCardPredicate evaluateWithObject:cardNumber];
    
}



@end
