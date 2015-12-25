//
//  SortFilter.m
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJSortFilter.h"

@implementation AJSortFilter

+ (instancetype)sortFilterWithPropertyName:(NSString *)propertyName ascending:(BOOL)ascending
{
    AJSortFilter *sortFilter = [[AJSortFilter alloc] init];
    sortFilter.sortPropertyName = propertyName;
    sortFilter.ascending = ascending;
    
    return sortFilter;
}
@end
