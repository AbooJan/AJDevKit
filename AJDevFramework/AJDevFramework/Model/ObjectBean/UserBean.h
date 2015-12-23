//
//  UserBean.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/22.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "ObjectBeanBase.h"

@interface UserBean : ObjectBeanBase
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@end
