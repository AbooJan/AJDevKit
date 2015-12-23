//
//  GlobalInstance.h
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/10.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBean.h"

@interface GlobalInstance : NSObject
AS_SINGLETON(GlobalInstance)

- (BOOL)checkLoginStatus;

- (void)saveUser:(UserBean *)user;
- (UserBean *)user;

@end
