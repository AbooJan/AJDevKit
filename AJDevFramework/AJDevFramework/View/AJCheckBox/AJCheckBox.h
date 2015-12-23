//
//  AJCheckBox.h
//  AJCheckButton
//
//  Created by 钟宝健 on 15/10/12.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 勾选框图片的对齐方式
typedef NS_ENUM(NSInteger, CheckboxImageAlignment) {
    CheckboxImageAlignmentLeft,
    CheckboxImageAlignmentRight
};


@class AJCheckbox;
@protocol AJCheckboxDelegate <NSObject>

- (void)checkbox:(AJCheckbox *)checkbox didCheck:(BOOL)isCheck;

@end

@interface AJCheckbox : UIButton

@property (nonatomic, assign) id<AJCheckboxDelegate> privateDelegate;
/// 勾选框图片的对齐方式
@property (nonatomic, assign) CheckboxImageAlignment checkboxImageAlignment;
/// 勾选时的图片
@property (nonatomic, strong) UIImage *checkedImage;
/// 未勾选时的图片
@property (nonatomic, strong) UIImage *uncheckedImage;
/// 是否勾选
@property (nonatomic, assign, getter = isCheck) BOOL check;
/// 是否可以勾选
@property (nonatomic, assign) BOOL canChecked;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 标题字体
@property (nonatomic, strong) UIFont *titleFont;

@end
