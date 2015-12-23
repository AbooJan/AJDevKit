//
//  NSMutableAttributedString+Extend.h
//  公用类
//
//  Created by 哈 哈 on 14-11-5.
//  Copyright (c) 2014年 mapabc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString(Extend)
-(void)setFont:(UIFont *)font range:(NSRange)range;

-(void)setTextColor:(UIColor *)textColor range:(NSRange)range;

- (void)setUnderlineRange:(NSRange)range;

- (void)setUnderline;
@end
