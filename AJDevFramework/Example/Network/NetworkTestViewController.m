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

- (void)handleResponse:(ResponseBeanSearchTel *)response
{
    TelInfo *tel = response.retData;
    
    NSString *result = [NSString stringWithFormat:@"手机号码： %@\n省份：%@\n运营商：%@\n", tel.telString, tel.province, tel.carrier];
    
    _resultLabel.text = result;
}

- (IBAction)searchBtnClick:(id)sender
{
    [[AJHub shareInstance] showHub:@""];
    
    RequestBeanSearchTel *requestBean = [[RequestBeanSearchTel alloc] init];
    requestBean.tel_local = _phoneTF.text;
    
    // 忽略测试
    requestBean.telNum = 1008611;
    
    // 读取缓存数据
    if ([requestBean cacheJson]) {
        NSDictionary *jsonDic = [[requestBean cacheJson] mj_JSONObject];
        ResponseBeanSearchTel *response = [ResponseBeanSearchTel mj_objectWithKeyValues:jsonDic];
        [self handleResponse:response];
        
        NSLog(@"显示缓存");
    }
    
//    requestBean.ignoreCache = YES;
    [requestBean startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [[AJHub shareInstance] dismiss];
        
        NSLog(@"请求结果是否来自缓存: %d \n\n", requestBean.isDataFromCache);
        
        ResponseBeanSearchTel *response = request.responseBean;
        
        [self handleResponse:response];
        
    } failure:^(YTKBaseRequest *request) {
        
        NSLog(@"faild: %ld -- %@", request.responseStatusCode, request.responseString);
        
    }];
    
}

@end
