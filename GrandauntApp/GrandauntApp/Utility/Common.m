//
//  Common.m
//  HealthCloud
//
//  Created by lihaibo on 15/10/26.
//  Copyright © 2015年 bomei. All rights reserved.
//

#include <sys/sysctl.h>
#import "AppDelegate.h"
#import <AdSupport/AdSupport.h>
#import <CoreLocation/CoreLocation.h>
@implementation Common

+ (NSString *)getUUID {
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    NSString *uuid = (__bridge NSString *)newUniqueIdString;
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    return uuid;
}

+ (BOOL)getNetWorkStates{
    
    if (@available(iOS 10.0, *)) {
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        return delegate.isNetWork;
    } else {
        return YES;
    }
}
+ (NSString *)getVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAlias:(NSString *) phone{
    return phone;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString * MOBILE = @"^0?(13|15|17|18|14)[0-9]{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)){
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)manufactureString:(NSString *)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(void)showSimpleAlertDialog:(NSString *)title withMessage:(NSString *)message target:(UIViewController *)target callBack:(block)callback{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        callback();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    [target presentViewController:alertVC animated:YES completion:nil];
}

+ (void)pushWithStoryBoardId:(NSString *)identifier
                  withTarget:(UIViewController *)target
                 withParamer:(NSMutableDictionary *)paramers {
    
    //    UIViewController *pushViewController = [[NSClassFromString(url) alloc] init];
    if ([identifier isEqualToString:@""]) {
        return;
    }
    
    UIViewController *pushViewController = [target.storyboard instantiateViewControllerWithIdentifier:identifier];
    pushViewController.hidesBottomBarWhenPushed = YES;
    [pushViewController transferParameters:paramers];
    [target.navigationController pushViewController:pushViewController
                                           animated:YES];
}

+ (void)popUrl:(NSString *)url
    withTarget:(UIViewController *)target
{
    NSArray *arr = target.navigationController.viewControllers;
    for (UIViewController *view in arr) {
        if ([view isKindOfClass:NSClassFromString(url)]) {
            //            [view transferParameters:paramers];
            [target.navigationController popToViewController:view animated:YES];
        }
    }
}

+ (NSString *)removeWhiteSpaceCharactersAtEnd:(NSString *)string {
	if (IsStrEmpty(string)) {
		return nil;
	} else {
		NSUInteger count = [string length] - 1;
		for (; count >0; count--) {
			if ([string characterAtIndex:count] != ' ') {
				break;
			}
		}
		NSString *str = [string substringToIndex:count+1];
		return str;
	}
}

+ (NSString *)removeWhiteSpaceCharactersAtBeginning:(NSString *)string {
	if (IsStrEmpty(string)) {
		return nil;
	} else {
		NSUInteger count = 0;
		for (;; count++) {
			if (count <string.length) {
				if ([string characterAtIndex:count] != ' ') {
					break;
				}
			} else {
				break;
			}
		}
		NSString *str = [string substringFromIndex:count];
		return str;
	}
}


+ (CGFloat)caculateWidth:(NSString *)text size:(UIFont *)font height:(CGFloat)height{
    CGSize textBlockMinSize = {CGFLOAT_MAX, height};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    
    size = [text boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                           attributes:@{
                                        NSFontAttributeName:font
                                        }
                              context:nil].size;
    return  size.width;
}

#pragma mark -
+ (CGFloat)caculateHeight:(NSString *)text size:(UIFont *)font width:(CGFloat)width {
    CGSize textBlockMinSize = {width, CGFLOAT_MAX};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    size = [text boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                         attributes:@{
                                                      NSFontAttributeName:font
                                                      }
                                            context:nil].size;
    return  size.height;
}


#pragma mark - 
//画线
+ (UIImageView *)drawLineImage:(CGRect)rect isHorizontal:(BOOL)isHorizontal lineWidth:(CGFloat)width red:(float)red green:(float)green blue:(float)blue{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), width);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, 0);
    if (isHorizontal) {
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), imageView.frame.size.width, 0);
    } else {
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, imageView.frame.size.height);
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageView;
}

