//
//  UIViewController+EmptyTableView.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/12/2.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import "UIViewController+EmptyTableView.h"


static NSString * const EMPTY_TABLEVIEW_KEY         = @"EMPTY_TABLEVIEW";
static NSString * const EMPTY_TIP_MESSAGE_KEY       = @"EMPTY_TIP_MESSAGE";
static NSString * const EMPTY_TIP_ICON_KEY          = @"EMPTY_TIP_ICON";


@implementation UIViewController (EmptyTableView)

#pragma mark - 数据绑定

- (void)setDzn_emptyTableView:(UITableView *)dzn_emptyTableView
{
    objc_setAssociatedObject(self, &EMPTY_TABLEVIEW_KEY, dzn_emptyTableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self configEmptyTableView];
}

- (UITableView *)dzn_emptyTableView
{
    return objc_getAssociatedObject(self, &EMPTY_TABLEVIEW_KEY);
}

- (void)setDzn_emptyTipMessage:(NSString *)dzn_emptyTipMessage
{
    objc_setAssociatedObject(self, &EMPTY_TIP_MESSAGE_KEY, dzn_emptyTipMessage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)dzn_emptyTipMessage
{
    return objc_getAssociatedObject(self, &EMPTY_TIP_MESSAGE_KEY);
}

- (void)setDzn_emptyTipIcon:(UIImage *)dzn_emptyTipIcon
{
    objc_setAssociatedObject(self, &EMPTY_TIP_ICON_KEY, dzn_emptyTipIcon, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)dzn_emptyTipIcon
{
    return objc_getAssociatedObject(self, &EMPTY_TIP_ICON_KEY);
}

#pragma mark - 代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.dzn_emptyTipIcon;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.dzn_emptyTipMessage) {
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]};
        
        return [[NSAttributedString alloc] initWithString:self.dzn_emptyTipMessage attributes:attributes];
        
    }else{
        return nil;
    }
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}

- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
{
    [self dzn_refreshData];
}

#pragma mark - 事件监听

- (void)configEmptyTableView
{
    self.dzn_emptyTableView.emptyDataSetSource = self;
    self.dzn_emptyTableView.emptyDataSetDelegate = self;
}

#pragma mark - 空方法

- (void)dzn_refreshData
{
    //
}

@end
