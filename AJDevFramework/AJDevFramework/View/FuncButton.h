//
//  FuncButton.h
//  CustomBtn
//
//  Created by 钟宝健 on 15/4/22.
//  Copyright (c) 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuncButton : UIButton
/// 是否显示红点
@property (nonatomic, assign) BOOL showBadge;
/// 描述文字
@property (nonatomic, copy) NSString *descStr;
@end
