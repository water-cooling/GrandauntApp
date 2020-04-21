//
//  LoginViewController.h
//  smallCourse
//
//  Created by MAC on 16/1/5.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (addltion)

@property (nonatomic, strong) NSString *editImgFelder;

+(UIImage *)createImageWithColor:(UIColor*) color;

#pragma mark 压缩图片
- (UIImage *)cutImageWithsize: (CGSize)size;

#pragma mark  截屏
+ (UIImage *)screenShot;

#pragma mark 高斯模糊
- (UIImage *)blurryWithBlurLevel:(CGFloat)blur;


+(UIImage*)decodeBase64ToImage:(NSString*)strEncodeData;

@end
