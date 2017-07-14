//
//  LoopCollectionViewCell.m
//  WZHLibrary
//
//  Created by QianHan on 2017/6/2.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "LoopCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface LoopCollectionViewCell ()

@property (nonatomic, weak) UIImageView *loopImageView;

@end

@implementation LoopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addLoopImageView];
    }
    return self;
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.loopImageView.frame = self.contentView.bounds;
}

- (void)configDataWithImageName:(NSString *)imageName {
    
    self.loopImageView.image = [UIImage imageNamed:imageName];
}

- (void)configDataWithImageUrl:(NSString *)imageUrl {

    [self.loopImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                          placeholderImage:[UIImage imageNamed:@"loop_place"]];
}

#pragma mark - 初始化
- (void)addLoopImageView {
    
    if (self.loopImageView == nil) {
        
        UIImageView *imageView    = [[UIImageView alloc] init];
        imageView.frame           = self.contentView.bounds;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode     = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        self.loopImageView = imageView;
    }
}

@end
