//
//  AJToast.m
//  AJToastHub
//
//  Created by 钟宝健 on 15/12/8.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "AJToast.h"

//==============消息体==========
@interface ToastMessage : NSObject
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) NSTimeInterval duration;
@end

@implementation ToastMessage
@end
//=============end=============


// 默认消失时间
static const CGFloat DEFAULT_SHOW_DELAY = 1.5;


@interface AJToast()
@property (nonatomic, strong) AJToastViewController *toastVC;
/// 默认是 ToastPositionBottom
@property (nonatomic, assign) ToastPosition toastPosition;
/// 消息队列
@property (nonatomic, strong) NSMutableArray<ToastMessage *> *messageArray;
/// 显示标记
@property (nonatomic, assign) BOOL isShowing;
@end

@implementation AJToast

#pragma mark - <初始化>

+ (AJToast *)shareInstance
{
    static dispatch_once_t once;
    static AJToast * instance;
    dispatch_once( &once, ^{
        
        instance = [[AJToast alloc] init];
        
        instance.toastVC  = [[AJToastViewController alloc] init];
        instance.toastVC.view.frame = [UIScreen mainScreen].bounds;
        
        instance.toastVC.toastWindow = instance;
        
        instance.frame = [UIScreen mainScreen].bounds;
        instance.windowLevel = UIWindowLevelStatusBar;
        instance.hidden = YES;
        instance.alpha = 1.0;
        instance.rootViewController = instance.toastVC;
        instance.backgroundColor = [UIColor clearColor];
        
        //
        instance.messageArray = [NSMutableArray array];
    } );
    
    return instance;
}

- (void)setToastPosition:(ToastPosition)toastPosition
{
    _toastPosition = toastPosition;
    
    self.toastVC.toastPosition = _toastPosition;
}

#pragma mark - Toast

- (void)dismiss
{
    __weak __typeof(&*self) weakSelf = self;
    
    [self.toastVC dismissToast:^{
        
        weakSelf.isShowing = NO;
        
        if (weakSelf.messageArray.count > 0) {
            [weakSelf showMessage:nil];
        }else{
            weakSelf.hidden = YES;
        }
        
    }];
}

#pragma mark 消息队列处理
- (void)addMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    if (message) {
        
        if (![self checkExist:message]) {
            
            ToastMessage *toastMessage = [[ToastMessage alloc] init];
            toastMessage.msg = message;
            toastMessage.duration = duration;
            
            [self.messageArray addObject:toastMessage];
        }
    }
}

- (BOOL)checkExist:(NSString *)message;
{
    for (ToastMessage *toastMsg in self.messageArray) {
        
        NSString *tempMsg = toastMsg.msg;
        
        if ([tempMsg isEqualToString:message]) {
            return YES;
        }
    }
    
    return NO;
}

- (ToastMessage *)oldestMessage
{
    if (self.messageArray.count > 0) {
        ToastMessage *oldestMsg = [self.messageArray firstObject];
        
        [self.messageArray removeObject:oldestMsg];
        
        return oldestMsg;
    }
    
    return nil;
}

#pragma mark 默认显示位置
- (void)showMessage:(NSString *)message
{
    [self showMessage:message afterDelay:DEFAULT_SHOW_DELAY];
}

- (void)showMessage:(NSString *)message afterDelay:(NSTimeInterval)dismissTime
{
    [self addMessage:message duration:dismissTime];
    
    if (!self.isShowing) {
        
        self.isShowing = YES;
        
        ToastMessage *toast = [self oldestMessage];
        NSString *oldestMessage = toast.msg;
        
        if (oldestMessage) {
            
            self.toastVC.toastMessageStr = oldestMessage;
            self.hidden = NO;
            
            [self.toastVC showToast:^{
                //
            }];
            
            // 消失控制
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:toast.duration];
        }
    }
}


#pragma mark 有显示位置
- (void)showMessage:(NSString *)message position:(ToastPosition)position
{
    self.toastPosition = position;
    [self showMessage:message afterDelay:DEFAULT_SHOW_DELAY];
}

- (void)showMessage:(NSString *)message position:(ToastPosition)position afterDelay:(NSTimeInterval)dismissTime
{
    self.toastPosition = position;
    [self showMessage:message afterDelay:dismissTime];
}

@end
