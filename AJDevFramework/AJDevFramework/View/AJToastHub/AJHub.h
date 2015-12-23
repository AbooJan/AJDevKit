//
//  AJHub.h
//  AJToastHub
//
//  Created by 钟宝健 on 15/12/8.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJHub : UIWindow

+ (AJHub *)shareInstance;

/// 显示Hub时背景是否可点击，默认不可点击
@property (nonatomic, assign) BOOL hubBackgroundCanClick;

- (void)dismiss;
- (void)showHub:(NSString *)message;

@end