#pragma mark - 硬件版本
+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)platformString {
    NSString *platform = [self platform];
    static NSDictionary* deviceNamesByCode = nil;
    if (!deviceNamesByCode) {
        deviceNamesByCode = @{@"iPod1,1"   :@"iPod_Touch1",
                              @"iPod2,1"   :@"iPod_Touch2",
                              @"iPod3,1"   :@"iPod_Touch3",
                              @"iPod4,1"   :@"iPod_Touch4",
                              @"iPod5,1"   :@"iPod_Touch5",
                              @"iPad1,1" :@"iPad1",
                              @"iPad2,1" :@"iPad2",
                              @"iPad2,2" :@"iPad2",
                              @"iPad2,3"   :@"iPad2",
                              @"iPad2,4"   :@"iPad2",
                              @"iPad2,5"   :@"iPad_mini",
                              @"iPad2,6" :@"iPad_mini",
                              @"iPad2,7" :@"iPad_mini",
                              @"iPad3,1" :@"iPad3",
                              @"iPad3,2" :@"iPad3",
                              @"iPad3,3"   :@"iPad3",
                              @"iPad3,4"   :@"iPad4",
                              @"iPad3,5" :@"iPad4",
                              @"iPad3,6" :@"iPad4",
                              @"iPad4,1" :@"iPad_Air",
                              @"iPad4,2" :@"iPad_Air",
                              @"iPad4,3"   :@"iPad_Air",
                              @"iPad4,4"   :@"iPad_mini",
                              @"iPad4,5"   :@"iPad_mini",
                              @"iPad4,6"   :@"iPad_mini",
                              @"iPhone1,1"   :@"iPhone1G_GSM",
                              @"iPhone1,2"   :@"iPhone3G_GSM",
                              @"iPhone2,1"   :@"iPhone3GS_GSM",
                              @"iPhone3,1"   :@"iPhone4_GSM",
                              @"iPhone3,3"   :@"iPhone4_CDMA",
                              @"iPhone4,1"   :@"iPhone4S",
                              @"iPhone5,1"   :@"iPhone5",
                              @"iPhone5,2"   :@"iPhone5",
                              @"iPhone5,3"   :@"iPhone5C",
                              @"iPhone5,4"   :@"iPhone5C",
                              @"iPhone6,1"   :@"iPhone5S",
                              @"iPhone6,2"   :@"iPhone5S",
                              @"i386"   :@"iPhone_Simulator",
                              @"x86_64" :@"iPhone_Simulator",
                              @"iPhone7,1":@"iPhone6_Plus",
                              @"iPhone7,2":@"iPhone6",
                              @"iPhone8,1":@"iPhone6S",
                              @"iPhone8,2":@"iPhone6_PlusS"
                              };
    }
    NSString *unknownPlatform = platform;
    if (platform) {
        platform = [deviceNamesByCode objectForKey:platform];
    }
    if ([platform length] == 0) {
        platform = unknownPlatform;
    }
    return platform;
}

