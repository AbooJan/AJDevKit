//
//  AJToast.m
//  AJToastHub
//
//  Created by 钟宝健 on 15/11/27.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJToastViewController.h"
#import "NSString+Size.h"
#import "UIView+Extend.h"
#import <POP/POP.h>
#import "AJToast.h"
#import "AJHub.h"

#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height
#define kToastMessageFont       [UIFont systemFontOfSize:13.0]
#define kHubMessageFont         [UIFont systemFontOfSize:13.0]
#define kDefaultCenter          CGPointMake(kScreenWidth / 2.0, kScreenHeight - 100.0 - DEFAULT_TOAST_HEIGHT)
#define kBgColor                [UIColor colorWithWhite:0.098 alpha:1.000]


static const CGFloat DEFAULT_TOAST_HEIGHT = 35.0;
static const CGFloat DEFAULT_TOAST_WIDTH  = 50.0;
static const CGFloat TOAST_MAX_WIDTH      = 300.0;

static const CGFloat SPACE_WIDTH    = 8.0;

static const CGFloat DEFAUTL_HUB_HEIGHT   = 80.0;
static const CGFloat DEFAULT_HUB_WIDTH    = 80.0;
static const CGFloat DEFAULT_HUB_MESSAGE_HEIGHT = 20.0;
static const CGFloat HUB_MAX_WIDTH        = 150.0;

static const CGFloat DEFAULT_ALPHA  = 0.7;


@interface AJToastViewController ()

@property (nonatomic, strong) UIView *toastContainView;
@property (nonatomic, strong) UILabel *toastMessageLabel;

@property (nonatomic, strong) UIView *hubContainView;

@end

@implementation AJToastViewController

#pragma mark - 初始化

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor clearColor];

    [self setupToastView];
    [self setupHubView];
}

- (void)setupToastView
{
    // 视图容器
    self.toastContainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_TOAST_WIDTH, DEFAULT_TOAST_HEIGHT)];
    self.toastContainView.center = kDefaultCenter;
    self.toastContainView.backgroundColor = kBgColor;
    self.toastContainView.alpha = 0.0;
    self.toastContainView.layer.cornerRadius = 5.0;
    self.toastContainView.layer.masksToBounds = YES;
    
    // 消息
    CGFloat messageLabelWidth = DEFAULT_TOAST_WIDTH - SPACE_WIDTH * 2.0;
    CGFloat messageLabelHeight = DEFAULT_TOAST_HEIGHT - SPACE_WIDTH * 2.0;
    self.toastMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE_WIDTH, SPACE_WIDTH, messageLabelWidth, messageLabelHeight)];
    self.toastMessageLabel.textColor = [UIColor whiteColor];
    self.toastMessageLabel.textAlignment = NSTextAlignmentCenter;
    self.toastMessageLabel.font = kToastMessageFont;
    self.toastMessageLabel.numberOfLines = 0;
    [self.toastContainView addSubview:self.toastMessageLabel];
}

- (void)setupHubView
{
    // 视图容器
    self.hubContainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_HUB_WIDTH, DEFAUTL_HUB_HEIGHT)];
    self.hubContainView.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight / 2.0);
    self.hubContainView.backgroundColor = kBgColor;
    self.hubContainView.alpha = 0.0;
    self.hubContainView.layer.cornerRadius = 5.0;
    self.hubContainView.layer.masksToBounds = YES;
    
    // 菊花
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    loadingView.bounds = CGRectMake(0, 0, 50.0, 50.0);
    loadingView.center = CGPointMake(DEFAULT_HUB_WIDTH / 2.0, DEFAUTL_HUB_HEIGHT / 2.0 - DEFAULT_HUB_MESSAGE_HEIGHT / 2.0);
    loadingView.tag = 1001;
    [loadingView startAnimating];
    [self.hubContainView addSubview:loadingView];
    
    // 消息
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_HUB_WIDTH - SPACE_WIDTH * 2.0, DEFAULT_HUB_MESSAGE_HEIGHT)];
    messageLabel.center = CGPointMake(DEFAULT_HUB_WIDTH / 2.0, CGRectGetMaxY(loadingView.frame) + SPACE_WIDTH / 2.0);
    messageLabel.font = kHubMessageFont;
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.tag = 1002;
    [self.hubContainView addSubview:messageLabel];
}

