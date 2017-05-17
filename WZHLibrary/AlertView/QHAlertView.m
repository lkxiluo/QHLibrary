//
//  WZHAlertView.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "QHAlertView.h"
#import "UIView+QHFrameLayout.h"

typedef void(^buttonHandle)(NSInteger index);
#define kContainerWidth  [UIScreen mainScreen].bounds.size.width - 100.0
#define kColor [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]
#define kButtonHeight 36.0

@interface QHAlertView ()

@property (nonatomic, copy) buttonHandle action;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation QHAlertView

static QHAlertView *alertView = nil;
static dispatch_once_t onceToken;
+ (instancetype)shareInstance {
    
    dispatch_once(&onceToken, ^{
        
        alertView = [[QHAlertView alloc] init];
    });
    return alertView;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
         buttonTitles:(NSArray *)titles
               action:(void (^)(NSInteger))action {
    
    if ([title length] == 0
        && [message length] == 0) {
        
        return;
    }
    
    CGFloat offsetY = 10.0f;
    if ([title length] > 0) {
        
        offsetY = [[QHAlertView shareInstance] addTitleLabelWithOffsetY:offsetY title:title];
    }
    
    if ([message length] > 0) {
        
        offsetY = [[QHAlertView shareInstance] addMessageLabelWithOffsetY:offsetY message:message];
    }
    
    offsetY = [[QHAlertView shareInstance] addButtonsWithOffsetY:offsetY titles:titles];
    [QHAlertView shareInstance].action = action;
    
    [QHAlertView shareInstance].containerView.height = offsetY;
    [QHAlertView shareInstance].containerView.center = [QHAlertView shareInstance].backgroundView.center;
    [[UIApplication sharedApplication].keyWindow addSubview:[QHAlertView shareInstance].backgroundView];
    [UIView animateWithDuration:0.2 animations:^{
        
        [QHAlertView shareInstance].backgroundView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        [QHAlertView shareInstance].backgroundView.alpha = 1.0;
    }];
}

+ (void)dismiss {
    
    [UIView animateWithDuration:0.2 animations:^{
       
        [QHAlertView shareInstance].backgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [QHAlertView shareInstance].backgroundView.alpha = 0.0;
        [[QHAlertView shareInstance].backgroundView removeFromSuperview];
        alertView = nil;
        onceToken = 0L;
    }];
}

- (void)buttonAction:(UIButton *)btn {
    
    if (self.action) {
        
        self.action(btn.tag);
    }
}

- (CGFloat)addTitleLabelWithOffsetY:(CGFloat)offsetY  title:(NSString *)title {
    
    UIFont *font  = [UIFont systemFontOfSize:14.0];
    CGSize size   = [title sizeWithAttributes:@{NSFontAttributeName:font}];

    UILabel *titleLabel      = [[UILabel alloc] init];
    titleLabel.frame         = CGRectMake( 10.0, offsetY, self.containerView.width - 20.0, size.height);
    titleLabel.textColor     = kColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font          = font;
    titleLabel.text          = title;
    [self.containerView addSubview:titleLabel];
    
    return offsetY + size.height + 10.0;
}

- (CGFloat)addMessageLabelWithOffsetY:(CGFloat)offsetY  message:(NSString *)message {
    
    UIFont *font  = [UIFont systemFontOfSize:14.0];
    CGSize size   = [message boundingRectWithSize:CGSizeMake(self.containerView.width - 20.0, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil].size;
    
    UILabel *messageLabel      = [[UILabel alloc] init];
    messageLabel.frame         = CGRectMake( 10.0, offsetY, self.containerView.width - 20.0, size.height);
    messageLabel.textColor     = kColor;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font          = font;
    messageLabel.text          = message;
    messageLabel.numberOfLines = 0;
    [self.containerView addSubview:messageLabel];
    
    return offsetY + size.height + 20.0;
}

- (CGFloat)addButtonsWithOffsetY:(CGFloat)offsetY titles:(NSArray *)titles {
    
    CGFloat y = offsetY;
    if (titles.count == 2) {
        
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame    = CGRectMake(0.0,
                                        offsetY,
                                        self.containerView.width,
                                        0.5f);
        lineLayer.backgroundColor = kColor.CGColor;
        [self.containerView.layer addSublayer:lineLayer];
        
        for (NSInteger i = 0; i < titles.count; i++) {
            
            UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0,
                                                                         offsetY,
                                                                         0.5f,
                                                                         kButtonHeight)];
            vLineView.backgroundColor = kColor;
            vLineView.centerX = self.containerView.width / 2;
            [self.containerView addSubview:vLineView];
            
            NSString *title = titles[i];
            CGFloat width   = (self.containerView.width - vLineView.width) / 2;
            CGRect frame = CGRectMake((width + vLineView.width) * i,
                                      offsetY,
                                      width,
                                      kButtonHeight);
            y = [self initButtonWithFrame:frame title:title tag:i];
        }
    } else {
        
        for (NSInteger i = 0; i < titles.count; i++) {
            
            NSString *title = titles[i];
            y = [self initButtonWithOffsetY:y title:title tag:i];
        }
    }
    return y;
}

- (CGFloat)initButtonWithOffsetY:(CGFloat)offsetY title:(NSString *)title tag:(NSInteger)tag {
    
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.frame    = CGRectMake(0.0,
                                    offsetY,
                                    self.containerView.width,
                                    0.5f);
    lineLayer.backgroundColor = kColor.CGColor;
    [self.containerView.layer addSublayer:lineLayer];
    offsetY                  = offsetY;
    CGRect frame             = CGRectMake(0.0, offsetY, self.containerView.width, kButtonHeight);
    offsetY                  = [self initButtonWithFrame:frame title:title tag:tag];
    
    return offsetY;
}

- (CGFloat)initButtonWithFrame:(CGRect)frame title:(NSString *)title  tag:(NSInteger)tag {
    
    UIFont *font           = [UIFont systemFontOfSize:14.0];
    UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame           = frame;
    button.titleLabel.font = font;
    button.tag             = tag;
    [button setTitleColor:kColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:button];
    
    return frame.size.height + frame.origin.y;
}

#pragma mark - getter/setter
- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2];
        _backgroundView.alpha = 0.0;
        [_backgroundView addSubview:self.containerView];
    }
    return _backgroundView;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(40.0, 0.0, kContainerWidth, 0.0)];
        _containerView.backgroundColor    = [UIColor whiteColor];
        _containerView.clipsToBounds      = YES;
        _containerView.layer.cornerRadius = 3.0;
    }
    return _containerView;
}


@end
