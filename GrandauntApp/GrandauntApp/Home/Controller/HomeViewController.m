//
//  HomeViewController.m
//  eleoke
//
//  Created by humengfan on 2018/7/17.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "HomeViewController.h"
#import "EleokeHomeNewsController.h"
#import "EleokeHomePolicyController.h"
#import "SeachHistoryView.h"
#import "BaseNavigationController.h"
#import "SignViewController.h"
@interface HomeViewController ()<UISearchBarDelegate,HistoryDidSelectDelegate,FGScrollviewDelegate>
@property (nonatomic,strong)UISearchBar * searchbar;

@property (nonatomic,strong)UIButton * backBtn;

@property(nonatomic,strong)FGContentView * contentView;

@property(nonatomic,strong)EleokeHomeNewsController * CurrentVc;

@property(nonatomic,strong)FGScrollSegmentView *segmentView;

@property(nonatomic,strong)SeachHistoryView * history;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,assign)NSInteger  SelectIndex;
@property(nonatomic,strong)NSArray * TitleArr;

@property(nonatomic,assign)BOOL  HistoryUp;


@property(nonatomic,strong)SignViewController * sign;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.contentView];
    UIView * view = [[UIView alloc]init];

     self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.backBtn.frame = CGRectMake(0, 13, 10, 15);
    
    self.backBtn.hidden = YES;
    [self.backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(BackClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.backBtn];
    
    self.searchbar.frame = CGRectMake(0, 8, UISCREENWIDTH-100 ,28);
    self.searchbar.clipsToBounds = YES;
    [view addSubview:self.searchbar];

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    [button addTarget:self action:@selector(seachClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    self.navigationItem.titleView = view;

    self.navigationItem.titleView.frame = CGRectMake(0, 0, UISCREENWIDTH-30, 44);
 
    button.frame =  CGRectMake(self.navigationItem.titleView.width - 35, 13, 35 , 16);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(login) name:LoginIn object:nil];
    [self LoadingSignCount];
 
}

-(void)login{
    
}

- (void)DeleteHistoryData
{
    if (self.dataSource.count) {
        
        [self.dataSource removeAllObjects];
        
        self.history.dataSource = self.dataSource;
        
        [NSKeyedArchiver archiveRootObject:self.dataSource toFile:KHistorySearchPath];
    }
}

-(void)LoadingSignCount{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDate *now = [NSDate date];
    
    NSDate *agoDate = [userDefault objectForKey:@"nowDate"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *ageDateString = [dateFormatter stringFromDate:agoDate];
    
    NSString *nowDateString = [dateFormatter stringFromDate:now];
    
    if ([nowDateString isEqualToString:ageDateString]) {
        
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"readArticleNum"]) {
        
        [[NSUserDefaults standardUserDefaults]setObject:@(5) forKey:@"readArticleNum"];
    }
 
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.searchbar resignFirstResponder];
    
}

-(NSInteger)numberOfChildViewControllers
{
    
    return self.TitleArr.count;
    
}




