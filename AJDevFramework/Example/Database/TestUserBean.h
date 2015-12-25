//
//  TestUserBean.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/25.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJDBObject.h"

@interface TestUserBean : AJDBObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@end

RLM_ARRAY_TYPE(TestUserBean)
