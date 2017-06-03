//
//  FoldCollectionViewLayout.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/17.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "LoopCollectionViewLayoutFold1.h"

static NSInteger const kItemCount = 3;        // 可视区内的选项数据
@interface LoopCollectionViewLayoutFold1 ()

@property (nonatomic, assign) CGSize itemSize;      // 选项大小
@property (nonatomic, assign) CGFloat viewWidth;    // 可视区域宽
@property (nonatomic, assign) CGFloat itemWidth;    // 选项宽

@end

@implementation LoopCollectionViewLayoutFold1

- (void)prepareLayout {
    
    [super prepareLayout];
    self.itemSize = CGSizeMake(CGRectGetHeight(self.collectionView.frame) * 4 / 3,
                               CGRectGetHeight(self.collectionView.frame));
    self.viewWidth = CGRectGetWidth(self.collectionView.frame);
    self.itemWidth = self.itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0,
                                                        (self.viewWidth - self.itemWidth) / 2,
                                                        0,
                                                        (self.viewWidth - self.itemWidth) / 2);
    
}

- (CGSize)collectionViewContentSize {
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    CGFloat contentWidth   = 0.0;
    for (NSInteger i = 0; i < sectionCount; i++) {
        
        NSInteger cellCount    = [self.collectionView numberOfItemsInSection:i];
        contentWidth += cellCount * self.itemWidth;
    }
    return CGSizeMake(contentWidth, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    CGFloat centerX            = self.collectionView.contentOffset.x + self.viewWidth / 2;
    NSIndexPath *rectIndexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(centerX,
                                                                                         CGRectGetHeight(self.collectionView.frame) / 2)];
    NSInteger sectionCount     = [self.collectionView numberOfSections];
    for (NSInteger i = 0; i < sectionCount; i++) {
        
    }
    NSInteger cellCount        = [self.collectionView numberOfItemsInSection:rectIndexPath.section];
    
    NSInteger currentIndex = centerX / self.itemWidth;
    NSInteger dCount       = (kItemCount - 1) / 2;
    NSInteger minIndex     = MAX(0, currentIndex - dCount);
    NSInteger maxIndex     = MIN(cellCount - 1, currentIndex + dCount);
    
    NSMutableArray *layoutArray= [NSMutableArray new];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutArray addObject:attributes];
    }
    
    return layoutArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size     = self.itemSize;
    CGFloat cY          = self.collectionView.contentOffset.x + self.viewWidth / 2;
    CGFloat attributesY = self.itemWidth * indexPath.row + self.itemWidth / 2;
    attributes.zIndex   = -ABS(attributesY - cY);

    CGFloat delta        = cY - attributesY;
    CGFloat ratio        = - delta / (self.itemWidth * 2);
    CGFloat scale        = 1 - ABS(delta) / (self.itemWidth * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    CGFloat centerY      = attributesY;
    centerY              = cY + sin(ratio * M_PI_2) * self.itemWidth * 0.65;
    attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame) / 2);
    
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat index = roundf((proposedContentOffset.x + self.viewWidth / 2 - self.itemWidth / 2) / self.itemWidth);
    proposedContentOffset.x = self.itemWidth * index + self.itemWidth / 2 - self.viewWidth / 2;
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

@end
