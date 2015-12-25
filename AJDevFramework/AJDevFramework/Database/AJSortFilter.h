//
//  SortFilter.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//
//  排序过滤
//

#import <Foundation/Foundation.h>

@interface AJSortFilter : NSObject
@property (nonatomic, copy) NSString *sortPropertyName;
/// 是否升序
@property (nonatomic, assign) BOOL ascending;

+ (instancetype)sortFilterWithPropertyName:(NSString *)propertyName ascending:(BOOL)ascending;

@end
