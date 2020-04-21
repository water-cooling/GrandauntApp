//
//  UIView+HUDExtensions.m
//  Parking
//
//  Created by ZhangTinghui on 14/12/13.
//  Copyright (c) 2014年 www.660pp.com. All rights reserved.
//

#import "UIView+HUDExtensions.h"

static const NSInteger kHUDPopLoadingViewTag    = 1412301511;
static const NSInteger kHUDPlaneMessageViewTag  = 1501091133;


@interface HUDCustomLoadingView : UIView
@property (nonatomic, weak) UIImageView *loadingView;
@property (nonatomic, assign) BOOL shouldRestoreAnimation;
@property (weak, nonatomic) UIImageView *gifView;
@property (nonatomic,strong) NSMutableArray *imgRefreshArr;

+ (instancetype)loadingView;
- (void)stopLoadingAnimation;
- (void)startLoadingAnimation;
@end

@implementation HUDCustomLoadingView
- (void)dealloc {
    [self stopLoadingAnimation];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)loadingView {
    CGRect rect = CGRectMake(0, 0, 45, 45);
    return [[self alloc] initWithFrame:rect];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        for (int i = 1; i<=19; i++) {
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"loding_%d.JPG",i]];
            [self.imgRefreshArr addObject:image];
        }
        
//        self.imgRefreshArr = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"circle_praise_double_1"],[UIImage imageNamed:@"circle_praise_double_2"],[UIImage imageNamed:@"circle_praise_double_3"],[UIImage imageNamed:@"circle_praise_double_4"],[UIImage imageNamed:@"circle_praise_double_5"],[UIImage imageNamed:@"circle_praise_double_6"],[UIImage imageNamed:@"circle_praise_double_7"],[UIImage imageNamed:@"circle_praise_double_8"],nil];
        [self _addLoadingView];
        [self _registerAppStateNotifications];
        [self startLoadingAnimation];
    }
    return self;
}

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (void)_addLoadingView {
//    NSArray *imageArray = @[@"common_loading"];
//    
//    [imageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        UIImage *image = [UIImage imageNamed:obj];
//        UIImageView *view = [[UIImageView alloc] initWithImage:image];
//        view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//        view.frame = self.bounds;
//        [self addSubview:view];
//        if (idx == 0) {
//            self.loadingView = view;
//        }
//    }];
    
    self.gifView.frame = self.bounds;
    [self addSubview:self.gifView];
    
    [self.gifView stopAnimating];
    if (self.imgRefreshArr.count == 1) {
        self.gifView.image = [self.imgRefreshArr lastObject];
    } else { // 多张图片
        self.gifView.animationImages = self.imgRefreshArr;
        self.gifView.animationDuration = 1.0;
        [self.gifView startAnimating];
    }
}

- (BOOL)_isInLoadingAnimation {
    return ([self.loadingView.layer animationForKey:@"loading"] != nil);
}

- (void)stopLoadingAnimation {
    if (![self _isInLoadingAnimation]) {
        return;
    }
    [self.loadingView.layer removeAnimationForKey:@"loading"];
}

- (void)startLoadingAnimation {
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = CGFLOAT_MAX;
    [self.loadingView.layer addAnimation:rotationAnimation forKey:@"loading"];
}

#pragma mark - AppStateNotification
- (void)_registerAppStateNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_appDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)_appDidEnterBackground:(NSNotification *)notification {
    self.shouldRestoreAnimation = [self _isInLoadingAnimation];
    [self stopLoadingAnimation];
}

- (void)_appWillEnterForeground:(NSNotification *)notification {
    if (!self.shouldRestoreAnimation) {
        return;
    }
    
    [self startLoadingAnimation];
}

@end



@implementation UIView (HUDExtensions)

#pragma mark - Popup Loading
- (MBProgressHUD *)_createAndShowHUDForPopupLoading {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    hud.color = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.2];
//    hud.labelColor = [UIColor grayColor];
    
    hud.tag = kHUDPopLoadingViewTag;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.customView = [HUDCustomLoadingView loadingView];
    return hud;
}

- (void)showPopupLoading {
    [self showPopupLoadingWithText:nil];
}

