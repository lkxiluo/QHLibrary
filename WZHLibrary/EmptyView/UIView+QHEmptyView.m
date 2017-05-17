//
//  UIView+WZHEmptyView.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "UIView+QHEmptyView.h"

NSUInteger const kSubViewTag = UINT_MAX - 100.0;
CGFloat const vspace   = 10.0f;    // 纵向间距
CGFloat const hspace   = 10.0f;    // 横向间距
CGFloat const kOffsety = 100.0;
void(^buttonAction)(NSInteger index);

@interface UIView ()

@end

@implementation UIView (QHEmptyView)

- (void)qh_showEmptyViewWithImage:(UIImage *)image
              description:(NSString *)description
             buttonTitles:(NSArray *)titles
                   action:(void (^)(NSInteger index))action {
    
    if (image == nil
        && description == nil
        && [titles count] == 0) {
        return;
    }
    [self qh_dismissEmptyView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    backgroundView.tag = kSubViewTag;
    [self addSubview:backgroundView];
    [self bringSubviewToFront:backgroundView];
    
    CGFloat offsetY = kOffsety;
    
    // 空图标
    CGFloat imageHeight = [self addEmptyImageViewWithOffsetY:offsetY image:image];
    offsetY = image == nil ? offsetY : offsetY + imageHeight + vspace;
    
    // 内容描述
    CGFloat descriptionHeight = [self addDescriptionLabelWithOffsetY:offsetY
                                                         description:description];
    offsetY = [description length] <= 0 ? offsetY : offsetY + descriptionHeight + vspace;
    
    CGFloat dValue = 0.0;
    
    if (titles.count == 0) {
        
        dValue = (self.frame.size.height - offsetY) / 2 - kOffsety;
        [self reframeWithDValue:dValue];
        return;
    }
    
    // 操作按钮
    CGFloat maxWidth = 0.0;
    CGFloat buttonHeight = 0.0;
    for (NSInteger i = 0; i < titles.count; i++) {
        
        CGSize buttonSize = [self addOperatorButtonWithOffsetY:offsetY
                                                         title:titles[i]
                                                           tag:kSubViewTag + 3 + i];
        maxWidth = maxWidth > buttonSize.width ? maxWidth : buttonSize.width;
        buttonHeight = buttonSize.height;
    }
    
    offsetY = offsetY + buttonHeight;
    dValue  = (self.frame.size.height - offsetY) / 2 - kOffsety;
    [self reframeOperateButtonWithWidth:maxWidth count:titles.count];
    [self reframeWithDValue:dValue];
    
    if (action) {
        
        buttonAction = action;
    }
}

- (void)qh_dismissEmptyView {
    
    for (UIView *subView in self.subviews) {
        
        if (subView.tag >= kSubViewTag) {
            
            [subView removeFromSuperview];
        }
    }
}

- (void)operatorAction:(UIButton *)button {
    
    if (buttonAction) {
        
        NSInteger index = button.tag - (kSubViewTag + 3);
        buttonAction(index);
    }
}

// 图片
- (CGFloat)addEmptyImageViewWithOffsetY:(CGFloat)offsetY
                                  image:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame        = CGRectMake((self.frame.size.width - image.size.width) / 2,
                                        offsetY,
                                        image.size.width,
                                        image.size.height);
    imageView.tag = kSubViewTag + 1;
    [self addSubview:imageView];
    [self bringSubviewToFront:imageView];
    
    return imageView.frame.size.height;
}

// 描述内容
- (CGFloat)addDescriptionLabelWithOffsetY:(CGFloat)offsetY
                              description:(NSString *)description {
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    CGSize descriptSize = [description boundingRectWithSize:CGSizeMake((self.frame.size.width - hspace) / 2,
                                                                       MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName: font}
                                                    context:nil].size;
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.frame    = CGRectMake(hspace,
                                           offsetY,
                                           self.frame.size.width - hspace * 2 ,
                                           descriptSize.height);
    descriptionLabel.font          = font;
    descriptionLabel.textColor     = [UIColor grayColor];
    descriptionLabel.text          = description;
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.tag           = kSubViewTag + 2;
    [self addSubview:descriptionLabel];
    [self bringSubviewToFront:descriptionLabel];
    
    return descriptionLabel.frame.size.height;
}

// 添加操作
- (CGSize)addOperatorButtonWithOffsetY:(CGFloat)offsetY
                               title:(NSString *)title
                                    tag:(NSInteger)tag {
    
    UIFont *font       = [UIFont systemFontOfSize:14.0];
    UIColor *tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];   // 从这里修改颜色
    CGSize titleSize   = [title sizeWithAttributes:@{NSFontAttributeName: font}];
    
    UIButton *button   = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame       = CGRectMake(0.0, offsetY, titleSize.width + hspace, titleSize.height + vspace);
    button.tag         = tag;
    [button setTitleColor:tintColor forState:UIControlStateNormal];
    button.titleLabel.font    = font;
    button.layer.cornerRadius = 3.0;
    button.layer.borderColor  = tintColor.CGColor;
    button.layer.borderWidth  = 1.0;
    [button addTarget:self
               action:@selector(operatorAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [self addSubview:button];
    [self bringSubviewToFront:button];
    
    return button.frame.size;
}

- (void)reframeOperateButtonWithWidth:(CGFloat)width count:(NSInteger)count {
    
    CGFloat totalWidth = 0.0;
    CGFloat offsetX    = 0.0;
    if (count > 1) {
        
        totalWidth = width * count + (count - 1) * hspace;
    } else {
        
        totalWidth = width * count;
    }
    offsetX = (self.frame.size.width - totalWidth) / 2;
    for (UIView *subView in self.subviews) {
        
        if (subView.tag >= kSubViewTag + 3) {
            
            NSInteger buttonIndex = subView.tag - (kSubViewTag + 3);
            CGFloat x             = offsetX + buttonIndex * (width + hspace);
            subView.frame         = CGRectMake(x,
                                               subView.frame.origin.y,
                                               width,
                                               subView.frame.size.height);
        }
    }
}

- (void)reframeWithDValue:(CGFloat)dValue {
    
    for (UIView *subView in self.subviews) {
        
        if (subView.tag > kSubViewTag) {
            
            subView.frame = CGRectMake(subView.frame.origin.x,
                                       subView.frame.origin.y + dValue,
                                       subView.frame.size.width,
                                       subView.frame.size.height);
        }
    }
}

@end
