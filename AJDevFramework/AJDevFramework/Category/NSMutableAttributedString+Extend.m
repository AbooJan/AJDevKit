//
//  NSMutableAttributedString+Extend.m
//  公用类
//
//  Created by 哈 哈 on 14-11-5.
//  Copyright (c) 2014年 mapabc. All rights reserved.
//

#import "NSMutableAttributedString+Extend.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString(Extend)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setFont:(UIFont *)font range:(NSRange)range{
    [self removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
    if (font) {
        [self addAttribute:(NSString *)kCTFontAttributeName value:font range:range];
        
    }
}

-(void)setTextColor:(UIColor *)textColor range:(NSRange)range{
    [self removeAttribute:(NSString *)NSForegroundColorAttributeName range:range];
    if (textColor) {
        [self addAttribute:(NSString *)NSForegroundColorAttributeName value:textColor range:range];
    }
}

- (void)setUnderlineRange:(NSRange)range{
    [self removeAttribute:NSUnderlineStyleAttributeName range:range];
    [self addAttribute:NSUnderlineStyleAttributeName value:@(kCTUnderlineStyleSingle|kCTUnderlinePatternSolid) range:range];
}

- (void)setUnderline{
    [self setUnderlineRange:NSMakeRange(0, self.length)];
}
@end
