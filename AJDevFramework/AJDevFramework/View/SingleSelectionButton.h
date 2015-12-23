//
//  SingleSelectionButton.h
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/6/18.
//  Copyright (c) 2015年 joiway. All rights reserved.
//
//  单项按钮
//

#import <UIKit/UIKit.h>

@interface SingleSelectionButton : UIButton
/// 选项名称
@property (copy, nonatomic) NSString *selectionNameStr;
/// 是否选中
@property (nonatomic, assign) BOOL hasSelected;
@end
