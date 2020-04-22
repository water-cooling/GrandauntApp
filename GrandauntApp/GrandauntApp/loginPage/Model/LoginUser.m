//
//  LoginUser.m
//  FuelTreasureProject
//
//  Created by 吴仕海 on 4/7/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

//#import "MainTabBarController.h"

//钻取ViewController


//本地验证信息提示
#define MD_LOGIN_EXPIRED_DAY            3 //自动登录过期天数 3 天
#define USER_LOGIN_TIME_SAVE_KEY        @"USER_LOGIN_TIME_SAVE_KEY"
#define USER_LOGIN_NAME_SAVE_KEY        @"USER_LOGIN_NAME_SAVE_KEY"
#define USER_LOGIN_PWD_SAVE_KEY         @"USER_LOGIN_PWD_SAVE_KEY"

#define kLoginUserUserDefaultsKey       @"kLoginUserUserDefaultsKey"

@interface LoginUser ()

@end

@implementation LoginUser

+(LoginUser *)sharedInstance{
    static LoginUser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(& onceToken,^{
        sharedInstance = [[self alloc]init];
        [sharedInstance localSaveInit];
    });
    return sharedInstance;
}

+ (BOOL)isAutoLogin{
    NSString *strLastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOGIN_TIME_SAVE_KEY];
    if (IsStrEmpty(strLastUpdateTime)) {
        return NO;
    }
    NSDate *dateLastUpdate = [strLastUpdateTime dateFromSecondString];
    if (!dateLastUpdate) {
        return NO;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    unsigned int unitFlags = (kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay);
    
    NSDateComponents *dateComponents = [calendar components:unitFlags
                                                   fromDate:dateLastUpdate
                                                     toDate:[NSDate date] options:0];
    //判断保存日期
    if (dateComponents.year <= 0 && dateComponents.month <= 0 && dateComponents.day <= MD_LOGIN_EXPIRED_DAY) {
        return YES;
    }
    return NO;
}

+ (void)updateBaseUser:(NSDictionary *)user{ 
    [[LoginUser sharedInstance] setValuesForKeysWithDictionary:user];
}

-(void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value ? [NSString stringWithFormat:@"%@",value] : @"" forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

- (BOOL)isLogin {
    return [LoginUser sharedInstance].token.length ? YES : NO;
}

+ (void)logout{
    [LoginUser sharedInstance].isLogin = NO;
    [LoginUser sharedInstance].token=@"";
    //存储数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USERMODEL"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginUserUserDefaultsKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_LOGIN_TIME_SAVE_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_LOGIN_NAME_SAVE_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_LOGIN_PWD_SAVE_KEY];
}

//本地存储开启
- (void)localSaveInit{
    unsigned int propertyCount = 0;
    objc_property_t *propertyties = class_copyPropertyList([LoginUser class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++ ) {
        objc_property_t property = propertyties[i];
        const char * name = property_getName(property);
        [self addObserver:self forKeyPath:[NSString stringWithUTF8String:name] options:NSKeyValueObservingOptionNew context:NULL];
    }
}

//observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([change isKindOfClass:[NSDictionary class]]){
        id obj = [change objectForKey:@"new"];
        [self updateLoginUserInfoDictionary:keyPath value:obj];
    }
}
- (void)updateLoginUserInfoDictionary:(NSString *)key value:(id)value{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *loginUserInfoMutableDictionary = [standardUserDefaults objectForKey:kLoginUserUserDefaultsKey];
    if (!loginUserInfoMutableDictionary) {
        loginUserInfoMutableDictionary = [[NSMutableDictionary alloc] init];
    }else{
        loginUserInfoMutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:loginUserInfoMutableDictionary];
    }
    if (value != nil && value !=[NSNull null] && ![value isKindOfClass:[NSError class]] && [value isKindOfClass:[NSObject class]]) {
        
        [loginUserInfoMutableDictionary setObject:value forKey:key];
        [standardUserDefaults setObject:loginUserInfoMutableDictionary forKey:kLoginUserUserDefaultsKey];
        [standardUserDefaults synchronize];
    }
}

//读取本地存储
+ (void)parseLoginUserInfoFromUserDefaults{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *loginUserInfoMutableDictionary = [standardUserDefaults objectForKey:kLoginUserUserDefaultsKey];
    if (loginUserInfoMutableDictionary) {
        BOOL isLogin = [[loginUserInfoMutableDictionary objectForKeyedSubscript:@"isLogin"] boolValue];
        if (isLogin){
            unsigned int propertyCount = 0;
            objc_property_t *propertyties = class_copyPropertyList([LoginUser class], &propertyCount);
            for (unsigned int i = 0; i < propertyCount; i++ ) {
                objc_property_t property = propertyties[i];
                const char * name = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:name];
                id obj = [loginUserInfoMutableDictionary objectForKeyedSubscript:propertyName];
                if (![propertyName isEqualToString:@"isLogin"] && obj) {
                    [[LoginUser sharedInstance] setValue:obj forKey:propertyName];
                }
            }
        }
    }
}
@end
