//
//  LoginUser.h
//  FuelTreasureProject
//
//  Created by 吴仕海 on 4/7/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginUser : NSObject

+(LoginUser *)sharedInstance;
@property (nonatomic, strong) NSString *rowId;//主键    string
@property (nonatomic, strong) NSString *createBy;//创建人    string
@property (nonatomic, strong) NSString *createTime;//创建时间   string
@property (nonatomic, strong) NSString *modifyBy;//更新人   string
@property (nonatomic, strong) NSString *modifyTime;//更新时间    string
@property (nonatomic, strong) NSString *isDeleted;//删除标识    string
@property (nonatomic, strong) NSString *growthValue;//成长值    string
@property (nonatomic, strong) NSString *mail;//邮箱    string
@property (nonatomic, strong) NSString *commonOil;//常用油品    string
@property (nonatomic, strong) NSString *nickname;//昵称    string
@property (nonatomic, strong) NSString *oilTimes;//加油次数    string
@property (nonatomic, strong) NSString *password;//密码    string
@property (nonatomic, strong) NSString *payPwd;//支付密码    string
@property (nonatomic, strong) NSString *phone;//手机号    string
@property (nonatomic, strong) NSString *status;//状态    string
@property (nonatomic, strong) NSString *userLevel;//userLevel    string
@property (nonatomic, strong) NSString *token;//token    string
@property (nonatomic, strong) NSString *isPartner;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *levelName;
@property (nonatomic , copy) NSString       * partnerLevel;
@property (nonatomic , copy) NSString      * goodProportion;
@property (nonatomic , copy) NSString              * sale;
@property (nonatomic , copy) NSString             * level;
@property (nonatomic , copy) NSString              * row_id;
@property (nonatomic , copy) NSString             * saleNeed;


@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isNotFirstLogin;//不是第一次登陆


//+(void) clearPointAlert;


+ (BOOL)isAutoLogin;
//+ (void)login:(NSString *)tel pwd:(NSString *)pwd serverPackage:(NSDictionary *)dictionary;
+ (void)logout;
+ (void)parseLoginUserInfoFromUserDefaults;
+ (void)updateBaseUser:(NSDictionary *) user;
//消息钻取
//二维码钻取
//+ (void)qrcodeDrill:(id) cself type:(NSInteger) type value:(NSString *) value;

@end
