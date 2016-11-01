//
//  AJDatabaseManager.m
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJDBManager.h"

@interface AJDBManager()
@property (nonatomic,strong) RLMRealm *realm;
@end

@implementation AJDBManager

+ (AJDBManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    static AJDBManager * instance;
    dispatch_once( &onceToken, ^{
        
        instance = [[AJDBManager alloc] init];
        
        // 不使用加密
//        instance.realm = [RLMRealm defaultRealm];
        
        // 64位AES-256+SHA2加密
        NSMutableData *key = [NSMutableData dataWithLength:64];
        (void)SecRandomCopyBytes(kSecRandomDefault, key.length, (uint8_t *)key.mutableBytes);
        
        RLMRealmConfiguration *realmConfig = [RLMRealmConfiguration defaultConfiguration];
        realmConfig.encryptionKey = key;
        NSError *error = nil;
        instance.realm = [RLMRealm realmWithConfiguration:realmConfig error:&error];
        if (!instance.realm) {
            NSLog(@"Error opening realm: %@", error);
        }
        
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
    RLMRealm *realm = [self sharedInstance].realm;
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:obj];
    [realm commitWriteTransaction];
}

+ (void)writeObjArray:(NSArray<__kindof AJDBObject *> *)objs
{
    RLMRealm *realm = [self sharedInstance].realm;
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:objs];
    [realm commitWriteTransaction];
}

#pragma mark - 更新

+ (void)updateObj:(void (^)())updateBlock
{
    RLMRealm *realm = [self sharedInstance].realm;
    
    [realm transactionWithBlock:^{
        updateBlock();
    }];
}

#pragma mark - 删除

+ (void)deleteObj:(__kindof AJDBObject *)obj
{
    RLMRealm *realm = [self sharedInstance].realm;
    [realm beginWriteTransaction];
    [realm deleteObject:obj];
    [realm commitWriteTransaction];
}

+ (void)deleteObjs:(NSArray<__kindof AJDBObject *> *)objs
{
    RLMRealm *realm = [self sharedInstance].realm;
    [realm beginWriteTransaction];
    [realm deleteObjects:objs];
    [realm commitWriteTransaction];
}

#pragma mark - 查询

+ (NSArray<__kindof AJDBObject *> *)queryAllObj:(Class)clazz
{
    [AJDBManager checkClazz:clazz];
    
    RLMRealm *realm = [self sharedInstance].realm;
    RLMResults<AJDBObject *> *queryResult = [clazz allObjectsInRealm:realm];
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
    
    RLMRealm *realm = [self sharedInstance].realm;
    RLMResults<AJDBObject *> *queryResult = [clazz objectsInRealm:realm withPredicate:predicate];
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
    
    RLMRealm *realm = [self sharedInstance].realm;
    RLMResults<AJDBObject *> *queryResult = [[clazz objectsInRealm:realm withPredicate:predicate]
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
    
    RLMRealm *realm = [self sharedInstance].realm;
    AJDBObject *queryObj = [clazz objectInRealm:realm forPrimaryKey:primaryKey];
    
    return queryObj;
}

#pragma mark - 清空数据库
+ (void)clear
{
    RLMRealm *realm = [self sharedInstance].realm;
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
