//
//  UIView+Extend.h
//  公用类
//
//  Created by 哈 哈 on 14-9-17.
//  Copyright (c) 2014年 mapabc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)point;

- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (void)centerInHorizontal:(UIView *)parentView;
- (void)centerInVertical:(UIView *)parentView;
- (void)centerInView:(UIView *)parentView;

- (CALayer *)addSubLayerWithFrame:(CGRect)frame color:(CGColorRef)colorRef;

- (void)addTopAndBottomLineWithColor:(CGColorRef)color;
- (void)addTopAndBottomLineWithHeight:(float)height color:(CGColorRef)colorRef;

- (CALayer *)addTopFillLineWithColor:(CGColorRef)color;
- (CALayer *)addBottomFillLineWithColor:(CGColorRef)color;

- (void)tapGestureWithTarget:(id)target action:(SEL)action;

@end
