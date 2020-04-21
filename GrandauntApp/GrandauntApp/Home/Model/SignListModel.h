//
//  SignListModel.h
//  eleoke
//
//  Created by humengfan on 2018/8/23.
//  Copyright © 2018年 王师傅 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignListModel : NSObject

@property(nullable,copy)NSString  * day;
@property(nullable,copy)NSString  * pearlNum;

@end



@interface SignListdataModel : NSObject

@property (nonatomic,assign)long long int time;
@property (nonatomic,strong) NSMutableArray * response;


@end

@interface SignListModels : NSObject

@property (nonatomic,assign)int code;
@property (nonatomic,strong) SignListdataModel * data;
@property (nonatomic,strong) NSMutableArray * messages;

@property(nonatomic,strong) UITableView *bret;

@property(nonatomic,strong) NSDictionary *pesthole;

@property(nonatomic,strong) NSString *geonim;

@property(nonatomic,strong) NSString *unexactingly;

@property(nonatomic,strong) UILabel *agamobium;
@end
