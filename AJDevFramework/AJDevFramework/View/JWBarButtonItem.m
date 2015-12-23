//
//  JWBarButtonItem.m
//  jianzhimao_enterprise
//
//  Created by 钟宝健 on 15/12/16.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import "JWBarButtonItem.h"
#import "CircleView.h"
#import "NSString+Size.h"

static const NSInteger RED_BADGE_TAG = 1001;
static const CGFloat BAR_BTN_WIDTH = 44.0;
static const CGFloat BAR_BTN_HEIGHT = 25.0;
static const CGFloat RED_BADGE_DIAMETER = 10.0;

@implementation JWBarButtonItem

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    barBtn.frame = CGRectMake(0, 0, BAR_BTN_WIDTH, BAR_BTN_HEIGHT);
    barBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [barBtn setImage:image forState:UIControlStateNormal];
    [barBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithCustomView:barBtn];
    self.tintColor = [UIColor colorWithRed:0.980 green:0.365 blue:0.078 alpha:1.000];
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIFont *barBtnFont = [UIFont systemFontOfSize:15.0];
    CGFloat width = [title widthWithFont:barBtnFont constrainedToHeight:BAR_BTN_HEIGHT];
    if (width < BAR_BTN_WIDTH) {
        width = BAR_BTN_WIDTH;
    }
    
    UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    barBtn.frame = CGRectMake(0, 0, width, BAR_BTN_HEIGHT);
    barBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    barBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [barBtn setTitleColor:[UIColor colorWithRed:0.980 green:0.365 blue:0.078 alpha:1.000] forState:UIControlStateNormal];
    [barBtn setTitle:title forState:UIControlStateNormal];
    [barBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithCustomView:barBtn];
    self.tintColor = [UIColor colorWithRed:0.980 green:0.365 blue:0.078 alpha:1.000];
    
    return self;
}


- (void)setShowBadge:(BOOL)showBadge
{
    _showBadge = showBadge;
    
    UIButton *barBtn = self.customView;
    UIView *redBadge = [barBtn viewWithTag:RED_BADGE_TAG];
    
    if (_showBadge) {
        
        if (!redBadge) {
            CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(BAR_BTN_WIDTH - RED_BADGE_DIAMETER / 2.0, 0.0, RED_BADGE_DIAMETER, RED_BADGE_DIAMETER)];
            circleView.circleColor = [UIColor redColor];
            circleView.tag = RED_BADGE_TAG;
            circleView.hidden = NO;
            
            [barBtn addSubview:circleView];
            
        }else{
            redBadge.hidden = NO;
        }
        
    }else{
        if (redBadge) {
            redBadge.hidden = YES;
        }
    }
}

@end
