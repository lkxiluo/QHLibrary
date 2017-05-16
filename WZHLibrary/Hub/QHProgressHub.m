//
//  WZHProgressHub.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "QHProgressHub.h"
#import "QHLoadingView.h"

#define kMaxContainerWidth  [UIScreen mainScreen].bounds.size.width - 40.0
#define kMinContainerWidth  100.0
#define kMaxContainerHeight [UIScreen mainScreen].bounds.size.height - 40.0

@interface QHProgressHub ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) QHLoadingView *defaultLoadingView;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *containerLabel;

@end

@implementation QHProgressHub

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    static QHProgressHub *instance = nil;
    dispatch_once(&onceToken, ^{
        
        instance = [[QHProgressHub alloc] init];
    });
    return instance;
}

+ (void)show {
    
    [QHProgressHub dismiss];
    [[UIApplication sharedApplication].keyWindow addSubview:[QHProgressHub shareInstance].backgroundView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:[QHProgressHub shareInstance].backgroundView];
}

+ (void)showWithStatus:(NSString *)status {
    
    if ([status length] == 0) {
        
        return;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:[QHProgressHub shareInstance].backgroundView];
    for (UIView *subview in [QHProgressHub shareInstance].backgroundView.subviews) {
        
        [subview removeFromSuperview];
    }
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    [[QHProgressHub shareInstance].backgroundView addSubview:[QHProgressHub shareInstance].containerView];
    [[QHProgressHub shareInstance].containerView addSubview:[QHProgressHub shareInstance].containerLabel];
    [QHProgressHub shareInstance].containerLabel.font = font;
    CGSize statusSize = [status boundingRectWithSize:CGSizeMake(kMaxContainerWidth - 20.0,
                                                                kMaxContainerHeight - 20.0)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: font}
                                             context:nil].size;
    CGFloat containerWidth = (statusSize.width < kMinContainerWidth ? kMinContainerWidth : statusSize.width) + 20.0;
    [QHProgressHub shareInstance].containerView.frame  = CGRectMake(0.0, 0.0, containerWidth, statusSize.height + 20.0);
    [QHProgressHub shareInstance].containerView.center = [QHProgressHub shareInstance].backgroundView.center;
    [QHProgressHub shareInstance].containerLabel.frame = CGRectMake((containerWidth - statusSize.width) / 2,
                                                                     0.0,
                                                                     statusSize.width,
                                                                     [QHProgressHub shareInstance].containerView.frame.size.height);
    [QHProgressHub shareInstance].containerLabel.text  = status;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [QHProgressHub shareInstance].containerView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        [QHProgressHub shareInstance].containerView.alpha = 1.0;
    }];
    
    NSTimeInterval afterTime = 0.3 + status.length * 0.1 > 5.0 ? 5.0 : 0.5 + status.length * 0.1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(afterTime * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [QHProgressHub shareInstance].containerView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            [QHProgressHub shareInstance].containerView.alpha = 0.0;
            [QHProgressHub dismiss];
        }];
    });
}

+ (void)dismiss {
    
    if ([QHProgressHub shareInstance].backgroundView) {
        
        [[QHProgressHub shareInstance].backgroundView removeFromSuperview];
        [QHProgressHub shareInstance].backgroundView = nil;
    }
}

#pragma mark - getter/setter
- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
        [_backgroundView addSubview:[self getLoadingView]];
    }
    return _backgroundView;
}

- (QHLoadingView *)defaultLoadingView {
    
    if (!_defaultLoadingView) {
        
        _defaultLoadingView = [[QHLoadingView alloc] init];
    }
    return _defaultLoadingView;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [[UIColor alloc] initWithRed:0.1
                                                                green:0.1
                                                                 blue:0.1
                                                                alpha:1.0];
        _containerView.layer.cornerRadius = 3.0f;
        _containerView.clipsToBounds      = YES;
        _containerView.alpha              = 1.0f;
    }
    return _containerView;
}

- (UILabel *)containerLabel {
    
    if (!_containerLabel) {
        
        _containerLabel           = [[UILabel alloc] init];
        _containerLabel.font      = [UIFont systemFontOfSize:14.0];
        _containerLabel.textColor = [UIColor whiteColor];
        _containerLabel.textAlignment = NSTextAlignmentCenter;
        _containerLabel.numberOfLines = 0;
    }
    return _containerLabel;
}

+ (void)setLoadingView:(UIView *)loadingView {
    
    if (loadingView) {
        
        [QHProgressHub shareInstance].loadingView = loadingView;
    } else {
        
        [QHProgressHub shareInstance].loadingView = [QHProgressHub shareInstance].defaultLoadingView;
    }
}

- (UIView *)getLoadingView {
    
    if (self.loadingView == nil) {
        
        self.loadingView = self.defaultLoadingView;
    }
    self.loadingView.center = self.backgroundView.center;
    return self.loadingView;
}

@end