#pragma mark - 逻辑处理

- (void)refreshViewFrameWithMessage
{
    // 先宽高计算
    CGFloat contentWidth = [self.toastMessageStr widthWithFont:kToastMessageFont constrainedToHeight:DEFAULT_TOAST_HEIGHT - SPACE_WIDTH * 2.0];
    
    CGFloat maxContentWidth = TOAST_MAX_WIDTH - SPACE_WIDTH * 2.0;
    if (contentWidth > maxContentWidth) {
        
        CGFloat contentHeight = [self.toastMessageStr heightWithFont:kToastMessageFont constrainedToWidth:maxContentWidth];
        
        // 调整父视图大小
        self.toastContainView.width = TOAST_MAX_WIDTH;
        self.toastContainView.height = contentHeight + SPACE_WIDTH * 2.0;
        
        // 调整消息大小
        self.toastMessageLabel.width = maxContentWidth;
        self.toastMessageLabel.height = contentHeight;
        
    }else{
        
        self.toastContainView.width = contentWidth + SPACE_WIDTH * 2.0;
        self.toastMessageLabel.width = contentWidth;
        
        self.toastContainView.height = DEFAULT_TOAST_HEIGHT;
        self.toastMessageLabel.height = DEFAULT_TOAST_HEIGHT - SPACE_WIDTH * 2.0;
    }
    
    // 调整Window大小
    if (self.toastWindow.toastBackgroundCanClick) {
        self.toastWindow.height = 2.0;
    }else{
        self.toastWindow.height = kScreenHeight;
    }
    
    // 调整内容视图中点
    self.toastContainView.center = kDefaultCenter;
}

#pragma mark - SET方法重写

- (void)setToastMessageStr:(NSString *)toastMessageStr
{
    _toastMessageStr = toastMessageStr;
    self.toastMessageLabel.text = _toastMessageStr;
    [self refreshViewFrameWithMessage];
}

#pragma mark - Toast

#pragma mark 显示隐藏
- (void)showToast:(void (^)())finished
{
    // 添加到视图中
    [self.view addSubview:self.toastContainView];
    
    // 初始化弹窗中点
    self.toastContainView.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight + self.toastContainView.height);
    if (self.toastPosition == ToastPositionTop) {
        self.toastContainView.center = CGPointMake(kScreenWidth / 2.0, - self.toastContainView.height);
    }
    
    // 目标中点Y坐标
    CGFloat spaceWidth = 80.0;
    CGFloat targetY;
    switch (self.toastPosition) {
        case ToastPositionBottom: {
            targetY = kScreenHeight - spaceWidth - self.toastContainView.height / 2.0;
            break;
        }
        case ToastPositionCenter: {
            targetY = kScreenHeight / 2.0;
            break;
        }
        case ToastPositionTop: {
            targetY = spaceWidth + self.toastContainView.height / 2.0;
            break;
        }
        default: {
            targetY = kScreenHeight / 2.0;
            break;
        }
    }
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(targetY);
    positionAnimation.springBounciness = 10;
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(DEFAULT_ALPHA);
    
    [self.toastContainView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation1"];
    [self.toastContainView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation1"];
    
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL isFinish) {
        finished();
    }];
}

- (void)dismissToast:(void (^)())finished
{
    // 设置消失时的Y坐标
    CGFloat animationPositionY = kScreenHeight + self.toastContainView.height;
    
    if(self.toastPosition == ToastPositionTop){
        animationPositionY = - self.toastContainView.height;
    }
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.0, self.toastContainView.height)];
    
    [self.toastContainView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation2"];
    [self.toastContainView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation2"];
    
    // 完成回调
    __weak __typeof(&*self) weakSelf = self;
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
        [weakSelf.toastContainView removeFromSuperview];
        finished();
    }];
}


#pragma mark - Hub

