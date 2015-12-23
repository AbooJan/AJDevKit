//
//  AJTextView.h
//  AJTextView
//
//  Created by 钟宝健 on 15/12/5.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJTextView : UITextView

@property (nullable, nonatomic,copy) IBInspectable NSString *placeholder;
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
