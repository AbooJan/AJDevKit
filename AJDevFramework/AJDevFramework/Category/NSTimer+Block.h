//
//  NSTimer+Block.h
//  TestDemo601
//
//  Created by 钟宝健 on 15/12/14.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TimerBlock)();

@interface NSTimer (Block)

@property (nonnull, nonatomic, copy, readonly) TimerBlock funcBlock;

+ ( NSTimer * _Nullable)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)time block:( void(^ _Nonnull )())block repeats:(BOOL)repeats;
+ ( NSTimer * _Nullable)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)time block:( void(^ _Nonnull )())block userInfo:(nullable id)userInfo repeats:(BOOL)repeats;

@end
