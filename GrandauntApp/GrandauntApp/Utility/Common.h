//  //   Common.h
//   HealthCloud
//  //   Created by lihaibo on 15/10/26.
//   Copyright © 2015年 bomei. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^block)(void);

@interface Common : NSObject


+ (BOOL)getNetWorkStates;

+ (NSString *)getVersion;
//判断是否开启定位
+(BOOL)yltxHasLocationServer;


+ (NSString *)getAlias:(NSString *) phone;

+ (BOOL)isMobileNumber:(NSString *)mobileNum ;
+(BOOL)isContentSpecialNumeric:(NSString *)str;
+(BOOL)isContentNum:(NSString *)str;

// 邮箱
+ (BOOL) validateEmail:(NSString *)email;

// 去掉字符串空格和回车
+ (NSString *)manufactureString:(NSString *)string;
// 去掉尾部空格
+ (NSString *)removeWhiteSpaceCharactersAtEnd:(NSString *)string;
// 去除头部空格
+ (NSString *)removeWhiteSpaceCharactersAtBeginning:(NSString *)string;
+(void)isOpenBmkLocationVc:(UIViewController *)vc  service:(void(^)(BOOL state))completion;
//  + (CGFloat)caculateWidth:(NSString *)text size:(UIFont *)font height:(CGFloat)height;
+ (CGFloat)caculateHeight:(NSString *)text size:(UIFont *)font width:(CGFloat)width;
+ (UIImageView *)drawLineImage:(CGRect)rect isHorizontal:(BOOL)isHorizontal lineWidth:(CGFloat)width red:(float)red green:(float)green blue:(float)blue;

+ (NSString *)platform;
+ (NSString *)platformString;

+ (NSString *) timeToFormatTime:(NSString *) oldTime;

// 图片颜色
+(UIImage *)imageWithColor:(UIColor*)color andSize:(CGSize)size;
/**
 *  截取视频第一帧
 *
 *  @param localVideoName
 *  @param width
 *  @param height
 *
 *  @return
 */
+ (UIImage *)getFirstImageFromVideoToLocal:(NSString *)localVideoName width:(CGFloat)width height:(CGFloat)height;

// string--dic
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 二维码转换
+(NSString *) qrcodeWithType:(NSString *) value type:(NSInteger) type channel:(NSString *) channel;

+ (BOOL)isRightInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange)range isDigit:(BOOL)isDigit;
// Label画线
+(UILabel *)drawCellLine:(CGFloat)cellHeight;

// Label画线(竖线)
+(UILabel *)drawCellLineVerticalLeft:(CGFloat)left top:(CGFloat)top height:(CGFloat)height;

// 随机字符串 - 生成指定长度的字符串
+(NSString *)randomStringWithLength:(NSInteger)len;

// 数字逗号分隔
+(NSString *)seperateNumberByComma:(NSString*)numberStr;

/**
 *  处理页面跳转
 *  url : 跳转类名
 *  object: 跳转对象
 */
+ (void)pushUrl:(NSString *)url
     withTarget:(UIViewController *)target
    withParamer:(NSMutableDictionary *)paramers;

/**
 *  处理页面返回
 *
 */
+ (void)popUrl:(NSString *)url
    withTarget:(UIViewController *)target;
/**
*  storyboard的ID
*  url : 对象
*  object: 传参
 */
+ (void)pushWithStoryBoardId:(NSString *)identifier
 withTarget:(UIViewController *)target
withParamer:(NSMutableDictionary *)paramers;
/**
 *  处理页面返回
 *
 */
+ (void)popUrl:(NSString *)url
    withTarget:(UIViewController *)target
   withParamer:(NSMutableDictionary *)paramers;

/**
 *改变字符串中具体某字符串的颜色
 */
+ (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize;


+ (void)showIndicator:(UIView *)view;
+ (void)showAlertInformation:(NSString *)info view:(UIViewController *)view;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideIndicator:(UIView *)view;
+ (void)showViewAlertInformation:(NSString *)info view:(UIView *)view;
+(BOOL)validateNumber:(NSString*)number;
// 查看系统缓存大小
+ (float) folderSizeAtPath:(NSString*) folderPath;
+(NSString * )reduceDate:(NSInteger)year monrth:(double)monrth day:(NSInteger)day;

+(UIImage *)setBGImageSize:(CGSize)size fromColor:(UIColor*)fromColor toColor:(UIColor*)toColor;

+ (CAGradientLayer *)setGradualChangingColor:(CGSize)viewSize fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr cornerRadius:(CGFloat)cornerRadius;


+ (float) heightForString:(NSString *)value andWidth:(float)width ;

// 去除字符串中的空格和换行符
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

// 判断是否是iphoneX系列
+ (BOOL)isIphoneXSeries;

+ (BOOL)isInPutOfString:(NSString *) string withInputString:(NSString *) inputString range:(NSRange) range;
//手机号中间处理
+ (NSString *)handlePhoneWihtString:(NSString *)phone;

//从钥匙串获取UUID
+ (NSString *)getUUIDByKeyChain;

+(BOOL)isIphoneX;

+ (UIImage *)convertViewToImage:(UIView *)view;
//图片设置圆角
+ (UIImage*)image:(UIImage *)image WithCornerRadius:(CGFloat)radius;

+(UIImage*)decodeBase64ToImage:(NSString*)strEncodeData;

+(void)showSimpleAlertDialog:(NSString *)title withMessage:(NSString *)message target:(UIViewController *)target callBack:(block)callback;


+ (NSDictionary *)parameterWithURL:(NSURL *)url;

+ (NSString *)hanlePhoneWithStarString:(NSString *)phone;
@end
