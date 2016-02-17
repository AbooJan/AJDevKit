//
//  UpdateViewController.m
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/24.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "UpdateViewController.h"
#import "DogBean.h"

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

#pragma mark - 批量写入删除测试

- (IBAction)writeArrayBtnClick:(UIButton *)sender
{
    NSMutableArray *dogArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        DogBean *dog1 = [[DogBean alloc] init];
        dog1.ID = 100+i;
        dog1.name = [NSString stringWithFormat:@"dog%ld", (long)(100+i)];
        
        [dogArray addObject:dog1];
    }
    
    [AJDBManager writeObjArray:dogArray];
}

- (IBAction)deleteArrayBtnClick:(id)sender
{
    NSArray *dogArray = [AJDBManager queryAllObj:[DogBean class]];
    
    if (dogArray.count > 0) {
        [AJDBManager deleteObjs:dogArray];
    }
}

@end
