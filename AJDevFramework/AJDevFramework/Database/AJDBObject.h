//
//  DBObject.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <Realm/Realm.h>

@interface AJDBObject : RLMObject
/// 必须定义主键
+ (NSString *)primaryKey;
@end
