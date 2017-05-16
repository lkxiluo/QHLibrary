//
//  TimerManager.h
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const kTimerManagerUpdate;
@interface TimerManager : NSObject

@property (nonatomic, assign) CGFloat duration;   // 默认倒计时按秒
@property (nonatomic, assign, readonly) NSTimeInterval timeInterval;

+ (instancetype)shareInstance;
- (void)startTimer;
- (void)stopTimer;
- (void)reset;

@end
