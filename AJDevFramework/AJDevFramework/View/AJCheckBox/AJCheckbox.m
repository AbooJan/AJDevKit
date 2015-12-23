//
//  AJCheckBox.m
//  AJCheckButton
//
//  Created by 钟宝健 on 15/10/12.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJCheckbox.h"

#define kDefaultCheckImageName   @"ic_check_1"
#define kDefaultUnCheckImageName @"ic_check_0"
#define kDefaultBorderWidth      8.0
#define kDefaultTitleLabelFont   [UIFont systemFontOfSize:14.0]

@interface AJCheckbox()
@property (nonatomic,strong) UILabel *customTitleLabel;
@property (nonatomic, strong) UIImageView *checkboxImageView;
@end

@implementation AJCheckbox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self configDefaultValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
        [self configDefaultValue];
    }
    return self;
}

- (void)setupViews
{
    CGFloat checkboxImageViewWidth = self.bounds.size.height - 2 * kDefaultBorderWidth;
    if (checkboxImageViewWidth >= 19.0) {
        checkboxImageViewWidth = 19.0;
    }
    
    CGFloat checkboxImageViewHeight = checkboxImageViewWidth;
    
    CGFloat titleLabelWidth = self.bounds.size.width - checkboxImageViewWidth - 2 * kDefaultBorderWidth;
    
    // 添加checkbox图片
    self.checkboxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultBorderWidth, kDefaultBorderWidth, checkboxImageViewWidth, checkboxImageViewHeight)];
    self.checkboxImageView.center = CGPointMake(kDefaultBorderWidth + checkboxImageViewWidth / 2.0, self.height / 2.0);
    [self addSubview:self.checkboxImageView];
    
    // 添加标题
    self.customTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(checkboxImageViewWidth + kDefaultBorderWidth, 0, titleLabelWidth, self.bounds.size.height)];
    [self addSubview:self.customTitleLabel];
}

- (void)configDefaultValue
{
    self.checkboxImageAlignment = CheckboxImageAlignmentLeft;
    self.checkedImage = [UIImage imageNamed:kDefaultCheckImageName];
    self.uncheckedImage = [UIImage imageNamed:kDefaultUnCheckImageName];
    self.check = NO;
    self.canChecked = YES;
    self.title = [self titleForState:UIControlStateNormal];
    self.titleFont = kDefaultTitleLabelFont;
}

#pragma mark - 重写Set方法
- (void)setCheckboxImageAlignment:(CheckboxImageAlignment)checkboxImageAlignment
{
    _checkboxImageAlignment = checkboxImageAlignment;
    
    switch (_checkboxImageAlignment) {
        case CheckboxImageAlignmentLeft: {
            
            self.customTitleLabel.textAlignment = NSTextAlignmentLeft;
            
            // 修改布局
            CGRect checkboxImageFrame = self.checkboxImageView.frame;
            checkboxImageFrame.origin.x = 0;
            self.checkboxImageView.frame = checkboxImageFrame;
            
            CGRect titleLabelFrame = self.customTitleLabel.frame;
            titleLabelFrame.origin.x = CGRectGetMaxX(checkboxImageFrame) + kDefaultBorderWidth;
            self.customTitleLabel.frame = titleLabelFrame;
            
            break;
        }
        case CheckboxImageAlignmentRight: {
            
            self.customTitleLabel.textAlignment = NSTextAlignmentRight;
            
            // 修改布局
            CGRect checkboxImageFrame = self.checkboxImageView.frame;
            checkboxImageFrame.origin.x = self.bounds.size.width - checkboxImageFrame.size.width;
            self.checkboxImageView.frame = checkboxImageFrame;
            
            CGRect titleLabelFrame = self.customTitleLabel.frame;
            titleLabelFrame.origin.x = kDefaultBorderWidth;
            self.customTitleLabel.frame = titleLabelFrame;
            
            break;
        }
        default: {
            break;
        }
    }
}

- (void)setCheck:(BOOL)check
{
    _check = check;
    
    if (_check) {
        self.checkboxImageView.image = self.checkedImage;
    }else{
        self.checkboxImageView.image = self.uncheckedImage;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.customTitleLabel.text = _title;
    
    [self setTitle:nil forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    self.customTitleLabel.font = _titleFont;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    self.customTitleLabel.textColor = color;
}

- (void)setCheckedImage:(UIImage *)checkedImage
{
    _checkedImage = checkedImage;
    
    if (self.isCheck) {
        self.checkboxImageView.image = _checkedImage;
    }
}

-(void)setUncheckedImage:(UIImage *)uncheckedImage
{
    _uncheckedImage = uncheckedImage;
    
    if (!self.isCheck) {
        self.checkboxImageView.image = _uncheckedImage;
    }
}

#pragma mark - 事件监听
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.canChecked) {
        if (self.isCheck) {
            self.check = NO;
        }else{
            self.check = YES;
        }
    }
    
    if ([self.privateDelegate respondsToSelector:@selector(checkbox:didCheck:)]) {
        [self.privateDelegate checkbox:self didCheck:self.isCheck];
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}


@end
