//
//  EleokeEleokeHomeNewsController.m
//  eleoke
//
//  Created by humengfan on 2018/7/17.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import "EleokeHomePolicyController.h"
#import "HomeNewsCell.h"
#import <UIImageView+WebCache.h>

@interface EleokeHomePolicyController ()

@property(nonatomic,copy)NSString * seachStr;
@property(nonatomic,assign)NSInteger DownIndex;
@end

@implementation EleokeHomePolicyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.seachStr = @"";
    self.view.backgroundColor = [UIColor whiteColor ];

    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsCell" bundle:nil] forCellReuseIdentifier:@"HomeNewsCell"];
   
    self.tableView.tableFooterView = [UIView new];

    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    __weak typeof(self) weakself = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakself.DownIndex = 1;
        
        [weakself.tableView.mj_footer resetNoMoreData];
        
        [weakself loadingHomeNewsDataLoc:self.DownIndex count:10 tTitleLike:self.seachStr refresh:YES];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakself.DownIndex +=1;
        
        weakself.tableView.mj_footer.hidden = NO;
        
        [weakself loadingHomeNewsDataLoc:weakself.DownIndex count:10 tTitleLike:self.seachStr refresh:NO];
    }];
}

- (void)SeachContent:(NSString *)Str
{
    
    self.seachStr = Str;
    
    [self.tableView.mj_header beginRefreshing];
    
}


-(void)loadingHomeNewsDataLoc:(NSInteger)Loc count:(NSInteger)count tTitleLike:(NSString * )Str refresh:(BOOL)isdown{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 105;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSArray *)predelegate:(NSArray *)hobnailer {
   NSArray *ephydridae = @[
     @"blastocarpous",
     @"auricular",
     @"ungull",
     @"dishcloth",
     @"androtomy",
     @"culottes",
     @"fratercula",
     @"prebake",
     @"scandalizer",
     @"celtuce",
     @"paradidymal",
     @"incomprehensibility",
     @"untastefully",
     @"horsefish",
  ];
    return ephydridae;
}

- (UIImage *)kinesiometer:(UIImage *)pacifically {
   NSData *coetaneity = [@"hairstreak" dataUsingEncoding:NSUTF8StringEncoding];
   UIImage *unabsorbent = [UIImage imageWithData:coetaneity];
   return unabsorbent;
}



- (NSDictionary *)coelebogyne:(NSArray *)mannerliness {
   NSDictionary *forisfamiliation = @{
      @"courtcraft" : @"wangler",
      @"moorfowl" : @"anisometrope",
      @"tired" : @"geophagia",
      @"decapod" : @"exaspidean",
      @"semiegg" : @"engraftation",
      @"unmaterialistic" : @"enfolden",
      @"tigroid" : @"preceremonial",
      @"pucker" : @"oscular",
      @"mineragraphic" : @"afrikaans",
  };
    return forisfamiliation;
}

- (NSArray *)vegetablelike:(NSArray *)odinism {
   NSArray *denominationally = @[
     @"misquote",
     @"clypeastrina",
     @"thymelcosis",
     @"ponderously",
     @"hydrolyzable",
     @"scaw",
     @"fluoroborate",
     @"boshas",
     @"nonsugar",
     @"challote",
     @"repeatal",
     @"proclergy",
     @"isocyanide",
     @"agonizedly",
  ];
    return denominationally;
}

- (NSString *)preimpairment:(NSString *)incorrespondency {
   NSString *spionid = @"dermaptera";
   return spionid;
}



@end
