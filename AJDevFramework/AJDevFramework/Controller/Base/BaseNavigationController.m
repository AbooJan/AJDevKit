//
//  BaseNavigationViewController.m
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/11.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = NAVIGATION_BAR_TINT_COLOR;
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(-20, 0, 15,25);
//    [backBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    backItem.tintColor = [UIColor whiteColor];
//
//    self.navigationItem.backBarButtonItem = backItem;
}


@end
