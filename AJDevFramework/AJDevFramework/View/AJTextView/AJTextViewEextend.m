//
//  AJTextViewEextend.m
//  AJTextView
//
//  Created by 钟宝健 on 15/12/19.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJTextViewEextend.h"
#import "AJTextView.h"

@interface AJTextViewEextend()<UITextViewDelegate>
@property (nonatomic, strong) AJTextView *ajtv;
@property (nonatomic, assign) NSInteger headContentLength;
@end

@implementation AJTextViewEextend

#pragma mark - <初始化>

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.ajtv = [[AJTextView alloc] initWithFrame:self.bounds];
    self.ajtv.font = [UIFont systemFontOfSize:14.0];
    self.ajtv.delegate = self;
    [self addSubview:self.ajtv];
}

- (void)refreshContent:(NSString *)content
{
    if (self.headContent && ![self.headContent isEqualToString:@""]) {
        
        NSString *contentStr = [NSString stringWithFormat:@"%@%@", self.headContent, content];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        
        if (self.headContentColor) {
            [attrStr addAttribute:(NSString *)NSForegroundColorAttributeName value:_headContentColor range:NSMakeRange(0, self.headContentLength)];
        }
        
        if (self.textColor && ![content isEqualToString:@""]) {
            [attrStr addAttribute:(NSString *)NSForegroundColorAttributeName value:_textColor range:NSMakeRange(self.headContentLength, content.length)];
        }
        
        self.ajtv.attributedText = attrStr;
        
    }else{
        self.ajtv.text = content;
    }
}

#pragma mark - <重写SET方法>

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.ajtv.placeholder = _placeholder;
}

- (void)setHeadContent:(NSString *)headContent
{
    _headContent = headContent;
    
    self.headContentLength = _headContent.length;
    
    [self refreshContent:@""];
}

- (void)setHeadContentColor:(UIColor *)headContentColor
{
    _headContentColor = headContentColor;
    
    // 样式内容
    [self refreshContent:@""];
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    [self refreshContent:_text];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.ajtv.font = _font;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.ajtv.textColor = _textColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setLimitContentLength:(BOOL)limitContentLength
{
    _limitContentLength = limitContentLength;
    
    self.ajtv.limitContentLength = _limitContentLength;
}

- (void)setShowLetterCount:(BOOL)showLetterCount
{
    _showLetterCount = showLetterCount;
    
    self.ajtv.showLetterCount = _showLetterCount;
}

- (void)setMaxLetterCount:(NSInteger)maxLetterCount
{
    _maxLetterCount = maxLetterCount;
    
    self.ajtv.maxLetterCount = _maxLetterCount;
}


#pragma mark - <代理>

-(void)textViewDidChange:(UITextView *)textView
{
    NSString *contentStr = textView.text;
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        
        if ((contentStr.length > self.headContentLength) && self.headContentLength > 0) {
            
            NSString *extendContentStr = [contentStr stringByReplacingOccurrencesOfString:self.headContent withString:@""];
            
            [self refreshContent:extendContentStr];
        }
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.selectedRange.location < self.headContentLength) {
        textView.selectedRange = NSMakeRange(self.headContentLength, 0);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < self.headContentLength) {
        return NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSString *contentStr = textView.text;
    _text = contentStr;
    _isOverMaxLength = self.ajtv.isOverMaxLength;
    
    if ((contentStr.length > self.headContentLength) && self.headContentLength > 0) {
        
        NSString *extendContentStr = [contentStr stringByReplacingOccurrencesOfString:self.headContent withString:@""];
        
        [self refreshContent:extendContentStr];
    }
}

@end
