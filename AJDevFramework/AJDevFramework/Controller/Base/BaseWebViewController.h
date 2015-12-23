//
//  BaseWebViewController.h
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/8/28.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *baseWebView;
/// 需要加载的链接
@property (copy, nonatomic) NSString *loadUrl;

///要pop回的viewCtrl
@property (nonatomic,weak) id willBackViewController;

/// 开始加载网页
- (void)startToLoad:(NSString *)loadUrl;

/// 退出页面
- (void)exitPage;

///返回指定的ViewCtrl
-(void)popToWillBackViewController;


/**
 *  执行JS，可以传参数
 *
 *  普通：   executeJS:@"fun()"
 *  含参数： executeJS:[NSString stringWithFormat:@"fun('%@', %d)", param1, param2]
 *
 *  @param js js方法名
 */
- (void)executeJS:(NSString *)js;

@end
