//
//  UIViewController+customTableView.m
//  YltxShare
//
//  Created by yltx on 2019/5/5.
//  Copyright © 2019年 com.yltx.ZR.share. All rights reserved.
//

static NSString *bgViewKey = @"bgViewKey";


@implementation UIViewController (customTableView)
#pragma mark - Getter
- (UIView *)bgView{
    return objc_getAssociatedObject(self, &bgViewKey);
}
#pragma mark - Setter
- (void)setBgView:(UIView *)bgView{
    objc_setAssociatedObject(self, &bgViewKey, bgViewKey, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - UITableView
-(void)setIOS:(UIScrollView *)scroller{
    if (@available(iOS 11.0, *))
    {
        scroller.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}



//设置下拉刷新项
-(void)setupRefreshTable:(UIScrollView *)tableView needsFooterRefresh:(BOOL)isFooterRefresh{
    
    if (tableView == nil) {
        return;
    }
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadHeaderTableViewDataSource)];
    
    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = NO;
    
    // 马上进入刷新状态
    //    [header beginRefreshing];
    
    // 设置header
    tableView.mj_header = header;
    
    
    if (isFooterRefresh) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        // 设置字体
        footer.stateLabel.font = [UIFont systemFontOfSize:15.0 weight:FONT_WEIGHT_THIN];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        // 设置颜色
        footer.stateLabel.textColor = [UIColor blackColor];
        
        tableView.mj_footer = footer;
        tableView.mj_footer.automaticallyHidden = YES;
        
    }
    
    
    
}


-(void)reloadHeaderTableViewDataSource{
}

- (void)reloadFooterTableViewDataSource{
    
    
}

-(void) loadMoreData{
    [self reloadFooterTableViewDataSource];
}

+ (UIViewController *)getRootViewController
{
    UIViewController      * topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    NSLog(@"1111%@",topController);
    
    
    while ( topController.presentedViewController ){
        
        topController = topController.presentedViewController;
        
    }
    if (topController !=nil ) {
        
        if ([topController isKindOfClass:[UITabBarController class]]) {
            
        UITabBarController *  tabbarController = (UITabBarController *)topController;
       
          UIViewController * selectController = tabbarController.selectedViewController;
           
            NSLog(@"22222%@",selectController);

            return selectController;

        }
        NSLog(@"22222%@",topController);

        return topController;

        
    }
    
    
    // topController should now be your topmost view controller
    
    AppDelegate * appDelegate  =  (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"3333%@",appDelegate.window.rootViewController);
    
    
    return appDelegate.window.rootViewController;
}
@end
