//
//  UIView+QHDraw.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "UIView+QHDraw.h"

@implementation UIView (QHDraw)

- (void)qh_drawVerticalDashLineWithLineLength:(int)lineLength
                               lineSpacing:(int)lineSpacing
                                 lineColor:(UIColor *)lineColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2,
                                        CGRectGetHeight(self.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    // 设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength],
                                    [NSNumber numberWithInt:lineSpacing], nil]];
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    // 把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)qh_drawHorizontalDashLineWithLineLength:(int)lineLength
                                 lineSpacing:(int)lineSpacing
                                   lineColor:(UIColor *)lineColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2,
                                        CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    // 设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength],
                                    [NSNumber numberWithInt:lineSpacing], nil]];
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    // 把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

@end
