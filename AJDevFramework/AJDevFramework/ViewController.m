//
//  ViewController.m
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/21.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTestViewController.h"
#import "UIViewController+EmptyTableView.h"
#import "UIViewController+MJRefresh.h"
#import "JWBarButtonItem.h"
#import "DatabaseTestViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *selectionArray;

// 测试空列表用
@property (nonatomic, assign) BOOL switchEmpty;
@property (nonatomic, strong) NSArray *emptyArray;

@end

@implementation ViewController

#pragma mark - <初始化>

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)initData
{
    [super initData];
    
    self.selectionArray = @[@"网络请求示例", @"数据库示例"];
    
    self.emptyArray = @[];
}

- (void)initView
{
    [super initView];
    
    JWBarButtonItem *emptySwitchBarItem = [[JWBarButtonItem alloc] initWithTitle:@"空列表" target:self action:@selector(emptyListBtnClick:)];
    self.navigationItem.rightBarButtonItem = emptySwitchBarItem;
    
    // 空列表测试
    self.dzn_emptyTableView = self.tableView;
    self.dzn_emptyTipIcon = [UIImage imageNamed:@"ic_test"];
    self.dzn_emptyTipMessage = @"暂无数据~";
    
    // 上拉下拉刷新测试
    self.mj_refreshTableView = self.tableView;
}

#pragma mark - <代理>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.switchEmpty) {
        return self.emptyArray.count;
    }else{
        return self.selectionArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reUseID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.selectionArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        NetworkTestViewController *networkTestVC = [STORYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"NetworkTestViewController"];
        [self pushVC:networkTestVC];
    }else if (indexPath.row == 1){
        DatabaseTestViewController *databaseTestVC = [STORYBOARD(@"Main") instantiateViewControllerWithIdentifier:@"DatabaseTestViewController"];
        [self pushVC:databaseTestVC];
    }
}

- (void)dzn_refreshData
{
    [self mj_beginRefresh];
}

#pragma mark - <事件>

- (void)emptyListBtnClick:(UIButton *)barBtn
{
    self.switchEmpty = !self.switchEmpty;
    
    [self.tableView reloadData];
}

- (void)mj_readData
{
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        
        [self mj_endRefresh];
        
    });
}

@end
