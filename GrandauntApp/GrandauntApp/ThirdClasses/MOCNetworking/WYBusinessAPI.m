//
//  WYBusinessAPI.m
//  HealthCloud
//
//  Created by lihaibo on 15/10/26.
//  Copyright © 2015年 bomei. All rights reserved.
//
#import "WYBusinessAPI.h"
@implementation WYBusinessAPI

+ (NSURLSessionTask *)wy_postHostAddressWithURL:(NSString *)partUrl parameters:(id)parameters post:(BOOL)isPost  completionHandler:(MOCResponseBlock)completionHandler{
//    DLog(@"%@",parameters);
    return [WYBusinessAPI postWithURL:[kHostAddressForHttp wy_stringByAppendingUrlPathComponent:partUrl]  method:partUrl post:isPost aclass:nil parameters:parameters timeoutInterval:20 completionHandler:completionHandler];
}
#pragma mark -
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters post:(BOOL)isPost completionHandler:(MOCResponseBlock)completionHandler{
    return [WYBusinessAPI postWithURL:url method:method post:isPost aclass:nil parameters:parameters timeoutInterval:0 completionHandler:completionHandler];
}
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method parameters:(id)parameters post:(BOOL)isPost timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(MOCResponseBlock)completionHandler{
    return [WYBusinessAPI postWithURL:url method:method post:isPost aclass:nil parameters:parameters timeoutInterval:timeoutInterval completionHandler:completionHandler];
}
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method post:(BOOL)isPost class:(Class)aclass parameters:(id)parameters completionHandler:(MOCResponseBlock)completionHandler{
    return [WYBusinessAPI postWithURL:url method:method post:isPost aclass:aclass parameters:parameters timeoutInterval:0 completionHandler:completionHandler];
}
+ (NSURLSessionTask *)wy_postWithURL:(NSString *)url method:(NSString *)method post:(BOOL)isPost class:(Class)aclass  parameters:(id)parameters timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(MOCResponseBlock)completionHandler{
    return [WYBusinessAPI postWithURL:url method:method post:isPost aclass:aclass parameters:parameters timeoutInterval:timeoutInterval completionHandler:completionHandler];
}

#pragma mark -
+ (NSURLSessionTask *)postWithURL:(NSString *)url method:(NSString *)method post:(BOOL)isPost aclass:(Class)aclass parameters:(id)parameters timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(MOCResponseBlock)completionHandler{
    return [WYBusinessAPI requestWithURL:url method:method post:isPost aclass:aclass parameters:parameters timeoutInterval:timeoutInterval completionHandler:completionHandler];
}
+ (NSURLSessionTask *)requestWithURL:(NSString *)url method:(NSString *)method post:(BOOL)isPost aclass:(Class)aclass parameters:(id)parameters timeoutInterval:(NSTimeInterval)timeoutInterval completionHandler:(MOCResponseBlock)completionHandler{
    return [WYBusinessAPI requestWithURL:url post:isPost class:aclass parameters:parameters timeoutInterval:timeoutInterval completionHandler:completionHandler];
}

#pragma mark -
//override
- (BOOL)validateTokenIsLegal:(id)responseObject{
    
    return YES;
}

@end
