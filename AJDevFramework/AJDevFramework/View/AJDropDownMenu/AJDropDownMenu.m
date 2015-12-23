//
//  AJDropDownMenu.m
//  AJDropDownMenu
//
//  Created by 钟宝健 on 15/10/21.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJDropDownMenu.h"
#import "EXTScope.h"
#import "UIView+Extend.h"
#import "DropDownMenuCell.h"

static const CGFloat ITEM_HEIGHT = 40.0;

@interface AJDropDownMenu() <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UITableView *menuItemTableView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL isShowing;
@end

@implementation AJDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor orangeColor];
    
    CGFloat maskViewWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maskViewWidth, 0.0)];
    self.containView.backgroundColor = [UIColor clearColor];
    
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maskViewWidth, 0.0)];
    self.maskView.backgroundColor = [UIColor lightGrayColor];
    self.maskView.alpha = 0;
    
    [self.containView addSubview:self.maskView];
    [self setupMenuList];
    [self setupMenuSubView];
    
    
    // 背景灰色手势
    UITapGestureRecognizer *maskViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    maskViewTapGesture.numberOfTapsRequired = 1;
    maskViewTapGesture.numberOfTouchesRequired = 1;
    [self.maskView addGestureRecognizer:maskViewTapGesture];
    
    // 菜单手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)setupMenuSubView
{
    CGFloat borderWidth = 8.0;
    
    CGFloat arrowWidth = 10.0;
    CGFloat arrowHeight = 5.0;
    
    // 添加标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(borderWidth, 0, self.width - arrowWidth - borderWidth , self.bounds.size.height)];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    // 添加指示箭头
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, arrowWidth, arrowHeight)];
    self.arrowImageView.image = [UIImage imageNamed:@"ic_down_arrow"];
    self.arrowImageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), self.height / 2.0);
    [self addSubview:self.arrowImageView];
}

- (void)setupMenuList
{
    self.menuItemTableView = [[UITableView alloc] initWithFrame:self.containView.bounds style:UITableViewStylePlain];
    self.menuItemTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.menuItemTableView.dataSource = self;
    self.menuItemTableView.delegate = self;
    self.menuItemTableView.alpha = 0.0;
    [self.containView addSubview:self.menuItemTableView];
}

- (void)setTargetView:(UIView *)targetView
{
    _targetView = targetView;
    
    self.maskView.height = self.targetView.height;
}

#pragma mark - 事件处理
- (void)tapEvent:(UITapGestureRecognizer *)tapGesture
{
    if (self.isShowing) {
        [self dismissMenu];
    }else{
        [self showMenu];
    }
}

- (void)showMenu
{
    if (self.items.count == 0) {
        NSLog(@"Menu items empty!!!");
        return;
    }
    
    self.isShowing = YES;
    
    [self.targetView addSubview:self.containView];
    
    self.containView.y = self.positionY;
    self.containView.height = self.targetView.height;
    
    CGFloat menuTableViewHeight = self.items.count * ITEM_HEIGHT;
    
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        
        @strongify(self);
        
        self.maskView.alpha = 0.6;
        
        self.menuItemTableView.height = menuTableViewHeight;
        self.menuItemTableView.alpha = 1.0;
        
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        
    } completion:^(BOOL finished) {
        
        @strongify(self);
        
        [self completeMenuShowEvent];
    }];
}

- (void)dismissMenu
{
    self.isShowing = NO;
    
    @weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        @strongify(self);
        
        self.maskView.alpha = 0.0;
        self.menuItemTableView.height = 0.0;
        self.menuItemTableView.alpha = 0.0;
        
        self.arrowImageView.transform = CGAffineTransformMakeRotation(0.0);
        
    } completion:^(BOOL finished) {
        
        @strongify(self);
        
        [self.containView removeFromSuperview];
        
        [self completeMenuShowEvent];
    }];
}

- (void)completeMenuShowEvent
{
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:didShow:)]) {
        [self.delegate dropDownMenu:self didShow:self.isShowing];
    }
}

#pragma mark - 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reUseID = @"menuCell";
    DropDownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DropDownMenuCell" owner:nil options:nil][0];
    }
    
    cell.title = self.items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:didSelectRowAtIndex:)]) {
        [self.delegate dropDownMenu:self didSelectRowAtIndex:indexPath.row];
    }
    
    [self dismissMenu];
}

#pragma mark - SET 方法
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = _title;
}

@end
