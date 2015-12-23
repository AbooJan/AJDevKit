//
//  SingleSelectionButton.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/6/18.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "SingleSelectionButton.h"

#define kSelctionFont [UIFont systemFontOfSize:14]
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kBorderWidth  8.0

@interface SingleSelectionButton()
@property (nonatomic, strong) UIImageView *checkboxImgView;
@end

@implementation SingleSelectionButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    // 添加选项图标
    CGFloat imgSize = 20.0;
    _checkboxImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_single_check_0"]];
    _checkboxImgView.bounds = CGRectMake(0, 0, imgSize, imgSize);
    _checkboxImgView.center = CGPointMake(kScreenWidth - kBorderWidth - imgSize / 2.0, self.frame.size.height / 2.0);
    
    [self addSubview:_checkboxImgView];
    
    // 选项名
    [self.titleLabel setFont:kSelctionFont];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    // 布局
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
}

- (void)setSelectionNameStr:(NSString *)selectionNameStr
{
    _selectionNameStr = selectionNameStr;
    
    [self setTitle:_selectionNameStr forState:UIControlStateNormal];
}

- (void)setHasSelected:(BOOL)hasSelected
{
    _hasSelected = hasSelected;
    
    if (_hasSelected) {
        _checkboxImgView.image = [UIImage imageNamed:@"ic_single_check_1"];
    }else{
        _checkboxImgView.image = [UIImage imageNamed:@"ic_single_check_0"];
    }
}

@end
