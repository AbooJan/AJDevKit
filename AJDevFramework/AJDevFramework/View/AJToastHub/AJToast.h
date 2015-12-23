//
//  AJToast.h
//  AJToastHub
//
//  Created by 钟宝健 on 15/12/8.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJToastViewController.h"

@interface AJToast : UIWindow

+ (AJToast *)shareInstance;

/// 显示Toast时背景是否可点击，默认不可点击
@property (nonatomic, assign) BOOL toastBackgroundCanClick;

- (void)dismiss;

/// 默认显示位置为底部
- (void)showMessage:(NSString *)message;
- (void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)dismissTime;

- (void)showMessage:(NSString *)message position:(ToastPosition)position;
- (void)showMessage:(NSString *)message position:(ToastPosition)position afterDelay:(NSTimeInterval)dismissTime;

@end
