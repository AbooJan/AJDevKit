//
//  ResponseBeanBase.h
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/9.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseBeanBase : NSObject

#warning !!!!temp param name
@property (assign, nonatomic) NSInteger code;
@property (copy, nonatomic) NSString *msg;

+ (NSDictionary *)mj_replacedKeyFromPropertyName;
@end
