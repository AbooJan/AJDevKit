//
//  StudentBean.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJDBObject.h"

@interface StudentBean : AJDBObject
@property   NSInteger   ID;
@property   NSString    *name;
@property   NSInteger   age;
@property   CGFloat     height;
@property   BOOL        checked;
@end
RLM_ARRAY_TYPE(StudentBean)
