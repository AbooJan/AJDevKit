//
//  RequestBeanBase.m
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/9.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "RequestBeanBase.h"

@implementation RequestBeanBase

/// 每个请求Bean继承必须实现该方法
- (NSString *)requestUrl
{
    return nil;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

@end
