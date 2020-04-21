//
//  UIView+HUDExtend.h
//  Imagic_Public
//
//  Created by boyce.huang on 2017/10/18.
//  Copyright © 2017年 huangpf. All rights reserved.
//
#import "LoadAnimationView.h"
#import <UIKit/UIKit.h>

@interface UIView (HUDExtend)
@property (strong, nonatomic) LoadAnimationView *loadingView;


- (void)beginLoading;


- (void)endLoading;
@end
