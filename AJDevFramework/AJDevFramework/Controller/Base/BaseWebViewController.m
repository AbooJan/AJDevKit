//
//  BaseWebViewController.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/8/28.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "BaseWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "TestMyNetWork.h"

@interface BaseWebViewController () <NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;

@property (nonatomic, strong) UIBarButtonItem *closeBarItem;
@property (nonatomic, strong) NSMutableArray *leftBarItems;
// 返回计数
@property (nonatomic, assign) NSInteger backTimes;

@property (nonatomic, strong) UIView *errView;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // webview
    CGRect webViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT);
    _baseWebView = [[UIWebView alloc] initWithFrame:webViewFrame];
    _baseWebView.scalesPageToFit = YES;
    [self.view addSubview:_baseWebView];
    
    // 设置WebView进度代理
    _progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    _baseWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;  // webview 原代理
    _progressProxy.progressDelegate = self;      // webview 进度加载代理
    
    // 初始化进度条
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.progressBarView.backgroundColor = [UIColor orangeColor];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_progressView setProgress:0.0 animated:YES];
    
    
    // 关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(16, 0, 60,25);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _closeBarItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-20, 0, 15,25);
    [backBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    _leftBarItems = [NSMutableArray arrayWithObjects:backBarItem, nil];
    
    // 错误视图
    _errView = [[UIView alloc] initWithFrame:webViewFrame];
    _errView.backgroundColor = RGB(240, 240, 240);
    [_errView tapGestureWithTarget:self action:@selector(checkNetWork)];
    
    // 错误提示图片
    UIImageView *errImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_network_err"]];
    errImgView.bounds = CGRectMake(0, 0, 211, 167);
    errImgView.center = CGPointMake(_errView.center.x, _errView.center.y - 40);
    [_errView addSubview:errImgView];
    
    // 错误提示标签
    CGFloat errLabelY = CGRectGetMaxY(errImgView.frame) + 16.0;
    CGFloat errLabelWidth = webViewFrame.size.width - 16.0 * 2;
    UILabel *errLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, errLabelY, errLabelWidth, 20.0)];
    errLabel.textAlignment = NSTextAlignmentCenter;
    errLabel.textColor = [UIColor lightGrayColor];
    errLabel.font = [UIFont systemFontOfSize:15];
    errLabel.text = @"网络出错,轻触屏幕重新加载";
    [_errView addSubview:errLabel];
    
}

- (void)checkNetWork
{
    [_errView removeFromSuperview];
    
    // 检查网络连接
    if ([TestMyNetWork testConnection] == NO)
    {
        [[AJToast shareInstance] showMessage:@"网络连接失败!"];
        
        [self.view addSubview:_errView];
        
    }else{
        
        // 开始加载网页
        NSURL *requestUrl = [NSURL URLWithString:_loadUrl];
        NSURLRequest *reqeust = [NSURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
        [_baseWebView loadRequest:reqeust ];
    }
}

#pragma mark 开始加载网页
- (void)startToLoad:(NSString *)loadUrl;
{
    _loadUrl = loadUrl;
    
    [self checkNetWork];
}

#pragma mark webview进度代理
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

#pragma mark - webview代理

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"完成加载");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    // 过滤掉 -999 错误
    if ([error code] == NSURLErrorCancelled)
    {
        return;
    }
    
    NSDictionary *userInfo = [error userInfo];
    
    NSString *urlKey = userInfo[@"NSErrorFailingURLStringKey"];
    
    NSRange actionRange = [urlKey rangeOfString:@"jzm"];
    if (actionRange.length == 3) {
        NSLog(@"ACTION 事件: %@", [error description]);
    }else{
        DLog(@"加载失败%@", [error description]);
        
        [self.view addSubview:_errView];
    }
}


#pragma mark -
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 必须将进度条从导航栏中移除
    [_progressView removeFromSuperview];
}

- (void)popViewController
{
    if ([_baseWebView canGoBack]) {
        [_baseWebView goBack];
        
        _backTimes ++;
        if (_backTimes >= 2) {
            
            if (_leftBarItems.count == 1) {
                [_leftBarItems addObject:_closeBarItem];
                [self.navigationItem setLeftBarButtonItems:_leftBarItems animated:YES];
            }
        }
        
    }else{
        [self exitPage];
    }
}

- (void)closeBarBtnClick
{
    [self exitPage];
}

- (void)exitPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToWillBackViewController
{
    if (self.willBackViewController && [self.willBackViewController isKindOfClass:[UIViewController class]]) {
        
        [self.navigationController popToViewController:self.willBackViewController animated:YES];
        
    }else{
        
        [self popViewController];
        
    }
}

- (void)executeJS:(NSString *)js
{
     [_baseWebView stringByEvaluatingJavaScriptFromString:js];
}

@end
