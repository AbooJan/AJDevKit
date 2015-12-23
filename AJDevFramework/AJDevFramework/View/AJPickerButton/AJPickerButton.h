//
//  AJPickerButtonX.h
//  AJPickerButton
//
//  Created by 钟宝健 on 15/10/11.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ArrowDirection){
    ArrowDirectionRight,
    ArrowDirectionDown
};

typedef NS_ENUM(NSInteger, TitleAlignment) {
    TitleAlignmentLeft,
    TitleAlignmentCenter,
    TitleAlignmentRight
};


@class AJPickerButton;

@protocol AJPickerButtonDelegate <NSObject>

- (void)pickerButton:(AJPickerButton *)pickerButton didSelectRow:(NSInteger)row;

@end

@interface AJPickerButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame selectionArray:(NSArray<NSString *> *)selectionArray;

/// 事件代理
@property (assign, nonatomic)  id<AJPickerButtonDelegate> privateDelegate;
/// Picker 显示的选项
@property (strong, nonatomic) NSArray<NSString *> *selectionArray;
/// 选中的索引
@property (assign, nonatomic) NSInteger selectedRow;
/// 按钮标题
@property (nonatomic, copy) NSString *title;
/// 按钮字体
@property (nonatomic, strong) UIFont *titleFont;
/// 按钮字体颜色
@property (nonatomic, strong) UIColor *titleColor;
/// 是否显示箭头, 默认显示
@property (assign, nonatomic, getter=isShowArrow) BOOL showArrow;
/// 箭头方向
@property (assign, nonatomic) ArrowDirection arrowDirection;
/// 标题对齐方式
@property (assign, nonatomic)  TitleAlignment titleAlignment;

@end
