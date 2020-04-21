//
//  UIButton+Additions.m
//  WeiKe
//
//  Created by WuShiHai on 6/18/15.
//  Copyright (c) 2015 jing. All rights reserved.
//

#import "UIButton+Additions.h"

static char UIButtonAssociatedObject;

@implementation UIButton (Additions)

#pragma mark - view
- (void)wy_autoLayoutImageAndTitle:(CGFloat)imageAndTitlePadding layoutDirectionIsHorizontal:(BOOL)isHorizontal{
    //not neccessary,if image or text is nil.
    if (self.imageView.image == nil || self.titleLabel.text == nil) {
        return;
    }
    if (isHorizontal) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, imageAndTitlePadding/2, 0, -imageAndTitlePadding/2)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -imageAndTitlePadding/2, 0, imageAndTitlePadding/2)];
    }else{
        CGFloat titleViewVerticalOffset = imageAndTitlePadding/2 + CGRectGetHeight(self.titleLabel.frame)/2;
        CGFloat titleViewHorizontalOffset = self.titleLabel.center.x - CGRectGetWidth(self.frame)/2;
        [self setTitleEdgeInsets:UIEdgeInsetsMake( titleViewVerticalOffset, -titleViewHorizontalOffset , -titleViewVerticalOffset,titleViewHorizontalOffset)];
        
        CGFloat imageViewVerticalOffset = imageAndTitlePadding/2 + CGRectGetHeight(self.imageView.frame)/2;
        CGFloat imageViewHorizontalOffset = self.imageView.center.x - CGRectGetWidth(self.frame)/2;
        [self setImageEdgeInsets:UIEdgeInsetsMake( -imageViewVerticalOffset, -imageViewHorizontalOffset , imageViewVerticalOffset, imageViewHorizontalOffset)];
    }
    
}

- (void)wy_reversalAutoLayoutImageAndTitle:(CGFloat)imageAndTitlePadding{
    //not neccessary,if image or text is nil.
    if (self.imageView.image == nil || self.titleLabel.text == nil) {
        return;
    }
    CGFloat titleViewHorizontalOffset = CGRectGetWidth(self.imageView.frame) + imageAndTitlePadding/2;
    [self setTitleEdgeInsets:UIEdgeInsetsMake( 0, -titleViewHorizontalOffset , 0,titleViewHorizontalOffset)];
    
    CGFloat imageViewHorizontalOffset = CGRectGetWidth(self.titleLabel.frame) + imageAndTitlePadding/2;
    [self setImageEdgeInsets:UIEdgeInsetsMake( 0, imageViewHorizontalOffset , 0, -imageViewHorizontalOffset)];
    
//    self.titleLabel.backgroundColor = [UIColor redColor];
}
- (void)setAssociatedObject:(NSObject *)associatedObject{
    objc_setAssociatedObject(self, &UIButtonAssociatedObject, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSObject *)associatedObject{
    return objc_getAssociatedObject(self, &UIButtonAssociatedObject);
}
- (void)wy_imageFullBackground{
    CGFloat width = self.width - self.imageView.width;
    CGFloat height = self.height - self.imageView.height;
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(-height/2, -width/2, -height/2, -width/2)];
}
#pragma mark - image scache
- (void)wy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder{
    [self sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:placeholder];
//    [self setImageWithURLStringName:imageName forState:state placeholder:placeholder extension:nil];
}
- (void)wy_setBackgroundImageWithImagedName:(NSString *)imageName forState:(UIControlState)state placeholderImage:(UIImage *)placeholder{
    if(imageName==nil)
    {
        imageName=@"";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        [self sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:image];
    }else{
        [self setImageWithURLStringName:imageName forState:state placeholder:placeholder];
    }
    
}

- (void)wy_setCDNImageWithImagedName:(NSString *)imageName forState:(UIControlState)state placeholderImage:(UIImage *)placeholder{
    if(imageName==nil)
    {
        imageName=@"";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        [self sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:image];
    }else{
        [self setImageWithURLStringName:imageName forState:state placeholder:placeholder];
    }
}

#pragma mark - Base
- (void)setImageWithURLStringName:(NSString *)imageName forState:(UIControlState)state placeholder:(UIImage *)placeholder{
    NSString *urlString =[@"" wy_stringByAppendingUrlPathComponent:imageName];
    WYWeakSelfDefine;
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:urlString] forState:state placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (cacheType == SDImageCacheTypeDisk) {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.5;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            [weakSelf.layer addAnimation:transition forKey:@"fade"];
        }

    }];

}

@end
