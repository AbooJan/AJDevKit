//
//  JWBarButtonItem.h
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/12/16.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWBarButtonItem : UIBarButtonItem

/// 是否显示红点，默认不显示
@property (nonatomic, assign) BOOL showBadge;


/// 事件监听方法返回的参数类型为UIButton
- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;
/// 事件监听方法返回的参数类型为UIButton
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end
