//
//  AboutViewController.m
//  bihucj
//
//  Created by humengfan on 2018/7/19.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "AboutViewController.h"
#import <UIImageView+WebCache.h>

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ContentLab;
@property (weak, nonatomic) IBOutlet UIImageView *Img;
@property (weak, nonatomic) IBOutlet UILabel *AppLevel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
