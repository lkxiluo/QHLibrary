//
//  UIColor+QHConvert.m
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "UIColor+QHConvert.h"

@implementation UIColor (QHConvert)

+ (UIColor*)qh_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)qh_colorWithHex:(NSInteger)hexValue {
    
    return [UIColor qh_colorWithHex:hexValue alpha:1.0];
}

+ (NSString *)qh_hexFromUIColor:(UIColor *)color {
    
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x",
            (int)((CGColorGetComponents(color.CGColor))[0] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[1] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[2] * 255.0)];
}

+ (NSArray *)getRGBComponents:(UIColor *)color {
    
    if (!color) {
        
        return @[
                 [NSNumber numberWithFloat:1.0],
                 [NSNumber numberWithFloat:1.0],
                 [NSNumber numberWithFloat:1.0],
                 [NSNumber numberWithFloat:1.0]
                 ];
    }
    CGFloat r, g, b, a;
    
    CGColorRef colorRef = [color CGColor];
    int numComponents = (int)CGColorGetNumberOfComponents(colorRef);
    
    if (numComponents == 4) {
        
        const CGFloat *components = CGColorGetComponents(colorRef);
        r = components[0];
        g = components[1];
        b = components[2];
    }
    
    return @[
             [NSNumber numberWithFloat:r],
             [NSNumber numberWithFloat:g],
             [NSNumber numberWithFloat:b],
             [NSNumber numberWithFloat:a]
             ];
}

+ (UIColor *)qh_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    
    // 删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    // 如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]
        || [cString hasPrefix:@"0x"]) {
        
        cString = [cString substringFromIndex:2];
    }
    
    // 如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location  = 0;
    range.length    = 2;
    // r
    NSString *rString   = [cString substringWithRange:range];
    // g
    range.location      = 2;
    NSString *gString   = [cString substringWithRange:range];
    // b
    range.location      = 4;
    NSString *bString   = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)qh_colorWithHexString:(NSString *)color {
    
    return [self qh_colorWithHexString:color alpha:1.0f];
}

@end
