//
//  UIView+QHFrameLayout.m
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "UIView+QHFrameLayout.h"

@implementation UIView (QHFrameLayout)
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)with {
    CGRect frame = self.frame;
    frame.size.width = with;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint newCenter = self.center;
    newCenter.x = centerX;
    self.center = newCenter;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint newCenter = self.center;
    newCenter.y = centerY;
    self.center = newCenter;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return CGSizeMake(self.width, self.height);
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)centerInView:(UIView *)view {
    self.center = CGPointMake((view.width - view.x) / 2, (view.height - view.y) / 2);
}

- (void)left:(CGFloat)space toView:(UIView *)view {
    self.x = view.x + view.width + space;
}

- (void)right:(CGFloat)space toView:(UIView *)view {
    self.x = view.x - space - self.width;
}

- (void)top:(CGFloat)space toView:(UIView *)view {
    self.y = view.y + view.height + space;
}

- (void)bottom:(CGFloat)space toView:(UIView *)view {
    self.y = view.y - space - self.height;
}

@end
