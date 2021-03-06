//
//  YTKBaseRequest.m
//
//  Copyright (c) 2012-2014 YTKNetwork https://github.com/yuantiku
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "YTKBaseRequest.h"
#import "YTKNetworkAgent.h"
#import "YTKNetworkPrivate.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation YTKBaseRequest

/// for subclasses to overwrite
- (void)requestCompleteFilter {
}

- (void)requestFailedFilter {
}

- (NSString *)requestUrl {
    return @"";
}

- (NSString *)cdnUrl {
    return @"";
}

- (NSString *)baseUrl {
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 60;
}

- (id)requestArgument {
    
    unsigned int propCount;
    objc_property_t* properties = class_copyPropertyList([self class], &propCount);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:propCount];
    
    NSArray *ignoreParams = [self ignoreArgumentNames];
    
    NSDictionary *mappingPatamsDic = [self configArguments];
    
    for (int i=0; i<propCount; i++) {
        
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        
        NSString *originalKey = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
        
        //忽略参数
        if (ignoreParams) {
            if ([ignoreParams containsObject:originalKey]) {
                continue;
            }
        }
        
        // 填充请求字典
        if(propName) {
            
            NSString *changeKey;
            
            // 根据映射字典，修改请求参数名称
            if (mappingPatamsDic) {
                
                changeKey = [mappingPatamsDic valueForKey:originalKey];
                
            }else{
                changeKey = originalKey;
            }

            id value = [self valueForKey:originalKey];
            
            if (value) {
                [params setObject:value forKey:changeKey];
            }
            
        }
        
    }
    
    free(properties);
    
    return params;
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument {
    return argument;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

- (NSArray *)requestAuthorizationHeaderFieldArray {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return nil;
}

- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}

- (BOOL)useCDN {
    return NO;
}

- (id)jsonValidator {
    return nil;
}

- (BOOL)statusCodeValidator {
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <=299) {
        return YES;
    } else {
        return NO;
    }
}

- (AFConstructingBlock)constructingBodyBlock {
    return nil;
}

- (NSString *)resumableDownloadPath {
    return nil;
}

- (AFDownloadProgressBlock)resumableDownloadProgressBlock {
    return nil;
}

/// append self to request queue
- (void)start {
    [self toggleAccessoriesWillStartCallBack];
    [[YTKNetworkAgent sharedInstance] addRequest:self];
}

/// remove self from request queue
- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    self.delegate = nil;
    [[YTKNetworkAgent sharedInstance] cancelRequest:self];
    [self toggleAccessoriesDidStopCallBack];
}

- (BOOL)isExecuting {
    return self.requestOperation.isExecuting;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(YTKBaseRequest *request))success
                                    failure:(void (^)(YTKBaseRequest *request))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(YTKBaseRequest *request))success
                              failure:(void (^)(YTKBaseRequest *request))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (id)responseJSONObject {
    return self.requestOperation.responseObject;
}

- (NSData *)responseData {
    return self.requestOperation.responseData;
}

- (NSString *)responseString {
    return self.requestOperation.responseString;
}

- (NSInteger)responseStatusCode {
    return self.requestOperation.response.statusCode;
}

- (NSDictionary *)responseHeaders {
    return self.requestOperation.response.allHeaderFields;
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<YTKRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}


#pragma mark JSON 解析
- (ResponseBeanBase *)responseBean
{
    return [self responseBeanWithJSON:self.responseString];
}

- (ResponseBeanBase *)responseBeanWithJSON:(NSString *)json
{
    const char *requestClassName = class_getName([self class]);
    
    NSString *responseBeanName = [[NSString stringWithUTF8String:requestClassName] stringByReplacingOccurrencesOfString:@"Request" withString:@"Response"];
    
    const char *responseBeanName1 = [responseBeanName UTF8String];
    
    NSString *values = json;
    
    id response = [objc_getClass(responseBeanName1) mj_objectWithKeyValues:values];
    
    return response;
}

/**
 *  忽略的参数列表
 *
 *  @return 忽略的参数列表
 */
- (NSArray *)ignoreArgumentNames;
{
    return nil;
}

/**
 *  重新修改请求参数名称
 * 
 *  示例：{@“原来的参数名称”:@"服务器的请求参数名称"}
 *
 *  @return 参数名称映射字典
 */
- (NSDictionary *)configArguments
{
    return nil;
}

#pragma mark - 额外处理网络请求结果

- (void)extendHandleRequestSuccess
{
    // hub
    if (self.showHub) {
        [[AJHub shareInstance] dismiss];
    }
    
    // log消息
    NSDictionary *responseDic = [self.responseString mj_JSONObject];
    NSString *url = [NSString stringWithFormat:@"%@%@", [self baseUrl], [self requestUrl]];
    DLog(@"\n=======end request success=======\n\nURL: %@\n\nResult:\n%@\n\n ======= end ======= \n", url, responseDic);
    
    //TODO: Toast 处理
//    ResponseBeanBase *baseResponse = self.responseBean;
//    if (baseResponse.code == SUCCESS_CODE) {
//        // 成功
//    }else{
//        // 失败Toast
//        if (baseResponse.msg) {
//            [[AJToast shareInstance] showMessage:baseResponse.msg];
//        }
//    }
}

- (void)extendHandleRequestFailure
{
    // hub
    if (self.showHub) {
        [[AJHub shareInstance] dismiss];
    }
    
    // log消息
    NSDictionary *responseDic = [self.responseString mj_JSONObject];
    NSString *url = [NSString stringWithFormat:@"%@%@", [self baseUrl], [self requestUrl]];
    DLog(@"\n=======end request failure=======\n\nURL: %@\n\nCode: %ld\n\nResult:\n%@\n\n ======= end ======= \n", url, (long)self.responseStatusCode,responseDic);
    
    
     //TODO: Toast 处理
//    [[AJToast shareInstance] showMessage:@"网络不给力~"];
}

- (void)handleHub
{
    // Hub
    if (self.showHub) {
        if (self.hubMsg != nil && ![self.hubMsg isEqualToString:@""]){
            [[AJHub shareInstance] showHub:self.hubMsg];
        }else{
            [[AJHub shareInstance] showHub:@""];
        }
    }
}

@end
