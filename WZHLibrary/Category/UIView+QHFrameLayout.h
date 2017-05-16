//
//  UIView+QHFrameLayout.h
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 简化布局，这里只做单层布局依赖，不做多层布局转换依赖
 */
@interface UIView (QHFrameLayout)

@property (nonatomic, assign) CGFloat x;        // x轴起始点
@property (nonatomic, assign) CGFloat y;        // y轴起始点
@property (nonatomic, assign) CGFloat width;    // 宽度
@property (nonatomic, assign) CGFloat height;   // 高度
@property (nonatomic, assign) CGPoint origin;   // 起始点
@property (nonatomic, assign) CGSize size;      // 大小
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 *  @brief 将视图的中心设置为目标视图的中心
 *
 *  @param view 目标视图
 */
- (void)centerInView:(UIView *)view;
/**
 *  @brief 视图左边距目标视图右边的距离
 *
 *  @param space 距离
 *  @param view  目标视图
 */
- (void)left:(CGFloat)space toView:(UIView *)view;
/**
 *  @brief 视图右边距目标视图左边的距离
 *
 *  @param space 距离
 *  @param view  目标视图
 */
- (void)right:(CGFloat)space toView:(UIView *)view;
/**
 *  @brief 视图顶部距目标视图底部的距离
 *
 *  @param space 距离
 *  @param view  目标视图
 */
- (void)top:(CGFloat)space toView:(UIView *)view;
/**
 *  @brief 视图底部部距目标视图顶部的距离
 *
 *  @param space 距离
 *  @param view  目标视图
 */
- (void)bottom:(CGFloat)space toView:(UIView *)view;

@end
