//
//  Arrow.m
//  AJPickerButton
//
//  Created by 钟宝健 on 15/10/11.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "Arrow.h"

#define kDefaultArrowColor [UIColor lightGrayColor]

@interface Arrow()
@property (strong, nonatomic) UIColor *arrowColor;
@end

@implementation Arrow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withArrowColor:(UIColor *)arrowColor
{
    self = [self initWithFrame:frame];
    
    _arrowColor = arrowColor;
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat borderWidth = 5.0;
    
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineWidth = 2.0;
    [bezierPath moveToPoint: CGPointMake(borderWidth + borderWidth / 2.0, borderWidth)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width - borderWidth - borderWidth / 2.0, (rect.size.height - 2.0 * borderWidth) / 2.0 + borderWidth)];
    [bezierPath addLineToPoint: CGPointMake(borderWidth + borderWidth / 2.0, rect.size.height - borderWidth)];
    
    if (_arrowColor) {
        [_arrowColor setStroke];
    }else{
        [kDefaultArrowColor setStroke];
    }
    
    [bezierPath stroke];
}


@end
