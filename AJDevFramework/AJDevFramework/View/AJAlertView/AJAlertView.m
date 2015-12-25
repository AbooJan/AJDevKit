//
//  AlertView.m
//  PopAnimationDemo
//
//  Created by 钟宝健 on 15/10/14.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJAlertView.h"
#import "UIView+Extend.h"
#import "NSString+Size.h"
#import "NSMutableAttributedString+Extend.h"

#define kMainScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kDefaultAlertViewWidth  300.0
#define kAlertContentFont       [UIFont systemFontOfSize:14]
#define kDevideColor            [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];

static const CGFloat DEFAULT_TITLEVIEW_HEIGHT   = 35.0;
static const CGFloat DEFAULT_CONTENTVIEW_HEIGHT = 60.0;
static const CGFloat DEFAULT_BUTTONVIEW_HEIGHT  = 40.0;
static const CGFloat DEFAULT_LOGO_WIDTH         = 40.0;
static const CGFloat DEFAULT_BORDER_WIDTH       = 8.0;

@interface AJAlertView()

@property (nonatomic, assign) AlertViewType alertType;

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *buttonView;
@end

@implementation AJAlertView

- (instancetype)initWithAlertType:(AlertViewType)alertType
{
    self = [super init];
    if (self) {
        
        // 默认提示框大小
        self.popupSize = CGSizeMake(kDefaultAlertViewWidth, DEFAULT_TITLEVIEW_HEIGHT + DEFAULT_CONTENTVIEW_HEIGHT + DEFAULT_BUTTONVIEW_HEIGHT);
        self.alertType = alertType;
    }
    return self;
}

- (void)setupCustomView
{
    self.backgroundColor = [UIColor whiteColor];
    
    // 标题
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultAlertViewWidth, DEFAULT_TITLEVIEW_HEIGHT)];
    [self configTitleView];
    [self addSubview:self.titleView];
    
    // 内容
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), kDefaultAlertViewWidth, DEFAULT_CONTENTVIEW_HEIGHT)];
    [self configContentView];
    [self addSubview:self.contentView];
    
    // 按钮
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentView.frame), kDefaultAlertViewWidth, DEFAULT_BUTTONVIEW_HEIGHT)];
    self.buttonView.backgroundColor = kDevideColor;
    [self configButtonView];
    [self addSubview:self.buttonView];
}

- (void)configTitleView
{
    CGFloat borderWidth = DEFAULT_BORDER_WIDTH;
    CGFloat divideLineHeight = 0.5;
    CGFloat titleLabelWidth = self.titleView.bounds.size.width;
    CGFloat titleLabelHeight = self.titleView.bounds.size.height - divideLineHeight;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(borderWidth, 0, titleLabelWidth, titleLabelHeight)];
    titleLabel.textColor = RGB(23, 23, 23);
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.tag = 1001;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:titleLabel];
    
    // 分界线
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), titleLabelWidth, divideLineHeight)];
    lineView.backgroundColor = RGB(254,116,24);
    lineView.alpha = 0.8;
    lineView.tag = 1002;
    [self.titleView addSubview:lineView];
}

- (void)configContentView
{
    CGFloat borderWidth = DEFAULT_BORDER_WIDTH;
    CGFloat logoWidth = DEFAULT_LOGO_WIDTH;
    CGFloat logoHeight = logoWidth;
    CGFloat descriptionWidth = self.contentView.width - borderWidth * 3.0 - logoWidth;
    CGFloat descriptionHeight = self.contentView.bounds.size.height;
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, logoWidth, logoHeight)];
    logo.center = CGPointMake(borderWidth + logoWidth / 2.0, self.contentView.bounds.size.height / 2.0);
    logo.tag = 1001;
    [self.contentView addSubview:logo];
    
    UILabel *descriptionLabel= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logo.frame) + borderWidth, 0, descriptionWidth, descriptionHeight)];
    descriptionLabel.tag = 1002;
    descriptionLabel.textAlignment = NSTextAlignmentLeft;
    descriptionLabel.font = kAlertContentFont;
    descriptionLabel.textColor = RGB(67,67,67);
    descriptionLabel.numberOfLines = 0;
    [self.contentView addSubview:descriptionLabel];
}

