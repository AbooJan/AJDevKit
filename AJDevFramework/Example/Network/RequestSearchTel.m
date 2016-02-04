//
//  RequestSearchTel.m
//  YTKDemo
//
//  Created by 钟宝健 on 15/8/14.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import "RequestSearchTel.h"

@implementation RequestBeanSearchTel

- (NSString *)requestUrl {
    return @"/apistore/mobilephoneservice/mobilephone";
}

- (NSArray *)ignoreArgumentNames
{
    return @[@"telNum"];
}

- (NSDictionary *)configArguments
{
    return @{@"tel_local" : @"tel"};
}

- (NSInteger)cacheTimeInSeconds
{
    // 2 秒内，重复请求，会直接读缓存（如果存在），不真正发起新的请求
    return 10.0;
}

@end
