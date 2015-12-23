//
//  RequestBeanBase.m
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/9.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "RequestBeanBase.h"

@implementation RequestBeanBase

#warning !!!!!
#warning 以下的配置为临时配置，具体配置根据项目不同
#warning !!!!!

/// 每个请求Bean继承必须实现该方法
- (NSString *)requestUrl
{
    return @"";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{@"apikey": @"61979cba44a3b9abb16c5127574dd2e5"};
}

@end
