//
//  AJPickerTextField.h
//  AJPickerTextField
//
//  Created by 钟宝健 on 15/10/9.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AJPickerTextField;

@protocol AJPickerTextFieldDelegate <NSObject>

- (void)pickerTextField:(AJPickerTextField *)pickerTextField didSelectRow:(NSInteger)row;

@end

@interface AJPickerTextField : UITextField
@property (assign, nonatomic)  id<AJPickerTextFieldDelegate> privateDelegate;
/// 输入内容尾巴，必须在设置选项前设置
@property (nonatomic, copy) NSString *tailContent;
/// Picker 显示的选项
@property (strong, nonatomic) NSArray<NSString *> *selectionArray;
/// 选中的索引
@property (assign, nonatomic) NSInteger selectedRow;

@end
