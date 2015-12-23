//
//  BaseTextField.m
//  微考勤
//
//  Created by liouly on 14-8-22.
//  Copyright (c) 2014年 ___AutoNavi___. All rights reserved.
//

#import "BaseTextField.h"
#import "WTReParser.h"

@implementation BaseTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lastAcceptedValue = nil;
        _parser = nil;
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        _lastAcceptedValue = nil;
        _parser = nil;
        
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    return self;
    
}

-(void)setPattern:(NSString *)pattern
{
    if (!pattern || [pattern isEqualToString:@""]) {
        
        _parser = nil;
        
    }else{
        
        _parser = [[WTReParser alloc] initWithPattern:pattern];
        
    }
}

-(NSString *)pattern
{
    return _parser.pattern;
}

-(void)formatInput:(UITextField *)textField
{
    if (!_parser) {
        
        return;
        
    }
    
    __block WTReParser *localParser = _parser;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *formatted = [localParser reformatString:textField.text];
        
        if (!formatted) {
            
            formatted = _lastAcceptedValue;
            
        }else{
            
            _lastAcceptedValue = formatted;
            
        }
        
        NSString *newText = formatted;
        
        if (![textField.text isEqualToString:newText]) {
            
            textField.text = formatted;
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
        
        
    });
    
}

@end