-(UIViewController<FGScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<FGScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index{
    
    
    EleokeHomeNewsController *childVc = (EleokeHomeNewsController *)reuseViewController;
    
    if (childVc == nil) {
        
        childVc =   [[EleokeHomeNewsController alloc]initWithStyle:UITableViewStylePlain];
    }
    
    self.CurrentVc = childVc;
    
    return childVc;
    
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController forIndex:(NSInteger)index
{
    self.SelectIndex = index;

    EleokeHomeNewsController *childVc = (EleokeHomeNewsController *)childViewController;
    
    childVc.SelectIndex = self.SelectIndex;
    
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index

{
    
    [self.searchbar resignFirstResponder];
    self.searchbar.text = @"";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(FGScrollSegmentView *)segmentView{
    
    if (!_segmentView) {
        __weak typeof(self) weakSelf = self;
        
        _segmentView = [[FGScrollSegmentView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, UISCREENWIDTH, 40) WithTitleArr:self.TitleArr delegate:self titleDidClick:^(NSString *Str, NSInteger index) {
            
            weakSelf.SelectIndex = index;
            
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.width * index, 0.0) animated:NO];
            
        }];
        _segmentView.backgroundColor = [UIColor whiteColor];
        _segmentView.layer.borderWidth = 1;
        _segmentView.layer.borderColor = [UIColor colorWithHexString:@"#F3F3F3"].CGColor;
    }
    return _segmentView;
}

- (FGContentView *)contentView {
    if (_contentView == nil) {
        
        FGContentView *content = [[FGContentView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight + 40, UISCREENWIDTH, UISCREENHEIGHT -SafeAreaTopHeight-40-49) segmentView:self.segmentView parentViewController:self delegate:self];
        _contentView = content;
    }
    return _contentView;
}




#pragma mark SeachbarDelelgate


- (void)BackClick{
    self.backBtn.hidden = YES;
    self.searchbar.frame = CGRectMake(0, 8, 298*iPhonescale ,28);
    [self.view sendSubviewToBack:self.history];
    [self.searchbar resignFirstResponder];
}


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        
        [self.view bringSubviewToFront:self.history];
        self.backBtn.hidden = NO;
        self.searchbar.frame = CGRectMake(24, 8, 275, 28);
        
    } else {
        
        [self.view sendSubviewToBack:self.history];
        
    }
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        
        [self.view bringSubviewToFront:self.history];
  
        
        self.backBtn.hidden = NO;
        
        self.searchbar.frame = CGRectMake(24, 8, 275, 28);
        
    } else {
        
        [self.view sendSubviewToBack:self.history];
        
    }
    
    self.CurrentVc.seachStr = searchBar.text;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchbar resignFirstResponder];

    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        
        [AlerShowManager showBriefAlert:@"请输入搜索内容"];

        return;
        
    }
    for (int i = 0; i < self.dataSource.count; i++) {
        
        if ([_dataSource[i] isEqualToString:searchBar.text]) {
            [_dataSource removeObjectAtIndex:i];
            break;
        }
    }
    
    [self.dataSource insertObject:searchBar.text atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:KHistorySearchPath];
    
    self.history.dataSource = self.dataSource;
    
    [self.view sendSubviewToBack:self.history];
    
    [self.CurrentVc SeachContent:searchBar.text];
    
    
    

}

-(void)didSelectIndexStr:(NSString *)Title
{
    self.searchbar.text = Title;
    
    [self.view sendSubviewToBack:self.history];
    
    [self.CurrentVc SeachContent:self.searchbar.text];

    
}


-(void)seachClick{
    
    [self.searchbar resignFirstResponder];

    if (self.searchbar.text == nil || [self.searchbar.text length] <= 0) {
        
        [AlerShowManager showBriefAlert:@"请输入搜索内容"];
        
        return;
        
    }
    for (int i = 0; i < self.dataSource.count; i++) {
        
        if ([_dataSource[i] isEqualToString:self.searchbar.text]) {
            
            [_dataSource removeObjectAtIndex:i];
            
            break;
        }
    }
    
    [self.dataSource insertObject:self.searchbar.text atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:KHistorySearchPath];
    
    self.history.dataSource = self.dataSource;
    
    [self.view sendSubviewToBack:self.history];
    
    [self.CurrentVc SeachContent:self.searchbar.text];

}


-(NSArray *)TitleArr
{
    if (!_TitleArr) {
        
        _TitleArr = [NSArray arrayWithObjects:@"资讯",@"号外",@"行情",@"专栏",@"政策",nil];
    }
    
    return _TitleArr;
    
}

