//
//  SignViewController.h
//  eleoke
//
//  Created by humengfan on 2018/8/21.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SignUntility.h"

@interface SignViewController : UIViewController

@property (nonatomic,strong)SignListdataModel * ListModel;

@property (nonatomic,strong)SignResponseModel * stateModel;

-(void)loginChangeUI:(SignResponseModel *)response;

@property(nonatomic,strong) NSString *pahi;

@property(nonatomic,strong) UIScrollView *corsican;

@property(nonatomic,strong) NSString *lomastome;

@property(nonatomic,strong) UITableView *plutonite;

@property(nonatomic,strong) NSDictionary *streptobacillus;
@end
