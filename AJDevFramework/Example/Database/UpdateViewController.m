//
//  UpdateViewController.m
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;

- (IBAction)updateBtnClick:(id)sender;

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initData
{
    [super initData];
    
    self.nameTF.text = self.studentBean.name;
    self.ageTF.text = [NSString stringWithFormat:@"%ld", (long)self.studentBean.age];
}

- (IBAction)updateBtnClick:(id)sender
{
    @weakify(self);
    
    [AJDBManager updateObj:^{
        
        @strongify(self);
        
        self.studentBean.name = self.nameTF.text;
        self.studentBean.age = [self.ageTF.text integerValue];
        
    }];
    
    [self.delegate confirmUpdate];
    
    [[AJToast shareInstance] showMessage:@"更新成功"];
    
    [self popVC];
}
@end
