//
//  WZHLoadingView.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/13.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "QHLoadingView.h"

@interface QHLoadingView ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *pingImageView;

@end

@implementation QHLoadingView

- (void)dealloc {
    
    [self.pingImageView.layer removeAllAnimations];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self setupView];
        self.frame = CGRectMake(0.0,
                                0.0,
                                self.pingImageView.frame.size.width,
                                self.pingImageView.frame.size.height);
        self.pingImageView.center = self.center;
        self.logoImageView.center = self.center;
        [self startAnimation];
    }
    return self;
}

- (void)setupView {
    
    [self addLogoImageView];
    [self addPingImageView];
}

- (void)addLogoImageView {
    
    if (self.logoImageView == nil) {
        
        UIImage *logoImage                 = [UIImage imageNamed:@"loading_image_center"];
        self.logoImageView                 = [[UIImageView alloc] initWithImage:logoImage];
        self.logoImageView.backgroundColor = [UIColor clearColor];
        self.logoImageView.contentMode     = UIViewContentModeScaleAspectFit;
        self.logoImageView.frame           = CGRectMake(0.0,
                                                        0.0,
                                                        logoImage.size.width,
                                                        logoImage.size.height);
        [self addSubview:self.logoImageView];
    }
}

- (void)addPingImageView {
    
    if (self.pingImageView == nil) {
        
        UIImage *pingImage                 = [UIImage imageNamed:@"loading_image_circle"];
        self.pingImageView                 = [[UIImageView alloc] initWithImage:pingImage];
        self.pingImageView.backgroundColor = [UIColor clearColor];
        self.pingImageView.contentMode     = UIViewContentModeScaleAspectFit;
        self.pingImageView.frame           = CGRectMake(0.0,
                                                        0.0,
                                                        pingImage.size.width,
                                                        pingImage.size.height);
        [self addSubview:self.pingImageView];
    }
}

- (void)startAnimation {
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    baseAnimation.fromValue      = [NSNumber numberWithFloat:0.0];
    baseAnimation.toValue        = [NSNumber numberWithFloat:2 * M_PI];
    baseAnimation.repeatCount    = MAXFLOAT;
    baseAnimation.duration       = 0.4;
    baseAnimation.removedOnCompletion = NO;
    [self.pingImageView.layer addAnimation:baseAnimation forKey:nil];
}

@end
