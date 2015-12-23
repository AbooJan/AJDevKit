//
//  CorePagesBarBtn.m
//  CorePagesView
//
//  Created by muxi on 15/3/20.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "CorePagesBarBtn.h"
#import "CorePagesViewConfig.h"


@implementation CorePagesBarBtn


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){

        [self setupViews];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    [self setTitleColor:DEFAULT_BTN_COLOR forState:UIControlStateNormal];
    [self setTitleColor:DEFAULT_BTN_COLOR forState:UIControlStateHighlighted];
    [self setTitleColor:HIGHLIGHTED_COLOR forState:UIControlStateSelected];
}


@end
