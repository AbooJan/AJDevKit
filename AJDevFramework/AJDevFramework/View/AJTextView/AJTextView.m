//
//  AJTextView.m
//  AJTextView
//
//  Created by 钟宝健 on 15/12/5.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJTextView.h"

#define kPlaceHolderTextColor [UIColor colorWithWhite:0.7 alpha:1.0]
#define kLetterCountFont      [UIFont systemFontOfSize:12]
#define kLetterCountColor     [UIColor whiteColor]

static const CGFloat SPACE_WIDTH = 8.0;
static const CGFloat LETTER_COUNT_WIDTH = 35.0;
static const CGFloat LETTER_COUNT_HEIGHT = 20.0;


@interface AJTextView()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) UILabel *letterCountLabel;
@end

@implementation AJTextView

#pragma mark - <初始化>

-(void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

#pragma mark - <视图控制>

- (void)textViewDidChange:(NSNotification *)notification
{
    [self refreshPlaceholder];
    
    // 长度限制
    if (self.limitContentLength) {
        
        AJTextView *textView = notification.object;
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            NSString *contentStr = textView.text;
            if (contentStr.length > self.maxLetterCount) {
                textView.text = [contentStr substringToIndex:self.maxLetterCount];
            }
        }
    }
}

-(void)refreshPlaceholder
{
    if([[self text] length])
    {
        [self.placeHolderLabel setAlpha:0];

        NSInteger lessLetterCount = self.maxLetterCount - self.text.length;
        [self showLetterCount:lessLetterCount];
    }
    else
    {
        [self.placeHolderLabel setAlpha:1];
        
        [self showLetterCount:self.maxLetterCount];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)refreshLetterCount
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)showLetterCount:(NSInteger)letterCount
{
    self.letterCountLabel.text = [NSString stringWithFormat:@"%ld", (long) letterCount];
    
    if (letterCount < 0) {
        self.letterCountLabel.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.602];
        
        _isOverMaxLength = YES;
        
    }else{
        self.letterCountLabel.textColor = kLetterCountColor;
        
        _isOverMaxLength = NO;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.placeHolderLabel sizeToFit];
    self.placeHolderLabel.frame = CGRectMake(SPACE_WIDTH, SPACE_WIDTH, CGRectGetWidth(self.frame) - 2 * SPACE_WIDTH, CGRectGetHeight(self.placeHolderLabel.frame));
    
    [self.letterCountLabel sizeToFit];
    CGFloat letterCountLabelY = CGRectGetHeight(self.frame) - SPACE_WIDTH / 2.0 - LETTER_COUNT_HEIGHT;
    CGFloat letterCountLabelX = CGRectGetWidth(self.frame) - SPACE_WIDTH / 2.0 - LETTER_COUNT_WIDTH;
    self.letterCountLabel.frame = CGRectMake(letterCountLabelX, letterCountLabelY , LETTER_COUNT_WIDTH, LETTER_COUNT_HEIGHT);
}

-(id<UITextViewDelegate>)delegate
{
    [self refreshPlaceholder];
    return [super delegate];
}

- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.font = self.font;
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.textColor = kPlaceHolderTextColor;
        _placeHolderLabel.alpha = 0.0;
        [self addSubview:self.placeHolderLabel];
    }
    
    return _placeHolderLabel;
}

- (UILabel *)letterCountLabel
{
    if (!_letterCountLabel) {
        _letterCountLabel = [[UILabel alloc] init];
        _letterCountLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _letterCountLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _letterCountLabel.numberOfLines = 0;
        _letterCountLabel.font = kLetterCountFont;
        _letterCountLabel.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        _letterCountLabel.textColor = kLetterCountColor;
        _letterCountLabel.layer.cornerRadius = 3.0;
        _letterCountLabel.layer.masksToBounds = YES;
        _letterCountLabel.alpha = 0.0;
        _letterCountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_letterCountLabel];
    }
    
    return _letterCountLabel;
}

#pragma mark - <重写SET方法>

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self refreshPlaceholder];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = self.font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeHolderLabel.text = self.placeholder;
    [self refreshPlaceholder];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    if (_cornerRadius > 0.0) {
        self.layer.cornerRadius = _cornerRadius;
        self.layer.masksToBounds = YES;
    }
}

- (void)setMaxLetterCount:(NSInteger)maxLetterCount
{
    _maxLetterCount = maxLetterCount;
    
    [self showLetterCount:_maxLetterCount];
    
    [self refreshLetterCount];
}

- (void)setShowLetterCount:(BOOL)showLetterCount
{
    _showLetterCount = showLetterCount;
    
    if (_showLetterCount) {
        self.letterCountLabel.alpha = 1.0;
    }else{
        self.letterCountLabel.alpha = 0.0;
    }
}

@end
