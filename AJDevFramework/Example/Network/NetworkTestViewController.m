//
//  NetworkTestViewController.m
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/23.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "NetworkTestViewController.h"
#import "ResponseSearchTel.h"
#import "RequestSearchTel.h"

@interface NetworkTestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)searchBtnClick:(id)sender;
@end

@implementation NetworkTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)searchBtnClick:(id)sender
{
    [[AJHub shareInstance] showHub:@""];
    
    RequestBeanSearchTel *requestBean = [[RequestBeanSearchTel alloc] init];
    requestBean.tel_local = _phoneTF.text;
    
    // 忽略测试
    requestBean.telNum = 1008611;
    
    [requestBean startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [[AJHub shareInstance] dismiss];
        
        ResponseBeanSearchTel *response = (ResponseBeanSearchTel *)request.responseBean;
        
        TelInfo *tel = response.retData;
        
        NSString *result = [NSString stringWithFormat:@"手机号码： %@\n省份：%@\n运营商：%@\n", tel.telString, tel.province, tel.carrier];
        
        _resultLabel.text = result;
        
    } failure:^(YTKBaseRequest *request) {
        
        NSLog(@"faild: %ld -- %@", request.responseStatusCode, request.responseString);
        
    }];
    
}

@end
