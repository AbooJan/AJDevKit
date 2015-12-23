//
//  UIView+Extend.m
//  公用类
//
//  Created by 哈 哈 on 14-9-17.
//  Copyright (c) 2014年 mapabc. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)

#pragma mark 设置宽度
- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

#pragma mark 设置高度
- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

#pragma mark 设置X
- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

#pragma mark 设置Y
- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

#pragma mark 获取X
- (CGFloat)x
{
    return self.frame.origin.x;
}

#pragma mark 获取Y
- (CGFloat)y
{
    return self.frame.origin.y;
}

#pragma mark 获取高度
- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark 获取宽度
- (CGFloat)width
{
    return self.frame.size.width;
}

#pragma mark 设置尺寸

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

#pragma mark 设置位置
- (void)setOrigin:(CGPoint)origin{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;}

#pragma mark 横向居中
- (void)centerInHorizontal:(UIView *)parentView
{
    [self setX:(parentView.width - self.width) / 2];
}


#pragma mark 纵向居中
- (void)centerInVertical:(UIView *)parentView
{
    [self setY:(parentView.height - self.height) / 2];
}

#pragma mark 居中
- (void)centerInView:(UIView *)parentView{
    [self centerInHorizontal:parentView];
    [self centerInVertical:parentView];
}

#pragma mark 添加layer
- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(CGColorRef)colorRef
{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = colorRef;
    [self.layer addSublayer:layer];
    return layer;
}



#pragma mark 添加顶部和底部的线条
- (void)addTopAndBottomLineWithColor:(CGColorRef)color
{
    return [self addTopAndBottomLineWithHeight:0.5f color:color];
}

#pragma mark 添加顶部和底部的线条
- (void)addTopAndBottomLineWithHeight:(float)height color:(CGColorRef)colorRef
{
    [self addSubLayerWithFrame:CGRectMake(0, 0, self.width, height) color:colorRef];
    [self addSubLayerWithFrame:CGRectMake(0, self.height - height, self.width, 0.5f) color:colorRef];
}



#pragma mark 添加顶部的线条
- (CALayer *)addTopFillLineWithColor:(CGColorRef)color
{
    return [self addSubLayerWithFrame:CGRectMake(0, 0, self.width, 0.5f) color:color];
}



#pragma mark 添加底部的线条
- (CALayer *)addBottomFillLineWithColor:(CGColorRef)color
{
    return [self addSubLayerWithFrame:CGRectMake(0,
                                                 self.height - 0.5f,
                                                 self.width,
                                                 0.5f)
                                color:color];
}

#pragma mark 添加点击事件
- (void)tapGestureWithTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:recognizer];
}


@end