- (void)refreshHubView
{
    if (self.hubMessageStr == nil || [self.hubMessageStr isEqualToString:@""]) {
        
        self.hubContainView.width = DEFAULT_HUB_WIDTH - 20.0;
        self.hubContainView.height = DEFAUTL_HUB_HEIGHT - 20.0;
        
        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)[self.hubContainView viewWithTag:1001];
        loadingView.center = CGPointMake(self.hubContainView.width  / 2.0, self.hubContainView.height  / 2.0);
        
    }else{
        
        // 计算文字长度
        CGFloat width = [self.hubMessageStr widthWithFont:kHubMessageFont constrainedToHeight:DEFAULT_HUB_MESSAGE_HEIGHT];
        if (width > (HUB_MAX_WIDTH - 2 * SPACE_WIDTH)) {
            width = HUB_MAX_WIDTH - 2 * SPACE_WIDTH;
        }
        
        // 调整Hub宽度
        CGFloat hubWidth = width + 2 * SPACE_WIDTH;
        if (hubWidth > HUB_MAX_WIDTH) {
            hubWidth = HUB_MAX_WIDTH;
        }else if (hubWidth < DEFAULT_HUB_WIDTH){
            hubWidth = DEFAULT_HUB_WIDTH;
        }else{
            //
        }
        
        self.hubContainView.width = hubWidth;
        self.hubContainView.height = DEFAUTL_HUB_HEIGHT;
        
        // 调整菊花中点
        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)[self.hubContainView viewWithTag:1001];
        loadingView.center = CGPointMake(hubWidth / 2.0, DEFAUTL_HUB_HEIGHT / 2.0 - DEFAULT_HUB_MESSAGE_HEIGHT / 2.0);
        
        // 调整消息位置
        UILabel *messageLabel = (UILabel *)[self.hubContainView viewWithTag:1002];
        messageLabel.width = width;
        messageLabel.center = CGPointMake(hubWidth / 2.0, messageLabel.center.y);
    }
    
    // 调整Window大小
    if (self.hubWindow.hubBackgroundCanClick) {
        self.hubWindow.height = 2.0;
    }else{
        self.hubWindow.height = kScreenHeight;
    }
}

- (void)showHub:(void (^)())finished
{
    // 添加到View中
    NSArray *subViews = self.view.subviews;
    BOOL hadShowing = [subViews containsObject:self.hubContainView];
    if (!hadShowing) {
        [self.view addSubview:self.hubContainView];
    }
    
    // 设置数据
    UILabel *messageLabel = (UILabel *)[self.hubContainView viewWithTag:1002];
    messageLabel.text = self.hubMessageStr;
    
    // 调整菊花中点
    [self refreshHubView];
    
    // --- 动画 ---
    
    self.hubContainView.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight / 2.0);
    
    POPSpringAnimation *alphaAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    alphaAnimation.fromValue = @(0.0);
    alphaAnimation.toValue = @(0.8);
    alphaAnimation.springSpeed = 18.f;
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    scaleAnimation.springBounciness = 12;
    scaleAnimation.springSpeed = 18.f;
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:self.hubContainView.layer.bounds.size];
    
    [self.hubContainView.layer pop_addAnimation:alphaAnimation forKey:@"hubAlpha2"];
    [self.hubContainView.layer pop_addAnimation:scaleAnimation forKey:@"hubScale2"];
    
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL isFinish) {
        finished();
    }];
}

- (void)dismissHub:(void (^)())finished
{
    POPSpringAnimation *alphaAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    alphaAnimation.fromValue = @(0.8);
    alphaAnimation.toValue = @(0.0);
    alphaAnimation.springSpeed = 18.f;
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    scaleAnimation.springBounciness = 1;
    scaleAnimation.springSpeed = 18.f;
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    
    [self.hubContainView.layer pop_addAnimation:alphaAnimation forKey:@"hubAlpha1"];
    [self.hubContainView.layer pop_addAnimation:scaleAnimation forKey:@"hubScale1"];
    
    // 完成回调
    __weak __typeof(&*self) weakSelf = self;
    [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
        
        [weakSelf.hubContainView removeFromSuperview];
        
        finished();
    }];
}

@end
