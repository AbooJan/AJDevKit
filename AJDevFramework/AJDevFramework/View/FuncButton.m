//
//  FuncButton.m
//  CustomBtn
//
//  Created by 钟宝健 on 15/4/22.
//  Copyright (c) 2015年 钟宝健. All rights reserved.
//

#import "FuncButton.h"
#import "CircleView.h"

#define kRedBadgeWidth 12.0
#define kFuncLabelColor RGB(25, 25, 25)

@interface FuncButton ()
@property (nonatomic, strong) UIImageView* funcImgView;
@property (nonatomic, strong) UILabel* funcLabel;
@property (nonatomic, strong) UIImageView* funcLabelBg;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) CircleView* redBadge;
@end

@implementation FuncButton

- (void)awakeFromNib
{
    [self setupView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.funcImgView.center = CGPointMake(self.width / 2.0, self.height * 0.5 - 25.0);

    CGFloat titleHeight = 20.0;
    self.funcLabel.center = CGPointMake(self.width / 2.0, CGRectGetMaxY(self.funcImgView.frame) + titleHeight / 2.0 + 4.0);

    self.funcLabelBg.frame = self.funcLabel.frame;

    _redBadge.center = CGPointMake(CGRectGetMaxX(_funcImgView.frame) , _funcImgView.y );
    
    self.descLabel.center = CGPointMake(self.width / 2.0, CGRectGetMaxY(self.funcLabel.frame) + self.descLabel.height / 2.0 + 3.0);
}

- (void)setupView
{

    CGFloat imgWidth = (self.width / 5.0) * 3.0;
    CGFloat imgHeight = imgWidth;

    self.funcImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, imgHeight)];
    self.funcImgView.image = [self imageForState:UIControlStateNormal];
    [self addSubview:self.funcImgView];

    self.funcLabelBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:self.funcLabelBg];

    CGFloat titleWidth = self.width - 8.0 * 2.0;
    CGFloat titleHeight = 20.0;
    self.funcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleHeight)];
    self.funcLabel.text = [self titleForState:UIControlStateNormal];
    self.funcLabel.font = [UIFont systemFontOfSize:14];
    self.funcLabel.textColor = kFuncLabelColor;
    self.funcLabel.textAlignment = NSTextAlignmentCenter;
    self.funcLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.funcLabel];

    [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];

    // 红点
    CGFloat redBadgeWidth = kRedBadgeWidth;
    CGFloat redBadgeHeight = redBadgeWidth;
    _redBadge = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, redBadgeWidth, redBadgeHeight)];
    _redBadge.circleColor = [UIColor redColor];
    [self addSubview:_redBadge];
    _redBadge.hidden = YES; // 默认隐藏
    
    // 描述文字
    CGFloat descLabelWidth = titleWidth;
    CGFloat descLabelHeight = 30.0;
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, descLabelWidth, descLabelHeight)];
    self.descLabel.font = [UIFont systemFontOfSize:10];
    self.descLabel.textColor = RGB(150, 150, 150);
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.numberOfLines = 0;
    [self addSubview:self.descLabel];
    
    
    // 清除原来图片和文字
    [self setImage:nil forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateNormal];
}

- (void)setShowBadge:(BOOL)showBadge
{
    _showBadge = showBadge;
    _redBadge.hidden = !_showBadge;
}

- (void)setDescStr:(NSString *)descStr
{
    _descStr = descStr;
    self.descLabel.text = _descStr;
}

- (void)changeToHighlighted
{
    [self.funcLabel setTextColor:[UIColor whiteColor]];
    [self.funcLabelBg setImage:[UIImage imageNamed:@"btn_orange_bg"]];
}

- (void)restoreFromHighlighted
{
    [self.funcLabel setTextColor:kFuncLabelColor];
    [self.funcLabelBg setImage:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if ([keyPath isEqualToString:@"highlighted"]) {

        NSInteger status = [change[@"new"] integerValue];

        if (status) {
            [self changeToHighlighted];
        }
        else {
            [self restoreFromHighlighted];
        }
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"highlighted"];
}

@end
