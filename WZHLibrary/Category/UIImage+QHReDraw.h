//
//  UIImage+QHReDraw.h
//  QHUtil
//
//  Created by QianHan on 2017/3/4.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 重绘图片
 */
@interface UIImage (QHReDraw)

/**
 绘制图片的圆角
 
 @param radius 圆角的半径大小
 @return 带圆角的图片
 */
- (UIImage *)qh_drawCornerImageWithRadius:(CGFloat)radius;

/**
 绘制图片的圆角

 @param radius 圆角的半径大小
 @param size 要绘制的图片的大小
 @return 带圆角的图片
 */
- (UIImage *)qh_drawCornerImageWithRadius:(CGFloat)radius sizeToFit:(CGSize)size;

/**
 压缩图片

 @param targetSize 将要压缩的图片大小
 @return 压缩后的图片
 */
- (UIImage *)qh_compressImageToSize:(CGSize)targetSize;

/**
 给目标图片修改颜色(滤镜)，CGBlendMode为kCGBlendModeDestinationIn

 @param color 要修改的目标颜色
 @return 修改颜色后的图片
 */
- (UIImage *)qh_imageWithColor:(UIColor *)color;

/**
 给目标图片修改颜色(滤镜)

 @param color 要修改的目标颜色
 @param blendMode 修改的模式
 @return 修改颜色后的图标
 */
- (UIImage *)qh_imageWithColor:(UIColor *)color blendMode:(CGBlendMode)blendMode;

/**
 根据颜色绘制图片(消耗CPU，少用)
 
 @param color 颜色值
 @return 图片
 */
+ (UIImage *)qh_createImageWithColor:(UIColor *)color;

/**
 将目标视图整个截图

 @param view 目标视图
 @return 视图截图后的图片
 */
+ (UIImage *)qh_screenShot:(UIView *)view;

/**
 根据位置大小对目标视图进行截图
 
 @param sourceView 目标视图
 @param frame 位置大小，当超出范围时只截取可视范围
 @return 截图后的的图片
 */
+ (UIImage *)qh_screenShotFromView:(UIView *)sourceView atFrame:(CGRect)frame;

@end
