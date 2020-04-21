//
//  UIImage+Addition.h
//  FuelTreasureProject
//
//  Created by 吴仕海 on 4/8/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;

//原图
+ (UIImage *)imageWithURLNamed:(NSString *)name;
+ (UIImage *)appLaunchImage;
+ (UIImage *)wy_imageName:(NSString *)name;//该方法的意义在于避免使用imagedName cache会占用cpu

+ (UIImage *)imageWithColor:(UIColor*)color andSize:(CGSize)size;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize fitScale:(BOOL)fitScal;


+ (UIImage *)resizeImage:(NSString *)imageName;
+ (NSData *)compressToSize:(long)targetSize image:(UIImage *)image;
@end
