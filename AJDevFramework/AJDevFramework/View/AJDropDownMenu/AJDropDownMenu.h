//
//  AJDropDownMenu.h
//  AJDropDownMenu
//
//  Created by 钟宝健 on 15/10/21.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AJDropDownMenu;

@protocol AJDropDownMenuDelegate <NSObject>

@optional
- (void)dropDownMenu:(AJDropDownMenu *)menu didShow:(BOOL)showing;

- (void)dropDownMenu:(AJDropDownMenu *)menu didSelectRowAtIndex:(NSInteger)index;

@end

@interface AJDropDownMenu : UIView

@property (nonatomic, assign) id<AJDropDownMenuDelegate> delegate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, assign) CGFloat positionY;

@property (nonatomic, strong) NSArray *items;

@end
