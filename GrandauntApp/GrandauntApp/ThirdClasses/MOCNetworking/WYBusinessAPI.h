//
//   WYBusinessAPI.h
//   HealthCloud
//
//   Created by lihaibo on 15/10/26.
//   Copyright © 2015年 bomei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYHTTPSessionManager.h"

@interface WYBusinessAPI : WYHTTPSessionManager

// 通用请求,host 写死  不能控制超时时间
+ (NSURLSessionTask *)wy_postHostAddressWithURL:(NSString *)partUrl parameters:(id)parameters post:(BOOL)isPost  completionHandler:(MOCResponseBlock)completionHandler;

// 以下url全部要写完整
// post 数据不自动解析 不控制超时时间
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters post:(BOOL)isPost completionHandler:(MOCResponseBlock)completionHandler;

// post 数据不自动解析 控制超时时间
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters post:(BOOL)isPost timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(MOCResponseBlock)completionHandler;

// post 数据自动解析 不控制超时时间
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method post:(BOOL)isPost class:(Class)aclass parameters:(id)parameters completionHandler:(MOCResponseBlock)completionHandler;

// post 数据自动解析 控制超时时间
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method post:(BOOL)isPost class:(Class)aclass  parameters:(id)parameters timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(MOCResponseBlock)completionHandler;
@end
