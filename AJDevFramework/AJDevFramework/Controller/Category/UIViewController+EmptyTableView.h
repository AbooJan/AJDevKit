//
//  UIViewController+EmptyTableView.h
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/12/2.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface UIViewController (EmptyTableView) <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonnull, nonatomic, strong) UITableView *dzn_emptyTableView;
/// 空白提示文字
@property (nullable, nonatomic, copy) NSString *dzn_emptyTipMessage;
/// 空白提示图片
@property (nullable, nonatomic, strong) UIImage *dzn_emptyTipIcon;

/**
 *  点击空白区域调用
 */
- (void)dzn_refreshData;

@end
