//
//  NSTimer+Block.m
//  TestDemo601
//
//  Created by 钟宝健 on 15/12/14.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#import "NSTimer+Block.h"
#import <objc/runtime.h>

static NSString * const BLOCK_KEY = @"BLOCK_KEY";

@implementation NSTimer (Block)

- (void)setFuncBlock:(TimerBlock)funcBlock
{
    objc_setAssociatedObject(self, &BLOCK_KEY, funcBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TimerBlock)funcBlock
{
    return objc_getAssociatedObject(self, &BLOCK_KEY);
}


+ (NSTimer *)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)time block:(void(^)())block repeats:(BOOL)repeats
{ 
    return [self bk_scheduledTimerWithTimeInterval:time block:block userInfo:nil repeats:repeats];
}

+ (NSTimer *)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)time block:(void (^)())block userInfo:(id)userInfo repeats:(BOOL)repeats
{
    NSTimer *timer = [self scheduledTimerWithTimeInterval:time target:self selector:@selector(block_blockInvoke:) userInfo:userInfo repeats:repeats];
    timer.funcBlock = block;
    
    return timer;
}

+ (void)block_blockInvoke:(NSTimer *)timer
{
    void (^block)() = timer.funcBlock;
    if (block) {
        block();
    }
}

@end
