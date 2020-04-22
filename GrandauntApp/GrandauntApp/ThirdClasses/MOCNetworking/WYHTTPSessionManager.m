//
//   WYHTTPSessionManager.m
//   HealthCloud
//
//   Created by lihaibo on 15/10/26.
//   Copyright © 2015年 bomei. All rights reserved.
//

// #import "MainTabBarController.h"
NSString * const moc_http_request_operation_manager_response_server_error_message = @"系统开小差,请稍后重试";
NSString * const moc_http_request_operation_manager_response_server_error_code = @"9989";
NSString * const moc_http_request_operation_manager_response_network_error_message = @"网络异常,请检查网络是否正常";
NSString * const moc_http_request_operation_manager_response_network_error_code = @"9998";
NSString * const moc_http_request_operation_manager_response_token_error_message = @"登录失效,请重新登录";
NSString * const moc_http_request_operation_manager_response_token_error_code = @"9899";

NSString * const moc_http_request_operation_manager_response_other_error_message = @"系统开小差,请稍后重试";
NSString * const moc_http_request_operation_manager_response_other_error_code = @"8999";
NSString *moc_http_request_operation_manager_base_url_string;// base URL
static NSString *moc_http_request_operation_manager_base_request_data_key;// 数据部分
static NSString *moc_http_request_operation_manager_base_request_message_key;// 错误信息部分

NSString *moc_http_request_operation_manager_token;

@interface WYHTTPSessionManager ()
@property (nonatomic, strong) WYHTTPResponse *response;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation WYHTTPSessionManager

+ (void)setupRequestOperationManagerBaseURLString:(NSString *)baseURLString{
    moc_http_request_operation_manager_base_url_string = baseURLString;
}
+ (void)setupRequestOperationManagerdataKey:(NSString *)dataKey                   messageKey:(NSString *)messageKey{
    NSAssert(!IsStrEmpty(dataKey), @"数据key不能为空");
    NSAssert(!IsStrEmpty(messageKey), @"信息key不能为空");
    moc_http_request_operation_manager_base_request_data_key = dataKey;
    moc_http_request_operation_manager_base_request_message_key  = messageKey;
}


// 获取证书
+ (AFSecurityPolicy *)customSecurityPolicy
{
    // 先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    // validatesDomainName 是否需要验证域名，默认为YES；
    // 假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    // 置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    // 如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}



+(void)requestHeader:(WYHTTPSessionManager *)client parameters:(NSDictionary *)parameters{
    [client.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}


#pragma mark -
+ (NSURLSessionTask *)requestWithURL:(NSString *)url
                                post:(BOOL)isPost
                               class:(Class)class
                          parameters:(id)parameters
                     timeoutInterval:(NSTimeInterval)timeoutInterval
                   completionHandler:(MOCResponseBlock)completionHandler{
    
    NSAssert(url, @"请求地址不能为空");
    
    WYHTTPSessionManager *client = [WYHTTPSessionManager manager];
    client.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    client.manager.securityPolicy.allowInvalidCertificates = YES;
    [client.manager.securityPolicy setValidatesDomainName:NO];
    [WYHTTPSessionManager requestHeader:client parameters:parameters];
    
    if (timeoutInterval > 0) {
        [client.manager.requestSerializer setTimeoutInterval:timeoutInterval];
    }
    
//     if (![GlobalFunc shareAppDelegate].isNetWork) {// 网络不可达
//
//         [client parseResponseFailed:nil task:nil completionHandler:completionHandler logInfo:@"网络不可达"];
//         return nil;
//     }
    
    
    
    if (isPost) {
        NSURLSessionTask *task = [client.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
            [client parseResponseSuccess:responseObject task:task class:class completionHandler:completionHandler logInfo:nil];// [NSString stringWithFormat:@"%@",[parameters objectForKey:@"METHOD"]]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [client parseResponseFailed:error task:task completionHandler:completionHandler logInfo:error.domain];
        }];
        return task;
    }else{
        NSURLSessionTask *task = [client.manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [client parseResponseSuccess:responseObject task:task class:class completionHandler:completionHandler logInfo:nil];// [NSString stringWithFormat:@"%@",[parameters objectForKey:@"METHOD"]]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [client parseResponseFailed:error task:task completionHandler:completionHandler logInfo:error.domain];
        }];
        return task;
    }
}

+ (void)initIntegralDisplay:(NSString *) point PointType:(NSString *)type
{
    mainBlock(^{
        // 增加积分
        //         [[MainTabBarController sharedInstance] pointAlertView:point title:type content:[NSString stringWithFormat:@"%@宝币",point]];
    });
}

