//
//  WeiboStatusBean.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/25.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJDBObject.h"
#import "TestUserBean.h"
#import "CommentBean.h"

@interface WeiboStatusBean : AJDBObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) RLMArray<TestUserBean *><TestUserBean> *parseUsers;

@property (nonatomic, strong) RLMArray<CommentBean *><CommentBean> *comments;

@end

