//
//  UIView+WZHEmptyView.h
//  WZHLibrary
//
//  Created by QianHan on 2017/5/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QHEmptyView)

/**
 显示数据提示

 @param image 提示的图标
 @param description 提示内容
 @param titles 操作按钮标题集
 @param action 操作事件
 */
- (void)qh_showWithImage:(UIImage *)image
            description:(NSString *)description
            buttonTitles:(NSArray *)titles
                  action:(void (^)(NSInteger index))action;

/**
 隐藏空数据提示
 */
- (void)qh_dismiss;

@end
