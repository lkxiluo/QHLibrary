//
//  LoopScrollView.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "LoopScrollView.h"

@interface LoopScrollView () <
UICollectionViewDelegate,
UICollectionViewDataSource> {
    
    LoopScrollViewType _type;
}

@property (nonatomic, strong) UICollectionView *loopCollectionView;

@end

@implementation LoopScrollView

- (instancetype)initWithType:(LoopScrollViewType)type frame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _type                = type;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [[LoopScrollView alloc] initWithType:LoopScrollViewNormal frame:frame];
    return self;
}

- (instancetype)init {
    
    self = [[LoopScrollView alloc] initWithType:LoopScrollViewNormal frame:CGRectZero];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self = [[LoopScrollView alloc] initWithType:LoopScrollViewNormal frame:self.frame];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.loopCollectionView.frame = self.bounds;
}

#pragma mark - addsubView
- (void)addLoopCollectionView {
    
    if (self.loopCollectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing          = 0.0f;
        layout.minimumInteritemSpacing     = 0.0f;
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        self.loopCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.loopCollectionView.pagingEnabled   = YES;
        self.loopCollectionView.delegate        = self;
        self.loopCollectionView.dataSource      = self;
        self.loopCollectionView.backgroundColor = [UIColor clearColor];
        self.loopCollectionView.showsVerticalScrollIndicator   = NO;
        self.loopCollectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.loopCollectionView];
    }
}

@end