-(UISearchBar *)searchbar{
    
    if (_searchbar == nil) {
        
        _searchbar = [[UISearchBar alloc]init];
        _searchbar.placeholder = @"搜索关键字";
        for (UIView *view in _searchbar.subviews) {
            
            for (UIView * subviews in view.subviews) {
                
                if ( [ subviews isKindOfClass:NSClassFromString(@"UISearchBarBackground").class]) {
                    
                    subviews.alpha = 0;
                }
            }
        }
        
        UITextField *textfield;
        if (@available(iOS 13.0, *)) {
                  // 针对 13.0 以上的iOS系统进行处理
                  NSUInteger numViews = [_searchbar.subviews count];
                  for(int i = 0; i < numViews; i++) {
                     if([[_searchbar.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
                         textfield = [_searchbar.subviews objectAtIndex:i];
                     }
                  }
              }else {
                  // 针对 13.0 以下的iOS系统进行处理
                textfield = [_searchbar valueForKey:@"_searchField"];
        }

        textfield.borderStyle = UITextBorderStyleNone;
        [textfield setBackgroundColor:[UIColor whiteColor]];
        [[UISearchBar appearance] setSearchFieldBackgroundImage:[self searchFieldBackgroundImage] forState:UIControlStateNormal];
        [textfield setDefaultTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.5]}];
        _searchbar.searchTextPositionAdjustment = UIOffsetMake(7, 0);
        
        textfield.layer.cornerRadius = 14;
        textfield.layer.masksToBounds = YES;
        
        [_searchbar setImage:[UIImage imageNamed:@"小搜索"]forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        _searchbar.delegate = self;
        
        _searchbar.showsBookmarkButton = NO;
        
        if ([[UIDevice currentDevice] systemVersion].doubleValue >= 11.0) {
            
            textfield.frame = CGRectMake(12, 8, _searchbar.width, 28);
            
        }else{
            
            textfield.frame = CGRectMake(0, 8, _searchbar.width, 28);
            
            [self setLeftPlaceholder];
        }
        
        
    }
    
    return _searchbar;
    
}


- (UIImage*)searchFieldBackgroundImage {
    UIColor*color = [UIColor whiteColor];
    CGFloat cornerRadius = 5;
    CGRect rect =CGRectMake(0,0,28,28);
    
    UIBezierPath*roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth=0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)setLeftPlaceholder {
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}


-(SeachHistoryView *)history
{
    
    if (!_history) {
        
        _history  = [[SeachHistoryView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, UISCREENWIDTH, UISCREENHEIGHT-SafeAreaTopHeight-(kDevice_iPhoneX? 34:0))];
        _history.dataSource = self.dataSource;
        
        _history.delegate = self;
        [self.view addSubview:_history];
    }
    
    return _history;
    
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
        if (!_dataSource) {
            
            
            _dataSource = [NSMutableArray array];
        }
    }
    return _dataSource;
}

- (NSString *)boswelliana:(NSString *)seasonableness {
   NSString *hemidystrophy = @"centrolinead";
   return hemidystrophy;
}



- (NSDictionary *)oki:(NSArray *)jainist {
   NSDictionary *excitosecretory = @{
      @"synoptist" : @"offcome",
      @"undiminishableness" : @"bookless",
      @"gloaming" : @"sarcoptidae",
      @"downlie" : @"slangous",
      @"jumby" : @"fulgid",
      @"multifidous" : @"bookkeeping",
      @"recollectedness" : @"xanthione",
      @"reneague" : @"jaggy",
      @"scruff" : @"waugh",
  };
    return excitosecretory;
}

- (NSString *)camerate:(NSString *)unillumination {
   NSString *unkenneled = @"anatolian";
   return unkenneled;
}



- (NSData *)expanded:(NSString *)ancienty {
   NSData *aftershine = [@"reshare" dataUsingEncoding:NSUTF8StringEncoding];
   return aftershine;
}

- (NSArray *)sempervivum:(NSArray *)lodgeman {
   NSArray *spunkily = @[
     @"soniferous",
     @"stodgily",
     @"parquetry",
     @"beroll",
     @"cysticercoid",
     @"xerophthalmy",
     @"photographee",
     @"tashlik",
     @"arrogatingly",
     @"fervid",
     @"cecils",
     @"incaliculate",
     @"aragonian",
     @"transverser",
  ];
    return spunkily;
}

@end
