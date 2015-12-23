//
//  UIViewController+MJRefresh.h
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/12/2.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MJRefresh)

@property (nonatomic, strong) UITableView *mj_refreshTableView;
@property (nonatomic, assign) NSInteger mj_currentPageIndex;

- (void)mj_beginRefresh;
- (void)mj_endRefresh;
- (void)mj_noMoreData;

//==== 刷新控制方法，本地必须调用 super 方法
- (void)mj_refreshData;
- (void)mj_loadMoreData;
// 一般只需实现这个方法即可,在里面实现网络请求
- (void)mj_readData;

@end
