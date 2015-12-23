//
//  AJHub.m
//  AJToastHub
//
//  Created by 钟宝健 on 15/12/8.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJHub.h"
#import "AJToastViewController.h"

@interface AJHub()
@property (nonatomic, strong) AJToastViewController *toastVC;
/// 显示计数
@property (nonatomic, assign) NSInteger showCount;

@end

@implementation AJHub

+ (AJHub *)shareInstance
{
    static dispatch_once_t once;
    static AJHub * instance;
    dispatch_once( &once, ^{
        
        instance = [[AJHub alloc] init];
        
        instance.toastVC  = [[AJToastViewController alloc] init];
        instance.toastVC.view.frame = [UIScreen mainScreen].bounds;
        
        instance.toastVC.hubWindow = instance;
        
        instance.frame = [UIScreen mainScreen].bounds;
        instance.windowLevel = UIWindowLevelStatusBar;
        instance.hidden = YES;
        instance.alpha = 1.0;
        instance.rootViewController = instance.toastVC;
        instance.backgroundColor = [UIColor clearColor];
        
    } );
    
    return instance;
}


- (void)dismiss
{
    if (self.showCount > 0) {
        self.showCount --;
        
        if (self.showCount == 0) {
            __weak __typeof(&*self) weakSelf = self;
            [self.toastVC dismissHub:^{
                weakSelf.hidden = YES;
            }];
        }
    }
}

- (void)showHub:(NSString *)message
{
    self.showCount ++;
    
    self.toastVC.hubMessageStr = message;
    self.hidden = NO;
    
    [self.toastVC showHub:^{
        //
    }];
    
}

@end
