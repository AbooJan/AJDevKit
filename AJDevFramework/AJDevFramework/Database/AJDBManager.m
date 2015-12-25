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

#pragma mark - 写入

+ (void)writeObj:(AJDBObject *)obj
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

+ (void)deleteObj:(AJDBObject *)obj
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:obj];
    [realm commitWriteTransaction];
}


#pragma mark - 查询

+ (NSArray<AJDBObject *> *)queryAllObj:(AJDBObject *)obj
{
    RLMResults<AJDBObject *> *queryResult = [[obj class] allObjects];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i = 0; i < queryResult.count; i ++) {
        
        AJDBObject *item = [queryResult objectAtIndex:i];
        
        [resultArray addObject:item];
    }
    
    return resultArray;
}

+ (NSArray<AJDBObject *> *)queryObjWithPredicate:(NSPredicate *)predicate targetObj:(AJDBObject *)obj
{
    RLMResults<AJDBObject *> *queryResult = [[obj class] objectsWithPredicate:predicate];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i = 0; i < queryResult.count; i ++) {
        
        AJDBObject *item = [queryResult objectAtIndex:i];
        
        [resultArray addObject:item];
    }
    
    return resultArray;
}

+ (NSArray<AJDBObject *> *)queryObjWithPredicate:(NSPredicate *)predicate targetObj:(AJDBObject *)obj sortFilter:(AJSortFilter *)sortFilter
{
    RLMResults<AJDBObject *> *queryResult = [[[obj class] objectsWithPredicate:predicate]
                                             sortedResultsUsingProperty:sortFilter.sortPropertyName
                                             ascending:sortFilter.ascending];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i = 0; i < queryResult.count; i ++) {
        
        AJDBObject *item = [queryResult objectAtIndex:i];
        
        [resultArray addObject:item];
    }
    
    return resultArray;
}

+ (AJDBObject *)queryObjWithPrimaryKeyValue:(id)primaryKey targetObj:(AJDBObject *)obj
{
    AJDBObject *queryObj = [[obj class] objectForPrimaryKey:primaryKey];
    
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
