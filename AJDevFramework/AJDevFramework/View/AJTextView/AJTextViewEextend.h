//
//  AJTextViewEextend.h
//  AJTextView
//
//  Created by 钟宝健 on 15/12/19.
//  Copyright © 2015年 钟宝健. All rights reserved.
//
//  AJTextView 的拓展
//

#import <UIKit/UIKit.h>

@interface AJTextViewEextend : UIView

@property (nullable, nonatomic, copy)   IBInspectable NSString *text;
@property (nullable, nonatomic, strong) IBInspectable UIFont *font;
@property (nullable, nonatomic, strong) IBInspectable UIColor *textColor;

@property (nullable, nonatomic,copy) IBInspectable NSString *placeholder;
/// 默认起始内容(此内容部可变)
@property (nullable, nonatomic, copy) IBInspectable NSString *headContent;
/// 必须在headContent之后赋值
@property (nullable, nonatomic, strong) IBInspectable UIColor *headContentColor;
/// 圆角
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/// 是否限制最大输入长度,默认不限制
@property (nonatomic, assign) IBInspectable BOOL limitContentLength;
/// 是否显示输入计数，默认不显示
@property (nonatomic, assign) IBInspectable BOOL showLetterCount;
/// 最大输入长度
@property (nonatomic, assign) IBInspectable NSInteger maxLetterCount;
/// 是否超出最大长度
@property (readonly, nonatomic, assign) BOOL isOverMaxLength;
@end
