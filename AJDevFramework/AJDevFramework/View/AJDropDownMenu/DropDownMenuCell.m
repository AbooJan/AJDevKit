//
//  DropDownMenuCell.m
//  AJDropDownMenu
//
//  Created by 钟宝健 on 15/10/21.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "DropDownMenuCell.h"

@interface DropDownMenuCell()
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

@implementation DropDownMenuCell

- (void)awakeFromNib {
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.itemNameLabel.text = _title;
}

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    
    self.iconImageView.image = _icon;
}

@end
