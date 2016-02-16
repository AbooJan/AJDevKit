//
//  AJDatabaseManager.m
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJDBManager.h"

@implementation AJDBManager

+ (AJDBManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    static AJDBManager * instance; \
    dispatch_once( &onceToken, ^{
        instance = [[AJDBManager alloc] init];
    } );
    return instance;
}

+ (void)checkClazz:(Class)clazz
{
    BOOL isCorrectClass = [[clazz new] isKindOfClass:[AJDBObject class]];
    NSAssert(isCorrectClass, @"必须继承自AJDBObject");
}

#pragma mark - 写入

+ (void)writeObj:(__kindof AJDBObject *)obj
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:obj];
    [realm commitWriteTransaction];
}

+ (void)writeObjArray:(NSArray<__kindof AJDBObject *> *)objs
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:objs];
    [realm commitWriteTransaction];
}

#pragma mark - 更新

+ (void)updateObj:(void (^)())updateBlock
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        updateBlock();
    }];
}

#pragma mark - 删除

+ (void)deleteObj:(__kindof AJDBObject *)obj
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:obj];
    [realm commitWriteTransaction];
}

+ (void)deleteObjs:(NSArray<__kindof AJDBObject *> *)objs
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:objs];
    [realm commitWriteTransaction];
}

#pragma mark - 查询

+ (NSArray<__kindof AJDBObject *> *)queryAllObj:(Class)clazz
{
    [AJDBManager checkClazz:clazz];
    
    RLMResults<AJDBObject *> *queryResult = [clazz allObjects];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i = 0; i < queryResult.count; i ++) {
        
        AJDBObject *item = [queryResult objectAtIndex:i];
        
        [resultArray addObject:item];
    }
    
    return resultArray;
}

+ (NSArray<__kindof AJDBObject *> *)queryObjWithPredicate:(NSPredicate *)predicate targetClass:(Class)clazz
{
    [AJDBManager checkClazz:clazz];
    
    RLMResults<AJDBObject *> *queryResult = [clazz objectsWithPredicate:predicate];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i = 0; i < queryResult.count; i ++) {
        
        AJDBObject *item = [queryResult objectAtIndex:i];
        
        [resultArray addObject:item];
    }
    
    return resultArray;
}

+ (NSArray<__kindof AJDBObject *> *)queryObjWithPredicate:(NSPredicate *)predicate sortFilter:(AJSortFilter *)sortFilter targetClass:(Class)clazz;
{
    [AJDBManager checkClazz:clazz];
    
    RLMResults<AJDBObject *> *queryResult = [[clazz objectsWithPredicate:predicate]
                                             sortedResultsUsingProperty:sortFilter.sortPropertyName
                                             ascending:sortFilter.ascending];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i = 0; i < queryResult.count; i ++) {
        
        AJDBObject *item = [queryResult objectAtIndex:i];
        
        [resultArray addObject:item];
    }
    
    return resultArray;
}

+ (__kindof AJDBObject *)queryObjWithPrimaryKeyValue:(id)primaryKey targetClass:(Class)clazz;
{
    [AJDBManager checkClazz:clazz];
    
    AJDBObject *queryObj = [clazz objectForPrimaryKey:primaryKey];
    
    return queryObj;
}

#pragma mark - 清空数据库
+ (void)clear
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
