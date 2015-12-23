//
//  JW_UILabel.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/8/4.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "JW_UILabel.h"

@implementation JW_UILabel
#pragma mark - Accessors

@synthesize verticalTextAlignment = _verticalTextAlignment;

- (void)setVerticalTextAlignment:(VerticalTextAlignment)verticalTextAlignment {
    _verticalTextAlignment = verticalTextAlignment;
    
    [self setNeedsLayout];
}


@synthesize textEdgeInsets = _textEdgeInsets;

- (void)setTextEdgeInsets:(UIEdgeInsets)textEdgeInsets {
    _textEdgeInsets = textEdgeInsets;
    
    [self setNeedsLayout];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
        [self initialize];
    }
    return self;
}


#pragma mark - UILabel

- (void)drawTextInRect:(CGRect)rect {
    rect = UIEdgeInsetsInsetRect(rect, self.textEdgeInsets);
    
    if (self.verticalTextAlignment == VerticalTextAlignmentTop) {
        CGSize sizeThatFits = [self sizeThatFits:rect.size];
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, sizeThatFits.height);
    } else if (self.verticalTextAlignment == VerticalTextAlignmentBottom) {
        CGSize sizeThatFits = [self sizeThatFits:rect.size];
        rect = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - sizeThatFits.height), rect.size.width, sizeThatFits.height);
    }
    
    [super drawTextInRect:rect];
}


#pragma mark - Private

- (void)initialize {
    self.verticalTextAlignment = VerticalTextAlignmentMiddle;
    self.textEdgeInsets = UIEdgeInsetsZero;
}
@end