+(UIImage *)imageWithColor:(UIColor*)color andSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [color set];
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)getFirstImageFromVideoToLocal:(NSString *)localVideoName width:(CGFloat)width height:(CGFloat)height{
    return nil;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//二维码转换
+(NSString *)qrcodeWithType:(NSString *)value type:(NSInteger)type channel:(NSString *)channel{
    NSString *result=@"";
//    /***
//     HTML网页 url
//     房产验证码 house
//     访客通行扫码 visitor
//     优惠券 coupon
//     **/
//    if(type==QRCodeTypeResult_Url){
//        result = [NSString stringWithFormat:@"%@|%@|",@"url",value];
//    }else if(type==QRCodeTypeResult_House){
//        result = [NSString stringWithFormat:@"%@|%@|",@"house",value];
//    }else if(type==QRCodeTypeResult_Visitor){
//        result = [NSString stringWithFormat:@"%@|%@|",@"visitor",value];
//    }else if(type==QRCodeTypeResult_Coupon){
//        result = [NSString stringWithFormat:@"%@|%@|%@",@"coupon",value,channel];
//    }
//    
    return result;
}



//随机字符串 - 生成指定长度的字符串
+(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}

+ (NSString *)seperateNumberByComma:(NSString*)numberStr{
    NSInteger  number = [numberStr integerValue];
    //提取正数部分
    BOOL negative = number<0;
    NSInteger num = labs(number);
    NSString *numStr = [NSString stringWithFormat:@"%ld",num];
    NSString * pointNum = [numberStr substringFromIndex:numStr.length];
    
    //根据数据长度判断所需逗号个数
    NSInteger length = numStr.length;
    NSInteger count = numStr.length/3;
    
    //在适合的位置插入逗号
    for (int i=1; i<=count; i++) {
        NSInteger location = length - i*3;
        if (location <= 0) {
            break;
        }
        //插入逗号拆分数据
        numStr = [numStr stringByReplacingCharactersInRange:NSMakeRange(location, 0) withString:@","];
    }
    //别忘给负数加上符号
    if (negative) {
        numStr = [NSString stringWithFormat:@"-%@",numStr];
    }
    NSString * comStr  = [NSString stringWithFormat:@"%@%@",numStr,pointNum];
    return comStr;
}

+ (BOOL)yltxHasLocationServer{
 if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {

     return YES;
 }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {

     return NO;
 }
    return NO;
}
/**
 *改变字符串中具体某字符串的颜色
 */
+ (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize {
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    NSRange markRange = [tempStr rangeOfString:change];
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}


+ (void)showIndicator:(UIView *)view {
    for (UIView * subView in view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            [subView removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    hud.customView = indicator;
    hud.bezelView.color = [UIColor clearColor];
    [indicator startAnimating];
    [view addSubview:hud];
    [hud showAnimated:YES];
}

+ (void)showAlertInformation:(NSString *)info view:(UIViewController *)view {
    for (UIView * subView in view.view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            [subView removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view.view];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.detailsLabel.text = info;
    hud.margin = 10.0;
    hud.detailsLabel.layer.cornerRadius = 5.0;
    
    [view.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0];
}

+ (void)showViewAlertInformation:(NSString *)info view:(UIView *)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.font = [UIFont systemFontOfSize:12.0];
    hud.detailsLabel.text = info;
    hud.margin = 10.0;
    hud.bezelView.layer.cornerRadius = 5.0;
    [view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0];
}

+ (void)hideHUDForView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+(void)hideIndicator:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)pushUrl:(NSString *)url
     withTarget:(UIViewController *)target
    withParamer:(NSMutableDictionary *)paramers {
    UIViewController *pushViewController = [[NSClassFromString(url) alloc] init];
    pushViewController.hidesBottomBarWhenPushed = YES;
    [pushViewController transferParameters:paramers];
    [target.navigationController pushViewController:pushViewController
                                           animated:YES];
}

+ (void)popUrl:(NSString *)url
    withTarget:(UIViewController *)target
   withParamer:(NSMutableDictionary *)paramers {
    NSArray *arr = target.navigationController.viewControllers;
    for (UIViewController *view in arr) {
        if ([view isKindOfClass:NSClassFromString(url)]) {
            [view transferParameters:paramers];
            [target.navigationController popToViewController:view animated:YES];
        }
    }
}

+(BOOL)isContentSpecialNumeric:(NSString *)str{
    NSString *tem = [[str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_//|~＜＞$€^£•'@#$%^&*():;.,?!<>\\_+'/\""];
    NSString *strs = [tem stringByTrimmingCharactersInSet:set];
    if (![str isEqualToString:strs]) {
        return YES;
    }
    return NO;
}

+(BOOL)isContentNum:(NSString *)str{
    NSString * nameCharacters = @"0123456789X";
    if ([nameCharacters containsString:str]) {
        return YES;
    }
    return NO;
}

+(void)isOpenBmkLocationVc:(UIViewController *)vc  service:(void(^)(BOOL state))completion{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
                                                        || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        completion(YES);
        NSLog(@"已经打开了定位服务");
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
//        [Common showAlertInformation:@"请在iPhone的\"设置-隐私-定位服务\"中允许访问位置信息" view:vc];
        completion(NO);
        NSLog(@"定位功能不可用");
    }
}

//缓存大小获取
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
+(BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+ (BOOL)isRightInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange) range isDigit:(BOOL)isDigit{
    //判断只输出数字和.号
    NSString *passWordRegex = nil;
    if (isDigit) {
        passWordRegex = @"[0-9\\.]";
    } else {
        passWordRegex = @"[0-9]";
    }
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    if (![passWordPredicate evaluateWithObject:inputString]) {
        return NO;
    }
    //逻辑处理
    if ([string containsString:@"."]) {
        if ([inputString isEqualToString:@"."]) {
            return NO;
        }
        NSRange subRange = [string rangeOfString:@"."];
        if (range.location - subRange.location > 2) {
            return NO;
        }
    }
    return YES;
}


+ (BOOL)isInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange) range{
    //判断只输出数字和.号
    NSString *passWordRegex = @"[0-9\\.]";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    if (![passWordPredicate evaluateWithObject:inputString]) {
        return NO;
    }
    //逻辑处理
    if ([string containsString:@"."]) {
        if ([inputString isEqualToString:@"."]) {
            return NO;
        }
        NSRange subRange = [string rangeOfString:@"."];
        if (range.location - subRange.location > 2) {
            return NO;
        }
    }
    if ([string stringByAppendingString:inputString].doubleValue >499) {
        return NO;
    }
    
    return YES;
}

+(NSString * )reduceDate:(NSInteger)year monrth:(double)monrth day:(NSInteger)day{
    NSDate *currentDate = currentDate = [NSDate date];
    NSCalendar *calendar = nil;
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        calendar = [NSCalendar currentCalendar];
    }
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:currentDate];
    [dateComponents setYear:-year];
    [dateComponents setMonth:-monrth];
    [dateComponents setDay:-day];
    
    NSDate *newdate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr = [formater stringFromDate:newdate];
    return  dateStr;
}

+(UIImage *)setBGImageSize:(CGSize)size fromColor:(UIColor*)fromColor toColor:(UIColor*)toColor{
    CIFilter *ciFilter = [CIFilter filterWithName:@"CILinearGradient"];
    CIVector *vector0 = [CIVector vectorWithX:size.width * 0 Y:size.height * (1-0.5)];
    CIVector *vector1 = [CIVector vectorWithX:size.width * 1 Y:size.height * (1-0.5)];
    [ciFilter setValue:vector0 forKey:@"inputPoint0"];
    [ciFilter setValue:vector1 forKey:@"inputPoint1"];
    [ciFilter setValue:[CIColor colorWithCGColor:fromColor.CGColor] forKey:@"inputColor0"];
    [ciFilter setValue:[CIColor colorWithCGColor:toColor.CGColor] forKey:@"inputColor1"];
    
    CIImage *ciImage = ciFilter.outputImage;
    CIContext* con = [CIContext contextWithOptions:nil];
    CGImageRef resultCGImage = [con createCGImage:ciImage
                                         fromRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultUIImage = [UIImage imageWithCGImage:resultCGImage];
    CGImageRelease(resultCGImage);
    return resultUIImage;
}

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value andWidth:(float)width {
    //获取当前文本的属性
     NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[value dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    UITextView * text = [[UITextView alloc]init];
    text.attributedText = attributedString;
    NSRange range = NSMakeRange(0, attributedString.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attributedString attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height - 32.0;
}


+ (BOOL) validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+ (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

+ (BOOL)isIphoneXSeries{
    if (@available(iOS 11.0, *)) {
        return [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0;
    } else {
        return  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO);
    }
}

+ (NSString *)handlePhoneWihtString:(NSString *)phone{
    if (phone.length == 0) {
        return  @"";
    }
    return [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}


+(BOOL)isIphoneX{
    if (@available(iOS 11.0, *)) {
        if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {
            return YES;
        }
    }
    return NO;
}
//使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}

+ (UIImage*)image:(UIImage *)image WithCornerRadius:(CGFloat)radius{
    
    CGFloat side = MIN(image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), NO, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, side, side)].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    CGFloat marginX = -(image.size.width - side) / 2.f;
    CGFloat marginY = -(image.size.height - side) / 2.f;
    [image drawInRect:CGRectMake(marginX, marginY, image.size.width, image.size.height)];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

+(UIImage*)decodeBase64ToImage:(NSString*)strEncodeData {
    
    NSString *  str = [strEncodeData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    
    //进行空字符串的处理
    
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    //进行换行字符串的处理
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    //去掉头部的前缀//data:image/jpeg;base64, （可根据实际数据情况而定，如果数据有固定的前缀，就执行下面的方法，如果没有就注销掉或删除掉）
    
    str = [str substringFromIndex:23];
    //23 是根据前缀的具体字符长度而定的。
    
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *photo = [UIImage imageWithData:imageData ];
    
    return  photo;
}

/**
 获取url的所有参数
 @param url 需要提取参数的url
 @return NSDictionary
 */
+ (NSDictionary *)parameterWithURL:(NSURL *)url {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}

+ (NSString *)hanlePhoneWithStarString:(NSString *)phone{
    if (phone.length == 11) {
         NSString *string=[phone stringByReplacingOccurrencesOfString:[phone substringWithRange:NSMakeRange(3,4)]withString:@"****"];
        return string;
    }
    return @"";
}
@end
