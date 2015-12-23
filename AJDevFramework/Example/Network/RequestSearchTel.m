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

@end
