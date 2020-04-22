//
//  ShowCodeVC.m
//  FungusProject
//
//  Created by humengfan on 2018/5/12.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "ShowCodeVC.h"
#import <UIImageView+WebCache.h>

@interface ShowCodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *CodeImage;
@property (weak, nonatomic) IBOutlet UILabel *WrongLab;
@property (weak, nonatomic) IBOutlet UITextField *textfild;
@property(nonatomic,copy)NSString * codeID;
@end

@implementation ShowCodeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.WrongLab.hidden = YES;
    self.view.backgroundColor = [[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.6];
    _textfild.layer.borderWidth = 1.0;
    _textfild.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    // Do any additional setup after loading the view from its nib.
    [self LoadingImage];
}

- (IBAction)distextfield:(UIControl *)sender {
    
    
    [self.textfild resignFirstResponder];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DismissVC:(UIButton *)sender {
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
    self.block(NO, self.codeID, self.textfild.text);

    
}
- (IBAction)RefreshImg:(UIButton *)sender {
    
    self.WrongLab.hidden = YES;
    
    [self LoadingImage];
}

- (IBAction)DIsmiss:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    self.block(NO, self.codeID, self.textfild.text);


}


-(void)LoadingImage{

    
}


- (IBAction)SureBtn:(UIButton *)sender {

    

}
- (IBAction)ValueChange:(UITextField *)sender {
    
    if ([sender.text isEqualToString:@""]) {
        
        self.WrongLab.hidden = YES;
    }
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
