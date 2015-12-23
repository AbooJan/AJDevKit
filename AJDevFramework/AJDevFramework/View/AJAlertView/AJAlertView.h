//
//  AlertView.h
//  PopAnimationDemo
//
//  Created by 钟宝健 on 15/10/14.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJPopupView.h"

typedef NS_ENUM(NSInteger, AlertViewType) {
    AlertViewTypeSingleText,
    AlertViewTypeTextAndImage,
    AlertViewTypeSingleTextContainTitle,
    AlertViewTypeTextAndImageContainTitle,
};

@class AJAlertView;

@protocol AJAlertViewDelegate <NSObject>

- (void)alertView:(AJAlertView *)alertView buttonClick:(NSInteger)index;

@end


@interface AJAlertView : AJPopupView

- (instancetype)initWithAlertType:(AlertViewType)alertType;

@property (nonatomic, assign) id<AJAlertViewDelegate> delegate;
@property (nonatomic, strong) NSAttributedString *title;
@property (nonatomic, assign) NSTextAlignment titleAlignment;
@property (nonatomic, strong) UIImage *logoImage;
@property (nonatomic, strong) NSAttributedString *alertContent;
@property (nonatomic, strong) NSArray<__kindof NSAttributedString *> *buttonTitles;

/// 默认样式标题
@property (nonatomic, copy) NSString *simpleTitle;
/// 默认样式确定按钮
@property (nonatomic, strong) NSArray <__kindof NSString *> *simpleButtonTitles;
/// 默认样式提示内容
@property (nonatomic, copy) NSString *simgpleAlertContent;

// 标题颜色
@property (nonatomic, strong) UIColor *titleColor;

@end
