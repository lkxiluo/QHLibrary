//
//  TimerManager.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "TimerManager.h"
#import "BackgroundTimerManager.h"

NSString * const kTimerManagerUpdate = @"kTimerManagerUpdate";

@interface TimerManager () {
    NSTimer *_timer;
}

@end

static TimerManager *timerManager = nil;
static dispatch_once_t onceToken;
@implementation TimerManager

+ (instancetype)shareInstance {
    
    dispatch_once(&onceToken, ^{
        
        timerManager = [[TimerManager alloc] init];
        [timerManager setTimeInterval:0];
        timerManager.duration = 1.0;
    });
    return timerManager;
}

- (void)startTimer {
    
    [[BackgroundTimerManager shareInstance] openBackgroundRunning];
    if (!_timer) {
        
        _timer  = [NSTimer scheduledTimerWithTimeInterval:self.duration
                                                   target:self
                                                 selector:@selector(remainTimeAction)
                                                 userInfo:nil
                                                  repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer {
    
    [self removeTimer];
}

- (void)removeTimer {
    
    self.timeInterval = 0;
    [_timer invalidate];
    _timer            = nil;
    timerManager      = nil;
    onceToken         = 0L;
    [[BackgroundTimerManager shareInstance] stopBackgroundRunning];
}

- (void)reset {
    
    [self removeTimer];
}

- (void)remainTimeAction {
    
    self.timeInterval++;
    [[NSNotificationCenter defaultCenter] postNotificationName:kTimerManagerUpdate object:nil];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    
    _timeInterval   = timeInterval;
}

@end
