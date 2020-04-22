//
//  MySweetTableViewController.m
//  bihucj
//
//  Created by humengfan on 2018/8/30.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "MySweetTableViewController.h"
#import "SweetTableViewCell.h"
#import <MJRefresh.h>
@interface MySweetTableViewController ()
@property(nonatomic,assign)NSInteger DownIndex;

@end

@implementation MySweetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的糖果";
    self.tableView.tableFooterView = [UIView new];

    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeVideoCell" bundle:nil] forCellReuseIdentifier:@"HomeVideoCell"];
    __weak typeof(self) weakself = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakself.DownIndex = 1;
        [weakself.tableView.mj_footer resetNoMoreData];
        
        [self loadingSweetData:self.DownIndex isRefresh:YES];

    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakself.DownIndex +=1;
        weakself.tableView.mj_footer.hidden = NO;
        
        [self loadingSweetData:self.DownIndex isRefresh:NO];
    }];
    
 
}

-(void)rightBarclick{
    
}

-(void)loadingSweetData:(NSInteger)count isRefresh:(BOOL)isdown{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SweetCell"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
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
