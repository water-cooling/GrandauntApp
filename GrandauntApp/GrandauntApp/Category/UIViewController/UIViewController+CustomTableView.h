//
//  UIViewController+customTableView.h
//  YltxShare
//
//  Created by yltx on 2019/5/5.
//  Copyright © 2019年 com.yltx.ZR.share. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CustomTableView)
@property(nonatomic,strong)UIView *bgView;

-(void)setIOS:(UIScrollView *)scroller;
-(void)setupRefreshTable:(UIScrollView *)tableView needsFooterRefresh:(BOOL)isFooterRefresh;
-(void)reloadHeaderTableViewDataSource;
- (void)reloadFooterTableViewDataSource;
+(UIViewController *) getRootViewController;

@end

NS_ASSUME_NONNULL_END
