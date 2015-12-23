//
//  RoundCornerButton.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/9/1.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "RoundCornerButton.h"

@implementation RoundCornerButton

- (void)awakeFromNib
{
    [self setupView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    // 圆角
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    

    // 设置背景
    CGSize btnImgSize = CGSizeMake(5.0, 5.0);
    
    UIColor *normalColor = self.backgroundColor;
    UIColor *highlightColor = [self darkedColor:normalColor];
    
    UIImage *normalImg = [self imageWithColor:normalColor size:btnImgSize];
    UIImage *highlightImg = [self imageWithColor:highlightColor size:btnImgSize];
    
    [self setBackgroundImage:normalImg forState:UIControlStateNormal];
    [self setBackgroundImage:highlightImg forState:UIControlStateSelected];
    [self setBackgroundImage:highlightImg forState:UIControlStateHighlighted];
}

- (UIColor *)darkedColor:(UIColor *)originalColor
{
    const CGFloat *components = CGColorGetComponents(originalColor.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1] - 0.2;
    CGFloat b = components[2] - 0.1;
    
    UIColor *changedColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    
    return changedColor;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
