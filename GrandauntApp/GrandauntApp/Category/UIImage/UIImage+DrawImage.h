//
//  UIImage+DrawImage.h
//  YltxShare
//
//  Created by yltx on 2019/5/8.
//  Copyright © 2019 com.yltx.ZR.share. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DrawImage)

+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size;

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

-(NSData *)compressWithMaxLength:(NSUInteger)maxLength;


-(UIImage *)circleImage:(CGRect)rect;

+ (UIImage *)imageWithColor:(UIColor *)color;


+(UIImage *)addWatemarkTextAfteriOS7_WithLogoImageTimeText:(NSString *)TimeText TitleText:(NSString *)TitleText contentText:(NSString *)contentText;

-(UIImage *)addWatemarkTextAfteriOS7_WithLogoImageTimeText:(NSString *)TimeText Qcode:(UIImage *)image;

-(UIImage *)addWatemarkTextAfteriOS7_WithImageQcode:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
