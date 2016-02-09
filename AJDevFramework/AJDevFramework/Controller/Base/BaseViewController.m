//
//  BaseViewController.m
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/9.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
#import "UIViewController+BackButtonHandler.h"


@interface BaseViewController () <BackButtonHandlerProtocol>
/// 用于拨打电话
@property (strong, nonatomic) UIWebView *telWebView;
@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
    [self initView];
    
    [self initData];
 
}

-(void)initData
{
    self.baseUserBean = [[GlobalInstance sharedInstance] user];
}

-(void)initView
{}

- (BOOL)onPopViewController
{
    return YES;
}

-(BOOL)navigationShouldPopOnBackButton
{
    return [self onPopViewController];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)pushVC:(UIViewController *)controller
{
    if (self.navigationController) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)pushVCNoAnimation:(UIViewController *)controller
{
    if (self.navigationController) {
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)popVC
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)popVCNoAnimation
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)logout
{
    //
}

-(void)callPhone:(NSString *)tel
{
    if (_telWebView == nil) {
        _telWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    
    NSString *telStr = [NSString stringWithFormat:@"tel://%@",tel];
    NSURL *telUrl = [NSURL URLWithString:telStr];
    
    BOOL check = [[UIApplication sharedApplication] canOpenURL:telUrl];
    
    if (check) {
        [_telWebView loadRequest:[NSURLRequest requestWithURL:telUrl]];
    }else{
        [[AJToast shareInstance] showMessage:@"号码有误"];
    }
    
}

@end
