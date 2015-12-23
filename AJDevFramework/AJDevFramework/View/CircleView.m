//
//  CircleView.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/8/28.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat borderWidth = 1.5;
    CGRect changeFrame = rect;
    changeFrame.origin.x = borderWidth;
    changeFrame.origin.y = borderWidth;
    changeFrame.size.height = rect.size.height - borderWidth * 2;
    changeFrame.size.width = rect.size.width - borderWidth * 2;
    
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: changeFrame];
    [_circleColor setFill];
    [ovalPath fill];
    
}


@end
