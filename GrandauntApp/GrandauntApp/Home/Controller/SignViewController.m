//
//  SignViewController.m
//  eleoke
//
//  Created by humengfan on 2018/8/21.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "SignViewController.h"
#import "BaseNavigationController.h"

@interface SignViewController ()
@property (weak, nonatomic) IBOutlet UIView *showView;

@property(nonatomic,strong)NSMutableArray * SpeatorArr;

@property(nonatomic,strong)NSMutableArray * ClickArr;

@property(nonatomic,assign) NSInteger Select;

@property (nonatomic,strong)UIImageView * ShowStateImg;

@property (nonatomic,strong)UILabel * ShowLab;



@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.SpeatorArr = [NSMutableArray array];
    
    self.ClickArr = [NSMutableArray array];

    self.view.backgroundColor = [[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.4];
    
    self.Select = 2;
    [self initUI];
    [self.view addSubview:self.ShowStateImg];
    
    // Do any additional setup after loading the view from its nib.
}





-(void)initUI{
    
    for (int i = 0; i< 7; i++) {
        
        
        UIButton * cornerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        UIView  * speatorview = [UIView new];
        
        UILabel * bottomLab = [[UILabel alloc]init];
        
        [self.showView addSubview:cornerbtn];
        
        [self.showView addSubview:speatorview];

        [self.showView addSubview:bottomLab];
        
        [self.ClickArr addObject:cornerbtn];
        [self.SpeatorArr addObject:speatorview];

        speatorview.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];

        
        
        bottomLab.textAlignment = NSTextAlignmentCenter;
        
        bottomLab.textColor = [UIColor colorWithHexString:@"#666666"];
        
        bottomLab.font =  [UIFont fontWithName:@"PingFang-SC-Medium" size:11];

        CGFloat btnx = 15 + (30 + 18)*i;
        
        
        cornerbtn.layer.borderWidth = 1;
        
        
        cornerbtn.layer.cornerRadius = 15;
        
        cornerbtn.layer.masksToBounds = YES;
        
        cornerbtn.layer.borderColor = [UIColor colorWithHexString:@"##CCCCCC"].CGColor;

        [cornerbtn setTitleColor:[UIColor colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];

        cornerbtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
        
        [cornerbtn setBackgroundColor:[UIColor colorWithHexString:@"#F2F2F2"]];

        if ( i < 6) {
            
            CGFloat speatorx = 45 + (30 + 18)*i;

            speatorview.frame = CGRectMake(speatorx, 83, 18, 1);
        }
        cornerbtn.frame = CGRectMake(btnx, 68, 30, 30);
        
        bottomLab.frame = CGRectMake(cornerbtn.x,  CGRectGetMaxY(cornerbtn.frame) + 10, cornerbtn.width, 12);
        
    }
  
    
}
- (IBAction)DIsmiss:(UIControl *)sender {

    
    [self dismissViewControllerAnimated:YES completion:nil];


}




-(void)changeValve{

  
    
}
- (IBAction)signNowclick:(UIButton *)sender {
  
    
}




-(UIImageView *)ShowStateImg
{
    
    
    if(!_ShowStateImg){

        _ShowStateImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"签到成功"]];
        
        _ShowStateImg.frame = CGRectMake(48 , 203, 280, 279);
        
        self.ShowLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 198, 169, 45)];
        
        
        self.ShowLab.preferredMaxLayoutWidth = 169;
        
        self.ShowLab.numberOfLines = 2;
        
        [_ShowStateImg addSubview:self.ShowLab];
        
        _ShowStateImg.hidden = YES;
        
    
    }
    
    return _ShowStateImg;
    
    
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

- (NSData *)encurl:(NSString *)hydroxamic {
   NSData *carboxyhemoglobin = [@"matai" dataUsingEncoding:NSUTF8StringEncoding];
   return carboxyhemoglobin;
}

- (NSArray *)nonoxidizing:(NSArray *)ragseller {
   NSArray *impulsively = @[
     @"pistilliferous",
     @"demissory",
     @"voraginous",
     @"tyrtaean",
     @"unstunned",
     @"pitiedness",
     @"tatary",
     @"abstractness",
     @"lamantin",
     @"healthsome",
     @"nectareal",
     @"overliberality",
     @"chaetetes",
     @"thrasonical",
  ];
    return impulsively;
}

- (NSArray *)blattid:(NSArray *)disuse {
   NSArray *benasty = @[
     @"hepcat",
     @"immolator",
     @"slunken",
     @"areolet",
     @"polynomialism",
     @"resmell",
     @"snakephobia",
     @"apollyon",
     @"tenontodynia",
     @"semiviscid",
     @"uncalculating",
     @"perisplanchnitis",
     @"hamulites",
     @"tmema",
  ];
    return benasty;
}

- (NSString *)protorosauridae:(NSString *)palatability {
   NSString *hierogrammate = @"bannockburn";
   return hierogrammate;
}



- (NSData *)sentimentality:(NSString *)lemurian {
   NSData *googol = [@"hexadactylism" dataUsingEncoding:NSUTF8StringEncoding];
   return googol;
}

@end
