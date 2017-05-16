//
//  UIView+QHDraw.h
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QHDraw)

/**
 需要绘制成垂直虚线
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor  虚线的颜色
 **/
- (void)qh_drawVerticalDashLineWithLineLength:(int)lineLength
                               lineSpacing:(int)lineSpacing
                                 lineColor:(UIColor *)lineColor;

/**
 需要绘制成水平虚线
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor  虚线的颜色
 **/
- (void)qh_drawHorizontalDashLineWithLineLength:(int)lineLength
                                 lineSpacing:(int)lineSpacing
                                   lineColor:(UIColor *)lineColor;

@end
