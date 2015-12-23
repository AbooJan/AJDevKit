//
//  PopupView.m
//  PopAnimationDemo
//
//  Created by 钟宝健 on 15/10/14.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJPopupView.h"
#import <POP/POP.h>
#import "UIColor+CustomColors.h"

@interface AJPopupView()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) BOOL isShowing;
@end

@implementation AJPopupView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
        
        self.animationDirection = AnimationDirectionUp;
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor customBlueColor];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    
    // 灰色背景
    self.maskView = [[UIView alloc] initWithFrame:[self lastWindow].bounds];
    self.maskView.backgroundColor = [UIColor customGrayColor];
    self.maskView.layer.opacity = 0.0;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
    tapGesture.numberOfTapsRequired = YES;
    tapGesture.numberOfTouchesRequired = YES;
    [self.maskView addGestureRecognizer:tapGesture];
    
    
    [self setupCustomView];
}

- (void)setupCustomView
{
    // 重写自定义视图
}

- (UIWindow *)lastWindow
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal)
            
            return window;
    }
    
    return nil;
}

- (void)show
{
    // 如果已经在显示，先关闭
    if (self.isShowing) {
        [self dismiss];
    }
    
    
    UIWindow *goalWindow = [self lastWindow];
    
    // 初始化弹窗中点
    if (self.animationDirection == AnimationDirectionUp) {
        self.center = CGPointMake(goalWindow.bounds.size.width / 2.0, goalWindow.bounds.size.height + self.frame.size.height);
    }else if (self.animationDirection == AnimationDirectionDown){
        self.center = CGPointMake(goalWindow.bounds.size.width / 2.0, - self.frame.size.height);
    }
    
    // 添加蒙版
    [goalWindow addSubview:self.maskView];
    
    // 添加本身弹窗
    [goalWindow addSubview:self];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(goalWindow.center.y);
    positionAnimation.springBounciness = 10;
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.2);
    
    [self.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [self.maskView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    
    // 标记
    self.isShowing = YES;
}

- (void)dismiss
{
    __weak __typeof(&*self) weakSelf = self;
    UIWindow *goalWindow = [self lastWindow];
    
    
    // 设置消失时的Y坐标
    CGFloat animationPositionY;
    if (self.animationDirection == AnimationDirectionUp) {
        animationPositionY = goalWindow.bounds.size.height + self.frame.size.height;
    }else if (self.animationDirection == AnimationDirectionDown){
        animationPositionY = - self.frame.size.height;
    }
    
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    offscreenAnimation.toValue = @(animationPositionY);
    [offscreenAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
        if (finish) {
            [weakSelf removeFromSuperview];
            [weakSelf.maskView removeFromSuperview];
            
            weakSelf.isShowing = NO;
        }
    }];
    
    [self.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
    [self.maskView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
}

#pragma mark - 重新Set方法
- (void)setPopupSize:(CGSize)popupSize
{
    _popupSize = popupSize;
    
    self.bounds = CGRectMake(0, 0, popupSize.width, popupSize.height);
}

#pragma mark - 事件监听
- (void)maskViewTap
{
    if (self.dismissOnTap) {
        [self dismiss];
    }
}

@end
