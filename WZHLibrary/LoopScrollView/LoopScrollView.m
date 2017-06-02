//
//  LoopScrollView.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "LoopScrollView.h"
#import "LoopCollectionViewCell.h"

#import "LoopCollectionViewLayoutFold1.h"
#import "LoopCollectionViewLayoutFold2.h"
#import "LoopCollectionViewLayout3DFlow.h"

static NSString *const kItemCellId = @"kItemCellId";
@interface LoopScrollView () <
UICollectionViewDelegate,
UICollectionViewDataSource> {
    
    LoopScrollViewType _type;
}

@property (nonatomic, weak) UICollectionView *loopCollectionView;

@end

@implementation LoopScrollView

- (instancetype)initWithType:(LoopScrollViewType)type frame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _type                = type;
        [self addLoopCollectionView];
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

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageNameArray.count <= 0 ? self.imageUrlArray.count : self.imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LoopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kItemCellId
                                                                             forIndexPath:indexPath];
    
    if (self.imageUrlArray.count > 0) {
    
        [cell configDataWithImageUrl:self.imageUrlArray[indexPath.row]];
    } else {
        
        [cell configDataWithImageName:self.imageNameArray[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UICollectionDelegate
- (UICollectionViewLayout *)createCollectionViewLayoutWithType:(LoopScrollViewType)type {
    
    UICollectionViewLayout *collectionViewLayout;
    switch (type) {
            
        case LoopScrollViewNormal: {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing          = 0.0f;
            layout.minimumInteritemSpacing     = 0.0f;
            layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
            collectionViewLayout = layout;
            break;
        }
        case LoopScrollViewFold1: {
            
            collectionViewLayout = [[LoopCollectionViewLayoutFold1 alloc] init];
            break;
        }
        case LoopScrollViewFold2: {
            
            collectionViewLayout = [[LoopCollectionViewLayoutFold2 alloc] init];
            break;
        }
        case LoopScrollView3DFlow: {
            
            collectionViewLayout = [[LoopCollectionViewLayout3DFlow alloc] init];
            break;
        }
            
        default:
            break;
    }
    
    return collectionViewLayout;
}

#pragma mark - addsubView
- (void)addLoopCollectionView {
    
    if (self.loopCollectionView == nil) {
        
        UICollectionViewLayout *layout   = [self createCollectionViewLayoutWithType:_type];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                                              collectionViewLayout:layout];
        collectionView.pagingEnabled   = YES;
        collectionView.delegate        = self;
        collectionView.dataSource      = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsVerticalScrollIndicator   = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[LoopCollectionViewCell class]
           forCellWithReuseIdentifier:kItemCellId];
        [self addSubview:collectionView];
        self.loopCollectionView = collectionView;
    }
}

- (void)setImageNameArray:(NSArray *)imageNameArray {
    
    _imageUrlArray     = nil;
    _imageNameArray    = imageNameArray;
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray {
    
    _imageNameArray     = nil;
    _imageUrlArray      = imageUrlArray;
}

@end
