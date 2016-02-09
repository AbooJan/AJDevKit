//
//  BaseViewController.h
//
//  Created by 钟宝健 on 15/9/9.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "RoundCornerButton.h"
#import "BaseNavigationController.h"

@interface BaseViewController : UIViewController

@property (strong, nonatomic) UserBean *baseUserBean;

-(void)initView NS_REQUIRES_SUPER;

-(void)initData NS_REQUIRES_SUPER;

- (void)pushVC:(UIViewController *)controller;
- (void)pushVCNoAnimation:(UIViewController *)controller;

-(void)popVC;
-(void)popVCNoAnimation;

-(void)logout;

-(void)callPhone:(NSString *)tel;

/// 是否退出当前控制器
- (BOOL)onPopViewController;

@end
