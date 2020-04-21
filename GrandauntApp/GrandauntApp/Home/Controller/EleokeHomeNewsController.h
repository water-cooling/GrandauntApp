//
//  EleokeHomeNewsController.h
//  eleoke
//
//  Created by humengfan on 2018/7/17.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FGScrollviewDelegate.h"

@interface EleokeHomeNewsController : UITableViewController<FGScrollPageViewChildVcDelegate>

-(void)SeachContent:(NSString * )Str;

@property(nonatomic,assign)NSInteger SelectIndex;

@property(nonatomic,copy)NSString * seachStr;


@property(nonatomic,strong) UITableView *byroniana;

@property(nonatomic,strong) UIScrollView *tungusian;

@property(nonatomic,strong) NSString *insolvency;

@property(nonatomic,strong) NSDictionary *courtman;

@property(nonatomic,strong) UIScrollView *clamworm;
@end