#pragma mark -
// data为对应部分的数据
- (void)parseResponseSuccess:(id)responseObject
                        task:(NSURLSessionDataTask *)task
                       class:(Class)class
           completionHandler:(MOCResponseBlock)completionHandler
                     logInfo:(NSString *)info
{
//    WYLog(@"%@:%@",info,(NSDictionary *)responseObject);
    self.response.data = responseObject;
    if ([self validateTokenIsLegal:responseObject]){// token合法
        // 如果code is null
      
        if ([responseObject[@"code"] isEqualToString:@"200"]) {// 返回成功
            id data = [responseObject objectForKey:moc_http_request_operation_manager_base_request_data_key];
            
            if ([data isKindOfClass:[NSString class]]) {
                id parseData = [data parseToArrayOrNSDictionary];// 解析前的数据保存
                if ([parseData isKindOfClass:[NSDictionary class]]) {
                    self.response.dataDictionary = parseData;
                }else if ([parseData isKindOfClass:[NSArray class]]) {
                    [self parseServerJsonArrayToJSONModel:parseData class:class];
                }
            }if ([data isKindOfClass:[NSDictionary class]]) {
                self.response.dataDictionary = data;
            }else if ([data isKindOfClass:[NSArray class]]) {
                [self parseServerJsonArrayToJSONModel:data class:class];
            }
    completionHandler?completionHandler(self.response,nil):nil;// 成功
        }else{
            [self parseResponseFailed:responseObject task:task completionHandler:completionHandler logInfo:info];
        }
    }else{// token不合法
        self.response.errorCode = moc_http_request_operation_manager_response_token_error_code;
        self.response.errorMessage = moc_http_request_operation_manager_response_token_error_message;
        completionHandler?completionHandler(self.response,[[NSError alloc] initWithDomain:moc_http_request_operation_manager_response_token_error_message code:moc_http_request_operation_manager_response_token_error_code.integerValue userInfo:nil]):nil;// 失败
    }
}

// data 可能为NSError 或者NSDictionary
- (void)parseResponseFailed:(id)responseObject
                       task:(NSURLSessionDataTask *)task
          completionHandler:(MOCResponseBlock)completionHandler
                    logInfo:(NSString *)info{
    //     NSLog(@"%@",responseObject);
    if (@available(iOS 10.0, *)) {
        if (![Common getNetWorkStates]) {// 网络不可达
            self.response.errorCode = moc_http_request_operation_manager_response_network_error_code;
            self.response.errorMessage = moc_http_request_operation_manager_response_network_error_message;
        }else{
            if ([responseObject isKindOfClass:[NSError class]]) {// failed block里面的error
                self.response.error = responseObject;
                self.response.errorCode = [NSString stringWithFormat:@"%@",@([(NSError *)responseObject code])];
                self.response.errorMessage = [responseObject localizedDescription];
                
                self.response.error = responseObject;
            }else{// 服务器请求成功,但是操作失败,这个需要由外部定义成功码
        }
    }
    NSError *error = self.response.error?:[[NSError alloc] initWithDomain:self.response.errorMessage ? self.response.errorMessage :@"" code:self.response.errorCode.integerValue userInfo:nil];
    completionHandler?completionHandler(self.response,error):nil;
    }
}

// 解析服务器的数据到对应的response里面去
- (void)parseServerJsonArrayToJSONModel:(NSArray *)array class:(Class)class{
        self.response.dataArray = array;
}
#pragma mark -
+ (WYHTTPSessionManager *)manager{
    WYHTTPSessionManager *client = [[WYHTTPSessionManager alloc] init];
    if (IsStrEmpty(moc_http_request_operation_manager_base_url_string)){
        client.manager= [AFHTTPSessionManager manager];
        client.response = [[WYHTTPResponse alloc] init];
        [client clientSetup];
        return client;
    }else{
        NSURL *baseURL = [[NSURL alloc] initWithString:moc_http_request_operation_manager_base_url_string];
        if (baseURL) {
            client.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        }else{
            client.manager = [AFHTTPSessionManager manager];
        }
        client.response = [[WYHTTPResponse alloc] init];
        [client clientSetup];
        return client;
    }
}

- (void)clientSetup{
    
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"text/json", nil];
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];

    
}

#pragma mark -
// 具体工程中建议重载的部分
- (BOOL)validateTokenIsLegal:(id)responseObject{
    return YES;
}
- (id)packageParameters:(id)parameters{
    return parameters;
}
- (void)cancelRequest{
    [self.manager.operationQueue cancelAllOperations];
}

@end

