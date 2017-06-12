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
    
    LoopScrollViewType _type;   // 轮播图显示类型
    NSInteger _itemsCount;      // 图片数
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return (_itemsCount == 1 && _type == LoopScrollViewNormal) ? 1 : 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return _itemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

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

    _imageUrlArray  = nil;
    _imageNameArray = imageNameArray;
    _itemsCount     = _imageNameArray.count;
    [self reloadData];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray {

    _imageNameArray = nil;
    _imageUrlArray  = imageUrlArray;
    _itemsCount     = _imageUrlArray.count;
    [self reloadData];
}

- (void)reloadData {
    
    [self.loopCollectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"`````jjj");
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.loopCollectionView scrollToItemAtIndexPath:indexPath
                                        atScrollPosition:UICollectionViewScrollPositionNone
                                                animated:NO];
    });
}

@end
