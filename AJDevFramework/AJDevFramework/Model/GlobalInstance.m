//
//  GlobalInstance.m
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/10.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "GlobalInstance.h"


#define kSaveUserPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/User.data"]


@implementation GlobalInstance
DEF_SINGLETON(GlobalInstance)

- (BOOL)checkLoginStatus
{
    UserBean *user = [self user];
    if (user) {
        NSString *account = user.account;
        NSString *password = user.password;
        
        if (account != nil && !isEmptyString(account) && password != nil && !isEmptyString(password) ) {
            return YES;
        }
    }
    
    return NO;
}

- (void)saveUser:(UserBean *)user
{
    // Encoding
    BOOL isSaveSuccess = [NSKeyedArchiver archiveRootObject:user toFile:kSaveUserPath];
    DLog(@"归档用户信息：%d", isSaveSuccess);
}

- (UserBean *)user
{
    // Decoding
    UserBean *userBean = [NSKeyedUnarchiver unarchiveObjectWithFile:kSaveUserPath];
    
    return userBean;
}

@end
