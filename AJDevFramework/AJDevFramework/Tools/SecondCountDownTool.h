//
//  SecondCountDownTool.h
//  jianzhimao_enterprise
//
//  Created by AbooJan on 15/3/28.
//  Copyright (c) 2015年 joiway. All rights reserved.
//
//  倒计时
//

#import <Foundation/Foundation.h>

@interface SecondCountDownTool : NSObject

+ (SecondCountDownTool *)shareInstance;

/**
 *  开启倒计时
 *
 *  @param seconds 倒计时秒数
 *  @param data    暂存数据
 */
- (void)startCountDownWithSeconds:(NSInteger)seconds data:(NSString *)data;

/**
 *  停止倒计时
 */
- (void)stopCountDown;
@end

extern NSString * const SecondCountDownToolStartNotification;
extern NSString * const SecondCountDownToolStopNotification;

/// 以下数据包含在 Notification 的userInfo字典中
/// 倒计时秒数
extern NSString * const SecondCountDownSecondDataKey;
/// 倒计时广播绑定数据
extern NSString * const SecondCountDownUserInfoDataKey;