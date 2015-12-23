//
//  ResponseBeanBase.h
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/9.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseBeanBase : NSObject

#warning !!!!! temp param

@property (nonatomic, assign) NSInteger errNum;
@property (nonatomic, copy) NSString *retMsg;

+ (NSDictionary *)mj_replacedKeyFromPropertyName;
@end