- (void)showPopupLoadingWithText:(NSString *)text {
    [[self _createAndShowHUDForPopupLoading] setLabelText:text];
}

- (void)showPopupLoadingWithText:(NSString *)text hideAfterDelay:(float)delay {
    MBProgressHUD *hud = [self _createAndShowHUDForPopupLoading];
    [hud hide:YES afterDelay:delay];
}

- (void)hidePopupLoading {
    [self hidePopupLoadingAnimated:YES];
}

- (void)hidePopupLoadingAnimated:(BOOL)animated {
    NSArray *huds = [MBProgressHUD allHUDsForView:self];
    for (MBProgressHUD *hud in huds) {
        if (hud.tag == kHUDPopLoadingViewTag) {
            [hud hide:animated];
        }
    }
}

#pragma mark - Popup Message
- (void)showPopupOKMessage:(NSString *)message {
    [self showPopupMessage:message type:UIViewPopupMessageTypeOK];
}

- (void)showPopupErrorMessage:(NSString *)message {
    [self showPopupMessage:message type:UIViewPopupMessageTypeError];
}

- (void)showPopupMessage:(NSString *)message type:(UIViewPopupMessageType)type {
    [self showPopupMessage:message type:type completion:nil];
}

- (void)showPopupMessage:(NSString *)message
                    type:(UIViewPopupMessageType)type
              completion:(void(^)(void))completion {
    
    if ([message length] <= 0) {
        if (completion) {
            completion();
        }
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    UIImage *iconImage = nil;
    switch (type) {
        case UIViewPopupMessageTypeError:
            iconImage = [UIImage imageNamed:@"hud_icon_error"];
            break;
        case UIViewPopupMessageTypeOK:
        default:
            iconImage = [UIImage imageNamed:@"hud_icon_ok"];
            break;
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:iconImage];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    
    if (completion) {
        hud.completionBlock = completion;
    }
    
    //根据消息的文字长度，决定delay时间长短
    //按照人平均阅读速度 400个/分钟
    NSTimeInterval delay = [message length] / (400/60);
    [hud hide:YES afterDelay:MAX(1.5f, delay)];
    
    //handle tap
    [hud addGestureRecognizer:[[UITapGestureRecognizer alloc]
                               initWithTarget:self
                               action:@selector(_handleHUDTap:)]];
}

- (void)_handleHUDTap:(UITapGestureRecognizer *)recognizer {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

#pragma mark - PlaneMessage 
- (void)showPlaneMessage:(NSString *)message {
    [self showPlaneMessage:message withIconImage:[UIImage imageNamed:@"hud_gray_info"]];
}

- (void)showPlaneMessage:(NSString *)message withIconImage:(UIImage *)iconImage {
    UIView *containerView = [self viewWithTag:kHUDPlaneMessageViewTag];
    if (!containerView) {
        CGRect frame = self.bounds;
        CGPoint contentCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        
        containerView = [[UIView alloc] initWithFrame:frame];
//        containerView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        containerView.tag = kHUDPlaneMessageViewTag;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:iconImage];
        
        UILabel *label      = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font          = [UIFont systemFontOfSize:14];
//        label.textColor     = UIColorForAppGrayLightTextColor;
        label.text          = message;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        // message
        CGRect labelBounds = self.bounds;
        labelBounds.size.width -= 15 * 2;
        labelBounds.size.height = [message boundingRectWithSize:CGSizeMake(CGRectGetWidth(labelBounds), CGFLOAT_MAX)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                        context:nil].size.height;
        label.bounds = labelBounds;
        label.center = contentCenter;
        imageView.center = CGPointMake(contentCenter.x,
                                       contentCenter.y - CGRectGetHeight(labelBounds)/2 - 15 - CGRectGetHeight(imageView.bounds)/2);
        
        [containerView addSubview:imageView];
        [containerView addSubview:label];
        
        [self addSubview:containerView];
    }
}

- (void)hidePlaneMessage {
    UIView *containerView = [self viewWithTag:kHUDPlaneMessageViewTag];
    if (containerView) {
        [containerView removeFromSuperview];
        containerView = nil;
    }
}

@end
