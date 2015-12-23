//
//  PopupView.h
//  PopAnimationDemo
//
//  Created by 钟宝健 on 15/10/14.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationDirection)
{
    AnimationDirectionUp,
    AnimationDirectionDown
};

@interface AJPopupView : UIView

/// 点击背景关闭，默认NO
@property (nonatomic, assign) BOOL dismissOnTap;
/// 弹窗大小
@property (nonatomic, assign) CGSize popupSize;
/// 动画方向, 默认 AnimationDirectionUp
@property (nonatomic, assign) AnimationDirection animationDirection;

/// 用于子类自定义视图
- (void)setupCustomView;
- (void)show;
- (void)dismiss;
@end
