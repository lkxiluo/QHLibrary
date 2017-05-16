//
//  WZHProgressHub.h
//  WZHLibrary
//
//  Created by QianHan on 2017/5/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QHProgressHub : NSObject

// 显示加载过程
+ (void)show;
/**
 显示提示
 @param status 提示内容
 */
+ (void)showWithStatus:(NSString *)status;
// 隐藏加载
+ (void)dismiss;
/**
 设置自定义加载视图
 @param loadingView 自定义的加载视图
 */
+ (void)setLoadingView:(UIView *)loadingView;

@end
