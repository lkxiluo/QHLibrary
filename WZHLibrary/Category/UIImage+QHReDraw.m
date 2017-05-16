//
//  UIImage+QHReDraw.m
//  QHUtil
//
//  Created by QianHan on 2017/3/4.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "UIImage+QHReDraw.h"

@implementation UIImage (QHReDraw)

- (UIImage *)qh_drawCornerImageWithRadius:(CGFloat)radius {
    
    return [self qh_drawCornerImageWithRadius:radius sizeToFit:self.size];
}

- (UIImage *)qh_drawCornerImageWithRadius:(CGFloat)radius sizeToFit:(CGSize)size {
    
    CGRect rect  =  CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    
    CGContextRef content        = UIGraphicsGetCurrentContext();
    UIBezierPath *radiusPath    = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    CGContextAddPath(content, radiusPath.CGPath);
    CGContextClip(content);
    [self drawInRect:rect];
    CGContextDrawPath(content,kCGPathFillStroke);
    UIImage *radiusImage        = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return radiusImage;
}

- (UIImage *)qh_compressImageToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;  // scale to fit height
        } else {
            scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth     = width * scaleFactor;
        scaledHeight    = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    // pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)qh_imageWithColor:(UIColor *)color blendMode:(CGBlendMode)blendMode {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)qh_imageWithColor:(UIColor *)color {
    
    return [self qh_imageWithColor:color blendMode:kCGBlendModeDestinationIn];
}

+ (UIImage *)qh_createImageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,  [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)qh_screenShot:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)qh_screenShotFromView:(UIView *)sourceView atFrame:(CGRect)frame {
    
    if (frame.origin.x >= sourceView.frame.size.width
        || frame.origin.y >= sourceView.frame.size.height) {
#ifdef DEBUG
        NSAssert(NO, @"the frame haved out of rang.");
#endif
        return nil;
    }
    CGFloat imageOriginX    = frame.origin.x > 0.0f ? frame.origin.x : 0.0f;
    CGFloat imageOriginY    = frame.origin.y > 0.0f ? frame.origin.x : 0.0f;
    CGFloat imageWidth      = frame.size.width;
    CGFloat imageHeight     = frame.size.height;
    // 超出范围，取可视范围内的截图
    if ((imageOriginX + frame.size.width) > sourceView.frame.size.width) {
        
        imageWidth  = sourceView.frame.size.width - imageOriginX;
    }
    
    if ((imageOriginY + frame.size.height) > sourceView.frame.size.height) {
        
        imageHeight = sourceView.frame.size.height - imageOriginY;
    }

    CGRect imageRect     = CGRectMake(imageOriginX, imageOriginY, imageWidth, imageHeight);
    UIGraphicsBeginImageContext(sourceView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(imageRect);
    [sourceView.layer renderInContext:context];
    UIImage *theImage    = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;
}


@end
