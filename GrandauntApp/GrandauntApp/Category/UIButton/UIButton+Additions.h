//
//  UIButton+Additions.h
//  WeiKe
//
//  Created by WuShiHai on 6/18/15.
//  Copyright (c) 2015 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Additions)

@property (nonatomic, strong) NSObject *associatedObject;

//important:use after set frame, set image ,set title
- (void)wy_autoLayoutImageAndTitle:(CGFloat)imageAndTitlePadding layoutDirectionIsHorizontal:(BOOL)isHorizontal;
- (void)wy_reversalAutoLayoutImageAndTitle:(CGFloat)imageAndTitlePadding;

//图片下载
- (void)wy_imageFullBackground;
- (void)wy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
- (void)wy_setBackgroundImageWithImagedName:(NSString *)imageName forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;

//CDN图片
- (void)wy_setCDNImageWithImagedName:(NSString *)imageName forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;

@end

