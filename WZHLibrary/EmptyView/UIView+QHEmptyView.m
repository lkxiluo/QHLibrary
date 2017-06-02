//
//  UIView+WZHEmptyView.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "UIView+QHEmptyView.h"
#import <objc/runtime.h>

NSUInteger const kSubViewTag = UINT_MAX - 100;
CGFloat const vspace         = 10.0f;// 纵向间距
CGFloat const hspace         = 10.0f;// 横向间距
CGFloat const kOffsety       = 100.0;

NSString const *WZHBlankViewBackgroudViewKey = @"kBackgroudViewKey";
static NSString *const kbuttonAction         = @"buttonAction";

@interface UIView ()

@end

@implementation UIView (QHEmptyView)

- (void)qh_showEmptyViewWithImage:(UIImage *)image
              description:(NSString *)description
             buttonTitles:(NSArray *)titles
                   action:(void (^)(NSInteger index))action {
    
    [self qh_dismissEmptyView];
    if (image == nil
        && description == nil
        && [titles count] == 0) {
        
        return;
    }
    
    UIView *backgroundView         = [self qh_backgroundView];
    [self addSubview:backgroundView];
    [self bringSubviewToFront:backgroundView];
    
    CGFloat offsetY = kOffsety;
    
    // 空图标
    CGFloat imageHeight = [self addEmptyImageViewWithOffsetY:offsetY image:image];
    offsetY             = image == nil ? offsetY : offsetY + imageHeight + vspace;
    
    // 内容描述
    CGFloat descriptionHeight = [self addDescriptionLabelWithOffsetY:offsetY
                                                         description:description];
    offsetY = [description length] <= 0 ? offsetY : offsetY + descriptionHeight + vspace;
    
    CGFloat dValue = 0.0;
    
    if (titles.count == 0) {
        
        dValue = (backgroundView.frame.size.height - offsetY) / 2 - kOffsety;
        [self reframeWithDValue:dValue];
        return;
    }
    
    // 操作按钮
    CGFloat maxWidth     = 0.0;
    CGFloat buttonHeight = 0.0;
    for (NSInteger i = 0; i < titles.count; i++) {
        
        CGSize buttonSize = [self addOperatorButtonWithOffsetY:offsetY
                                                         title:titles[i]
                                                           tag:kSubViewTag + i];
        maxWidth = maxWidth > buttonSize.width ? maxWidth : buttonSize.width;
        buttonHeight = buttonSize.height;
    }
    
    offsetY = offsetY + buttonHeight;
    dValue  = (backgroundView.frame.size.height - offsetY) / 2 - kOffsety;
    [self reframeOperateButtonWithWidth:maxWidth count:titles.count];
    [self reframeWithDValue:dValue];
    
    if (action) {
        
        [self qh_setButtonAction:action];
    }
}

- (void)qh_dismissEmptyView {
    
    UIView *backgroundView = [self qh_backgroundView];
    [backgroundView removeFromSuperview];
    for (UIView *subView in backgroundView.subviews) {
        
        [subView removeFromSuperview];
    }
}

- (void)operatorAction:(UIButton *)button {
    
    void (^buttonAction)(NSInteger index) = [self qh_buttonAction];
    if (buttonAction) {
        
        [self qh_dismissEmptyView];
        NSInteger index = button.tag - kSubViewTag;
        buttonAction(index);
    }
}

// 图片
- (CGFloat)addEmptyImageViewWithOffsetY:(CGFloat)offsetY
                                  image:(UIImage *)image {
    
    UIView *backgroundView = [self qh_backgroundView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame        = CGRectMake((backgroundView.frame.size.width - image.size.width) / 2,
                                        offsetY,
                                        image.size.width,
                                        image.size.height);
    [backgroundView addSubview:imageView];
    
    return imageView.frame.size.height;
}

// 描述内容
- (CGFloat)addDescriptionLabelWithOffsetY:(CGFloat)offsetY
                              description:(NSString *)description {
    
    UIView *backgroundView = [self qh_backgroundView];
    UIFont *font = [UIFont systemFontOfSize:14.0];
    CGSize descriptSize = [description boundingRectWithSize:CGSizeMake((backgroundView.frame.size.width - hspace) / 2,
                                                                       MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName: font}
                                                    context:nil].size;
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.frame    = CGRectMake(hspace,
                                           offsetY,
                                           backgroundView.frame.size.width - hspace * 2 ,
                                           descriptSize.height);
    descriptionLabel.font          = font;
    descriptionLabel.textColor     = [UIColor grayColor];
    descriptionLabel.text          = description;
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.numberOfLines = 0;
    [backgroundView addSubview:descriptionLabel];
    
    return descriptionLabel.frame.size.height;
}

// 添加操作
- (CGSize)addOperatorButtonWithOffsetY:(CGFloat)offsetY
                               title:(NSString *)title
                                    tag:(NSInteger)tag {
    
    UIView *backgroundView = [self qh_backgroundView];
    UIFont *font       = [UIFont systemFontOfSize:14.0];
    UIColor *tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];   // 从这里修改颜色
    CGSize titleSize   = [title sizeWithAttributes:@{NSFontAttributeName: font}];
    
    UIButton *button   = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame       = CGRectMake(0.0,
                                    offsetY,
                                    titleSize.width + hspace,
                                    titleSize.height + vspace);
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
    [backgroundView addSubview:button];
    
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
    
    UIView *backgroundView = [self qh_backgroundView];
    offsetX = (backgroundView.frame.size.width - totalWidth) / 2;
    for (UIView *subView in backgroundView.subviews) {
        
        if (subView.tag >= kSubViewTag) {
            
            NSInteger buttonIndex = subView.tag - kSubViewTag;
            CGFloat x             = offsetX + buttonIndex * (width + hspace);
            subView.frame         = CGRectMake(x,
                                               subView.frame.origin.y,
                                               width,
                                               subView.frame.size.height);
        }
    }
}

- (void)reframeWithDValue:(CGFloat)dValue {
    
    UIView *backgroundView = [self qh_backgroundView];
    for (UIView *subView in backgroundView.subviews) {
        
        subView.frame = CGRectMake(subView.frame.origin.x,
                                   subView.frame.origin.y + dValue,
                                   subView.frame.size.width,
                                   subView.frame.size.height);
    }
}

- (UIView *)qh_backgroundView {
    
    UIView *backgroundView = (UIView *)objc_getAssociatedObject(self,
                                                                (__bridge const void *)WZHBlankViewBackgroudViewKey);
    
    if (!backgroundView) {
        
        backgroundView                  = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor  = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
        objc_setAssociatedObject(self,
                                 (__bridge const void *)WZHBlankViewBackgroudViewKey,
                                 backgroundView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backgroundView;
}

- (void (^)(NSInteger index))qh_buttonAction {
    
    void (^buttonAction)(NSInteger index) = (void (^)(NSInteger index))objc_getAssociatedObject(self,
                                                                                                (__bridge const void *)kbuttonAction);
    if (!buttonAction) {
        
        return nil;
    }
    
    return buttonAction;
}

- (void)qh_setButtonAction:(void (^)(NSInteger index))action {
    
    if (action) {
        
        objc_setAssociatedObject(self,
                                 (__bridge const void *)kbuttonAction,
                                 action,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

@end
