//
//  UIViewController+MJRefresh.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/12/2.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import "UIViewController+MJRefresh.h"
#import "MJRefresh.h"


static NSString * const TARGET_TABLEVIEW_KEY   = @"TARGET_TABLEVIEW";
static NSString * const CURRENT_PAGE_INDEX_KEY = @"CURRENT_PAGE_INDEX";


@implementation UIViewController (MJRefresh)

#pragma mark - 数据绑定

- (void)setMj_refreshTableView:(UITableView *)mj_refreshTableView
{
    objc_setAssociatedObject(self, &TARGET_TABLEVIEW_KEY, mj_refreshTableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self enableRefreshTableView];
}

- (UITableView *)mj_refreshTableView
{
    return objc_getAssociatedObject(self, &TARGET_TABLEVIEW_KEY);
}

- (void)setMj_currentPageIndex:(NSInteger)mj_currentPageIndex
{
    objc_setAssociatedObject(self, &CURRENT_PAGE_INDEX_KEY, @(mj_currentPageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)mj_currentPageIndex
{
    NSInteger pageIndex = [objc_getAssociatedObject(self, &CURRENT_PAGE_INDEX_KEY) integerValue];
    
    return pageIndex;
}

#pragma mark - 事件处理

- (void)enableRefreshTableView
{
    self.mj_refreshTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mj_refreshData)];
    self.mj_refreshTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mj_loadMoreData)];
}

- (void)mj_beginRefresh
{
    [self.mj_refreshTableView.mj_header beginRefreshing];
}

- (void)mj_endRefresh
{
    [self.mj_refreshTableView.mj_header endRefreshing];
    [self.mj_refreshTableView.mj_footer endRefreshing];
}

- (void)mj_noMoreData
{
    [self.mj_refreshTableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark - 空方法

- (void)mj_refreshData
{
    self.mj_currentPageIndex = 1;
    [self mj_readData];
}

- (void)mj_loadMoreData
{
    self.mj_currentPageIndex ++;
    [self mj_readData];
}

- (void)mj_readData
{
    //
}

@end
