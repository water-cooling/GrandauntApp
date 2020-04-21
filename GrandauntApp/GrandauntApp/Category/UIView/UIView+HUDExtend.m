//
//  UIView+HUDExtend.m
//  Imagic_Public
//
//  Created by boyce.huang on 2017/10/18.
//  Copyright © 2017年 huangpf. All rights reserved.
//

static const void *LoadingView_Key = "loadingView_Key";
@implementation UIView (HUDExtend)
#pragma mark 属性关联
-(void)setLoadingView:(LoadAnimationView *)loadingView{
    
    objc_setAssociatedObject(self, &LoadingView_Key,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LoadAnimationView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingView_Key);
}

-(void)beginLoading{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[LoadAnimationView class]]) {
            [self.loadingView startAnimation];
            return;
        }
    }
    
//    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[LoadAnimationView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        [self addSubview:self.loadingView];
        [self.loadingView startAnimation];
//    }else{
//        [self.loadingView startAnimation];
//    }
}

- (void)endLoading{
//    if (self.loadingView) {
        [self.loadingView stopLoadAnimation];
//    }
}
@end

