//
//  SecondCountDownTool.m
//  jianzhimao_enterprise
//
//  Created by AbooJan on 15/3/28.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "SecondCountDownTool.h"
#import "TestMyNetWork.h"

NSString * const SecondCountDownToolStartNotification = @"SecondCountDownToolStartNotification";
NSString * const SecondCountDownToolStopNotification =  @"SecondCountDownToolStopNotification";

NSString * const SecondCountDownSecondDataKey   = @"SecondCount";
NSString * const SecondCountDownUserInfoDataKey = @"UserInfo";


@interface SecondCountDownTool()
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger secondsCountDown;
@property (nonatomic, copy) NSString *data;
@end

@implementation SecondCountDownTool

static SecondCountDownTool *_instance;
+(SecondCountDownTool *)shareInstance
{
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

- (void)startCountDownWithSeconds:(NSInteger)seconds data:(NSString *)data
{
    // 如果网络没有连接，不开启倒计时
    if (![TestMyNetWork testConnection]) {
        _secondsCountDown = 1;
        
        return;
    }
    
    
    if (!_countDownTimer) {
        
        _secondsCountDown = seconds;
 
        _data = data;
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    }
    
}

-(void)timeFireMethod{
    
    _secondsCountDown--;
    if(_secondsCountDown==0){
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
    
    // 数据传递
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SecondCountDownToolStartNotification
     object:nil
     userInfo:@{ SecondCountDownSecondDataKey   : @(_secondsCountDown),
                 SecondCountDownUserInfoDataKey : _data}];
}

- (void)stopCountDown
{
    if(_countDownTimer){
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SecondCountDownToolStopNotification object:nil];
}

@end
