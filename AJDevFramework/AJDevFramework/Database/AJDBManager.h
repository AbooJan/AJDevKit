//
//  AJDatabaseManager.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AJDBObject.h"
#import "AJDBArray.h"
#import "AJSortFilter.h"

@interface AJDBManager : NSObject

/**
 *  写入一条数据
 *
 *  @param obj 目标数据
 */
+ (void)writeObj:(AJDBObject *)obj;

/**
 *  批量写入
 *
 *  @param objs 数组
 */
+ (void)writeObjArray:(NSArray<__kindof AJDBObject *> *)objs;

/**
 *  更新一条数据，更新数据必须在block中执行
 *
 *  @param updateBlock 在block中更新数据
 */
+ (void)updateObj:(void (^)())updateBlock;

/**
 *  在数据库中删除目标数据
 *
 *  @param obj 目标数据
 */
+ (void)deleteObj:(AJDBObject *)obj;

/**
 *  查询目标数据模型的所有存储数据
 *
 *  @param obj 需要查询的目标类
 *
 *  @return 数据库中存储的所有数据
 */
+ (NSArray<AJDBObject *> *)queryAllObj:(AJDBObject *)obj;

/**
 *  根据断言条件查询目标数据
 *
 *  @param predicate 查询条件
 *  @param obj       需要查询的对象
 *
 *  @return 查询结果
 */
+ (NSArray<AJDBObject *> *)queryObjWithPredicate:(NSPredicate *)predicate targetObj:(AJDBObject *)obj;

/**
 *  根据断言条件查询数据，并进行排序
 *
 *  @param predicate  查询条件
 *  @param obj        需要查询的对象
 *  @param sortFilter 排序配置
 *
 *  @return 查询结果
 */
+ (NSArray<AJDBObject *> *)queryObjWithPredicate:(NSPredicate *)predicate targetObj:(AJDBObject *)obj sortFilter:(AJSortFilter *)sortFilter;

/**
 *  根据主键查询目标数据
 *
 *  @param primaryKey 主键值
 *  @param obj        需要查询的对象
 *
 *  @return 查询结果
 */
+ (AJDBObject *)queryObjWithPrimaryKeyValue:(id)primaryKey targetObj:(AJDBObject *)obj;

/**
 *  清空数据库
 */
+ (void)clear;

@end
