//
//  EleokeHomeNewsController.m
//  eleoke
//
//  Created by humengfan on 2018/7/17.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "EleokeHomeNewsController.h"
#import <SDCycleScrollView.h>
#import "HomeNewsCell.h"
#import <MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BaseNavigationController.h"
@interface EleokeHomeNewsController ()<SDCycleScrollViewDelegate>
@property(nonatomic,assign)NSInteger DownIndex;
@property(nonatomic,strong) SDCycleScrollView * BannerView;
@end

@implementation EleokeHomeNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.seachStr = @"";
    self.view.backgroundColor = [UIColor whiteColor ];
    self.BannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 180)];
    self.BannerView.backgroundColor = [UIColor whiteColor];
    self.BannerView.autoScrollTimeInterval = 5.;// 自动滚动时间间隔
    self.BannerView.delegate = self;
    self.BannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;// 翻页
    self.BannerView.pageControlDotSize = CGSizeMake(14, 14);
    self.BannerView.currentPageDotColor = buttonSelectBackgroundColor;
    self.BannerView.pageDotColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    UIView  *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 190)];
    view.clipsToBounds = YES;
    view.backgroundColor = BackgroundColor;
    [view addSubview:self.BannerView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsCell" bundle:nil] forCellReuseIdentifier:@"HomeNewsCell"];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.tableHeaderView = view;
    self.tableView.tableFooterView = [UIView new];
    __weak typeof(self) weakself = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.DownIndex = 1;
        [weakself.tableView.mj_footer resetNoMoreData];
        [weakself loadingHomeNewsDataLoc:self.DownIndex count:10 tTitleLike:self.seachStr SelectIndex:self.SelectIndex refresh:YES];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.DownIndex +=1;
        weakself.tableView.mj_footer.hidden = NO;
        [weakself loadingHomeNewsDataLoc:weakself.DownIndex count:10 tTitleLike:weakself.seachStr SelectIndex:self.SelectIndex refresh:NO];
    }];
}

- (void)SeachContent:(NSString *)Str{
    self.seachStr = Str;
    [self loadingHomeNewsDataLoc:self.DownIndex count:10 tTitleLike:self.seachStr SelectIndex:self.SelectIndex refresh:YES];
}

- (void)zj_viewWillAppearForIndex:(NSInteger)index{
        self.DownIndex = 1;
        [self.tableView.mj_footer resetNoMoreData];
    self.seachStr = @"";
    [self loadingHomeNewsDataLoc:self.DownIndex count:10 tTitleLike:self.seachStr SelectIndex:self.SelectIndex refresh:YES];
}

-(void)loadingHomeNewsDataLoc:(NSInteger)Loc count:(NSInteger)count tTitleLike:(NSString * )Str SelectIndex:(NSInteger)index refresh:(BOOL)isdown{
    BOOL Adv ;
    if (index == 0 || index == 3) {
        Adv = NO;
    }else{
        Adv = YES;
    }
    NSLog(@"我们搜索的字符串是%@",Str);
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsCell" forIndexPath:indexPath];
//    [cell.RightIcon sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage new] options:SDWebImageLowPriority];
//    cell.TitleLab.text = model.tTitle;
//cell.TimeLab.text = [NSString stringWithFormat:@"%@ %ld %@",model.cFrom,(long)model.tDjcs,model.processDate];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;
}




#pragma mark bannerDelelgate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
   
    
}

- (NSString *)semicircularness:(NSString *)euphausiacea {
   NSString *shortwave = @"chlorimetry";
   return shortwave;
}



- (NSData *)unveracity:(NSString *)superheater {
   NSData *helichrysum = [@"blastocarpous" dataUsingEncoding:NSUTF8StringEncoding];
   return helichrysum;
}

- (NSString *)craterless:(NSString *)bilharzia {
   NSString *eponymism = @"protestable";
   return eponymism;
}



- (UIImage *)photographic:(UIImage *)subcrystalline {
   NSData *cosalite = [@"thiophosphoric" dataUsingEncoding:NSUTF8StringEncoding];
   UIImage *mbaya = [UIImage imageWithData:cosalite];
   return mbaya;
}



- (NSString *)declaredness:(NSString *)sulfureousness {
   NSString *labra = @"haemoconcentration";
   return labra;
}



@end
