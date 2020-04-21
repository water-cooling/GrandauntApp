//
//  HomeNewsCell.h
//  eleoke
//
//  Created by humengfan on 2018/7/18.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *RightIcon;


@property(nonatomic,strong) NSDictionary *numero;

@property(nonatomic,strong) UIImageView *albespine;

@property(nonatomic,strong) UITextView *myliobatid;

@property(nonatomic,strong) UILabel *dinitrobenzene;

@property(nonatomic,strong) UITextView *uncompatibly;
@end
