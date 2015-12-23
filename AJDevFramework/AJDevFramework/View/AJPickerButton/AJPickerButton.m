//
//  AJPickerButtonX.m
//  AJPickerButton
//
//  Created by 钟宝健 on 15/10/11.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJPickerButton.h"
#import "AJPickerTextField.h"
#import "Arrow.h"

#define kDefaultTitleFont        [UIFont systemFontOfSize:14]
#define kDefaultTitleColor       [UIColor darkGrayColor]
#define kDefaultTitleAlignment   TitleAlignmentCenter
#define kDefaultArrowDirection   ArrowDirectionDown

@interface AJPickerButton()<AJPickerTextFieldDelegate>
@property (nonatomic, strong) AJPickerTextField *pickerTextField;
@property (nonatomic, strong) UILabel *customTitleLabel;
@property (strong, nonatomic) Arrow *arrow;
@end

@implementation AJPickerButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self initDefaultValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
        [self initDefaultValue];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame selectionArray:(NSArray<NSString *> *)selectionArray
{
    self = [self initWithFrame:frame];
    
    self.selectionArray = selectionArray;
    
    return self;
}

- (void)setupViews
{
    CGFloat borderWidth = 6.0;
    
    CGFloat arrowWidth = 25.0;
    CGFloat arrowHeight = arrowWidth;
    
    // 添加隐藏输入框
    self.pickerTextField = [[AJPickerTextField alloc] initWithFrame:self.bounds];
    self.pickerTextField.privateDelegate = self;
    self.pickerTextField.hidden = YES;
    [self addSubview:self.pickerTextField];
    
    // 添加内容显示Label
    CGFloat labelWidth = self.bounds.size.width - arrowWidth - borderWidth * 2.0;
    self.customTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(borderWidth, 0, labelWidth, self.bounds.size.height)];
    self.customTitleLabel.text = [self titleForState:UIControlStateNormal];
    self.customTitleLabel.textColor = kDefaultTitleColor;
    self.customTitleLabel.font = kDefaultTitleFont;
    self.customTitleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.customTitleLabel];
    
    // 添加箭头
    self.arrow = [[Arrow alloc] initWithFrame:CGRectMake(0, 0, arrowWidth, arrowHeight) withArrowColor:[UIColor lightGrayColor]];
    self.arrow.center = CGPointMake(CGRectGetMaxX(self.customTitleLabel.frame) + arrowWidth / 2.0 + borderWidth, self.bounds.size.height / 2.0);
    [self addSubview:self.arrow];
    
    // 为箭头添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(arrowTapGestureEvent:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.arrow addGestureRecognizer:tapGesture];
}

- (void)initDefaultValue
{
    [self setTitle:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    
    self.titleFont = kDefaultTitleFont;
    self.titleColor = kDefaultTitleColor;
    self.showArrow = YES;
    self.arrowDirection = ArrowDirectionRight;
    self.titleAlignment = TitleAlignmentCenter;
}

#pragma mark - 重写Set事件

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    self.customTitleLabel.font = _titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    self.customTitleLabel.tintColor = _titleColor;
}

- (void)setShowArrow:(BOOL)showArrow
{
    _showArrow = showArrow;
    
    if (!_showArrow) {
        
        CGFloat arrowWidth = self.arrow.frame.size.width;
        
        CGRect titleLabelFrame = self.customTitleLabel.frame;
        titleLabelFrame.size.width = titleLabelFrame.size.width + arrowWidth;
        self.customTitleLabel.frame = titleLabelFrame;
        
        CGRect arrowFrame = self.arrow.frame;
        arrowFrame.origin.x = arrowFrame.origin.x + arrowWidth;
        arrowFrame.size.width = 0;
        self.arrow.frame = arrowFrame;
    }
}

- (void)setArrowDirection:(ArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    
    switch (_arrowDirection) {
        case ArrowDirectionRight:
        {
            // 默认向右
        }
            break;
            
        case ArrowDirectionDown:
        {
            self.arrow.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
            break;
            
        default:
            break;
    }
}

- (void)setTitleAlignment:(TitleAlignment)titleAlignment
{
    _titleAlignment = titleAlignment;
    
    switch (_titleAlignment) {
        case TitleAlignmentLeft:
            self.customTitleLabel.textAlignment = NSTextAlignmentLeft;
            break;
            
        case TitleAlignmentCenter:
            self.customTitleLabel.textAlignment = NSTextAlignmentCenter;
            break;
            
        case TitleAlignmentRight:
            self.customTitleLabel.textAlignment = NSTextAlignmentRight;
            break;
            
        default:
            break;
    }
}

- (void)setSelectionArray:(NSArray<NSString *> *)selectionArray
{
    _selectionArray = selectionArray;
    
    self.pickerTextField.selectionArray = self.selectionArray;
    
    self.selectedRow = 0;
    if(_selectionArray.count > 0){
        self.customTitleLabel.text = self.selectionArray[self.selectedRow];
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    self.customTitleLabel.text = title;
    
    [super setTitle:nil forState:state];
}

- (NSString *)titleForState:(UIControlState)state
{
    return self.customTitleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.customTitleLabel.text = title;
}

#pragma mark 选项按钮点击
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self.pickerTextField becomeFirstResponder];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [self.pickerTextField resignFirstResponder];
    
    [super cancelTrackingWithEvent:event];
}

- (void)arrowTapGestureEvent:(UITapGestureRecognizer *)tapGesture
{
    [self.pickerTextField becomeFirstResponder];
}

#pragma mark - AJPickerTextField 代理
- (void)pickerTextField:(AJPickerTextField *)pickerTextField didSelectRow:(NSInteger)row
{
    self.selectedRow = row;
    
    self.title = self.selectionArray[row];
    self.customTitleLabel.text = self.selectionArray[row];
    
    if ([self.privateDelegate respondsToSelector:@selector(pickerButton:didSelectRow:)]) {
        [self.privateDelegate pickerButton:self didSelectRow:row];
    }
}

@end
