//
//  AJPickerTextField.m
//  AJPickerTextField
//
//  Created by 钟宝健 on 15/10/9.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJPickerTextField.h"

@interface AJPickerTextField() <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation AJPickerTextField

#pragma mark - <初始化>
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    CGFloat pickerViewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat pickerViewHeight = 150.0;
    CGFloat toolBarHeight = 45.0;
    
    // setup inputAccessoryView
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, pickerViewWidth, toolBarHeight)];
    toolBar.tintColor = [UIColor darkGrayColor];
    UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBarItemClick:)];
    UIBarButtonItem *fixBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *confirmBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmBarItemClick:)];
    [toolBar setItems:@[cancelBarItem, fixBarItem, confirmBarItem] animated:YES];
    self.inputAccessoryView = toolBar;
    
    // setup inputView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, pickerViewWidth, pickerViewHeight)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.inputView = pickerView;
    
}

- (void)setSelectionArray:(NSArray<NSString *> *)selectionArray
{
    _selectionArray = selectionArray;
    
        // 默认选中第一项
    self.selectedRow = 0;
    [self refreshContent];
    
    // 刷新picker
    UIPickerView *inputView = (UIPickerView *)self.inputView;
    [inputView reloadAllComponents];
    [inputView selectRow:0 inComponent:0 animated:NO];
}

- (void)refreshContent
{
    if (self.tailContent) {
        self.text = [NSString stringWithFormat:@"%@%@", self.selectionArray[self.selectedRow], self.tailContent];
    }else{
        self.text = self.selectionArray[self.selectedRow];
    }
}

#pragma mark - <事件监听>
- (void)cancelBarItemClick:(UIBarButtonItem *)barItem
{
    [self resignFirstResponder];
}

- (void)confirmBarItemClick:(UIBarButtonItem *)barItem
{
    [self refreshContent];
    
    if ([self.privateDelegate respondsToSelector:@selector(pickerTextField:didSelectRow:)]) {
        [self.privateDelegate pickerTextField:self didSelectRow:self.selectedRow];
    }
    
    [self resignFirstResponder];
}


#pragma mark - <代理>

#pragma mark Pikcer 代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.selectionArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *selection = self.selectionArray[row];
    
    return selection;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow = row;
}

@end
