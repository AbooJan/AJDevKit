//
//  BaseTextField.h
//  微考勤
//
//  Created by liouly on 14-8-22.
//  Copyright (c) 2014年 ___AutoNavi___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegexDefine.h"


@class WTReParser;

@interface BaseTextField : UITextField
{
    NSString *_lastAcceptedValue;
    WTReParser *_parser;
}

@property (strong, nonatomic) NSString *pattern;

@end