- (void)configButtonView
{
    UIImageView *divideLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDefaultAlertViewWidth, 0.5)];
    divideLineView.backgroundColor = kDevideColor;
    [self.buttonView addSubview:divideLineView];
}

#pragma mark - 设置弹窗类型

- (void)setAlertType:(AlertViewType)alertType
{
    [self resetView];
    
    switch (alertType) {
        case AlertViewTypeSingleText: {
            
            [self hideTitleView];
            [self hideLogo];
            
            break;
        }
        case AlertViewTypeTextAndImage: {
            
            [self hideTitleView];
            
            break;
        }
        case AlertViewTypeSingleTextContainTitle: {
            
            [self hideLogo];
            
            break;
        }
        case AlertViewTypeTextAndImageContainTitle: {
            
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark 还原到默认
- (void)resetView
{
    self.titleView.hidden = NO;
    self.titleView.height = DEFAULT_TITLEVIEW_HEIGHT;
    
    self.contentView.y = CGRectGetMaxY(self.titleView.frame);
    self.buttonView.y = CGRectGetMaxY(self.contentView.frame);
    
    self.popupSize = CGSizeMake(kDefaultAlertViewWidth, DEFAULT_TITLEVIEW_HEIGHT + DEFAULT_CONTENTVIEW_HEIGHT + DEFAULT_BUTTONVIEW_HEIGHT);
    
    // 显示内容区域的图片
    UIImageView *logo = (UIImageView *)[self.contentView viewWithTag:1001];
    UITextView *descriptionTextView = (UITextView *)[self.contentView viewWithTag:1002];
    
    logo.hidden = NO;
    logo.width = DEFAULT_LOGO_WIDTH;
    descriptionTextView.x = CGRectGetMaxX(logo.frame) + DEFAULT_BORDER_WIDTH;
    descriptionTextView.width = self.contentView.width - DEFAULT_BORDER_WIDTH * 3.0 - DEFAULT_LOGO_WIDTH;
}

#pragma mark 隐藏标题
- (void)hideTitleView
{
    self.titleView.hidden = YES;
    self.titleView.height = 0.0;
    self.contentView.y = 0.0;
    self.buttonView.y = CGRectGetMaxY(self.contentView.frame);
    
    // 修改默认弹窗大小
    self.popupSize = CGSizeMake(kDefaultAlertViewWidth, DEFAULT_CONTENTVIEW_HEIGHT + DEFAULT_BUTTONVIEW_HEIGHT);
}

#pragma mark 隐藏内容区域的图片
- (void)hideLogo
{
    // 隐藏内容区域的图片
    UIImageView *logo = (UIImageView *)[self.contentView viewWithTag:1001];
    UILabel *descriptionLabel = (UILabel *)[self.contentView viewWithTag:1002];
    
    logo.hidden = YES;
    logo.width = 0.0;
    descriptionLabel.x = DEFAULT_BORDER_WIDTH;
    descriptionLabel.width = self.contentView.width - DEFAULT_BORDER_WIDTH * 2.0;
}

#pragma mark - 重写Set方法
- (void)setTitle:(NSAttributedString *)attrTitle
{
    _title = attrTitle;
    
    UILabel *titleLabel = (UILabel *)[self.titleView viewWithTag:1001];
    titleLabel.attributedText = _title;
}

- (void)setSimpleTitle:(NSString *)simpleTitle
{
    _simpleTitle = simpleTitle;
    
    UILabel *titleLabel = (UILabel *)[self.titleView viewWithTag:1001];
    titleLabel.text = _simpleTitle;
}

- (void)setTitleAlignment:(NSTextAlignment)titleAlignment
{
    _titleAlignment = titleAlignment;
    
    UILabel *titleLabel = (UILabel *)[self.titleView viewWithTag:1001];
    titleLabel.textAlignment = _titleAlignment;
}

- (void)setLogoImage:(UIImage *)logoImage
{
    _logoImage = logoImage;
    
    UIImageView *logo = (UIImageView *)[self.contentView viewWithTag:1001];
    logo.image = _logoImage;
}

- (void)setAlertContent:(NSAttributedString *)attrAlertContent
{
    _alertContent = attrAlertContent;
    
    UILabel *descriptionLabel = (UILabel *)[self.contentView viewWithTag:1002];
    descriptionLabel.attributedText = _alertContent;
    
    // 计算高度
    CGFloat height = [_alertContent.string heightWithFont:kAlertContentFont constrainedToWidth:descriptionLabel.width];
    if (height > DEFAULT_CONTENTVIEW_HEIGHT) {
        
        self.contentView.height = height + 2 * DEFAULT_BORDER_WIDTH;
        descriptionLabel.height = self.contentView.height;
        
        UIImageView *logo = (UIImageView *)[self.contentView viewWithTag:1001];
        logo.center = CGPointMake(logo.center.x, self.contentView.height / 2.0);
        
        self.buttonView.y = CGRectGetMaxY(self.contentView.frame);
        
        // 计算高度差
        CGFloat deltaHeight = height - DEFAULT_CONTENTVIEW_HEIGHT + 2 * DEFAULT_BORDER_WIDTH;
        self.popupSize = CGSizeMake(self.popupSize.width, self.popupSize.height + deltaHeight);
    }
}

- (void)setSimgpleAlertContent:(NSString *)simgpleAlertContent
{
    _simgpleAlertContent = simgpleAlertContent;
    
    NSMutableAttributedString *attrAlertContent = [[NSMutableAttributedString alloc] initWithString:_simgpleAlertContent];
    [attrAlertContent setFont:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, _simgpleAlertContent.length)];
    [attrAlertContent setTextColor:RGB(67,67,67) range:NSMakeRange(0, _simgpleAlertContent.length)];
    
    self.alertContent = attrAlertContent;
}

- (void)setButtonTitles:(NSArray<__kindof NSAttributedString *> *)attrButtonTitles
{
    _buttonTitles = attrButtonTitles;
    
    CGFloat divideLineWidth = 0.5;
    CGFloat buttonWidth = (kDefaultAlertViewWidth - (_buttonTitles.count - 1) * divideLineWidth) / _buttonTitles.count;
    
    for (NSInteger i = 0; i < _buttonTitles.count; i++) {
        NSAttributedString *title = _buttonTitles[i];
        [self addbuttonWithAttrTitle:title index:i btnWidth:buttonWidth];
    }
}

- (void)setSimpleButtonTitles:(NSArray<__kindof NSString *> *)simpleButtonTitles
{
    _simpleButtonTitles = simpleButtonTitles;
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < _simpleButtonTitles.count; i++) {
        NSString *title = _simpleButtonTitles[i];
        
        NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [attrTitle setFont:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, title.length)];
        
        if (i == 0) {
            [attrTitle setTextColor:RGB(254,118,30) range:NSMakeRange(0, title.length)];
        }else{
            [attrTitle setTextColor:RGB(67,67,67) range:NSMakeRange(0, title.length)];
        }
        
        [buttonArray addObject:attrTitle];
    }
    
    self.buttonTitles = buttonArray;
}

- (void)addbuttonWithAttrTitle:(NSAttributedString *)title index:(NSInteger)index btnWidth:(CGFloat)btnWidth
{
    CGFloat divideLineWidth = 0.5;
    CGFloat btnX = index * divideLineWidth + index * btnWidth;
    CGFloat btnHeight = self.buttonView.height;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(btnX, 0.5, btnWidth, btnHeight);
    btn.tag = index;
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setAttributedTitle:title forState:UIControlStateNormal];
    [self.buttonView addSubview:btn];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    UILabel *titleLabel = (UILabel *)[self.titleView viewWithTag:1001];
    titleLabel.textColor = _titleColor;
}

#pragma mark - 事件监听
- (void)buttonClick:(UIButton *)btn
{
    NSInteger index = btn.tag;
    
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(alertView:buttonClick:)]) {
        [self.delegate alertView:self buttonClick:index];
    }
}

@end
