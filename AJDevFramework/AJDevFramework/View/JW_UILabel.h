//
//  JW_UILabel.h
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/8/4.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VerticalTextAlignment) {
    
    VerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
    
    VerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
    
    VerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
};

@interface JW_UILabel : UILabel


/// 默认居中，跟原来的UILabel一样
@property (nonatomic, assign) VerticalTextAlignment verticalTextAlignment;

/// 默认为：UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;
@end
