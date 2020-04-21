//
//  UIImage+Stretch.h
//  OneCommunity
//
//  Created by hubing on 16/2/16.
//  Copyright © 2016年 OneCommunity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Stretch)


/**
 *  返回一张自由拉伸的图片
 */
+(UIImage *)resizedImageWithName:(NSString *)name;

//+(UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)letf top:(CGFloat)top;

@end
