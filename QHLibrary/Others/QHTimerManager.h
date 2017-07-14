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
@interface QHTimerManager : NSObject

@property (nonatomic, assign) CGFloat duration;   // 倒计时间隔，默认1秒
@property (nonatomic, assign, readonly) NSTimeInterval timeInterval; // 倒计时执行次数

+ (instancetype)shareInstance;
- (void)startTimer;
- (void)stopTimer;
- (void)reset;

@end
