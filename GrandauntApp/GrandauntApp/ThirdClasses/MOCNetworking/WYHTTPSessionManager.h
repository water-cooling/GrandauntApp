// 
//   WYHTTPSessionManager.h
//   HealthCloud
//
//   Created by lihaibo on 15/10/26.
//   Copyright © 2015年 bomei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYHTTPResponse.h"

extern NSString * const moc_http_request_operation_manager_response_server_error_message;
extern NSString * const moc_http_request_operation_manager_response_server_error_code;
extern NSString * const moc_http_request_operation_manager_response_network_error_message;
extern NSString * const moc_http_request_operation_manager_response_network_error_code;
extern NSString * const moc_http_request_operation_manager_response_token_error_message;
extern NSString * const moc_http_request_operation_manager_response_token_error_code;
extern NSString * const moc_http_request_operation_manager_response_other_error_message;
extern NSString * const moc_http_request_operation_manager_response_other_error_code;

typedef void (^MOCResponseBlock)(WYHTTPResponse *response,NSError *error);

@interface WYHTTPSessionManager : NSObject

+ (void)setupRequestOperationManagerBaseURLString:(NSString *)baseURLString;
// 必须调一次的初始化函数
+ (void)setupRequestOperationManagerdataKey:(NSString *)dataKey                   messageKey:(NSString *)messageKey;

/*
 对请求参数统一说明
 url除去baseURL后的地址部分
 aclass 需要解析成的对象模型,aclass继承于JSONModel
 parameters传给服务器的参数(除去公用头)
 success 请求成功,并且操作完成调用
 failed  请求失败,或者请求成功操作失败调用
 complete 请求完成后统一调用
 
 */
+ (NSURLSessionTask * )requestWithURL:(NSString *)url post:(BOOL)isPost class:(Class)aclass parameters:(id)parameters timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(MOCResponseBlock)completionHandler;

// 需要重载的方法
- (BOOL)validateTokenIsLegal:(id)responseObject;// 验证token
- (id)packageParameters:(id)parameters;// 封装头部
- (void)cancelRequest;

@end

