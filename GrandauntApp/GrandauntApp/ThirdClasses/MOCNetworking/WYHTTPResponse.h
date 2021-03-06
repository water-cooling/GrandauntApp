//
//   WYHTTPResponse.h
//   HealthCloud
//
//   Created by lihaibo on 15/10/26.
//   Copyright © 2015年 bomei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYHTTPResponse : NSObject

@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) NSDictionary *dataDictionary;// 服务器返回的是字典,就保存在这里
@property (nonatomic, strong) NSArray *dataArray;// 服务器返回的是数组,就保存在这里
@property (nonatomic, strong) id data;// 用于存储从服务器获得的原始数据,部分地方要用到原始数据保存到plist
@property (nonatomic, strong) NSString *point;// 积分传递前端显示
@property (nonatomic, strong) NSError *error;// 请求数据失败时返回的error

@end
