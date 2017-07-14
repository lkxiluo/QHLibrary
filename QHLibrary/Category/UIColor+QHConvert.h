//
//  UIColor+QHConvert.h
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 颜色值之间的转换，RBG、十进制、16进制
 */
@interface UIColor (QHConvert)

/**
 16进制颜色转换成UIColor
 
 @param hexValue 16进制颜色 例如0xfafafa
 @return UIColor
 */
+ (UIColor *)qh_colorWithHex:(NSInteger)hexValue;

/**
 16进制颜色转换成UIColor
 
 @param hexValue 16进制颜色 例如0xfafafa
 @param alpha 颜色透明度
 @return UIColor
 */
+ (UIColor *)qh_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

/**
 16进制颜色转换成UIColor

 @param color 16进制字符串 例如@“0xfafafa”、@"0Xfafafa"、@"#fafafa"
 @return UIColor
 */
+ (UIColor *)qh_colorWithHexString:(NSString *)color;

/**
 16进制颜色转换成UIColor
 
 @param color 16进制字符串 例如@“0xfafafa”、@"0Xfafafa"、@"#fafafa"
 @param alpha 颜色透明度
 @return UIColor
 */
+ (UIColor *)qh_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 UIColor颜色转化为16进制颜色值

 @param color UIColor颜色值
 @return 16进制字符串 #fafafa
 */
+ (NSString *)qh_hexFromUIColor:(UIColor *)color;


@end
